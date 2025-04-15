import 'package:central_jogos/entities/match.dart';
import 'package:central_jogos/widgets/digit_placeholder.dart';
import 'package:flutter/material.dart';

class Scoreboard extends StatelessWidget {
  final bool readOnly, forceClean;
  final CompetitionMatch match;

  const Scoreboard({
    super.key, required this.match, 
    this.readOnly = false, this.forceClean = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(
            match.team1, 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 15,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: DigitPlaceHolder(
                    disableHorizontalRule: true, 
                    maxLength: 2,
                    readOnly: readOnly,
                    startValue: forceClean ? null : match.scoreTeam1,
                  ),
                ),
                  Text(
                    "X", 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: DigitPlaceHolder(
                      disableHorizontalRule: true, 
                      maxLength: 2,
                      readOnly: readOnly,
                      startValue: forceClean ? null : match.scoreTeam2,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            match.team2, 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }    
}