Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAFD539E89
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347765AbiFAHkS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350313AbiFAHkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18439969F
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=U7VDzUfo/MComxW8ryPBxSJ4ZD+uAoFOMoqs2ae4fr8=;
        t=1654069206; x=1655278806; b=PV+GoeD75LkTFuOERIfAmTnDcQnjd0I8nPxYhbVoS/GxJWa
        inIBi9ksrCJlKbPKxCKUmxAAPG4ll02a1z1jkXdV9LKD/GLwWEo+g39ywDjLenI4OYQL2Ladx8RTy
        MC+Vguxa1JnlT14WzYP3UaAROLqFtDPREyfPV3r1k2XCqUbW5cvRvZnF7Fu2vEXihMPF553S0ThF5
        xiwmv3O/vV0rKQChgVYyPJve9X900L5/1HvfYtVhHP4PdQrSg6HNnuH2ixeO0wtauWG+6kSdEDYAA
        1QAI/C4CGlKl1KYl5lf9WiKQAHb1pzF9yz+Vg4/qNII5BfGY5+qAHY5hbajbyrAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxY-00AJPK-RZ;
        Wed, 01 Jun 2022 09:40:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/15] mac80211: make some SMPS code MLD-aware
Date:   Wed,  1 Jun 2022 09:39:56 +0200
Message-Id: <20220601093922.399d17ff5c3b.Ia03d9b83db279084b47d4ed449e70735155f3bf2@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Start making some SMPS related code MLD-aware. This isn't
really done yet, but again cuts down our 'deflink' reliance.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c  |  4 +--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  2 +-
 drivers/net/wireless/realtek/rtw88/main.c     |  4 +--
 include/net/mac80211.h                        |  3 +-
 net/mac80211/cfg.c                            | 19 ++++++++----
 net/mac80211/debugfs_netdev.c                 |  2 +-
 net/mac80211/ht.c                             | 29 ++++++++++---------
 net/mac80211/ieee80211_i.h                    |  4 ++-
 net/mac80211/iface.c                          |  2 +-
 net/mac80211/mlme.c                           |  2 +-
 net/mac80211/util.c                           |  5 ++--
 11 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
index 40d790b36d85..1dc974e2c511 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2008 - 2014, 2022 Intel Corporation. All rights reserved.
  *****************************************************************************/
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
@@ -441,7 +441,7 @@ static void iwlagn_bt_traffic_change_work(struct work_struct *work)
 		priv->current_ht_config.smps = smps_request;
 		for_each_context(priv, ctx) {
 			if (ctx->vif && ctx->vif->type == NL80211_IFTYPE_STATION)
-				ieee80211_request_smps(ctx->vif, smps_request);
+				ieee80211_request_smps(ctx->vif, 0, smps_request);
 		}
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 3ee5ea3484be..14b2de65bd84 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -304,7 +304,7 @@ void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			smps_mode = IEEE80211_SMPS_DYNAMIC;
 	}
 
