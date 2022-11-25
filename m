Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C23637FB6
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKXTij (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKXTih (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:38:37 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219084A9D2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:38:36 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id l8so2945805ljh.13
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MvDRofuMuZ5pMPBbYZEO6AJ4QXjmBpHA1AzlqmxDiQI=;
        b=Z/2EXZ1TMpQoFw7AiaXIS8yo+Xjf+3rQeV/byVMFGY/kkeFX1b+ywIB3Tq+oh4iQKY
         4Y3pvygNltCqntEK8W0YSlr/r7dW3DzPaS8gIiZdBgAJ1rhdc5ufcQUXIzuMoGtz6Il6
         lG9klJqsvAeJJnboyZRdwQmKA9IWvX04Rn2/YHKEJ5MFmCwu+a1R6V1k3ZXD7LFOYrZc
         iT1iRW14wss+0rLNOKQJVvEZMuRLu+JKIDDeFbpwkLA5hO9mkAr0EqwO5OAG+7nWst7x
         y8B/dBJat/5uRpWIOCIRP7OeHfucyDz3WMQ8+eKfCPVsTqReDnk+AO9QyWIv2lRIXof8
         56NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvDRofuMuZ5pMPBbYZEO6AJ4QXjmBpHA1AzlqmxDiQI=;
        b=XbLdB0Gj12Ju5CkORUx/oeh6LmXr9ZJ5ygSeG2Got3th9wGdPckShafzaaogQp0AwJ
         bkERMGw5K7zlIohgndk6HFn4YJfQWjkB9i+Y9FgfGeQKtzsDNtqSe86FMRqAM/z9w7Zo
         p6HZB6x0jhSHk40PQgVZm0BmYGt0+6rpP2SMpkIUVXRNTXUOQ0vubmkSG6UlxJiTc7p7
         i933O+pyuLHj6hC8cOGXch5epLrdbVKf4kLh+JF5BmK/19aSTdy7yu0myCyjP4MzD4pV
         lQY12Hs7gias+J5fK1mp61U62zLnn86YXUGjF4s9SJ5PdWeqT1f/VzmenQHzogOdT8xt
         oLRg==
X-Gm-Message-State: ANoB5pkfjxxSywoGbALGA4DiscpinP9SyeFkEz6lOTz4fL2CMp2bZntc
        9b9f/5LbnnS1oDN5LpatMDVgOJEy+2cJHzDl1dP2Bs+hSv63UA==
X-Google-Smtp-Source: AA0mqf7QugNwKII9c8kd+rXNpzpU6qY7saInSAeIyJuBJzGTtkEwllvsXc6mBA5aV0NF+jPyGl2RjZNKqzEyvy8wieA=
X-Received: by 2002:a2e:894f:0:b0:279:7c42:9240 with SMTP id
 b15-20020a2e894f000000b002797c429240mr2546302ljk.54.1669318714203; Thu, 24
 Nov 2022 11:38:34 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:37:23 +0200
Message-ID: <CADUzMVbUXjKrNjEXwrkYy6QWNcYudmi9ia5=hjA0pxgM5TDE8g@mail.gmail.com>
Subject: RT2561 Ralink WPA3 SSID connection problem #8
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

Hello,

Moving to the next Cardbus device, I installed a Ricoh based PCI to
Cardbus adapter and on Ubuntu boot I get:

[  330.143963] pcmcia_socket pcmcia_socket0: pccard: CardBus card
inserted into slot 0
[  330.144016] pci 0000:06:00.0: [1814:0302] type 00 class 0x028000
[  330.144053] pci 0000:06:00.0: reg 0x10: [mem 0xffff8000-0xffffffff]
[  330.144442] pci 0000:06:00.0: BAR 0: assigned [mem 0xf4000000-0xf4007fff]
[  330.239066] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[  330.239831] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  330.350656] rt61pci 0000:06:00.0: enabling device (0000 -> 0002)
[  330.359333] ieee80211 phy0: rt2x00_set_chip: Info - Chipset
detected - rt: 2561, rf: 0003, rev: 000c
[  330.359352] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[  330.370262] rt61pci 0000:06:00.0 wlp6s0: renamed from wlan0
[  330.409545] ieee80211 phy0: rt2x00lib_request_firmware: Info -
Loading firmware file 'rt2561.bin'
[  330.412828] ieee80211 phy0: rt2x00lib_request_firmware: Info -
Firmware detected - version: 0.8

It could not connect to a 2,4GHz WPA3 SSID:
[  648.448124] wlp6s0: authenticate with c6:27:28:**:**:**
[  648.460096] wlp6s0: send auth to c6:27:28:**:**:** (try 1/3)
[  648.601699] wlp6s0: authenticate with c6:27:28:**:**:**
[  648.601718] wlp6s0: send auth to c6:27:28:**:**:** (try 1/3)
[  648.705982] wlp6s0: authenticated
[  648.707959] wlp6s0: associate with c6:27:28:**:**:** (try 1/3)
[  648.711251] wlp6s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  648.711390] wlp6s0: associated
[  648.803854] wlp6s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  648.876363] wlp6s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  650.345116] wlp6s0: authenticate with c6:27:28:**:**:**
[  650.368159] wlp6s0: send auth to c6:27:28:**:**:** (try 1/3)
[  650.369802] wlp6s0: authenticated
[  650.372061] wlp6s0: associate with c6:27:28:**:**:** (try 1/3)
[  650.375392] wlp6s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  650.375524] wlp6s0: associated
[  650.442245] wlp6s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  650.500529] wlp6s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  651.949104] wlp6s0: authenticate with c6:27:28:**:**:**
[  651.972117] wlp6s0: send auth to c6:27:28:**:**:** (try 1/3)
[  651.978953] wlp6s0: authenticated
[  651.979924] wlp6s0: associate with c6:27:28:**:**:** (try 1/3)
[  651.983302] wlp6s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  651.983431] wlp6s0: associated
[  652.090904] wlp6s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  652.116629] wlp6s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  653.549078] wlp6s0: authenticate with c6:27:28:**:**:**
[  653.572136] wlp6s0: send auth to c6:27:28:**:**:** (try 1/3)
[  653.573791] wlp6s0: authenticated
[  653.579965] wlp6s0: associate with c6:27:28:**:**:** (try 1/3)
[  653.583372] wlp6s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  653.583505] wlp6s0: associated
[  653.616722] wlp6s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  653.712584] wlp6s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  664.365020] wlp6s0: authenticate with c6:27:28:**:**:**
[  664.388108] wlp6s0: send auth to c6:27:28:**:**:** (try 1/3)
[  664.389743] wlp6s0: authenticated
[  664.391973] wlp6s0: associate with c6:27:28:**:**:** (try 1/3)
[  664.395319] wlp6s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  664.395453] wlp6s0: associated
[  664.471295] wlp6s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  664.540564] wlp6s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)

