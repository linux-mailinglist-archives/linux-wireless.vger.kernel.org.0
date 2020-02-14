Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A023A15F8DF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 22:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbgBNVls (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 16:41:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38768 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgBNVls (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 16:41:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so12315943wmj.3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Feb 2020 13:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=xNCHrPO4JYCGtwyLOoSZamBrBi1JStpfFpUBxbCqbpQ=;
        b=hjbsD4W6cHmcO7pAnWYtm26nBExg4mG1J6JIzkCEKwXJoXFgnj+j2REcZ7E70k5i+L
         kWT2oH9L27+4Moat09tHqLjKRx+X+p6VtEUcB1Xy+BV9R9AZQwe1se0OFgIeSxn2MVZS
         jLsDSP5K6cdLpX6B7oPq+Bet1EJsEXfVtvS9zsLRC2Kb2UAcG4zPWd4XUKjZlWp73TsR
         RS7s6tzxRxZZZzZ+BJGRdD+fPdcXbMs5C6/5sa8VXS0k99QZLoyo7ITG4m57dD2Z2NZ1
         5lbWSY+zWXvEQcqY24YkW/NosItC7Dcy6+q5CvB9HyPbsrh2pS2wUAHd1lWwX9Ueylw3
         5RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=xNCHrPO4JYCGtwyLOoSZamBrBi1JStpfFpUBxbCqbpQ=;
        b=CGr6hPhETlNYme/w/m68cKjzMCErILpsUl33LUZgZG7YhM5wwTe4KyqUNBzV4N+n4f
         ymtVaoie1gPrPtDLKnH44QWl4rn62DLtquNrIIeLP7L8qhsIevhLEH3RApreVmfJt6V1
         2bAw7bFuJ31BQkFDbmMQnIVE5wqQsLaBZeNB22p9HbdsEQolUHZzu3JoJE1j25JSg0Ar
         vxx6uTg/xPTKG7QHpwMpbCvKmkhaaKQS0NnFm+M48gKTbynQEMCUU9TPom8dk1izg2Vd
         TJ6tAiJgZ+gtG9JQhbrJ3ikxCJud5IbGqyCLWGcMiwK+ny+g5Ewo+ThDfco3XkjcvGUo
         jeCQ==
X-Gm-Message-State: APjAAAXVs+a6cN2xLxmIWRb7dKCUcF9obTMAf5uvd4aikUpI5PBrDU09
        qT4vJ1D/JCs5RTG+gHYH4Nej38K8
X-Google-Smtp-Source: APXvYqwO0ZV8AcNQOTZOTrEkkspmDeHTCpprZ9ZQGlu66KRSjrOShh2+c4TYwfgMPKXtjujyAuGlMw==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr6731998wmi.20.1581716498465;
        Fri, 14 Feb 2020 13:41:38 -0800 (PST)
Received: from t2b3 ([5.56.225.192])
        by smtp.gmail.com with ESMTPSA id b18sm8803908wru.50.2020.02.14.13.41.36
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:41:37 -0800 (PST)
Date:   Fri, 14 Feb 2020 22:41:34 +0100
From:   Tobias Predel <tobias.predel@gmail.com>
To:     linux-wireless@vger.kernel.org
Subject: [rtw88] Linux 5.6-rc1 / RTL8822BE WiFi adapter
Message-ID: <20200214214134.GA12764@t2b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I use linux-mainline (5.6.0-rc1, Arch Linux config) in order to check for 
improvements for the rtw88 driver because I have been experiencing a lot of 
connection losses so far for my Realtek Semiconductor Co., Ltd. RTL8822BE 
802.11a/b/g/n/ac WiFi adapter (Hewlett-Packard Company Realtek RTL8822BE 
802.11ac 2 × 2 Wi-Fi + Bluetooth 4.2 Combo Adapter (MU-MIMO supported))

So far multiple warnings and errors are reported while being connected with
a wireless network - I tested also another network and get similiar
behavior.

In short, I get several "timed out to flush queue 1" and sometimes 
"failed to send h2c command" warning messages leading sometimes to
connection losses or throttling.

Is the provided firmware file in the linux-firmware tree still
compatible with the driver code?

I would be very glad if someone could look into this.

Feb 14 20:54:29 t2b3 kernel: rtw_pci 0000:02:00.0: failed to send h2c command
Feb 14 20:58:37 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-92 noise=9999 txrate=270000
Feb 14 20:58:46 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 20:58:48 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 20:58:48 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-67 noise=9999 txrate=270000
Feb 14 20:59:42 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-74 noise=9999 txrate=270000
Feb 14 20:59:53 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 20:59:54 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:00:02 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-66 noise=9999 txrate=243000
Feb 14 21:00:02 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-85 noise=9999 txrate=243000
Feb 14 21:00:07 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
Feb 14 21:00:12 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:00:14 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:00:14 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-71 noise=9999 txrate=243000
Feb 14 21:00:49 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-74 noise=9999 txrate=270000
Feb 14 21:00:56 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:00:57 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:00:57 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:00:58 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:01:00 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:01:00 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-65 noise=9999 txrate=270000
Feb 14 21:01:00 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-65 noise=9999 txrate=270000
Feb 14 21:03:21 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-79 noise=9999 txrate=243000
Feb 14 21:03:29 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:03:33 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:03:43 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-66 noise=9999 txrate=300000
Feb 14 21:04:42 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-90 noise=9999 txrate=300000
Feb 14 21:04:48 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:04:49 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:04:54 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:04:54 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-68 noise=9999 txrate=243000
Feb 14 21:08:55 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-63 noise=9999 txrate=243000
Feb 14 21:10:36 t2b3 mutt[8832]: DIGEST-MD5 common mech free
Feb 14 21:11:29 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-95 noise=9999 txrate=243000
Feb 14 21:11:41 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:11:41 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-65 noise=9999 txrate=270000
Feb 14 21:14:12 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-62 noise=9999 txrate=300000
Feb 14 21:15:08 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 21:15:32 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-72 noise=9999 txrate=243000
Feb 14 21:15:44 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:16:21 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:16:21 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:16:25 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:17:05 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:17:48 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:18:07 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-66 noise=9999 txrate=300000
Feb 14 21:18:46 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-72 noise=9999 txrate=300000
Feb 14 21:18:48 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:49 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:49 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:56 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:56 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:58 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:58 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:58 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:58 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:59 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:59 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:18:59 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:19:00 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-81 noise=9999 txrate=162000
Feb 14 21:19:01 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:19:03 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:19:05 t2b3 upowerd[1175]: energy 43.605000 bigger than full 43.513800
Feb 14 21:19:06 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:19:08 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:19:09 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:19:09 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:19:13 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:19:13 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:19:13 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-70 noise=9999 txrate=162000
Feb 14 21:22:47 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-62 noise=9999 txrate=243000
Feb 14 21:22:55 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-72 noise=9999 txrate=300000
Feb 14 21:23:06 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:23:11 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-66 noise=9999 txrate=243000
Feb 14 21:24:06 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-83 noise=9999 txrate=243000
Feb 14 21:24:13 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:24:18 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-67 noise=9999 txrate=270000
Feb 14 21:25:50 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-73 noise=9999 txrate=300000
Feb 14 21:26:01 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:26:03 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-65 noise=9999 txrate=243000
Feb 14 21:26:12 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-95 noise=9999 txrate=270000
Feb 14 21:26:23 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
Feb 14 21:26:23 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-64 noise=9999 txrate=243000
Feb 14 21:26:58 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-76 noise=9999 txrate=216000
Feb 14 21:27:09 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:27:10 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:27:10 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:27:10 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-69 noise=9999 txrate=216000
Feb 14 21:27:17 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-63 noise=9999 txrate=270000
Feb 14 21:27:40 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-103 noise=9999 txrate=243000
Feb 14 21:27:51 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:27:51 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-66 noise=9999 txrate=270000
Feb 14 21:28:09 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-64 noise=9999 txrate=162000
Feb 14 21:30:47 t2b3 kernel: perf: interrupt took too long (2547 > 2500), lowering kernel.perf_event_max_sample_rate t>
Feb 14 21:31:52 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 21:32:17 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-72 noise=9999 txrate=270000
Feb 14 21:32:21 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:32:27 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:32:27 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:27 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:27 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:27 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:29 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000000, rcr=0xf400408e
Feb 14 21:32:29 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x1b, len=18
Feb 14 21:32:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 21:32:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 21:32:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 23000042 00000000
Feb 14 21:32:32 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-64 noise=9999 txrate=270000
Feb 14 21:32:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:34 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 21:32:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:34 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:32:35 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x13, len=7
Feb 14 21:32:35 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x14, len=7
Feb 14 21:32:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:32:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:32:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 27000042 00000000
Feb 14 21:32:36 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x15, len=7
Feb 14 21:32:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 27000042 00000000
Feb 14 21:32:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 21:32:40 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-75 noise=9999 txrate=216000
Feb 14 21:32:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:40 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:40 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000010, rcr=0xf400400e
Feb 14 21:32:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:40 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:45 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:45 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:45 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:45 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:45 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:45 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:45 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
[...]
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:50 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:51 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:51 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:51 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:32:51 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-69 noise=9999 txrate=216000
Feb 14 21:32:51 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-69 noise=9999 txrate=216000
Feb 14 21:32:51 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:51 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:51 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000000, rcr=0xf400408e
Feb 14 21:32:51 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x1c, len=18
Feb 14 21:32:51 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000010, rcr=0xf400400e
Feb 14 21:32:52 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:52 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:54 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:54 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:55 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:57 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:58 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:58 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:58 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:32:58 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:32:58 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:32:58 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:58 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:58 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x16, len=7
Feb 14 21:32:58 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:58 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:32:59 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x17, len=7
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:33:00 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:33:01 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:33:01 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:33:01 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:33:01 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:33:01 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:33:01 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:33:01 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:33:01 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
[...]
Feb 14 21:34:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:12 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1f000042 00000000
Feb 14 21:34:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:12 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:34:14 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x32, len=7
Feb 14 21:34:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:34:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:34:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:14 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:14 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000010, rcr=0xf400400e
Feb 14 21:34:14 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x33, len=7
Feb 14 21:34:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:34:14 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:34:18 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:34:18 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:34:18 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:18 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:18 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:34:18 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:34:18 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:18 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:19 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:20 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:21 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:22 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
[...]
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x34, len=7
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
geb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x35, len=7
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:34:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:34:27 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:27 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:27 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:34:27 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:34:27 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:34:27 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000000, rcr=0xf400408e
Feb 14 21:34:27 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x1f, len=18
Feb 14 21:34:27 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x36, len=7
Feb 14 21:34:28 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x37, len=7
Feb 14 21:34:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1c000042 00000000
Feb 14 21:34:29 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x38, len=7
Feb 14 21:34:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1c000042 00000000
Feb 14 21:34:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0ffff010
Feb 14 21:34:32 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x39, len=7
Feb 14 21:34:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 21:34:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:34:34 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:34:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 22000042 00000000
Feb 14 21:34:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1e000042 00000000
Feb 14 21:34:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:34:36 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:34:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:34:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:34:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:34:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1d000042 00000000
Feb 14 21:34:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0ffff010
Feb 14 21:34:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:34:38 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x3a, len=7
Feb 14 21:34:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:34:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:34:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1d000042 00000000
Feb 14 21:34:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:34:40 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x3b, len=7
Feb 14 21:34:42 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:34:42 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:34:42 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1c000042 00000000
Feb 14 21:34:42 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:34:42 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x3c, len=7
Feb 14 21:34:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:34:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:34:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1d000042 00000000
Feb 14 21:34:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:34:44 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x3d, len=7
Feb 14 21:34:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:34:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:34:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1d000042 00000000
Feb 14 21:34:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0ffff010
Feb 14 21:34:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:34:46 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x3e, len=7
Feb 14 21:34:48 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:34:48 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:34:48 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1d000042 00000000
Feb 14 21:34:48 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:34:48 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x3f, len=7
Feb 14 21:34:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:34:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:34:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1c000042 00000000
Feb 14 21:34:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:34:50 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x40, len=7
[...]
Feb 14 21:36:04 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 21:36:04 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 21:36:06 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 21000042 00000000
Feb 14 21:36:08 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 21:36:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:10 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 23000042 00000000
Feb 14 21:36:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:10 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:36:12 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x5c, len=7
Feb 14 21:36:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:36:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:36:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 23000042 00000000
Feb 14 21:36:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 21:36:12 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x5d, len=7
Feb 14 21:36:12 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x5e, len=7
Feb 14 21:36:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 21:36:16 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 20000042 00000000
Feb 14 21:36:18 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 21:36:19 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:36:19 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:36:19 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000010, rcr=0xf400400e
Feb 14 21:36:20 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:20 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:36:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:36:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:27 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:27 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:27 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:27 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:27 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:27 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:27 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:27 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:27 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:27 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:29 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:29 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:36:30 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:36:31 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:36:31 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:31 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:31 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000000, rcr=0xf400408e
Feb 14 21:36:31 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x22, len=18
Feb 14 21:36:31 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x5f, len=7
Feb 14 21:36:32 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x60, len=7
Feb 14 21:36:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:36:32 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:36:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 21:36:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 21:36:32 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x61, len=7
Feb 14 21:36:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 21000042 00000000
Feb 14 21:36:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:36:36 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:36:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 20000042 00000000
[...]
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x73, len=7
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:49:22 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:49:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:49:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:49:23 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:49:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:23 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x74, len=7
Feb 14 21:49:23 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:49:23 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:49:24 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:49:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:49:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:49:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:49:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 1
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:49:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:26 t2b3 wpa_supplicant[615]: nl80211: send_and_recv->nl_recvmsgs failed: -33
Feb 14 21:49:26 t2b3 wpa_supplicant[615]: wlp2s0: SME: Trying to authenticate with a4:2b:b0:c1:6f:44 (SSID='TP-Link_3F>
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000000, rcr=0xf400408e
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x2c, len=18
Feb 14 21:49:26 t2b3 kernel: wlp2s0: disconnect from AP 98:da:c4:5c:3f:b8 for new auth to a4:2b:b0:c1:6f:44
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000001 00000000
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: sta 98:da:c4:5c:3f:b8 with macid 0 left
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: this vif is not mu bfee
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:26 t2b3 kernel: wlp2s0: authenticate with a4:2b:b0:c1:6f:44
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x00, len=7
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: coex: bt status(0)
Feb 14 21:49:26 t2b3 kernel: wlp2s0: send auth to a4:2b:b0:c1:6f:44 (try 1/3)
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x01, len=7
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: get alpha2 00 from initiator 0, mapping to chplan 0x7f, txregd 9
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x00, len=18
Feb 14 21:49:26 t2b3 NetworkManager[517]: <info>  [1581713366.8172] device (wlp2s0): supplicant interface state: compl>
Feb 14 21:49:26 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-REGDOM-CHANGE init=CORE type=WORLD
Feb 14 21:49:26 t2b3 kernel: wlp2s0: send auth to a4:2b:b0:c1:6f:44 (try 2/3)
Feb 14 21:49:26 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x01, len=18
Feb 14 21:49:27 t2b3 kernel: wlp2s0: send auth to a4:2b:b0:c1:6f:44 (try 3/3)
Feb 14 21:49:27 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x02, len=18
Feb 14 21:49:27 t2b3 kernel: wlp2s0: authentication with a4:2b:b0:c1:6f:44 timed out
[...]
eb 14 21:52:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:52:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:52:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 21000042 00000000
Feb 14 21:52:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0ffff010
Feb 14 21:52:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:52:36 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x62, len=7
Feb 14 21:52:37 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x63, len=7
Feb 14 21:52:37 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x64, len=7
Feb 14 21:52:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:52:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:52:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 21000042 00000000
Feb 14 21:52:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:52:38 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x65, len=7
Feb 14 21:52:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:52:40 t2b3 kernel: rtw_pci 0000:02:00.0: firmware failed to restore hardware setting
Feb 14 21:52:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:52:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 22000042 00000000
Feb 14 21:52:40 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x66, len=7
Feb 14 21:52:42 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 21000042 00000000
Feb 14 21:52:42 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:52:42 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x67, len=7
Feb 14 21:52:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:52:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:52:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 23000042 00000000
Feb 14 21:52:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0ffff010
Feb 14 21:52:44 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x68, len=7
Feb 14 21:52:44 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x69, len=7
Feb 14 21:52:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 21:52:48 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:52:48 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:52:48 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 21000042 00000000
Feb 14 21:52:48 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:52:48 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:52:48 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:52:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:52:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:52:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 1f000042 00000000
Feb 14 21:52:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:52:50 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x6a, len=7
Feb 14 21:52:52 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:52:52 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:52:52 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 21:52:52 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 21:52:52 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x6b, len=7
Feb 14 21:52:54 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:52:54 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:52:54 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 23000042 00000000
Feb 14 21:52:54 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:52:54 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:58:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:58:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:58:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 22000042 00000000
Feb 14 21:58:22 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0xe3, len=7
Feb 14 21:58:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:58:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:58:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 20000042 00000000
Feb 14 21:58:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:58:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:58:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:58:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:58:26 t2b3 kernel: rtw_pci 0000:02:00.0: firmware failed to restore hardware setting
Feb 14 21:58:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:58:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 21:58:26 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0xe4, len=7
Feb 14 21:58:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:58:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:58:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 20000042 00000000
Feb 14 21:58:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0ffff010
Feb 14 21:58:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:58:28 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:58:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:58:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:58:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:58:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 20000042 00000000
Feb 14 21:58:30 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0xe5, len=7
Feb 14 21:59:21 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0xff, len=7
Feb 14 21:59:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:59:22 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:59:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 24000042 00000000
Feb 14 21:59:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:59:22 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:59:22 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:59:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:59:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:59:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 23000042 00000000
Feb 14 21:59:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 21:59:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:59:24 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x00, len=7
Feb 14 21:59:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:59:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:59:26 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 22000042 00000000
Feb 14 21:59:26 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x01, len=7
Feb 14 21:59:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 24000042 00000000
Feb 14 21:59:30 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x02, len=7
Feb 14 21:59:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 21:59:32 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 21:59:32 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x04, len=18
Feb 14 21:59:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:59:32 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:59:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 23000042 00000000
Feb 14 21:59:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 21:59:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:59:32 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:59:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:59:32 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x03, len=7
Feb 14 21:59:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:59:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:59:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 24000042 00000000
Feb 14 21:59:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:59:34 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x04, len=7
Feb 14 21:59:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:59:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:59:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 24000042 00000000
Feb 14 21:59:36 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x05, len=7
Feb 14 21:59:38 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 21:59:38 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x05, len=18
Feb 14 21:59:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:59:38 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:59:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 24000042 00000000
Feb 14 21:59:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:59:38 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:59:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:59:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:59:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:59:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 24000042 00000000
Feb 14 21:59:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 21:59:40 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x06, len=7
Feb 14 21:59:42 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 22000042 00000000
Feb 14 21:59:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 21:59:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 21:59:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 20000042 00000000
Feb 14 21:59:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 21:59:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 21:59:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 21:59:45 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x07, len=7
Feb 14 21:59:46 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x08, len=7
Feb 14 21:59:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 21:59:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 21:59:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 24000042 00000000
Feb 14 21:59:46 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x09, len=7
[...]
Feb 14 22:00:02 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:00:02 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:00:02 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 20000042 00000000
Feb 14 22:00:02 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:00:02 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x10, len=7
Feb 14 22:00:02 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x11, len=7
Feb 14 22:00:04 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:00:04 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:00:04 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 20000042 00000000
Feb 14 22:00:04 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0ffff010
Feb 14 22:00:04 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x12, len=7
Feb 14 22:00:04 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x13, len=7
Feb 14 22:00:06 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 22000042 00000000
Feb 14 22:00:08 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 22:00:09 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:00:09 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x06, len=18
Feb 14 22:00:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:00:10 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:00:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:00:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:00:10 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:00:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:00:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:00:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:00:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 23000042 00000000
Feb 14 22:00:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 22:00:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:00:12 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x14, len=7
Feb 14 22:00:12 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x15, len=7
Feb 14 22:00:13 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x16, len=7
Feb 14 22:00:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:00:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:00:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 22000042 00000000
Feb 14 22:00:14 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x17, len=7
Feb 14 22:00:16 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:00:16 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:00:16 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 21000042 00000000
Feb 14 22:00:16 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:00:16 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:00:16 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:00:18 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x18, len=7
Feb 14 22:00:18 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:00:18 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:00:18 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 22:00:18 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x19, len=7
Feb 14 22:00:20 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:00:20 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:00:20 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 21000042 00000000
Feb 14 22:00:20 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0ffff010
Feb 14 22:00:20 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:00:20 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
[...]
Feb 14 22:02:06 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x48, len=7
Feb 14 22:02:06 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:02:06 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:02:06 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 24000042 00000000
Feb 14 22:02:06 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0ffff010
Feb 14 22:02:06 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x49, len=7
Feb 14 22:02:06 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x4a, len=7
Feb 14 22:02:08 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:02:08 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:02:08 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 22000042 00000000
Feb 14 22:02:08 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:02:08 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:02:08 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:02:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:02:10 t2b3 kernel: rtw_pci 0000:02:00.0: firmware failed to restore hardware setting
Feb 14 22:02:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:02:10 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:02:10 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x4b, len=7
Feb 14 22:02:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:02:12 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:02:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 23000042 00000000
Feb 14 22:02:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:02:12 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:02:12 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:02:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:02:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:02:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 20000042 00000000
Feb 14 22:02:14 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0ffff010
Feb 14 22:02:14 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x4c, len=7
Feb 14 22:02:16 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 22:02:16 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 22:02:16 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 22000042 00000000
Feb 14 22:02:18 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:02:18 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:02:18 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 21000042 00000000
Feb 14 22:02:18 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:02:18 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
[...]
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000000, rcr=0xf400408e
Feb 14 22:04:24 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x07, len=18
Feb 14 22:04:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 22:04:25 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 22:04:25 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 27000042 00000000
Feb 14 22:04:26 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:26 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x08, len=18
Feb 14 22:04:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:04:28 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 22:04:29 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x85, len=7
Feb 14 22:04:29 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x86, len=7
Feb 14 22:04:30 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:04:31 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:31 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x09, len=18
Feb 14 22:04:32 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:04:33 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:33 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x0a, len=18
Feb 14 22:04:34 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 27000042 00000000
Feb 14 22:04:35 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:35 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x0b, len=18
Feb 14 22:04:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:04:36 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:04:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:04:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 22:04:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:04:36 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:04:36 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:04:36 t2b3 kernel: rtw_pci 0000:02:00.0: failed to send h2c command
Feb 14 22:04:37 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:37 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:04:37 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:04:37 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x87, len=7
Feb 14 22:04:37 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x0c, len=18
Feb 14 22:04:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 22:04:38 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 22:04:38 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:04:39 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x0c, seq=0x88, len=7
Feb 14 22:04:39 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:39 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x0d, len=18
Feb 14 22:04:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:04:40 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:04:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:04:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:04:40 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:04:40 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:04:41 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:41 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:04:41 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:04:41 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x89, len=7
Feb 14 22:04:41 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x0e, len=18
Feb 14 22:04:42 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:04:42 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:04:43 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:43 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:04:43 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:04:43 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x0f, len=18
Feb 14 22:04:43 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x8a, len=7
Feb 14 22:04:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 22:04:44 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 22:04:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 27000042 00000000
Feb 14 22:04:44 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 22:04:45 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:45 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x10, len=18
Feb 14 22:04:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:04:46 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:04:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:04:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:04:46 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:04:46 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:04:47 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:47 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:04:47 t2b3 kernel: rtw_pci 0000:02:00.0: firmware failed to restore hardware setting
Feb 14 22:04:47 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:04:47 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x8b, len=7
[...]
Feb 14 22:04:48 t2b3 kernel: ------------[ cut here ]------------
Feb 14 22:04:48 t2b3 kernel: purge skb(s) not reported by firmware
Feb 14 22:04:48 t2b3 kernel: WARNING: CPU: 4 PID: 0 at drivers/net/wireless/realtek/rtw88/tx.c:155 rtw_tx_report_purge>
Feb 14 22:04:48 t2b3 kernel: Modules linked in: ccm rfcomm fuse ebtable_filter ebtables ip6table_filter ip6_tables ipt>
Feb 14 22:04:48 t2b3 kernel:  intel_pch_thermal videodev intel_gtt agpgart ecdh_generic rfkill syscopyarea sysfillrect>
Feb 14 22:04:48 t2b3 kernel: CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.6.0-rc1-1-mainline #1
Feb 14 22:04:48 t2b3 kernel: Hardware name: HP HP ProBook 430 G5/8377, BIOS Q85 Ver. 01.09.01 10/15/2019
Feb 14 22:04:48 t2b3 kernel: RIP: 0010:rtw_tx_report_purge_timer+0x20/0x50 [rtw88]
Feb 14 22:04:48 t2b3 kernel: Code: 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 8b 47 f0 85 c0 75 01 c3 41 54 55 53 48>
Feb 14 22:04:48 t2b3 kernel: RSP: 0018:ffff9986c0230e78 EFLAGS: 00010286
Feb 14 22:04:48 t2b3 kernel: RAX: 0000000000000000 RBX: ffff8fa986325cf8 RCX: 0000000000000000
Feb 14 22:04:48 t2b3 kernel: RDX: 0000000000000102 RSI: 0000000000000086 RDI: 00000000ffffffff
Feb 14 22:04:48 t2b3 kernel: RBP: 0000000000000000 R08: 0000000000001cef R09: 0000000000000001
Feb 14 22:04:48 t2b3 kernel: R10: 0000000000000000 R11: 0000000000000001 R12: ffff8fa986325cf8
Feb 14 22:04:48 t2b3 kernel: R13: ffffffffc1572960 R14: ffff8fa99831dd80 R15: ffff8fa986325cf8
Feb 14 22:04:48 t2b3 kernel: FS:  0000000000000000(0000) GS:ffff8fa998300000(0000) knlGS:0000000000000000
Feb 14 22:04:48 t2b3 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 14 22:04:48 t2b3 kernel: CR2: 0000033af9588148 CR3: 000000010440a003 CR4: 00000000003606e0
Feb 14 22:04:48 t2b3 kernel: Call Trace:
Feb 14 22:04:48 t2b3 kernel:  <IRQ>
Feb 14 22:04:48 t2b3 kernel:  call_timer_fn+0x2d/0x160
Feb 14 22:04:48 t2b3 kernel:  run_timer_softirq+0x1ad/0x510
Feb 14 22:04:48 t2b3 kernel:  ? rtw_tx_report_enqueue+0x80/0x80 [rtw88]
Feb 14 22:04:48 t2b3 kernel:  __do_softirq+0x111/0x34d
Feb 14 22:04:48 t2b3 kernel:  irq_exit+0xac/0xd0
Feb 14 22:04:48 t2b3 kernel:  smp_apic_timer_interrupt+0xa6/0x1b0
Feb 14 22:04:48 t2b3 kernel:  apic_timer_interrupt+0xf/0x20
Feb 14 22:04:48 t2b3 kernel:  </IRQ>
Feb 14 22:04:48 t2b3 kernel: RIP: 0010:cpuidle_enter_state+0xc9/0x410
Feb 14 22:04:48 t2b3 kernel: Code: e8 ac 0d 98 ff 80 7c 24 0f 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 1c 03 00 00>
Feb 14 22:04:48 t2b3 kernel: RSP: 0018:ffff9986c011fe68 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
Feb 14 22:04:48 t2b3 kernel: RAX: ffff8fa998300000 RBX: ffff8fa998337600 RCX: 000000000000001f
Feb 14 22:04:48 t2b3 kernel: RDX: 0000000000000000 RSI: 00000000471c71c7 RDI: 0000000000000000
Feb 14 22:04:48 t2b3 kernel: RBP: ffffffffb92c9f20 R08: 000004deb749b76f R09: 0000000000001c78
Feb 14 22:04:48 t2b3 kernel: R10: 0000000000000800 R11: ffff8fa99832bd64 R12: 000004deb749b76f
Feb 14 22:04:48 t2b3 kernel: R13: 0000000000000006 R14: 0000000000000006 R15: ffff8fa995ee0000
Feb 14 22:04:48 t2b3 kernel:  ? cpuidle_enter_state+0xa4/0x410
Feb 14 22:04:48 t2b3 kernel:  cpuidle_enter+0x29/0x40
Feb 14 22:04:48 t2b3 kernel:  do_idle+0x1e6/0x270
Feb 14 22:04:48 t2b3 kernel:  cpu_startup_entry+0x19/0x20
Feb 14 22:04:48 t2b3 kernel:  start_secondary+0x186/0x1d0
Feb 14 22:04:48 t2b3 kernel:  secondary_startup_64+0xb6/0xc0
Feb 14 22:04:48 t2b3 kernel: ---[ end trace f47b25d3e719c265 ]---
Feb 14 22:04:48 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 22:04:48 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:04:48 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x11, len=18
Feb 14 22:04:49 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:49 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:04:49 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:04:49 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x8c, len=7
Feb 14 22:04:49 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x12, len=18
Feb 14 22:04:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 22:04:50 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 22:04:50 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:04:51 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:51 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x13, len=18
Feb 14 22:04:52 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 26000042 00000000
Feb 14 22:04:52 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 49800040 0fffe000
Feb 14 22:04:53 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:53 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x14, len=18
Feb 14 22:04:54 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 03306160 00001111
Feb 14 22:04:54 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (3)
Feb 14 22:04:54 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 25000042 00000000
Feb 14 22:04:54 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:04:54 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:04:54 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01210120 00000000
Feb 14 22:04:54 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-BEACON-LOSS
Feb 14 22:04:54 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 01000020 00000c00
Feb 14 22:04:54 t2b3 kernel: rtw_pci 0000:02:00.0: firmware failed to restore hardware setting
Feb 14 22:04:54 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:04:54 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x8d, len=7
Feb 14 22:04:55 t2b3 kernel: ------------[ cut here ]------------
Feb 14 22:04:55 t2b3 kernel: purge skb(s) not reported by firmware
Feb 14 22:04:55 t2b3 kernel: WARNING: CPU: 4 PID: 0 at drivers/net/wireless/realtek/rtw88/tx.c:155 rtw_tx_report_purge>
Feb 14 22:04:55 t2b3 kernel: Modules linked in: ccm rfcomm fuse ebtable_filter ebtables ip6table_filter ip6_tables ipt>
Feb 14 22:04:55 t2b3 kernel:  intel_pch_thermal videodev intel_gtt agpgart ecdh_generic rfkill syscopyarea sysfillrect>
Feb 14 22:04:55 t2b3 kernel: CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W         5.6.0-rc1-1-mainline #1
Feb 14 22:04:55 t2b3 kernel: Hardware name: HP HP ProBook 430 G5/8377, BIOS Q85 Ver. 01.09.01 10/15/2019
Feb 14 22:04:55 t2b3 kernel: RIP: 0010:rtw_tx_report_purge_timer+0x20/0x50 [rtw88]
Feb 14 22:04:55 t2b3 kernel: Code: 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 8b 47 f0 85 c0 75 01 c3 41 54 55 53 48>
Feb 14 22:04:55 t2b3 kernel: RSP: 0018:ffff9986c0230e78 EFLAGS: 00010286
Feb 14 22:04:55 t2b3 kernel: RAX: 0000000000000000 RBX: ffff8fa986325cf8 RCX: 0000000000000000
Feb 14 22:04:55 t2b3 kernel: RDX: 0000000000000102 RSI: 0000000000000086 RDI: 00000000ffffffff
Feb 14 22:04:55 t2b3 kernel: RBP: 0000000000000000 R08: 0000000000001d32 R09: 0000000000000001
Feb 14 22:04:55 t2b3 kernel: R10: 0000000000000000 R11: 0000000000000001 R12: ffff8fa986325cf8
Feb 14 22:04:55 t2b3 kernel: R13: ffffffffc1572960 R14: ffff8fa99831dd80 R15: ffff8fa986325cf8
Feb 14 22:04:55 t2b3 kernel: FS:  0000000000000000(0000) GS:ffff8fa998300000(0000) knlGS:0000000000000000
Feb 14 22:04:55 t2b3 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 14 22:04:55 t2b3 kernel: CR2: 00000265bd18c000 CR3: 000000010440a002 CR4: 00000000003606e0
Feb 14 22:04:55 t2b3 kernel: Call Trace:
Feb 14 22:04:55 t2b3 kernel:  <IRQ>
Feb 14 22:04:55 t2b3 kernel:  call_timer_fn+0x2d/0x160
Feb 14 22:04:55 t2b3 kernel:  run_timer_softirq+0x1ad/0x510
Feb 14 22:04:55 t2b3 kernel:  ? rtw_tx_report_enqueue+0x80/0x80 [rtw88]
Feb 14 22:04:55 t2b3 kernel:  __do_softirq+0x111/0x34d
Feb 14 22:04:55 t2b3 kernel:  irq_exit+0xac/0xd0
Feb 14 22:04:55 t2b3 kernel:  smp_apic_timer_interrupt+0xa6/0x1b0
Feb 14 22:04:55 t2b3 kernel:  apic_timer_interrupt+0xf/0x20
Feb 14 22:04:55 t2b3 kernel:  </IRQ>
Feb 14 22:04:55 t2b3 kernel: RIP: 0010:cpuidle_enter_state+0xc9/0x410
Feb 14 22:04:55 t2b3 kernel: Code: e8 ac 0d 98 ff 80 7c 24 0f 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 1c 03 00 00>
Feb 14 22:04:55 t2b3 kernel: RSP: 0018:ffff9986c011fe68 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
Feb 14 22:04:55 t2b3 kernel: RAX: ffff8fa998300000 RBX: ffff8fa998337600 RCX: 000000000000001f
Feb 14 22:04:55 t2b3 kernel: RDX: 0000000000000000 RSI: 00000000471c71c7 RDI: 0000000000000000
Feb 14 22:04:55 t2b3 kernel: RBP: ffffffffb92c9f20 R08: 000004e05c804ff2 R09: 00000000000018a2
Feb 14 22:04:55 t2b3 kernel: R10: 0000000000000230 R11: ffff8fa99832bd64 R12: 000004e05c804ff2
Feb 14 22:04:55 t2b3 kernel: R13: 0000000000000004 R14: 0000000000000004 R15: ffff8fa995ee0000
Feb 14 22:04:55 t2b3 kernel:  ? cpuidle_enter_state+0xa4/0x410
Feb 14 22:04:55 t2b3 kernel:  cpuidle_enter+0x29/0x40
Feb 14 22:04:55 t2b3 kernel:  do_idle+0x1e6/0x270
Feb 14 22:04:55 t2b3 kernel:  cpu_startup_entry+0x19/0x20
Feb 14 22:04:55 t2b3 kernel:  start_secondary+0x186/0x1d0
Feb 14 22:04:55 t2b3 kernel:  secondary_startup_64+0xb6/0xc0
Feb 14 22:04:55 t2b3 kernel: ---[ end trace f47b25d3e719c266 ]---
Feb 14 22:04:55 t2b3 kernel: rtw_pci 0000:02:00.0: timed out to flush queue 2
Feb 14 22:04:55 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000001 00000000
Feb 14 22:04:55 t2b3 kernel: rtw_pci 0000:02:00.0: sta 98:da:c4:5c:3f:b8 with macid 0 left
Feb 14 22:04:55 t2b3 kernel: rtw_pci 0000:02:00.0: this vif is not mu bfee
Feb 14 22:04:55 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 22:04:55 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 22:04:55 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0xff, seq=0x15, len=18
Feb 14 22:04:55 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-DISCONNECTED bssid=98:da:c4:5c:3f:b8 reason=4 locally_gen>
Feb 14 22:04:55 t2b3 NetworkManager[517]: <warn>  [1581714295.5704] sup-iface[0x557f983ab120,wlp2s0]: connection disco>
Feb 14 22:04:55 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:04:55 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:04:55 t2b3 wpa_supplicant[615]: dbus: wpa_dbus_property_changed: no property SessionLength in object /fi/w1/>
Feb 14 22:04:55 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-REGDOM-CHANGE init=CORE type=WORLD
Feb 14 22:04:55 t2b3 kernel: rtw_pci 0000:02:00.0: get alpha2 00 from initiator 0, mapping to chplan 0x7f, txregd 9
Feb 14 22:04:55 t2b3 NetworkManager[517]: <info>  [1581714295.5928] device (wlp2s0): supplicant interface state: compl>
Feb 14 22:04:55 t2b3 wpa_supplicant[615]: wlp2s0: Reject scan trigger since one is already pending
Feb 14 22:04:55 t2b3 wpa_supplicant[615]: wlp2s0: Failed to initiate AP scan
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000161 00000000
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 033a6160 00001011
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (7)
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: config rx filter, changed=0x00000010, new=0x00000010, rcr=0xf400400e
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x00, len=7
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: coex: bt status(0)
Feb 14 22:04:56 t2b3 kernel: rtw_pci 0000:02:00.0: recv C2H, id=0x09, seq=0x01, len=7
Feb 14 22:04:56 t2b3 wpa_supplicant[615]: wlp2s0: Reject scan trigger since one is already pending
Feb 14 22:04:56 t2b3 wpa_supplicant[615]: wlp2s0: Failed to initiate AP scan
Feb 14 22:04:56 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
Feb 14 22:04:57 t2b3 kernel: rtw_pci 0000:02:00.0: send H2C content 00000060 00000000
Feb 14 22:04:57 t2b3 kernel: rtw_pci 0000:02:00.0: coex: coex tdma type (0)
Feb 14 22:04:57 t2b3 wpa_supplicant[615]: wlp2s0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
Feb 14 22:04:57 t2b3 wpa_supplicant[615]: wlp2s0: Reject scan trigger since one is already pending
Feb 14 22:04:57 t2b3 wpa_supplicant[615]: wlp2s0: Failed to initiate AP scan
Feb 14 22:04:58 t2b3 wpa_supplicant[615]: wlp2s0: Reject scan trigger since one is already pending
Feb 14 22:04:58 t2b3 wpa_supplicant[615]: wlp2s0: Failed to initiate AP scan
Feb 14 22:04:59 t2b3 wpa_supplicant[615]: wlp2s0: Reject scan trigger since one is already pending
Feb 14 22:04:59 t2b3 wpa_supplicant[615]: wlp2s0: Failed to initiate AP scan
[...]

Regards,
Tobias Predel
-- 
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
