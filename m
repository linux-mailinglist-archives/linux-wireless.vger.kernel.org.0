Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7163B46F5E
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 12:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfFOKBH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 06:01:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOKBG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 06:01:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20CB913A82;
        Sat, 15 Jun 2019 10:01:06 +0000 (UTC)
Received: from localhost (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B44E81001B05;
        Sat, 15 Jun 2019 10:01:05 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [PATCH v2 3/7] rt2800: initial watchdog implementation
Date:   Sat, 15 Jun 2019 12:00:56 +0200
Message-Id: <20190615100100.29800-4-sgruszka@redhat.com>
In-Reply-To: <20190615100100.29800-1-sgruszka@redhat.com>
References: <20190615100100.29800-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 15 Jun 2019 10:01:06 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add watchdog for rt2800 devices. For now it only detect hung
and print error.

[Note: I verified that printing messages from process context is
fine on MT7620 (WT3020) platform that have problem when printk
is called from interrupt context].

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 56 +++++++++++++++++++
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 +
 .../net/wireless/ralink/rt2x00/rt2800pci.c    |  1 +
 .../net/wireless/ralink/rt2x00/rt2800soc.c    |  1 +
 .../net/wireless/ralink/rt2x00/rt2800usb.c    |  1 +
 .../net/wireless/ralink/rt2x00/rt2x00queue.h  |  6 ++
 6 files changed, 67 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 621cd4ce69e2..d420d759a877 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1212,6 +1212,60 @@ void rt2800_txdone_nostatus(struct rt2x00_dev *rt2x00dev)
 }
 EXPORT_SYMBOL_GPL(rt2800_txdone_nostatus);
 
+static int rt2800_check_hung(struct data_queue *queue)
+{
+	unsigned int cur_idx = rt2800_drv_get_dma_done(queue);
+
+	if (queue->wd_idx != cur_idx)
+		queue->wd_count = 0;
+	else
+		queue->wd_count++;
+
+	return queue->wd_count > 16;
+}
+
+void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
+{
+	struct data_queue *queue;
+	bool hung_tx = false;
+	bool hung_rx = false;
+
+	if (test_bit(DEVICE_STATE_SCANNING, &rt2x00dev->flags))
+		return;
+
+	queue_for_each(rt2x00dev, queue) {
+		switch (queue->qid) {
+		case QID_AC_VO:
+		case QID_AC_VI:
+		case QID_AC_BE:
+		case QID_AC_BK:
+		case QID_MGMT:
+			if (rt2x00queue_empty(queue))
+				continue;
+			hung_tx = rt2800_check_hung(queue);
+			break;
+		case QID_RX:
+			/* For station mode we should reactive at least
+			 * beacons. TODO: need to find good way detect
+			 * RX hung for AP mode.
+			 */
+			if (rt2x00dev->intf_sta_count == 0)
+				continue;
+			hung_rx = rt2800_check_hung(queue);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (hung_tx)
+		rt2x00_warn(rt2x00dev, "Watchdog TX hung detected\n");
+
+	if (hung_rx)
+		rt2x00_warn(rt2x00dev, "Watchdog RX hung detected\n");
+}
+EXPORT_SYMBOL_GPL(rt2800_watchdog);
+
 static unsigned int rt2800_hw_beacon_base(struct rt2x00_dev *rt2x00dev,
 					  unsigned int index)
 {
@@ -10211,6 +10265,8 @@ int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev)
 		__set_bit(REQUIRE_TASKLET_CONTEXT, &rt2x00dev->cap_flags);
 	}
 
+	rt2x00dev->link.watchdog_interval = msecs_to_jiffies(100);
+
 	/*
 	 * Set the rssi offset.
 	 */
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
index dbb413ec8b08..f35f4e20d5aa 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
@@ -197,6 +197,8 @@ void rt2800_txdone_nostatus(struct rt2x00_dev *rt2x00dev);
 bool rt2800_txstatus_timeout(struct rt2x00_dev *rt2x00dev);
 bool rt2800_txstatus_pending(struct rt2x00_dev *rt2x00dev);
 
+void rt2800_watchdog(struct rt2x00_dev *rt2x00dev);
+
 void rt2800_write_beacon(struct queue_entry *entry, struct txentry_desc *txdesc);
 void rt2800_clear_beacon(struct queue_entry *entry);
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
index 71ef8f07b47b..df6345a92f72 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -351,6 +351,7 @@ static const struct rt2x00lib_ops rt2800pci_rt2x00_ops = {
 	.link_tuner		= rt2800_link_tuner,
 	.gain_calibration	= rt2800_gain_calibration,
 	.vco_calibration	= rt2800_vco_calibration,
+	.watchdog		= rt2800_watchdog,
 	.start_queue		= rt2800mmio_start_queue,
 	.kick_queue		= rt2800mmio_kick_queue,
 	.stop_queue		= rt2800mmio_stop_queue,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 34e9291d949c..1054ade65af2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -196,6 +196,7 @@ static const struct rt2x00lib_ops rt2800soc_rt2x00_ops = {
 	.link_tuner		= rt2800_link_tuner,
 	.gain_calibration	= rt2800_gain_calibration,
 	.vco_calibration	= rt2800_vco_calibration,
+	.watchdog		= rt2800_watchdog,
 	.start_queue		= rt2800mmio_start_queue,
 	.kick_queue		= rt2800mmio_kick_queue,
 	.stop_queue		= rt2800mmio_stop_queue,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
index 9f23b18c50bb..da813dfa9a91 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -687,6 +687,7 @@ static const struct rt2x00lib_ops rt2800usb_rt2x00_ops = {
 	.link_tuner		= rt2800_link_tuner,
 	.gain_calibration	= rt2800_gain_calibration,
 	.vco_calibration	= rt2800_vco_calibration,
+	.watchdog		= rt2800_watchdog,
 	.start_queue		= rt2800usb_start_queue,
 	.kick_queue		= rt2x00usb_kick_queue,
 	.stop_queue		= rt2800usb_stop_queue,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.h b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.h
index 099e747f70e7..23739dd0bc9b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.h
@@ -435,6 +435,9 @@ enum data_queue_flags {
  * @length: Number of frames in queue.
  * @index: Index pointers to entry positions in the queue,
  *	use &enum queue_index to get a specific index field.
+ * @wd_count: watchdog counter number of times entry does change
+ *      in the queue
+ * @wd_idx: index of queue entry saved by watchdog
  * @txop: maximum burst time.
  * @aifs: The aifs value for outgoing frames (field ignored in RX queue).
  * @cw_min: The cw min value for outgoing frames (field ignored in RX queue).
@@ -462,6 +465,9 @@ struct data_queue {
 	unsigned short length;
 	unsigned short index[Q_INDEX_MAX];
 
+	unsigned short wd_count;
+	unsigned int wd_idx;
+
 	unsigned short txop;
 	unsigned short aifs;
 	unsigned short cw_min;
-- 
2.20.1

