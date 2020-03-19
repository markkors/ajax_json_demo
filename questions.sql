-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Gegenereerd op: 19 mrt 2020 om 15:57
-- Serverversie: 5.5.62-MariaDB
-- PHP-versie: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `questions`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `answer`
--

CREATE TABLE `answer` (
  `idAnswer` int(11) NOT NULL,
  `Prefix` varchar(255) DEFAULT NULL,
  `AnwerText` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `answer`
--

INSERT INTO `answer` (`idAnswer`, `Prefix`, `AnwerText`) VALUES
(1, 'a', 'antwoord a'),
(2, 'b ', 'antwoord b'),
(3, 'c', 'antwoord c'),
(4, 'd', 'antwoord d');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `player`
--

CREATE TABLE `player` (
  `idPlayer` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `player`
--

INSERT INTO `player` (`idPlayer`, `Name`) VALUES
(1, 'mark'),
(2, 'kees');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `playeranswer`
--

CREATE TABLE `playeranswer` (
  `idPlayerAnswer` int(11) NOT NULL,
  `PlayerID` int(11) DEFAULT NULL,
  `QuestionID` int(11) DEFAULT NULL,
  `Answer` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `playeranswer`
--

INSERT INTO `playeranswer` (`idPlayerAnswer`, `PlayerID`, `QuestionID`, `Answer`) VALUES
(3, 2, 1, 'a'),
(4, 2, 4, 'b'),
(5, 1, 1, 'c'),
(6, 1, 4, 'd');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `question`
--

CREATE TABLE `question` (
  `idQuestion` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `Desc` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `question`
--

INSERT INTO `question` (`idQuestion`, `Type`, `Desc`) VALUES
(1, 1, 'Vraag 1 abcd'),
(4, 1, 'Vraag 2 abcd'),
(5, 1, 'Vraag 3 abcd');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `questionanswer`
--

CREATE TABLE `questionanswer` (
  `idQuestionAnswer` int(11) NOT NULL,
  `QuestionID` int(11) DEFAULT NULL,
  `AnswerID` int(11) NOT NULL,
  `Correct` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `questionanswer`
--

INSERT INTO `questionanswer` (`idQuestionAnswer`, `QuestionID`, `AnswerID`, `Correct`) VALUES
(1, 1, 1, b'0'),
(2, 1, 2, b'1'),
(3, 1, 3, b'0'),
(4, 1, 4, b'0'),
(5, 4, 1, b'0'),
(6, 4, 2, b'0'),
(7, 4, 3, b'0'),
(8, 4, 4, b'1');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `questionstype`
--

CREATE TABLE `questionstype` (
  `idQuestionsTypes` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `questionstype`
--

INSERT INTO `questionstype` (`idQuestionsTypes`, `Name`) VALUES
(1, 'meerkeuze'),
(2, 'open');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `quiz`
--

CREATE TABLE `quiz` (
  `idQuiz` int(11) NOT NULL,
  `Date` datetime NOT NULL,
  `Name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `quiz`
--

INSERT INTO `quiz` (`idQuiz`, `Date`, `Name`) VALUES
(1, '2020-02-05 00:00:00', 'eerste quiz'),
(2, '2020-02-08 00:00:00', 'quiz 2');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `quizplayer`
--

CREATE TABLE `quizplayer` (
  `idQuizPlayer` int(11) NOT NULL,
  `QuizID` int(11) NOT NULL,
  `PlayerID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `quizplayer`
--

INSERT INTO `quizplayer` (`idQuizPlayer`, `QuizID`, `PlayerID`) VALUES
(1, 1, 2),
(2, 1, 1),
(3, 2, 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `quizquestion`
--

CREATE TABLE `quizquestion` (
  `idQuizQuestion` int(11) NOT NULL,
  `QuizID` int(11) DEFAULT NULL,
  `QuestionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `quizquestion`
--

INSERT INTO `quizquestion` (`idQuizQuestion`, `QuizID`, `QuestionID`) VALUES
(1, 1, 1),
(2, 1, 4);

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`idAnswer`);

--
-- Indexen voor tabel `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`idPlayer`);

--
-- Indexen voor tabel `playeranswer`
--
ALTER TABLE `playeranswer`
  ADD PRIMARY KEY (`idPlayerAnswer`),
  ADD KEY `fk_playeranswer_player_idx` (`PlayerID`),
  ADD KEY `fk_playeranswer_question_idx` (`QuestionID`);

--
-- Indexen voor tabel `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`idQuestion`,`Type`),
  ADD KEY `fk_question_questiontype_idx` (`Type`);

--
-- Indexen voor tabel `questionanswer`
--
ALTER TABLE `questionanswer`
  ADD PRIMARY KEY (`idQuestionAnswer`,`AnswerID`),
  ADD KEY `fk_questionanswer_question_idx` (`QuestionID`),
  ADD KEY `fk_questionanswer_answer_idx` (`AnswerID`);

--
-- Indexen voor tabel `questionstype`
--
ALTER TABLE `questionstype`
  ADD PRIMARY KEY (`idQuestionsTypes`);

--
-- Indexen voor tabel `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`idQuiz`);

--
-- Indexen voor tabel `quizplayer`
--
ALTER TABLE `quizplayer`
  ADD PRIMARY KEY (`idQuizPlayer`),
  ADD KEY `fk_quizplayer_quiz_idx` (`QuizID`),
  ADD KEY `fk_quizplayer_player_idx` (`PlayerID`);

--
-- Indexen voor tabel `quizquestion`
--
ALTER TABLE `quizquestion`
  ADD PRIMARY KEY (`idQuizQuestion`,`QuestionID`),
  ADD KEY `fk_quizquestion_quiz_idx` (`QuizID`),
  ADD KEY `fk_quizquestion_question_idx` (`QuestionID`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `answer`
--
ALTER TABLE `answer`
  MODIFY `idAnswer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT voor een tabel `player`
--
ALTER TABLE `player`
  MODIFY `idPlayer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT voor een tabel `playeranswer`
--
ALTER TABLE `playeranswer`
  MODIFY `idPlayerAnswer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT voor een tabel `question`
--
ALTER TABLE `question`
  MODIFY `idQuestion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT voor een tabel `questionanswer`
--
ALTER TABLE `questionanswer`
  MODIFY `idQuestionAnswer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT voor een tabel `questionstype`
--
ALTER TABLE `questionstype`
  MODIFY `idQuestionsTypes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT voor een tabel `quiz`
--
ALTER TABLE `quiz`
  MODIFY `idQuiz` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT voor een tabel `quizplayer`
--
ALTER TABLE `quizplayer`
  MODIFY `idQuizPlayer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT voor een tabel `quizquestion`
--
ALTER TABLE `quizquestion`
  MODIFY `idQuizQuestion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `playeranswer`
--
ALTER TABLE `playeranswer`
  ADD CONSTRAINT `fk_playeranswer_player` FOREIGN KEY (`PlayerID`) REFERENCES `player` (`idPlayer`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_playeranswer_question` FOREIGN KEY (`QuestionID`) REFERENCES `quizquestion` (`QuestionID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Beperkingen voor tabel `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `fk_question_questiontype` FOREIGN KEY (`Type`) REFERENCES `questionstype` (`idQuestionsTypes`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Beperkingen voor tabel `questionanswer`
--
ALTER TABLE `questionanswer`
  ADD CONSTRAINT `fk_questionanswer_answer` FOREIGN KEY (`AnswerID`) REFERENCES `answer` (`idAnswer`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_questionanswer_question` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`idQuestion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Beperkingen voor tabel `quizplayer`
--
ALTER TABLE `quizplayer`
  ADD CONSTRAINT `fk_quizplayer_player` FOREIGN KEY (`PlayerID`) REFERENCES `player` (`idPlayer`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_quizplayer_quiz` FOREIGN KEY (`QuizID`) REFERENCES `quiz` (`idQuiz`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Beperkingen voor tabel `quizquestion`
--
ALTER TABLE `quizquestion`
  ADD CONSTRAINT `fk_quizquestion_question` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`idQuestion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_quizquestion_quiz` FOREIGN KEY (`QuizID`) REFERENCES `quiz` (`idQuiz`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
