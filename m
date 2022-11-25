Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3AF637F63
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKXTKF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXTKF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:10:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9A565E6C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:10:03 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id c1so3762396lfi.7
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DG509Zw3c4ynNldvtVQyH7nHb5PSNGv9f10CzTWAA6c=;
        b=axCXEygzaLNrKXJoir9c7t5FfQKihkk00Zw7iqvFFSEnZZ1zDn+lsrHSfSYwVjQCD8
         qGa0JCbS+5khT0VEd20xSp1Dp32ziAAYkqEzKM0RwzhSpZbwvw8h6/M/XdLCtWVhwYUr
         QWnrIuJOr38E3U8h+KwQ61yKwOMtpHxiNa9FAWkJmxO1PPNvrWw+jngZ7kOMLaZ30FhG
         sN4U3UXIW4gYaxVNYSCQT2hBbn346xf7LMP8gkINpCh/T5QbUDB6fXTdHVgtO/6Y+9rT
         hpYlJTdo+58QI25bsDybMwG5RylO0KIxUSqxuPuYc/kbirsoscPVF8LiY1j3xWOlR7ym
         sI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DG509Zw3c4ynNldvtVQyH7nHb5PSNGv9f10CzTWAA6c=;
        b=ltnFxZ6/mNUdlK9/VQAUlrDkhrsaBb+jPerGsFolRrtbBmOmHmZcRHeoGgKZGFhUwq
         ckbRMWfi1x0Ta1puHaLjdWgLi9aN6qFxXQIdvDJ5Fo6Lv5nQBaf+TcgNst2MXId9cJLD
         03Vt7h54L7oRDhBA//aiq6YLNM0o6stEnQfrO/MZCgDnmvB4eb3zq+ddXfgpbnqj5mYl
         DTk929ddgoo8efqDzR8zr/PyEFTjtagtJbkKZkcuCESXuOh1aHxAv6sxbA9l+D5CvKXk
         G/OYbdK64+n+s70yd8wPgUUfijSv8MfMVPMk2zP5uFrauXEFkikQIB3TNVZSCPIu7d/C
         WMTg==
X-Gm-Message-State: ANoB5pn8vsNoaE4J3rdyvgSPK8PPIhOzdchxvIh+tYmgL/Vl8mB4G6IL
        zjhCuwSzLVPjc5ZNMArU4EUqTmiH9Wb7C5jaBFj7d/COrEwK8w==
X-Google-Smtp-Source: AA0mqf7PxxkP7n9oGxMytlKeq55G0TuHDEt9EyoOvOmogHNAl+Uer2CmW2/OoxlLXq3nebLyMcNz6bmjOqDu2m0AWUg=
X-Received: by 2002:a19:6a02:0:b0:4a2:9853:b89d with SMTP id
 u2-20020a196a02000000b004a29853b89dmr10841096lfu.105.1669317001638; Thu, 24
 Nov 2022 11:10:01 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:08:51 +0200
Message-ID: <CADUzMVbL0ujvdRDCcQS0uBxruVYW3XV335wAz27AA80x5q9kOQ@mail.gmail.com>
Subject: PRO/Wireless 2200BG Intel WPA3 SSID connection problem #1
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello guys,

This period I have been dealing with WLANs as I have added a new WPA3
SSID and fell on some trouble and limitations(more messages will
follow on this). Long story short, some WLAN cards do not work and
some Android based mobile phones do not work(like my Android 12 based
SAMSUNG M31 which is not detecting such SSIDs at all!). On one hand,
vendors like Atheros have done a good job. As a result, all cards were
able to connect successfully at SSID using the WPA3 encryption. This
includes miniPCI, PCI, miniPCIe, Cardbus and USB adapters. On the
other hand vendors like Intel haven't done a really good job. miniPCI
cards from Intel are out of question due to legacy driver and custom
802.11 implementation. Initial miniPCIe cards like 4965 series do not
support it similar to many iwlwifi cards. I believe that all iwlwifi
supported cards should be able to use WPA3. My 2006 Atheros cards
connect successfully so I expect the same for intel cards launched a
decade after the old Atheros cards otherwise we should blacklist such
devices to save lots of noise from bug reports about undetected
networks. Hopefully the Intel team will fix everything so that noone
will not need to switch cards on laptops. Some of those like HP and
Lenovo laaptops have the famous blacklist so they need lots of work to
replace the WLAN card and get it working. On the rest like my brothers
Dell, you just switch the card and it works!

Starting with the tests, I have used a single antenna setup on all
miniPCI & miniPCIe devices tested at my PC. On laptops I have used 2
antennas except my CQ57 which has only one antenna installed... M2
cards were tested with 2 antennas. Most devices were initially tested
with live Ubuntu 22.04 and later using 22.10. Now I am using Debian
11. Just for testing I used Debian 10 as well but it is not able to
detect WPA3 enabled SSIDs. Also I have a combo WPA2,3 SSID. In
addition to the 2,4GHz WPA3 SSID, I have added a 5GHz one at my WFA
certified router. What is more, I have tested a set of Unify APs after
adding a WPA SSID at 2,4 GHz.

I have prepared a new 6.0 kernel at my Debian 11 based AMD PC for
testing but I will wait for your response prior doing further testing.

Back to the 2200BG, here is how it boots on Ubuntu:
[  217.324956] lib80211: common routines for IEEE802.11 drivers
[  217.324960] lib80211_crypt: registered algorithm 'NULL'
[  217.347417] libipw: 802.11 data/management/control stack, git-1.1.13
[  217.347422] libipw: Copyright (C) 2004-2005 Intel Corporation
<jketreno@linux.intel.com>
[  217.402564] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network
Driver, 1.2.2kmprq
[  217.402570] ipw2200: Copyright(c) 2003-2006 Intel Corporation
[  217.402868] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[  217.642903] ipw2200: Detected geography ZZR (14 802.11bg channels,
0 802.11a channels)
[  217.650646] ipw2200 0000:05:06.0 wlp5s6: renamed from eth0

It can't connect to WPA3 2,4GHz SSID and I got no logs.

At combo WPA2,3 2,4GHz SSID it was able to connect successfully:
[  618.159511] lib80211_crypt: registered algorithm 'CCMP'
[  618.194283] IPv6: ADDRCONF(NETDEV_CHANGE): wlp5s6: link becomes ready

This is the device:
05:06.0 Network controller [0280]: Intel Corporation PRO/Wireless
2200BG [Calexico2] Network Connection [8086:4220] (rev 05)
    Subsystem: Intel Corporation PRO/Wireless 2200BG [Calexico2]
Network Connection [8086:2702]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32 (750ns min, 6000ns max)
    Interrupt: pin A routed to IRQ 20
    NUMA node: 0
    Region 0: Memory at fdbff000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
    Kernel driver in use: ipw2200
    Kernel modules: ipw2200
00: 86 80 20 42 06 00 90 02 05 00 80 02 00 20 00 00
10: 00 f0 bf fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 02 27
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 03 18
40: 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 c8
e0: 00 20 00 13 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
