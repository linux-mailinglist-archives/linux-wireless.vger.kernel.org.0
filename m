Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFBE1E9935
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2020 19:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgEaRPJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 May 2020 13:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaRPI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 May 2020 13:15:08 -0400
X-Greylist: delayed 322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 31 May 2020 10:15:08 PDT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48717C061A0E
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2020 10:15:08 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 49ZlCn21B8zQlCW
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2020 19:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:message-id:reply-to:from:from:date:date
        :received; s=mail20150812; t=1590944977; bh=KYQ55C6Ixd0rsFWKGrYC
        7tetgzz0/8WBBbmHk4SXq/M=; b=UlT2lx/jL8dlGLx+ga0oTMJL3Cz7siVehdo6
        KqVGK2Ymwa7EQv1GJDK8xHUmI0RU0XK5WJju0WrzOwEx3MZaYlbWhnTD987pg1hB
        v4xQ3AvWY3DgY/rmw+Dt0/+ya+V6W/sJupgvNlWzTpOKP+jVy2b+qDh4Q+Py+9L0
        xcCnUJQVond6n2frTQfaf1dR0GhJAFXfLLIc4d+0k9EAEjPMpCpavxHyo1O3hZh/
        apPoTZVEmv+ejSTr59kZTN6bGPfMDTIEVYJ+zkd9Lx0AOV16FGaWLxCPoNbLf1pJ
        eTGbY3PaM8SckwuhCUOUI4q1fBu120QuuV9YYG2aU9bLCJ+o2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1590944979; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a0DgE4aKW7u4YR4e56Pb48xkalxziKIZCWI6cAf3FXE=;
        b=YaFP39y6QGiiug7kB1NIpx0Owo8ZGOBl9Tygdb6FfBsKx6tU/Ahack+EdeNPksF9b2Ytq6
        6paZ6vNvL6xmBWtOBIE7/MGVAaqCgC25AvknA8FwoHyU5xNdpewOtbtA+6mv6bMOfYZpuj
        /ZbSDD0GqF2c4jZ6ZxZTROO9qS399y6Y+AIH6Jy40VUEGVdu5jQoTPTU/Fwjwsiu46hFy3
        CWfGpLx4y5KOoJzB0HmUxuO5jhGHx+Tw2tHKE0ejwLh1pSeDkZ1D+c7EXxj7MYNjmuxyCn
        Uo5f9MycjDB/sw9wnVwu+S2yjc/hLbAMo87qJXyV2AseMXE4dHmc2/zYR1FSAQ==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id jMUsnD_NbScD for <linux-wireless@vger.kernel.org>;
        Sun, 31 May 2020 19:09:37 +0200 (CEST)
Date:   Sun, 31 May 2020 19:09:34 +0200 (CEST)
From:   rt5572@mailbox.org
Reply-To: rt5572@mailbox.org
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <616157256.22858.1590944974598@office.mailbox.org>
Subject: rt2800usb: Low Tx throughput
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: 32F3C17F0
X-Rspamd-Score: -4.41 / 15.00 / 15.00
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

First of all, apologies if this mailing list is not the right place to report this kind of issue.

I am encountering a very low Tx throughput (~12 Mbits/s) when sending data with iperf from an rt2800usb station to an OpenWRT mwlwifi AP. There are no other stations connected to the AP, or other applications running apart from iperf.
Rx throughput, however, is well within the expected range (~112 Mbits/s).
For reference, the same USB network adapter achieves 10 times the Tx throughput (~130 Mbits/s) when using the Windows driver in an otherwise identical test (iperf binary compiled for Windows, same AP, same location).

Additional information follows:

Linux kernel: 4.14.178

rt2800usb module and its dependencies: backported from Linux (v5.7-rc3-0-g6a8b55ed4056) using backports v5.7-rc3-1-0-gc0c7d2bb
The same issue can be reproduced using the modules that came originally with the 4.14.178 kernel.

lsusb:
ID 148f:5572 Ralink Technology, Corp. RT5572 Wireless Adapter

'iw dev wireless station dump' output in the client after a 60-second iperf run:

Station XX:XX:XX:XX:XX:XX (on wireless)
inactive time:  7540 ms
rx bytes:       2729211
rx packets:     31477
tx bytes:       92127099
tx packets:     60088
tx retries:     1100
tx failed:      3
beacon loss:    0
beacon rx:      721
rx drop misc:   18
signal:         -46 dBm
signal avg:     -47 dBm
beacon signal avg:      209 dBm
tx bitrate: 300.0 MBit/s MCS 15 40MHz short GI
rx bitrate: 162.0 MBit/s MCS 12 40MHz
expected throughput: 58.43Mbps
authorized: yes
authenticated: yes
associated: yes
preamble: long
WMM/WME: yes
MFP: no
TDLS peer: no
DTIM period: 2
beacon interval:100
short preamble: yes
short slot time:yes
connected time: 74 seconds

iperf output:

station# iperf -c ap -t 60 -i 5
------------------------------------------------------------
Client connecting to router, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  3] local A.B.C.D port 45136 connected with W.X.Y.Z port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 5.0 sec  3.60 MBytes  6.03 Mbits/sec
[  3]  5.0-10.0 sec  7.50 MBytes  12.6 Mbits/sec
[  3] 10.0-15.0 sec  7.50 MBytes  12.6 Mbits/sec
[  3] 15.0-20.0 sec  7.50 MBytes  12.6 Mbits/sec
[  3] 20.0-25.0 sec  7.25 MBytes  12.2 Mbits/sec
[  3] 25.0-30.0 sec  7.12 MBytes  12.0 Mbits/sec
[  3] 30.0-35.0 sec  7.12 MBytes  12.0 Mbits/sec
[  3] 35.0-40.0 sec  7.12 MBytes  12.0 Mbits/sec
[  3] 40.0-45.0 sec  7.00 MBytes  11.7 Mbits/sec
[  3] 45.0-50.0 sec  7.12 MBytes  12.0 Mbits/sec
[  3] 50.0-55.0 sec  7.00 MBytes  11.7 Mbits/sec

ap# iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local W.X.Y.Z port 5001 connected with A.B.C.D port 45136
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-59.5 sec  82.9 MBytes  11.7 Mbits/sec

I enabled all the MAC80211 and Ralink debug options I could find in the backports menuconfig, but nothing interesting showed up in dmesg during the tests:
[18591.310959] ieee80211 phy1: rt2x00_set_rt: Info - RT chipset 5592, rev 0222 detected
[18591.323993] ieee80211 phy1: rt2x00_set_rf: Info - RF chipset 000f detected
[18591.324351] ieee80211 phy1: Selected rate control algorithm 'minstrel_ht'
[18592.057905] rt2800usb 1-1.4.2:1.0 wireless: renamed from wlan0
[18606.170423] ieee80211 phy1: rt2x00lib_request_firmware: Info - Loading firmware file 'rt2870.bin'
[18606.210871] ieee80211 phy1: rt2x00lib_request_firmware: Info - Firmware detected - version: 0.36
[18614.393426] wireless: authenticate with XX:XX:XX:XX:XX:XX
[18614.448933] wireless: send auth to XX:XX:XX:XX:XX:XX (try 1/3)
[18614.449587] wireless: authenticated
[18614.451765] wireless: associate with XX:XX:XX:XX:XX:XX (try 1/3)
[18614.470701] wireless: RX AssocResp from XX:XX:XX:XX:XX:XX (capab=0x11 status=0 aid=1)
[18614.476924] wireless: associated

iw event -t output is empty.

Any pointers as to where I could start debugging this problem?

Many thanks.
