Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4553296B80
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 23:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfHTVeW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 17:34:22 -0400
Received: from gesmail.globaledgesoft.com ([182.73.204.242]:42747 "EHLO
        gesmail.globaledgesoft.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730430AbfHTVeW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 17:34:22 -0400
Received: from mail.globaledgesoft.com (mail.globaledgesoft.com [172.16.2.30])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gesmail.globaledgesoft.com (Postfix) with ESMTP id A3FBA7C882C;
        Wed, 21 Aug 2019 03:03:27 +0530 (IST)
Received: from mail.globaledgesoft.com (localhost [127.0.0.1])
        by mail.globaledgesoft.com (Postfix) with ESMTPS id 59061B8086B;
        Wed, 21 Aug 2019 03:09:56 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.globaledgesoft.com (Postfix) with ESMTP id 3B118B80855;
        Wed, 21 Aug 2019 03:09:56 +0530 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mail.globaledgesoft.com
Received: from mail.globaledgesoft.com ([127.0.0.1])
        by localhost (mail.globaledgesoft.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q1ikFjkeU6Qa; Wed, 21 Aug 2019 03:09:56 +0530 (IST)
Received: from localhost.localdomain (unknown [172.16.2.250])
        by mail.globaledgesoft.com (Postfix) with ESMTPSA id 0E6E4B8071C;
        Wed, 21 Aug 2019 03:09:56 +0530 (IST)
From:   Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
Subject: [PATCH 1/1] nl80211: AP deauthentication flooding.
Date:   Wed, 21 Aug 2019 03:03:59 +0530
Message-Id: <1566336839-11508-1-git-send-email-b.balakrishna@globaledgesoft.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AP sends deauth per each data frame to STA which is not associated to
AP. Non associated STA keeps on sending data frame and leads to deauth
flooding.

Fix to be sending at-most single deauth per second if AP receive data frame from
non-associated STA.

Signed-off-by: Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
---
 net/wireless/core.c    | 67 +++++++++++++++++++++++++++++++++++++++++++++
 net/wireless/core.h    | 17 ++++++++++++
 net/wireless/nl80211.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 152 insertions(+), 5 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index a599469..a29b02a 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -360,6 +360,71 @@ static void cfg80211_sched_scan_stop_wk(struct work_struct *work)
 	rtnl_unlock();
 }
 
+/**
+ * This timer will check for expired node and it will delete that node.
+ * Timer will run for every 10 seconds till list is empty.
+ **/
+void cfg80211_non_assoc_sta_timer_wk(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct cfg80211_non_assoc_stas_info *uk_stas_info;
+	struct cfg80211_non_assoc_single_sta_info *sta, *tsta;
+
+	uk_stas_info = container_of(delayed_work,
+			struct cfg80211_non_assoc_stas_info, sta_update_timer);
+
+	if (list_empty(&uk_stas_info->non_assoc_sta_list))
+		return;
+
+	spin_lock(&uk_stas_info->sta_lock);
+	list_for_each_entry_safe(sta, tsta,
+	 &uk_stas_info->non_assoc_sta_list, list) {
+	/* Clearing the node if we didn't receive any packet within 4 seconds */
+	    if (time_before(sta->last_rx_pkt +
+	     (CFG80211_NON_ASSOC_MIN_CACHE_UPDATE * HZ), jiffies)) {
+	        list_del(&sta->list);
+	        kfree(sta);
+	    }
+	}
+	spin_unlock(&uk_stas_info->sta_lock);
+
+	schedule_delayed_work(&uk_stas_info->sta_update_timer,
+	            CFG80211_NON_ASSOC_FILTER_TIMER_INT * HZ);
+}
+
+static void cfg80211_non_assoc_sta_info_dealloc(
+	                struct cfg80211_registered_device *rdev)
+{
+	struct cfg80211_non_assoc_single_sta_info *sta, *tsta;
+	struct cfg80211_non_assoc_stas_info *uk_stas_info =
+	                    rdev->non_assoc_stas_info;
+
+	cancel_delayed_work_sync(&uk_stas_info->sta_update_timer);
+	spin_lock(&uk_stas_info->sta_lock);
+	list_for_each_entry_safe(sta, tsta,
+	 &uk_stas_info->non_assoc_sta_list, list) {
+	    list_del(&sta->list);
+	    kfree(sta);
+	}
+	spin_unlock(&uk_stas_info->sta_lock);
+
+	kfree(rdev->non_assoc_stas_info);
+}
+
+static void cfg80211_non_assoc_sta_info_alloc(
+	                struct cfg80211_registered_device *rdev)
+{
+	rdev->non_assoc_stas_info = kzalloc(
+	    sizeof(struct cfg80211_non_assoc_stas_info), GFP_KERNEL);
+	if (!rdev->non_assoc_stas_info)
+		return;
+
+	INIT_LIST_HEAD(&rdev->non_assoc_stas_info->non_assoc_sta_list);
+	spin_lock_init(&rdev->non_assoc_stas_info->sta_lock);
+	INIT_DELAYED_WORK(&rdev->non_assoc_stas_info->sta_update_timer,
+	                cfg80211_non_assoc_sta_timer_wk);
+}
+
 static void cfg80211_propagate_radar_detect_wk(struct work_struct *work)
 {
 	struct cfg80211_registered_device *rdev;
@@ -521,6 +586,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
 
 	init_waitqueue_head(&rdev->dev_wait);
+	cfg80211_non_assoc_sta_info_alloc(rdev);
 
 	/*
 	 * Initialize wiphy parameters to IEEE 802.11 MIB default values.
@@ -1024,6 +1090,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	flush_work(&rdev->destroy_work);
 	flush_work(&rdev->sched_scan_stop_wk);
 	flush_work(&rdev->mlme_unreg_wk);
+	cfg80211_non_assoc_sta_info_dealloc(rdev);
 	flush_work(&rdev->propagate_radar_detect_wk);
 	flush_work(&rdev->propagate_cac_done_wk);
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 77556c5..7bfbbec 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -21,6 +21,22 @@
 
 #define WIPHY_IDX_INVALID	-1
 
+/* Running  non-association filter timer for every 10 seconds */
+#define CFG80211_NON_ASSOC_FILTER_TIMER_INT    10
+#define CFG80211_NON_ASSOC_MIN_CACHE_UPDATE    4
+struct cfg80211_non_assoc_stas_info {
+	struct list_head non_assoc_sta_list;
+	spinlock_t sta_lock;
+	struct delayed_work sta_update_timer;
+};
+
+struct cfg80211_non_assoc_single_sta_info {
+	u8 address[ETH_ALEN];
+	u16 count;
+	unsigned long last_rx_pkt;
+	struct list_head list;
+};
+
 struct cfg80211_registered_device {
 	const struct cfg80211_ops *ops;
 	struct list_head list;
@@ -103,6 +119,7 @@ struct cfg80211_registered_device {
 	struct cfg80211_chan_def cac_done_chandef;
 	struct work_struct propagate_cac_done_wk;
 
+	struct cfg80211_non_assoc_stas_info *non_assoc_stas_info;
 	/* must be last because of the way we do wiphy_priv(),
 	 * and it should at least be aligned to NETDEV_ALIGN */
 	struct wiphy wiphy __aligned(NETDEV_ALIGN);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 92e0648..10ee3cf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15686,11 +15686,31 @@ static bool __nl80211_unexpected_frame(struct net_device *dev, u8 cmd,
 	return true;
 }
 
+struct cfg80211_non_assoc_single_sta_info * cfg80211_find_non_assoc_sta_entry(
+	struct cfg80211_non_assoc_stas_info *uk_stas_info, const u8 *addr)
+{
+	struct cfg80211_non_assoc_single_sta_info *sta, *find_sta = NULL;
+
+	spin_lock(&uk_stas_info->sta_lock);
+	list_for_each_entry(sta, &uk_stas_info->non_assoc_sta_list, list) {
+	    if (ether_addr_equal(addr, sta->address)) {
+	        find_sta = sta;
+	        break;
+	    }
+	}
+	spin_unlock(&uk_stas_info->sta_lock);
+
+	return find_sta;
+}
+
 bool cfg80211_rx_spurious_frame(struct net_device *dev,
 				const u8 *addr, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	bool ret;
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	bool ret, run_timer = false, deauth = true;
+	struct cfg80211_non_assoc_single_sta_info *sta;
 
 	trace_cfg80211_rx_spurious_frame(dev, addr);
 
@@ -15699,10 +15719,53 @@ bool cfg80211_rx_spurious_frame(struct net_device *dev,
 		trace_cfg80211_return_bool(false);
 		return false;
 	}
-	ret = __nl80211_unexpected_frame(dev, NL80211_CMD_UNEXPECTED_FRAME,
-					 addr, gfp);
-	trace_cfg80211_return_bool(ret);
-	return ret;
+
+	if (!rdev->non_assoc_stas_info)
+	    return true;
+
+	/* If list is empty, we should trigger the timer to clear the node */
+	if (list_empty(&rdev->non_assoc_stas_info->non_assoc_sta_list))
+	    run_timer = true;
+
+
+	/* If we didn't find the station, creating new node. Else, updating the time */
+	sta = cfg80211_find_non_assoc_sta_entry(
+	                rdev->non_assoc_stas_info, addr);
+	if (sta) {
+	/* Checking pkt is received within second. If we didn't update, sending deauth packet */
+	    if (time_after(sta->last_rx_pkt + HZ, jiffies))
+	        deauth = false;
+	    else
+	        sta->last_rx_pkt = jiffies;
+	} else {
+	    sta = kzalloc(sizeof
+	     (struct cfg80211_non_assoc_single_sta_info), GFP_ATOMIC);
+	    if (sta == NULL)
+	        return true;
+
+	    memcpy(sta->address, addr, ETH_ALEN);
+	    spin_lock(&rdev->non_assoc_stas_info->sta_lock);
+	    list_add(&sta->list,
+	        &rdev->non_assoc_stas_info->non_assoc_sta_list);
+	    spin_unlock(&rdev->non_assoc_stas_info->sta_lock);
+	    sta->last_rx_pkt = jiffies;
+	}
+
+	sta->count++;
+
+	if (run_timer)
+	    schedule_delayed_work(
+	        &rdev->non_assoc_stas_info->sta_update_timer,
+	        CFG80211_NON_ASSOC_FILTER_TIMER_INT * HZ);
+
+	if (deauth) {
+	    ret = __nl80211_unexpected_frame(dev,
+	            NL80211_CMD_UNEXPECTED_FRAME, addr, gfp);
+	    trace_cfg80211_return_bool(ret);
+	    return ret;
+	}
+
+	return true;
 }
 EXPORT_SYMBOL(cfg80211_rx_spurious_frame);
 
-- 
1.9.1

Disclaimer:- The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. The views expressed in this E-mail message (including the enclosure/(s) or attachment/(s) if any) are those of the individual sender, except where the sender expressly, and with authority, states them to be the views of GlobalEdge. Before opening any mail and attachments please check them for viruses .GlobalEdge does not accept any liability for virus infected mails.