-	ieee80211_request_smps(vif, smps_mode);
+	ieee80211_request_smps(vif, 0, smps_mode);
 }
 
 static bool iwl_wait_stats_complete(struct iwl_notif_wait_data *notif_wait,
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index b151af13e310..a5d541b71ab9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1596,9 +1596,9 @@ static void rtw_vif_smps_iter(void *data, u8 *mac,
 		return;
 
 	if (rtwdev->hal.txrx_1ss)
-		ieee80211_request_smps(vif, IEEE80211_SMPS_STATIC);
+		ieee80211_request_smps(vif, 0, IEEE80211_SMPS_STATIC);
 	else
-		ieee80211_request_smps(vif, IEEE80211_SMPS_OFF);
+		ieee80211_request_smps(vif, 0, IEEE80211_SMPS_OFF);
 }
 
 void rtw_set_txrx_1ss(struct rtw_dev *rtwdev, bool txrx_1ss)
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a3621900fbe4..e7e91b283cab 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6210,13 +6210,14 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif,
 /**
  * ieee80211_request_smps - request SM PS transition
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: link ID for MLO, or 0
  * @smps_mode: new SM PS mode
  *
  * This allows the driver to request an SM PS transition in managed
  * mode. This is useful when the driver has more information than
  * the stack about possible interference, for example by bluetooth.
  */
-void ieee80211_request_smps(struct ieee80211_vif *vif,
+void ieee80211_request_smps(struct ieee80211_vif *vif, unsigned int link_id,
 			    enum ieee80211_smps_mode smps_mode);
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index cc332b31d219..cf63542d40fa 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2917,6 +2917,7 @@ static int ieee80211_testmode_dump(struct wiphy *wiphy,
 #endif
 
 int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
+				 unsigned int link_id,
 				 enum ieee80211_smps_mode smps_mode)
 {
 	const u8 *ap;
@@ -2930,8 +2931,8 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
 		return -EINVAL;
 
-	old_req = sdata->deflink.u.mgd.req_smps;
-	sdata->deflink.u.mgd.req_smps = smps_mode;
+	old_req = sdata->link[link_id]->u.mgd.req_smps;
+	sdata->link[link_id]->u.mgd.req_smps = smps_mode;
 
 	if (old_req == smps_mode &&
 	    smps_mode != IEEE80211_SMPS_AUTOMATIC)
@@ -2943,10 +2944,10 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	 * the new value until we associate.
 	 */
 	if (!sdata->u.mgd.associated ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
+	    sdata->vif.link_conf[link_id]->chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
-	ap = sdata->deflink.u.mgd.bssid;
+	ap = sdata->link[link_id]->u.mgd.bssid;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
@@ -2970,7 +2971,7 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	err = ieee80211_send_smps_action(sdata, smps_mode,
 					 ap, ap);
 	if (err)
-		sdata->deflink.u.mgd.req_smps = old_req;
+		sdata->link[link_id]->u.mgd.req_smps = old_req;
 	else if (smps_mode != IEEE80211_SMPS_OFF && tdls_peer_found)
 		ieee80211_teardown_tdls_peers(sdata);
 
@@ -2982,6 +2983,7 @@ static int ieee80211_set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = wdev_priv(dev->ieee80211_ptr);
+	unsigned int link_id;
 
 	if (sdata->vif.type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
@@ -2998,7 +3000,12 @@ static int ieee80211_set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 
 	/* no change, but if automatic follow powersave */
 	sdata_lock(sdata);
-	__ieee80211_request_smps_mgd(sdata, sdata->deflink.u.mgd.req_smps);
+	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
+		if (!sdata->link[link_id])
+			continue;
+		__ieee80211_request_smps_mgd(sdata, link_id,
+					     sdata->link[link_id]->u.mgd.req_smps);
+	}
 	sdata_unlock(sdata);
 
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_DYNAMIC_PS))
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index bd398b631763..dfb194e15018 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -256,7 +256,7 @@ static int ieee80211_set_smps(struct ieee80211_sub_if_data *sdata,
 		return -EOPNOTSUPP;
 
 	sdata_lock(sdata);
-	err = __ieee80211_request_smps_mgd(sdata, smps_mode);
+	err = __ieee80211_request_smps_mgd(sdata, 0, smps_mode);
 	sdata_unlock(sdata);
 
 	return err;
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 22677df83ed8..111828b559a0 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -542,30 +542,33 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_request_smps_mgd_work(struct work_struct *work)
 {
-	struct ieee80211_sub_if_data *sdata =
-		container_of(work, struct ieee80211_sub_if_data,
-			     deflink.u.mgd.request_smps_work);
-
-	sdata_lock(sdata);
-	__ieee80211_request_smps_mgd(sdata,
-				     sdata->deflink.u.mgd.driver_smps_mode);
-	sdata_unlock(sdata);
+	struct ieee80211_link_data *link =
+		container_of(work, struct ieee80211_link_data,
+			     u.mgd.request_smps_work);
+
+	sdata_lock(link->sdata);
+	__ieee80211_request_smps_mgd(link->sdata, link->link_id,
+				     link->u.mgd.driver_smps_mode);
+	sdata_unlock(link->sdata);
 }
 
-void ieee80211_request_smps(struct ieee80211_vif *vif,
+void ieee80211_request_smps(struct ieee80211_vif *vif, unsigned int link_id,
 			    enum ieee80211_smps_mode smps_mode)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_link_data *link = sdata->link[link_id];
 
 	if (WARN_ON_ONCE(vif->type != NL80211_IFTYPE_STATION))
 		return;
 
-	if (sdata->deflink.u.mgd.driver_smps_mode == smps_mode)
+	if (WARN_ON(!link))
 		return;
 
-	sdata->deflink.u.mgd.driver_smps_mode = smps_mode;
-	ieee80211_queue_work(&sdata->local->hw,
-			     &sdata->deflink.u.mgd.request_smps_work);
+	if (link->u.mgd.driver_smps_mode == smps_mode)
+		return;
+
+	link->u.mgd.driver_smps_mode = smps_mode;
+	ieee80211_queue_work(&sdata->local->hw, &link->u.mgd.request_smps_work);
 }
 /* this might change ... don't want non-open drivers using it */
 EXPORT_SYMBOL_GPL(ieee80211_request_smps);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e75496a99299..0948d074c4b9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2422,8 +2422,10 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 			    struct ieee802_11_elems *elems,
 			    enum nl80211_band band, u32 *basic_rates);
 int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
+				 unsigned int link_id,
 				 enum ieee80211_smps_mode smps_mode);
-void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata);
+void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata,
+			   unsigned int link_id);
 void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata);
 
 size_t ieee80211_ie_split_vendor(const u8 *ies, size_t ielen, size_t offset);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index c5be60ee12d8..ea75d5d5cb6a 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1657,7 +1657,7 @@ static void ieee80211_recalc_smps_work(struct work_struct *work)
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data, recalc_smps);
 
-	ieee80211_recalc_smps(sdata);
+	ieee80211_recalc_smps(sdata, 0);
 }
 
 /*
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 30423b2d4eee..cdbf7a5dc2ba 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2337,7 +2337,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	ieee80211_recalc_ps(local);
 	mutex_unlock(&local->iflist_mtx);
 
-	ieee80211_recalc_smps(sdata);
+	ieee80211_recalc_smps(sdata, 0);
 	ieee80211_recalc_ps_vif(sdata);
 
 	netif_carrier_on(sdata->dev);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 4ec96170a679..ecda655e7481 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2803,7 +2803,8 @@ void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
 }
 EXPORT_SYMBOL_GPL(ieee80211_resume_disconnect);
 
-void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata)
+void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata,
+			   unsigned int link_id)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *chanctx_conf;
@@ -2811,7 +2812,7 @@ void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata)
 
 	mutex_lock(&local->chanctx_mtx);
 
-	chanctx_conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+	chanctx_conf = rcu_dereference_protected(sdata->vif.link_conf[link_id]->chanctx_conf,
 						 lockdep_is_held(&local->chanctx_mtx));
 
 	/*
-- 
2.36.1

