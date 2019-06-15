Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E4E46F61
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFOKBL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 06:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOKBL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 06:01:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8236D308FC4D;
        Sat, 15 Jun 2019 10:01:10 +0000 (UTC)
Received: from localhost (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 214A060A98;
        Sat, 15 Jun 2019 10:01:09 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [PATCH v2 6/7] rt2x00: add restart hw
Date:   Sat, 15 Jun 2019 12:00:59 +0200
Message-Id: <20190615100100.29800-7-sgruszka@redhat.com>
In-Reply-To: <20190615100100.29800-1-sgruszka@redhat.com>
References: <20190615100100.29800-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sat, 15 Jun 2019 10:01:10 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add ieee80211_restart_hw() to watchdog and debugfs file for testing
if restart works as expected.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  4 +++
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  7 ++++
 .../net/wireless/ralink/rt2x00/rt2x00debug.c  | 35 +++++++++++++++++++
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    | 10 ++++--
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 32a4b84e6e05..0fb519f2b83f 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1263,6 +1263,9 @@ void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
 
 	if (hung_rx)
 		rt2x00_warn(rt2x00dev, "Watchdog RX hung detected\n");
+
+	if (hung_tx || hung_rx)
+		ieee80211_restart_hw(rt2x00dev->hw);
 }
 EXPORT_SYMBOL_GPL(rt2800_watchdog);
 
@@ -10283,6 +10286,7 @@ int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev)
 		__set_bit(REQUIRE_TASKLET_CONTEXT, &rt2x00dev->cap_flags);
 	}
 
+	__set_bit(CAPABILITY_RESTART_HW, &rt2x00dev->cap_flags);
 	rt2x00dev->link.watchdog_interval = msecs_to_jiffies(100);
 
 	/*
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index dc6b79e4be3b..7c7cced009bd 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -712,6 +712,7 @@ enum rt2x00_capability_flags {
 	CAPABILITY_VCO_RECALIBRATION,
 	CAPABILITY_EXTERNAL_PA_TX0,
 	CAPABILITY_EXTERNAL_PA_TX1,
+	CAPABILITY_RESTART_HW,
 };
 
 /*
@@ -1268,6 +1269,12 @@ rt2x00_has_cap_vco_recalibration(struct rt2x00_dev *rt2x00dev)
 	return rt2x00_has_cap_flag(rt2x00dev, CAPABILITY_VCO_RECALIBRATION);
 }
 
+static inline bool
+rt2x00_has_cap_restart_hw(struct rt2x00_dev *rt2x00dev)
+{
+	return rt2x00_has_cap_flag(rt2x00dev, CAPABILITY_RESTART_HW);
+}
+
 /**
  * rt2x00queue_map_txskb - Map a skb into DMA for TX purposes.
  * @entry: Pointer to &struct queue_entry
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c b/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
index aac3aae7afaa..ef5f51512212 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
@@ -52,6 +52,7 @@ struct rt2x00debug_intf {
 	 *   - chipset file
 	 *   - device state flags file
 	 *   - device capability flags file
+	 *   - hardware restart file
 	 *   - register folder
 	 *     - csr offset/value files
 	 *     - eeprom offset/value files
@@ -68,6 +69,7 @@ struct rt2x00debug_intf {
 	struct dentry *chipset_entry;
 	struct dentry *dev_flags;
 	struct dentry *cap_flags;
+	struct dentry *restart_hw;
 	struct dentry *register_folder;
 	struct dentry *csr_off_entry;
 	struct dentry *csr_val_entry;
@@ -566,6 +568,34 @@ static const struct file_operations rt2x00debug_fop_cap_flags = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t rt2x00debug_write_restart_hw(struct file *file,
+					    const char __user *buf,
+					    size_t length,
+					    loff_t *offset)
+{
+	struct rt2x00debug_intf *intf =	file->private_data;
+	struct rt2x00_dev *rt2x00dev = intf->rt2x00dev;
+	static unsigned long last_reset;
+
+	if (!rt2x00_has_cap_restart_hw(rt2x00dev))
+		return -EOPNOTSUPP;
+
+	if (time_before(jiffies, last_reset + msecs_to_jiffies(2000)))
+		return -EBUSY;
+
+	last_reset = jiffies;
+
+	ieee80211_restart_hw(rt2x00dev->hw);
+	return length;
+}
+
+static const struct file_operations rt2x00debug_restart_hw = {
+	.owner = THIS_MODULE,
+	.write = rt2x00debug_write_restart_hw,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
 static struct dentry *rt2x00debug_create_file_driver(const char *name,
 						     struct rt2x00debug_intf
 						     *intf,
@@ -661,6 +691,10 @@ void rt2x00debug_register(struct rt2x00_dev *rt2x00dev)
 					      intf->driver_folder, intf,
 					      &rt2x00debug_fop_cap_flags);
 
+	intf->restart_hw = debugfs_create_file("restart_hw", 0200,
+					       intf->driver_folder, intf,
+					       &rt2x00debug_restart_hw);
+
 	intf->register_folder =
 	    debugfs_create_dir("register", intf->driver_folder);
 
@@ -742,6 +776,7 @@ void rt2x00debug_deregister(struct rt2x00_dev *rt2x00dev)
 	debugfs_remove(intf->csr_off_entry);
 	debugfs_remove(intf->register_folder);
 	debugfs_remove(intf->dev_flags);
+	debugfs_remove(intf->restart_hw);
 	debugfs_remove(intf->cap_flags);
 	debugfs_remove(intf->chipset_entry);
 	debugfs_remove(intf->driver_entry);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index a6c374c483c2..35414f97a978 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1258,8 +1258,14 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 {
 	int retval;
 
-	if (test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags))
-		return 0;
+	if (test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags)) {
+		/*
+		 * This is special case for ieee80211_restart_hw(), otherwise
+		 * mac80211 never call start() two times in row without stop();
+		 */
+		rt2x00dev->ops->lib->pre_reset_hw(rt2x00dev);
+		rt2x00lib_stop(rt2x00dev);
+	}
 
 	/*
 	 * If this is the first interface which is added,
-- 
2.20.1

