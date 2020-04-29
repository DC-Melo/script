#!/bin/sh
adb shell dumpsys activity |grep mFocusedActivity
