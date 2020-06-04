Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01AA1EE20C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 12:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgFDKEg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDKEg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 06:04:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28BDC03E96D
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 03:04:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jgmje-009Ft3-07; Thu, 04 Jun 2020 12:04:30 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] cfg80211: fix potential management registrations deadlock
Date:   Thu,  4 Jun 2020 12:04:20 +0200
Message-Id: <20200604120420.b1dc540a7e26.I55dcca56bb5bdc5d7ad66a36a0b42afd7034d8be@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Lockdep reports that we may deadlock because we take the RTNL on
the work struct, but flush it under RTNL. Clearly, it's correct.

Fix this by moving the work struct to the wiphy (registered dev)
layer, and iterate over all the wdevs inside there. This then
means we need to track which one of them has work to do, so we
don't update to the driver for all wdevs all the time.

Also fix a locking bug I noticed while working on this - the
registrations list is iterated as if it was an RCU list, but it
isn't handle that way - and we need to lock now for the update
flag anyway, so remove the RCU.

Fixes: 6cd536fe62ef ("cfg80211: change internal management frame registration API")
Reported-by: Markus Theil <markus.theil@tu-ilmenau.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  5 +++--
 net/wireless/core.c    |  6 +++---
 net/wireless/core.h    |  2 ++
 net/wireless/mlme.c    | 26 +++++++++++++++++++++-----
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b58ad1a3f695..fc7e8807838d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5075,7 +5075,8 @@ struct cfg80211_cqm_config;
  *	by cfg80211 on change_interface
  * @mgmt_registrations: list of registrations for management frames
  * @mgmt_registrations_lock: lock for the list
- * @mgmt_registrations_update_wk: update work to defer from atomic context
+ * @mgmt_registrations_need_update: mgmt registrations were updated,
+ *	need to propagate the update to the driver
  * @mtx: mutex used to lock data in this struct, may be used by drivers
  *	and some API functions require it held
  * @beacon_interval: beacon interval used on this device for transmitting
@@ -5121,7 +5122,7 @@ struct wireless_dev {
 
 	struct list_head mgmt_registrations;
 	spinlock_t mgmt_registrations_lock;
-	struct work_struct mgmt_registrations_update_wk;
+	u8 mgmt_registrations_need_update:1;
 
 	struct mutex mtx;
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index f0226ae9561c..c623d9bf5096 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -497,6 +497,8 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_WORK(&rdev->propagate_radar_detect_wk,
 		  cfg80211_propagate_radar_detect_wk);
 	INIT_WORK(&rdev->propagate_cac_done_wk, cfg80211_propagate_cac_done_wk);
+	INIT_WORK(&rdev->mgmt_registrations_update_wk,
+		  cfg80211_mgmt_registrations_update_wk);
 
 #ifdef CONFIG_CFG80211_DEFAULT_PS
 	rdev->wiphy.flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
@@ -1047,6 +1049,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	flush_work(&rdev->sched_scan_stop_wk);
 	flush_work(&rdev->propagate_radar_detect_wk);
 	flush_work(&rdev->propagate_cac_done_wk);
+	flush_work(&rdev->mgmt_registrations_update_wk);
 
 #ifdef CONFIG_PM
 	if (rdev->wiphy.wowlan_config && rdev->ops->set_wakeup)
@@ -1108,7 +1111,6 @@ static void __cfg80211_unregister_wdev(struct wireless_dev *wdev, bool sync)
 	rdev->devlist_generation++;
 
 	cfg80211_mlme_purge_registrations(wdev);
-	flush_work(&wdev->mgmt_registrations_update_wk);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_P2P_DEVICE:
@@ -1253,8 +1255,6 @@ void cfg80211_init_wdev(struct cfg80211_registered_device *rdev,
 	spin_lock_init(&wdev->event_lock);
 	INIT_LIST_HEAD(&wdev->mgmt_registrations);
 	spin_lock_init(&wdev->mgmt_registrations_lock);
-	INIT_WORK(&wdev->mgmt_registrations_update_wk,
-		  cfg80211_mgmt_registrations_update_wk);
 	INIT_LIST_HEAD(&wdev->pmsr_list);
 	spin_lock_init(&wdev->pmsr_lock);
 	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index e0e5b3ee9699..67b0389fca4d 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -99,6 +99,8 @@ struct cfg80211_registered_device {
 	struct cfg80211_chan_def cac_done_chandef;
 	struct work_struct propagate_cac_done_wk;
 
+	struct work_struct mgmt_registrations_update_wk;
+
 	/* must be last because of the way we do wiphy_priv(),
 	 * and it should at least be aligned to NETDEV_ALIGN */
 	struct wiphy wiphy __aligned(NETDEV_ALIGN);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 189334314cba..a6c61a2e6569 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -440,9 +440,15 @@ static void cfg80211_mgmt_registrations_update(struct wireless_dev *wdev)
 
 	ASSERT_RTNL();
 
+	spin_lock_bh(&wdev->mgmt_registrations_lock);
+	if (!wdev->mgmt_registrations_need_update) {
+		spin_unlock_bh(&wdev->mgmt_registrations_lock);
+		return;
+	}
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(tmp, &rdev->wiphy.wdev_list, list) {
-		list_for_each_entry_rcu(reg, &tmp->mgmt_registrations, list) {
+		list_for_each_entry(reg, &tmp->mgmt_registrations, list) {
 			u32 mask = BIT(le16_to_cpu(reg->frame_type) >> 4);
 			u32 mcast_mask = 0;
 
@@ -460,16 +466,23 @@ static void cfg80211_mgmt_registrations_update(struct wireless_dev *wdev)
 	}
 	rcu_read_unlock();
 
+	wdev->mgmt_registrations_need_update = 0;
+	spin_unlock_bh(&wdev->mgmt_registrations_lock);
+
 	rdev_update_mgmt_frame_registrations(rdev, wdev, &upd);
 }
 
 void cfg80211_mgmt_registrations_update_wk(struct work_struct *wk)
 {
-	struct wireless_dev *wdev = container_of(wk, struct wireless_dev,
-						 mgmt_registrations_update_wk);
+	struct cfg80211_registered_device *rdev;
+	struct wireless_dev *wdev;
+
+	rdev = container_of(wk, struct cfg80211_registered_device,
+			    mgmt_registrations_update_wk);
 
 	rtnl_lock();
-	cfg80211_mgmt_registrations_update(wdev);
+	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
+		cfg80211_mgmt_registrations_update(wdev);
 	rtnl_unlock();
 }
 
@@ -557,6 +570,7 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 		nreg->multicast_rx = multicast_rx;
 		list_add(&nreg->list, &wdev->mgmt_registrations);
 	}
+	wdev->mgmt_registrations_need_update = 1;
 	spin_unlock_bh(&wdev->mgmt_registrations_lock);
 
 	cfg80211_mgmt_registrations_update(wdev);
@@ -585,7 +599,8 @@ void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlportid)
 		list_del(&reg->list);
 		kfree(reg);
 
-		schedule_work(&wdev->mgmt_registrations_update_wk);
+		wdev->mgmt_registrations_need_update = 1;
+		schedule_work(&rdev->mgmt_registrations_update_wk);
 	}
 
 	spin_unlock_bh(&wdev->mgmt_registrations_lock);
@@ -608,6 +623,7 @@ void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev)
 		list_del(&reg->list);
 		kfree(reg);
 	}
+	wdev->mgmt_registrations_need_update = 1;
 	spin_unlock_bh(&wdev->mgmt_registrations_lock);
 
 	cfg80211_mgmt_registrations_update(wdev);
-- 
2.26.2

