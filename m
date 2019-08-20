Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B84196C06
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfHTWN2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 18:13:28 -0400
Received: from gesmail.globaledgesoft.com ([182.73.204.242]:60758 "EHLO
        gesmail.globaledgesoft.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729887AbfHTWN2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 18:13:28 -0400
Received: from mail.globaledgesoft.com (mail.globaledgesoft.com [172.16.2.30])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gesmail.globaledgesoft.com (Postfix) with ESMTP id 08E657C8849;
        Wed, 21 Aug 2019 03:42:34 +0530 (IST)
Received: from mail.globaledgesoft.com (localhost [127.0.0.1])
        by mail.globaledgesoft.com (Postfix) with ESMTPS id BE4B0B8086B;
        Wed, 21 Aug 2019 03:49:02 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.globaledgesoft.com (Postfix) with ESMTP id A5AB1B80855;
        Wed, 21 Aug 2019 03:49:02 +0530 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mail.globaledgesoft.com
Received: from mail.globaledgesoft.com ([127.0.0.1])
        by localhost (mail.globaledgesoft.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6Y_zAGCWdaQ8; Wed, 21 Aug 2019 03:49:02 +0530 (IST)
Received: from localhost.localdomain (unknown [172.16.2.250])
        by mail.globaledgesoft.com (Postfix) with ESMTPSA id 731BBB8071C;
        Wed, 21 Aug 2019 03:49:02 +0530 (IST)
From:   Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
Subject: [PATCH 1/1] rt2x00: Queue flush fix
Date:   Wed, 21 Aug 2019 03:43:05 +0530
Message-Id: <1566339185-11875-1-git-send-email-b.balakrishna@globaledgesoft.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Added rt2x00 queue flush fix and beacon frames checks.

Signed-off-by: Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800mmio.c  |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c   |  7 ++--
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c   | 22 ++++++++++--
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c | 44 +++++++++++++++++++-----
 4 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
index 110bb39..9964371 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
@@ -566,7 +566,7 @@ void rt2800mmio_queue_init(struct data_queue *queue)
 
 	switch (queue->qid) {
 	case QID_RX:
-		queue->limit = 128;
+		queue->limit = 512;
 		queue->data_size = AGGREGATION_SIZE;
 		queue->desc_size = RXD_DESC_SIZE;
 		queue->winfo_size = rxwi_size;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 35414f9..085a41e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -128,7 +128,8 @@ static void rt2x00lib_intf_scheduled_iter(void *data, u8 *mac,
 
 	if (test_and_clear_bit(DELAYED_UPDATE_BEACON, &intf->delayed_flags)) {
 		mutex_lock(&intf->beacon_skb_mutex);
-		rt2x00queue_update_beacon(rt2x00dev, vif);
+		if (intf->enable_beacon)
+			rt2x00queue_update_beacon(rt2x00dev, vif);
 		mutex_unlock(&intf->beacon_skb_mutex);
 	}
 }
@@ -191,6 +192,7 @@ static void rt2x00lib_beaconupdate_iter(void *data, u8 *mac,
 					struct ieee80211_vif *vif)
 {
 	struct rt2x00_dev *rt2x00dev = data;
+	struct rt2x00_intf *intf = vif_to_intf(vif);
 
 	if (vif->type != NL80211_IFTYPE_AP &&
 	    vif->type != NL80211_IFTYPE_ADHOC &&
@@ -204,7 +206,8 @@ static void rt2x00lib_beaconupdate_iter(void *data, u8 *mac,
 	 * never be called for USB devices.
 	 */
 	WARN_ON(rt2x00_is_usb(rt2x00dev));
-	rt2x00queue_update_beacon(rt2x00dev, vif);
+	if (intf->enable_beacon)
+		rt2x00queue_update_beacon(rt2x00dev, vif);
 }
 
 void rt2x00lib_beacondone(struct rt2x00_dev *rt2x00dev)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index beb20c5..5c424da 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -103,6 +103,25 @@ void rt2x00mac_tx(struct ieee80211_hw *hw,
 	 */
 	if (!test_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags))
 		goto exit_free_skb;
+	/* Dirty hack for queue overrun protection,
+	 * if AC_VO/AC_VI/AC_BE is full, use next queue.
+	 * if AC_BK is full use previous queue.
+	 */
+	if (qid < 4) {
+		queue = rt2x00queue_get_tx_queue(rt2x00dev,qid);
+		if (unlikely(rt2x00queue_full(queue))) {
+			switch(qid) {
+				case 0: /* QID_AC_VO */
+				case 1: /* QID_AC_VI */
+				case 2: /* QID_AC_BE */
+					qid++;
+					break;
+				case 3: /* QID_AC_BK */
+					qid--;
+					break;
+			}
+		}
+	}
 
 	/*
 	 * Use the ATIM queue if appropriate and present.
@@ -602,8 +621,7 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 			 * Upload beacon to the H/W. This is only required on
 			 * USB devices. PCI devices fetch beacons periodically.
 			 */
-			if (rt2x00_is_usb(rt2x00dev))
-				rt2x00queue_update_beacon(rt2x00dev, vif);
+			rt2x00queue_update_beacon(rt2x00dev, vif);
 
 			if (rt2x00dev->intf_beaconing == 1) {
 				/*
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
index 3b6100e..4254811 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
@@ -986,25 +986,37 @@ void rt2x00queue_stop_queue(struct data_queue *queue)
 
 void rt2x00queue_flush_queue(struct data_queue *queue, bool drop)
 {
+	unsigned int i;
+	bool started;
 	bool tx_queue =
 		(queue->qid == QID_AC_VO) ||
 		(queue->qid == QID_AC_VI) ||
 		(queue->qid == QID_AC_BE) ||
 		(queue->qid == QID_AC_BK);
+	mutex_lock(&queue->status_lock);
+	/* If the queue has been started, we must stop it temporarily
+	 * to prevent any new frames to be queued on the device. If
+	 * we are not dropping the pending frames, the queue must
+	 * only be stopped in the software and not the hardware,
+	 * otherwise the queue will never become empty on its own.
+	 */
+	started = test_bit(QUEUE_STARTED, &queue->flags);
+	if (started) {
+		// pause the queue.
+		rt2x00queue_pause_queue(queue);
 
+		/* If we are not supposed to drop any pending
+		 * frames, this means we must force a start (=kick)
+		 * to the queue to make sure the hardware will
+		 * start transmitting.
+		 */
+		if (!drop && tx_queue)
+			queue->rt2x00dev->ops->lib->kick_queue(queue);
+	}
 	if (rt2x00queue_empty(queue))
 		return;
 
 	/*
-	 * If we are not supposed to drop any pending
-	 * frames, this means we must force a start (=kick)
-	 * to the queue to make sure the hardware will
-	 * start transmitting.
-	 */
-	if (!drop && tx_queue)
-		queue->rt2x00dev->ops->lib->kick_queue(queue);
-
-	/*
 	 * Check if driver supports flushing, if that is the case we can
 	 * defer the flushing to the driver. Otherwise we must use the
 	 * alternative which just waits for the queue to become empty.
@@ -1013,11 +1025,25 @@ void rt2x00queue_flush_queue(struct data_queue *queue, bool drop)
 		queue->rt2x00dev->ops->lib->flush_queue(queue, drop);
 
 	/*
+	 * When we don't want to drop any frames, or when
+	 * the driver doesn't fully flush the queue correcly,
+	 * we must wait for the queue to become empty.
+	 */
+	for (i = 0; !rt2x00queue_empty(queue) && i < 10; i++)
+		msleep(10);
+
+	/*
 	 * The queue flush has failed...
 	 */
 	if (unlikely(!rt2x00queue_empty(queue)))
 		rt2x00_warn(queue->rt2x00dev, "Queue %d failed to flush\n",
 			    queue->qid);
+	/*
+	 * Restore the queue to the previous status.
+	 */
+	if (started)
+		rt2x00queue_unpause_queue(queue);
+	mutex_unlock(&queue->status_lock);
 }
 EXPORT_SYMBOL_GPL(rt2x00queue_flush_queue);
 
-- 
1.9.1

Disclaimer:- The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. The views expressed in this E-mail message (including the enclosure/(s) or attachment/(s) if any) are those of the individual sender, except where the sender expressly, and with authority, states them to be the views of GlobalEdge. Before opening any mail and attachments please check them for viruses .GlobalEdge does not accept any liability for virus infected mails.

