Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBCFE0EA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 12:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfD2Kyo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 06:54:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbfD2Kyn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 06:54:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1704D308213B;
        Mon, 29 Apr 2019 10:54:43 +0000 (UTC)
Received: from localhost (unknown [10.43.2.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A20C864431;
        Mon, 29 Apr 2019 10:54:42 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [RFC/RFT 6/7] rt2x00: add restart hw
Date:   Mon, 29 Apr 2019 12:54:29 +0200
Message-Id: <1556535270-3551-7-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1556535270-3551-1-git-send-email-sgruszka@redhat.com>
References: <1556535270-3551-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 29 Apr 2019 10:54:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add ieee80211_restart_hw() to watchdog and debugfs file for testing
if restart works as expected.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c   |  4 +++
 drivers/net/wireless/ralink/rt2x00/rt2x00.h      |  7 +++++
 drivers/net/wireless/ralink/rt2x00/rt2x00debug.c | 35 ++++++++++++++++++++++++
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c   | 10 +++++--
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 4a2e15b5aba4..7d488fa8ef05 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1266,6 +1266,9 @@ void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
 
 	if (hung_rx)
 		rt2x00_warn(rt2x00dev, "Watchdog RX hung detected\n");
+
+	if (hung_tx || hung_rx)
+		ieee80211_restart_hw(rt2x00dev->hw);
 }
 EXPORT_SYMBOL_GPL(rt2800_watchdog);
 
@@ -10286,6 +10289,7 @@ int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev)
 		__set_bit(REQUIRE_TASKLET_CONTEXT, &rt2x00dev->cap_flags);
 	}
 
+	__set_bit(CAPABILITY_RESTART_HW, &rt2x00dev->cap_flags);
 	rt2x00dev->link.watchdog_interval = msecs_to_jiffies(100);
 
 	/*
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index cdf496c55b9d..1d7eaa9ecffb 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -724,6 +724,7 @@ enum rt2x00_capability_flags {
 	CAPABILITY_VCO_RECALIBRATION,
 	CAPABILITY_EXTERNAL_PA_TX0,
 	CAPABILITY_EXTERNAL_PA_TX1,
+	CAPABILITY_RESTART_HW,
 };
 
 /*
@@ -1281,6 +1282,12 @@ rt2x00_has_cap_vco_recalibration(struct rt2x00_dev *rt2x00dev)
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
index 05a2e8da412c..860a19cae3e5 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
@@ -63,6 +63,7 @@ struct rt2x00debug_intf {
 	 *   - chipset file
 	 *   - device state flags file
 	 *   - device capability flags file
+	 *   - hardware restart file
 	 *   - register folder
 	 *     - csr offset/value files
 	 *     - eeprom offset/value files
@@ -79,6 +80,7 @@ struct rt2x00debug_intf {
 	struct dentry *chipset_entry;
 	struct dentry *dev_flags;
 	struct dentry *cap_flags;
+	struct dentry *restart_hw;
 	struct dentry *register_folder;
 	struct dentry *csr_off_entry;
 	struct dentry *csr_val_entry;
@@ -577,6 +579,34 @@ static const struct file_operations rt2x00debug_fop_cap_flags = {
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
@@ -672,6 +702,10 @@ void rt2x00debug_register(struct rt2x00_dev *rt2x00dev)
 					      intf->driver_folder, intf,
 					      &rt2x00debug_fop_cap_flags);
 
+	intf->restart_hw = debugfs_create_file("restart_hw", 0200,
+					       intf->driver_folder, intf,
+					       &rt2x00debug_restart_hw);
+
 	intf->register_folder =
 	    debugfs_create_dir("register", intf->driver_folder);
 
@@ -753,6 +787,7 @@ void rt2x00debug_deregister(struct rt2x00_dev *rt2x00dev)
 	debugfs_remove(intf->csr_off_entry);
 	debugfs_remove(intf->register_folder);
 	debugfs_remove(intf->dev_flags);
+	debugfs_remove(intf->restart_hw);
 	debugfs_remove(intf->cap_flags);
 	debugfs_remove(intf->chipset_entry);
 	debugfs_remove(intf->driver_entry);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 357c0941aaad..93ab4d089b21 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1269,8 +1269,14 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
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
2.7.5

