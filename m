Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7101E92211
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 13:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfHSLUN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 07:20:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfHSLUN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 07:20:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9723307D965;
        Mon, 19 Aug 2019 11:20:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FCB06092F;
        Mon, 19 Aug 2019 11:20:12 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Mathias Kresin <dev@kresin.me>, Emil Karlson <jekarl@iki.fi>
Subject: [PATCH 5.3] rt2x00: clear IV's on start to fix AP mode regression
Date:   Mon, 19 Aug 2019 13:20:07 +0200
Message-Id: <1566213607-6723-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 19 Aug 2019 11:20:13 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To do not brake HW restart we should keep initialization vectors data.
I assumed that on start the data is already initialized to zeros, but
that not true on some scenarios and we should clear it. So add
additional flag to check if we are under HW restart and clear IV's
data if we are not.

Patch fixes AP mode regression.

Reported-and-tested-by: Emil Karlson <jekarl@iki.fi>
Fixes: 710e6cc1595e ("rt2800: do not nullify initialization vector data")
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c |  9 +++++++++
 drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  1 +
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 13 ++++++++-----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 4a996550288e..cbec2131e943 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -6095,6 +6095,15 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 	}
 
 	/*
+	 * Clear encryption initialization vectors on start, but keep them
+	 * for watchdog reset. Otherwise we will have wrong IVs and not be
+	 * able to keep connections after reset.
+	 */
+	if (!test_bit(DEVICE_STATE_RESET, &rt2x00dev->flags))
+		for (i = 0; i < 256; i++)
+			rt2800_register_write(rt2x00dev, MAC_IVEIV_ENTRY(i), 0);
+
+	/*
 	 * Clear all beacons
 	 */
 	for (i = 0; i < 8; i++)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index d35ef06c5c7a..1dd54a0d083d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -659,6 +659,7 @@ enum rt2x00_state_flags {
 	DEVICE_STATE_ENABLED_RADIO,
 	DEVICE_STATE_SCANNING,
 	DEVICE_STATE_FLUSHING,
+	DEVICE_STATE_RESET,
 
 	/*
 	 * Driver configuration
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index ad063c920323..c3eab767bc21 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1253,13 +1253,14 @@ static int rt2x00lib_initialize(struct rt2x00_dev *rt2x00dev)
 
 int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 {
-	int retval;
+	int retval = 0;
 
 	if (test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags)) {
 		/*
 		 * This is special case for ieee80211_restart_hw(), otherwise
 		 * mac80211 never call start() two times in row without stop();
 		 */
+		set_bit(DEVICE_STATE_RESET, &rt2x00dev->flags);
 		rt2x00dev->ops->lib->pre_reset_hw(rt2x00dev);
 		rt2x00lib_stop(rt2x00dev);
 	}
@@ -1270,14 +1271,14 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 	 */
 	retval = rt2x00lib_load_firmware(rt2x00dev);
 	if (retval)
-		return retval;
+		goto out;
 
 	/*
 	 * Initialize the device.
 	 */
 	retval = rt2x00lib_initialize(rt2x00dev);
 	if (retval)
-		return retval;
+		goto out;
 
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
@@ -1286,11 +1287,13 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 	/* Enable the radio */
 	retval = rt2x00lib_enable_radio(rt2x00dev);
 	if (retval)
-		return retval;
+		goto out;
 
 	set_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags);
 
-	return 0;
+out:
+	clear_bit(DEVICE_STATE_RESET, &rt2x00dev->flags);
+	return retval;
 }
 
 void rt2x00lib_stop(struct rt2x00_dev *rt2x00dev)
-- 
1.9.3

