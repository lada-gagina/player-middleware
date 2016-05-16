/* Copyright 2014-2016 CyberTech Labs Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License. */

#include <QtCore/QObject>
#include <QtCore/QDebug>

#include <trikControl/brickInterface.h>

class Gyroscope : public QObject
{
	Q_OBJECT
public:
	Gyroscope(trikControl::BrickInterface &brick)
		: mBrick(brick)
	{
	}

public slots:
	void showGyroscopeReading()
	{
		auto const reading = mBrick.gyroscope()->read();
		qDebug() << reading;
		mBrick.display()->addLabel(QString("(%1, %2, %3)").arg(reading[0]).arg(reading[1]).arg(reading[2]), 1, 1);
	}

private:
	trikControl::BrickInterface &mBrick;
};