So I attempted connection to the 2,4GHz WPA2,3 SSID but I got really
slow speed and then it died:
[  816.674070] rt2x00mmio_regbusy_read() Indirect register access
failed: offset=0x0000308c, value=0x0001cd11
[ 1136.270434] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 2 failed to flush
[ 1136.970398] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 2 failed to flush
[ 1137.574381] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 2 failed to flush
[ 1138.808101] wlp6s0: authenticate with c6:27:28:**:**:**
[ 1138.834586] wlp6s0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1139.038341] wlp6s0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1139.242287] wlp6s0: send auth to c6:27:28:**:**:** (try 3/3)
[ 1139.446254] wlp6s0: authentication with c6:27:28:**:**:** timed out
[ 1140.078257] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1141.186228] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1141.790174] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1143.051366] wlp6s0: authenticate with c6:27:28:**:**:**
[ 1143.078356] wlp6s0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1143.078487] wlp6s0: authenticated
[ 1143.086115] wlp6s0: associate with c6:27:28:**:**:** (try 1/3)
[ 1143.294124] wlp6s0: associate with c6:27:28:**:**:** (try 2/3)
[ 1143.498073] wlp6s0: associate with c6:27:28:**:**:** (try 3/3)
[ 1143.702112] wlp6s0: association with c6:27:28:**:**:** timed out
[ 1144.358048] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1145.973952] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1146.589994] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1147.839176] wlp6s0: authenticate with c6:27:28:**:**:**
[ 1147.866065] wlp6s0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1148.073908] wlp6s0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1148.277888] wlp6s0: send auth to c6:27:28:**:**:** (try 3/3)
[ 1148.481888] wlp6s0: authentication with c6:27:28:**:**:** timed out
[ 1149.125886] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1152.621769] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1153.225787] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1154.532380] wlp6s0: authenticate with c6:27:28:**:**:**
[ 1154.545935] wlp6s0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1154.749745] wlp6s0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1154.953698] wlp6s0: send auth to c6:27:28:**:**:** (try 3/3)
[ 1155.157712] wlp6s0: authentication with c6:27:28:**:**:** timed out
[ 1155.805705] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1166.429459] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush
[ 1167.033457] ieee80211 phy0: rt2x00queue_flush_queue: Warning -
Queue 0 failed to flush

This is the device:
06:00.0 Network controller [0280]: Ralink corp. RT2561/RT61 rev B
802.11g [1814:0302]
    Subsystem: D-Link System Inc AirPlus G DWL-G630 Wireless Cardbus
Adapter (rev.E2) [1186:3c08]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR+ INTx-
    Latency: 64, Cache Line Size: 4 bytes
    Interrupt: pin A routed to IRQ 20
    NUMA node: 0
    Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=32K]
    Capabilities: [40] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: rt61pci
    Kernel modules: rt61pci
00: 14 18 02 03 16 00 10 84 00 00 80 02 01 40 00 00
10: 00 00 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 01 06 00 00 86 11 08 3c
30: 00 00 00 00 40 00 00 00 00 00 00 00 14 01 00 00
40: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
