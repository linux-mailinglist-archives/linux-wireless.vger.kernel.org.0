Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7D2E2B4E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Dec 2020 12:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgLYLDf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Dec 2020 06:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgLYLDe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Dec 2020 06:03:34 -0500
X-Greylist: delayed 424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Dec 2020 03:02:39 PST
Received: from mout2.freenet.de (mout2.freenet.de [IPv6:2001:748:100:40::2:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3156BC061573
        for <linux-wireless@vger.kernel.org>; Fri, 25 Dec 2020 03:02:39 -0800 (PST)
Received: from [195.4.92.125] (helo=sub6.freenet.de)
        by mout2.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1kskkv-0000lB-Au
        for linux-wireless@vger.kernel.org; Fri, 25 Dec 2020 11:55:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=justmail.de
        ; s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=O4c+0Mod1ZSdoqG27m2i5skX1qp7vPiz1P5je8ozgAM=; b=LqEhD7x/irkNU1t+AtIPoaUccl
        KUnGq/BgDqwfyz8JiCtu1Rjx38d1V4ezJs4ZCTewKHJtd+SIA/hrPqtfue/FXB7pDiD0PveAtSbKl
        xHladdQyZd72bvy2CtAC7nTqknNof2HKstphP6WEncNmDQEXIhAn/RXJzRF4hIw0cbRo7Y9LHEMnC
        YGPE53oXA7+YVy2svVKzUaXBKA/g+xRqlT8crdCy3orVwOxRlfzEvGUWlyvDxDHzp4tCViLmF7V9s
        bEnWoWAdhKjINDARQlcC1qnB0Bgex/w4JjYB52MIyiGegyY43ykJtRJUkg74xw0tlzuShPuVEJPzF
        fVYmxlFA==;
Received: from p200300de57258500505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:5725:8500:5054:ff:fe15:ac42]:43604 helo=mail.maya.org)
        by sub6.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.92 #3)
        id 1kskkv-00046Z-8e
        for linux-wireless@vger.kernel.org; Fri, 25 Dec 2020 11:55:33 +0100
Received: internal info suppressed
From:   Klaus Mueller <kmueller@justmail.de>
Subject: RTL8821CE: CTRL-EVENT-BEACON-LOSS and connection loss
To:     linux-wireless@vger.kernel.org
Message-ID: <e0de2157-c06e-c327-e969-d32cb21daf40@justmail.de>
Date:   Fri, 25 Dec 2020 11:55:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originated-At: 2003:de:5725:8500:5054:ff:fe15:ac42!43604
X-FNSign: v=2 s=2465DD15EB8C3AB588E2C3F494BBEE42CA34A35BBF07F9CBB1CC06B4485D182B
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

I'm having a
04:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE
802.11ac PCIe Wireless Network Adapter
        Subsystem: AzureWave Device 3041
        Flags: bus master, fast devsel, latency 0, IRQ 71
        I/O ports at d000 [size=256]
        Memory at f7600000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number xxxx...
        Capabilities: [158] Latency Tolerance Reporting
        Capabilities: [160] L1 PM Substates
        Capabilities: [170] Precision Time Measurement
        Capabilities: [17c] Vendor Specific Information: ID=0003 Rev=1
Len=054 <?>

or PCI-IDs
04:00.0 0280: 10ec:c821
        Subsystem: 1a3b:3041

It's running in 2.4 GHz / 40 MHz / Station EAPTLS / WPA-EAP-SHA256 mode.
wpa_supplicant 2.9 / no networkmanager. Kernel version is 5.10.1.



What are the problems?
- lots of "CTRL-EVENT-BEACON-LOSS" entries in wpa_supplicant.log
- very often loosing connection (CTRL-EVENT-DISCONNECTED)


There are 3 drivers:
[1] https://github.com/tomaspinho/rtl8821ce
[2] Driver in Kernel 5.10.1 (not really considered)
[3] Driver from https://github.com/lwfinger/rtw88

Throughput is measured using netperf.


Let's go into details. I will distinguish roughly two situations: very
good and mostly bad radio reception condition.



1. Very good radio reception condition
--------------------------------------
(~ 1 m distance between STA and AP and nothing in between).

=> no problem. Driver [1] and [3] are working as they should. Throughput
is about 12 MiB/s Rx and 13 MiB/s with both drivers.

on idle mode:
# iw dev wlan0 scan | egrep "signal|freq|SSID:"
        freq: 2412
        signal: -21.00 dBm
        SSID: mysta

on load: ~ -2[23] dBm




2. Mostly bad radio reception conditions
-----------------------------------------
Driver [1] doesn't work at all or pretty bad.
Driver [3] connects pretty fast (mostly as normal).

directly after reboot under bad conditions
# iw dev wlan0 scan | egrep "signal|freq|SSID:"
        freq: 2412
        signal: -7[268].00 dBm
        SSID: mysta

=> No "problems" can be seen. Throughput is about 2 MiB/s.

Now, the notebook is taken to good radio reception condition. It
performs as expected - no problem.

Now, bringing back the notebook again to the bad conditions:


# iw dev wlan0 scan | egrep "signal|freq|SSID:"
        freq: 2412
        signal: -25.00 dBm
        SSID: mysta

=> Driver doesn't realize changed conditions! Frequent
CTRL-EVENT-BEACON-LOSS events are coming up. If you set up a ping, the
CTRL-EVENT-BEACON-LOSS events (mostly) disappear now. During netperf,
they are disappearing completely. Switching off netperf and ping, the
CTRL-EVENT-BEACON-LOSS events are coming up again and even complete
connection loss appears.

Loosing connection at this point is fatal, because reconnection is very
hard and a connection is lost again after few seconds. Therefore, you
have to bring the notebook back again to the good conditions to get the
connection working again.

=> The driver doesn't seem to recognize the bad signal strength!



Conclusion at the moment:
=========================

- Driver seems to always remember best ever seen signal quality and
ignores reduced quality.
- Power save seems not to be the problem (I can see BEACON_LOSS events
with or without power management enabled).
- Driver doesn't like idle mode on bad conditions if it saw better
conditions before. As long as there is load on the device, the
connection persists and no or seldom CTRL-EVENT-BEACON-LOSS events can
be seen. If there is no more traffic, CTRL-EVENT-BEACON-LOSS events are
coming up frequently and the connection will be lost after more or less
short time.



I would be glad if you could find a solution. Don't hesitate if you have
further questions. I've no problem to test some patches.


Thanks
Klaus
