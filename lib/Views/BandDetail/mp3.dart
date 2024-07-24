import 'package:audioplayers/audioplayers.dart';
import 'package:event_music_app/Constants/colors.dart';
import 'package:event_music_app/Helper/texts.dart';
import 'package:event_music_app/data/band_model.dart';
import 'package:flutter/material.dart';

class Mp3 extends StatefulWidget {
  List<Track> tracks;

  Mp3({super.key, required this.tracks});

  @override
  State<Mp3> createState() => _Mp3State();
}

class _Mp3State extends State<Mp3> {
  AudioPlayer _audioPlayer = AudioPlayer();
  int _currentTrackIndex = -1;
  PlayerState _playerState = PlayerState.stopped;
  Duration _currentPosition = Duration.zero;
  Duration _trackDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _trackDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  void _playPause() {
    if (_currentTrackIndex == -1) return; // Do nothing if no track is selected

    if (_playerState == PlayerState.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(widget.tracks[_currentTrackIndex].file));
    }
  }

  void _playNext() {
    if (_currentTrackIndex < widget.tracks.length - 1) {
      setState(() {
        _currentTrackIndex++;
        _audioPlayer.play(UrlSource(widget.tracks[_currentTrackIndex].file));
      });
    }
  }

  void _playPrevious() {
    if (_currentTrackIndex > 0) {
      setState(() {
        _currentTrackIndex--;
        _audioPlayer.play(UrlSource(widget.tracks[_currentTrackIndex].file));
      });
    }
  }

  void _cancelPlayback() {
    _audioPlayer.stop();
    setState(() {
      _currentTrackIndex = -1;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tracks = widget.tracks;
    return Scaffold(
        backgroundColor: Colors.transparent,
        bottomSheet:_currentTrackIndex == -1
            ? null
            : Container(
            height: 80,
            width: double.infinity,
            color: white,
            child: Column(children: [
              Stack(children: [
                Container(
                    width: double.infinity,
                    height: 5,
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10))),
                Container(
                    width: 200,
                    height: 5,
                    decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(10))),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: tracks[_currentTrackIndex].title.isEmpty
                              ? Image.asset('assets/mp3.png')
                              : Image.network(tracks[_currentTrackIndex].image,
                                  width: 55, height: 55, fit: BoxFit.cover)),
                      SizedBox(width: 10),
                      Text(tracks[_currentTrackIndex].title,
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500))
                    ])),
                Positioned(
                    bottom: 0,
                    right: 5,
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [white, Color.fromARGB(199, 255, 255, 255)])),
                        child: Row(children: [
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: _playPrevious,
                              icon: Icon(Icons.skip_previous),
                              padding: EdgeInsets.zero),
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              onPressed: _playPause,
                              icon: Icon(_playerState == PlayerState.playing ? Icons.pause : Icons.play_arrow)),
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: _playNext,
                              icon: Icon(Icons.skip_next),
                              padding: EdgeInsets.zero),
                          SizedBox(height: 40, child: VerticalDivider(thickness: 2, color: Colors.black54)),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            onPressed:_cancelPlayback,
                            icon: Icon(Icons.cancel_outlined),
                            color: Colors.black87,
                          )
                        ])))
              ])
            ])),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: widget.tracks.length,
            itemBuilder: (_, i) {
              final track = widget.tracks[i];
              return Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 0),
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: primary),
                      child: ListTile(
                          onTap: () {
                            setState(() {
                              _currentTrackIndex = i;
                            });
                            _audioPlayer.play(UrlSource(track.file));
                          },
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: track.image.isEmpty ? Image.asset('assets/mp3.png') : Image.network(track.image)),
                          title: Text(
                            track.title,
                            style: Boldt16,
                          ),
                          subtitle: Text(
                            track.singers,
                            maxLines: 2,
                            style: Lightt12,
                          ),
                          trailing: CircleAvatar(
                              radius: 20,
                              backgroundColor: white,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    _currentTrackIndex == i && _playerState == PlayerState.playing
                                        ? Icons.multitrack_audio
                                        : Icons.play_arrow_rounded,
                                    color: black,
                                  ))))));
            }));
  }
}
