# AirBnB Database Seeding

This document explains how to use the `seed.sql` file to populate the AirBnB database with sample data. This data is useful for testing, development, and demonstration purposes.

## Table of Contents

- [Overview](#overview)
- [Purpose](#purpose)
- [Sample Data Included](#sample-data-included)
- [How to Use](#how-to-use)
- [Important Notes](#important-notes)

## Overview

The `seed.sql` script contains SQL `INSERT` statements that add sample records to all tables defined in the AirBnB database schema. Run this script after creating the tables with `schema.sql`.

## Purpose

- **Development:** Quickly set up a working database with initial data.
- **Testing:** Test queries, features, and data relationships without manual entry.
- **Demonstration:** Provide realistic data for demos and presentations.
- **Data Integrity:** Confirm that constraints and relationships work as expected.

## Sample Data Included

The `seed.sql` file provides sample data for:

- **Users:** Multiple accounts with roles such as guest, host, and admin.
- **Properties:** Various property listings by hosts (e.g., apartments, cabins, villas).
- **Bookings:** Bookings with different statuses (`confirmed`, `pending`, `canceled`).
- **Payments:** Payment records using different methods (`credit_card`, `paypal`, `stripe`).
- **Reviews:** Guest reviews with ratings and comments.
- **Messages:** Example messages between guests and hosts.
