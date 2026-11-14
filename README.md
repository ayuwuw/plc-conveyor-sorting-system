# PLC Conveyor Sorting System

## Project Purpose

The purpose of this project is to practise fundamental PLC programming concepts using Structured Text (ST).

## Description

This project implements a simple conveyor sorting system that detects and counts packages using optical and inductive sensors.

The system uses a pneumatic cylinder to divert packages and a state machine to control the conveyor operation.

## Main Features

- Start and reset functionality.
- Conveyor motor control.
- Package detection using an optical sensor.
- Metal detection using an inductive sensor.
- Total and metal package counting.
- Pneumatic cylinder control for package diversion.
- Limit switch monitoring.
- Cylinder timeout detection and fault handling.

## Operating States

- STOP: Conveyor is stopped and waiting for a start command.
- RUN: Conveyor runs and detects and counts packages.
- DIVERT_EXTEND: Conveyor stops and the cylinder extends.
- DIVERT_RETRACT: Cylinder retracts before the conveyor resumes.
- FAULT: Conveyor stops due to a timeout or error and waits for a reset.

## Technologies

- PLC Programming
- Structured Text (IEC 61131-3)
- State Machine
- Timers and Edge Detection

## Learning Objectives

Practise fundamental PLC concepts, including digital inputs and outputs, edge detection, timers, counters, state machines, and fault handling.
