Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6451F6FE63
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfGVLID (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 07:08:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbfGVLIC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 07:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yVmEQXIfb3diaCuw9NilkrqXhDl+7j5UDll83rF5cL4=; b=mkPMm++9Y2zO68jJznkqKnS9rC
        FmJbGhzKfVhi7y9RntImyTg+WDwTl4/T6ttc918YH868PEv8rhwo1mEKpgPhhw3kInkE4J15CC7pj
        7vV+p9G5m5KV3QPfwtuG8j7TileWHSNUfqjeTRi4mXp83/4akn5gNjf5SfSDZUaIGwsQA+9Xpuiq3
        R2YBG4rpuvNWag+BqyE/9vP3R9ahHx37w/9u0kj34BXSgmbh5MRacWP+M3GbtxqoImA0WoEHhNrEm
        wsiNJOOSr38K9yFXFM1ZUe0m1tqj/FaN3RE/pSt+8wvQwlWM70e34Y4/UeIoONyLen4wEtP7jQKBy
        OIA5lcsA==;
Received: from 177.157.124.3.dynamic.adsl.gvt.net.br ([177.157.124.3] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpWAh-000259-FK; Mon, 22 Jul 2019 11:07:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hpWAa-000420-H3; Mon, 22 Jul 2019 08:07:52 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 20/22] docs: net: convert two README files to ReST format
Date:   Mon, 22 Jul 2019 08:07:47 -0300
Message-Id: <129f4fb2b209af7cc6e64fcb2f0a366021829c16.1563792334.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563792333.git.mchehab+samsung@kernel.org>
References: <cover.1563792333.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are two README files there with doesn't have a .txt
extension nor are at ReST format.

In order to help with the docs conversion to ReST, rename those
and manually convert them to ReST format.

As there are lot more to be done for networking to be part of
the documentation body, for now mark those two files with
:orphan:, in order to supress a build warning.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../networking/caif/{README => caif.rst}      | 88 +++++++++++++------
 .../{README => mac80211_hwsim.rst}            | 28 ++++--
 MAINTAINERS                                   |  2 +-
 3 files changed, 81 insertions(+), 37 deletions(-)
 rename Documentation/networking/caif/{README => caif.rst} (70%)
 rename Documentation/networking/mac80211_hwsim/{README => mac80211_hwsim.rst} (81%)

diff --git a/Documentation/networking/caif/README b/Documentation/networking/caif/caif.rst
similarity index 70%
rename from Documentation/networking/caif/README
rename to Documentation/networking/caif/caif.rst
index 757ccfaa1385..07afc8063d4d 100644
--- a/Documentation/networking/caif/README
+++ b/Documentation/networking/caif/caif.rst
@@ -1,18 +1,31 @@
-Copyright (C) ST-Ericsson AB 2010
-Author: Sjur Brendeland/ sjur.brandeland@stericsson.com
-License terms: GNU General Public License (GPL) version 2
----------------------------------------------------------
+:orphan:
 
-=== Start ===
-If you have compiled CAIF for modules do:
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-$modprobe crc_ccitt
-$modprobe caif
-$modprobe caif_socket
-$modprobe chnl_net
 
+================
+Using Linux CAIF
+================
 
-=== Preparing the setup with a STE modem ===
+
+:Copyright: |copy| ST-Ericsson AB 2010
+
+:Author: Sjur Brendeland/ sjur.brandeland@stericsson.com
+
+Start
+=====
+
+If you have compiled CAIF for modules do::
+
+    $modprobe crc_ccitt
+    $modprobe caif
+    $modprobe caif_socket
+    $modprobe chnl_net
+
+
+Preparing the setup with a STE modem
+====================================
 
 If you are working on integration of CAIF you should make sure
 that the kernel is built with module support.
@@ -32,24 +45,30 @@ module parameter "ser_use_stx".
 Normally Frame Checksum is always used on UART, but this is also provided as a
 module parameter "ser_use_fcs".
 
-$ modprobe caif_serial ser_ttyname=/dev/ttyS0 ser_use_stx=yes
-$ ifconfig caif_ttyS0 up
+::
 
-PLEASE NOTE: 	There is a limitation in Android shell.
+    $ modprobe caif_serial ser_ttyname=/dev/ttyS0 ser_use_stx=yes
+    $ ifconfig caif_ttyS0 up
+
+PLEASE NOTE:
+		There is a limitation in Android shell.
 		It only accepts one argument to insmod/modprobe!
 
-=== Trouble shooting ===
+Trouble shooting
+================
 
 There are debugfs parameters provided for serial communication.
 /sys/kernel/debug/caif_serial/<tty-name>/
 
 * ser_state:   Prints the bit-mask status where
+
   - 0x02 means SENDING, this is a transient state.
   - 0x10 means FLOW_OFF_SENT, i.e. the previous frame has not been sent
-	and is blocking further send operation. Flow OFF has been propagated
-	to all CAIF Channels using this TTY.
+    and is blocking further send operation. Flow OFF has been propagated
+    to all CAIF Channels using this TTY.
 
 * tty_status: Prints the bit-mask tty status information
+
   - 0x01 - tty->warned is on.
   - 0x02 - tty->low_latency is on.
   - 0x04 - tty->packed is on.
@@ -58,13 +77,17 @@ There are debugfs parameters provided for serial communication.
   - 0x20 - tty->stopped is on.
 
 * last_tx_msg: Binary blob Prints the last transmitted frame.
-	This can be printed with
+
+  This can be printed with::
+
 	$od --format=x1 /sys/kernel/debug/caif_serial/<tty>/last_rx_msg.
-	The first two tx messages sent look like this. Note: The initial
-	byte 02 is start of frame extension (STX) used for re-syncing
-	upon errors.
 
-  - Enumeration:
+  The first two tx messages sent look like this. Note: The initial
+  byte 02 is start of frame extension (STX) used for re-syncing
+  upon errors.
+
+  - Enumeration::
+
         0000000  02 05 00 00 03 01 d2 02
                  |  |     |  |  |  |
                  STX(1)   |  |  |  |
@@ -73,7 +96,9 @@ There are debugfs parameters provided for serial communication.
                              Command:Enumeration(1)
                                 Link-ID(1)
                                     Checksum(2)
-  - Channel Setup:
+
+  - Channel Setup::
+
         0000000  02 07 00 00 00 21 a1 00 48 df
                  |  |     |  |  |  |  |  |
                  STX(1)   |  |  |  |  |  |
@@ -86,13 +111,18 @@ There are debugfs parameters provided for serial communication.
 					  Checksum(2)
 
 * last_rx_msg: Prints the last transmitted frame.
-	The RX messages for LinkSetup look almost identical but they have the
-	bit 0x20 set in the command bit, and Channel Setup has added one byte
-	before Checksum containing Channel ID.
-	NOTE: Several CAIF Messages might be concatenated. The maximum debug
+
+  The RX messages for LinkSetup look almost identical but they have the
+  bit 0x20 set in the command bit, and Channel Setup has added one byte
+  before Checksum containing Channel ID.
+
+  NOTE:
+	Several CAIF Messages might be concatenated. The maximum debug
 	buffer size is 128 bytes.
 
-== Error Scenarios:
+Error Scenarios
+===============
+
 - last_tx_msg contains channel setup message and last_rx_msg is empty ->
   The host seems to be able to send over the UART, at least the CAIF ldisc get
   notified that sending is completed.
@@ -103,7 +133,9 @@ There are debugfs parameters provided for serial communication.
 
 - if /sys/kernel/debug/caif_serial/<tty>/tty_status is non-zero there
   might be problems transmitting over UART.
+
   E.g. host and modem wiring is not correct you will typically see
   tty_status = 0x10 (hw_stopped) and ser_state = 0x10 (FLOW_OFF_SENT).
+
   You will probably see the enumeration message in last_tx_message
   and empty last_rx_message.
diff --git a/Documentation/networking/mac80211_hwsim/README b/Documentation/networking/mac80211_hwsim/mac80211_hwsim.rst
similarity index 81%
rename from Documentation/networking/mac80211_hwsim/README
rename to Documentation/networking/mac80211_hwsim/mac80211_hwsim.rst
index 3566a725d19c..d2266ce5534e 100644
--- a/Documentation/networking/mac80211_hwsim/README
+++ b/Documentation/networking/mac80211_hwsim/mac80211_hwsim.rst
@@ -1,5 +1,13 @@
+:orphan:
+
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===================================================================
 mac80211_hwsim - software simulator of 802.11 radio(s) for mac80211
-Copyright (c) 2008, Jouni Malinen <j@w1.fi>
+===================================================================
+
+:Copyright: |copy| 2008, Jouni Malinen <j@w1.fi>
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as
@@ -7,6 +15,7 @@ published by the Free Software Foundation.
 
 
 Introduction
+============
 
 mac80211_hwsim is a Linux kernel module that can be used to simulate
 arbitrary number of IEEE 802.11 radios for mac80211. It can be used to
@@ -43,6 +52,7 @@ regardless of channel.
 
 
 Simple example
+==============
 
 This example shows how to use mac80211_hwsim to simulate two radios:
 one to act as an access point and the other as a station that
@@ -50,17 +60,19 @@ associates with the AP. hostapd and wpa_supplicant are used to take
 care of WPA2-PSK authentication. In addition, hostapd is also
 processing access point side of association.
 
+::
 
-# Build mac80211_hwsim as part of kernel configuration
 
-# Load the module
-modprobe mac80211_hwsim
+    # Build mac80211_hwsim as part of kernel configuration
 
-# Run hostapd (AP) for wlan0
-hostapd hostapd.conf
+    # Load the module
+    modprobe mac80211_hwsim
 
-# Run wpa_supplicant (station) for wlan1
-wpa_supplicant -Dnl80211 -iwlan1 -c wpa_supplicant.conf
+    # Run hostapd (AP) for wlan0
+    hostapd hostapd.conf
+
+    # Run wpa_supplicant (station) for wlan1
+    wpa_supplicant -Dnl80211 -iwlan1 -c wpa_supplicant.conf
 
 
 More test cases are available in hostap.git:
diff --git a/MAINTAINERS b/MAINTAINERS
index 665c3c1e939b..634d229fbfff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9568,7 +9568,7 @@ F:	Documentation/networking/mac80211-injection.txt
 F:	include/net/mac80211.h
 F:	net/mac80211/
 F:	drivers/net/wireless/mac80211_hwsim.[ch]
-F:	Documentation/networking/mac80211_hwsim/README
+F:	Documentation/networking/mac80211_hwsim/mac80211_hwsim.rst
 
 MAILBOX API
 M:	Jassi Brar <jassisinghbrar@gmail.com>
-- 
2.21.0

