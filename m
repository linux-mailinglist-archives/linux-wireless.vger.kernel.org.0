Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7E573345
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiGMJqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiGMJp0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E98F5100
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cX/BeR+h76ka3Kt1VUdoS/kmfbv7UXAyLqzcyZEb4To=;
        t=1657705522; x=1658915122; b=aUT9ZJZlhm/YaKEP2FhvZIkvPMolsyxoJWFY7Yi4ZbYfp0u
        Er2012204s5b8F07iqcEk12PnJslfF9giMm8HEv2gfaoSUglPlCABeGJ8v/8SGrVLNcw2hVFky52O
        QJDqwV2EaQDlDp2beu9sitCsG1kcQVprV6kfxrqZeK2kODmx1VtCNfPslLQ1FCq2KL9ALL4mbtOpK
        g8Umx5pIVcKzLRGiOAL1LtHnGy0KXGvPfO0vsWbs5oC8kWzgdW7ay2TTA3ih3H5EqieH7UMsMwNmu
        gDzCCD7Ec31Cxlw+ezrCDRwr5RdHLQEb0eRmm85C6pkq06HIv5JvPK4STZi2DPrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvn-00EgvB-2C;
        Wed, 13 Jul 2022 11:45:19 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 45/76] wifi: mac80211: replace link_id with link_conf in start/stop_ap()
Date:   Wed, 13 Jul 2022 11:44:31 +0200
Message-Id: <20220713114425.04ff106a9b9e.I83fe22e7216099b3d1fd962bcf33b79e145cbdb2@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

From: Gregory Greenman <gregory.greenman@intel.com>

When calling start/stop_ap(), mac80211 already has a protected
link_conf pointer. Pass it to the driver, so it shouldn't
handle RCU protection.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 16 ++++++-------
 drivers/net/wireless/realtek/rtw88/mac80211.c |  3 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  5 ++--
 drivers/net/wireless/silabs/wfx/sta.c         |  4 ++--
 drivers/net/wireless/silabs/wfx/sta.h         |  4 ++--
 include/net/mac80211.h                        |  4 ++--
 net/mac80211/cfg.c                            |  4 ++--
 net/mac80211/driver-ops.h                     | 18 ++++++++++-----
 net/mac80211/trace.h                          | 23 ++++++++-----------
 net/mac80211/util.c                           |  3 ++-
 10 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 3de558f286a1..126106ea62d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2397,7 +2397,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 
 static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 unsigned int link_id)
+				 struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -2525,20 +2525,20 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 
 static int iwl_mvm_start_ap(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
-			    unsigned int link_id)
+			    struct ieee80211_bss_conf *link_conf)
 {
-	return iwl_mvm_start_ap_ibss(hw, vif, link_id);
+	return iwl_mvm_start_ap_ibss(hw, vif, link_conf);
 }
 
 static int iwl_mvm_start_ibss(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif)
 {
-	return iwl_mvm_start_ap_ibss(hw, vif, 0);
+	return iwl_mvm_start_ap_ibss(hw, vif, &vif->bss_conf);
 }
 
 static void iwl_mvm_stop_ap_ibss(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 unsigned int link_id)
+				 struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -2603,15 +2603,15 @@ static void iwl_mvm_stop_ap_ibss(struct ieee80211_hw *hw,
 
 static void iwl_mvm_stop_ap(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
-			    unsigned int link_id)
+			    struct ieee80211_bss_conf *link_conf)
 {
-	iwl_mvm_stop_ap_ibss(hw, vif, link_id);
+	iwl_mvm_stop_ap_ibss(hw, vif, link_conf);
 }
 
 static void iwl_mvm_stop_ibss(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif)
 {
-	iwl_mvm_stop_ap_ibss(hw, vif, 0);
+	iwl_mvm_stop_ap_ibss(hw, vif, &vif->bss_conf);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index bb7291665d37..c7b98a0599d5 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -430,7 +430,8 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 }
 
 static int rtw_ops_start_ap(struct ieee80211_hw *hw,
-			    struct ieee80211_vif *vif, unsigned int link_id)
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf)
 {
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f40569c8575c..cef27e781ae2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -382,7 +382,8 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 }
 
 static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
-			      struct ieee80211_vif *vif, unsigned int link_id)
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
@@ -403,7 +404,7 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 
 static
 void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		       unsigned int link_id)
+		       struct ieee80211_bss_conf *link_conf)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 89402afe4fe6..920bd1a4a1b1 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -380,7 +380,7 @@ static void wfx_set_mfp_ap(struct wfx_vif *wvif)
 }
 
 int wfx_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		 unsigned int link_id)
+		 struct ieee80211_bss_conf *link_conf)
 {
 	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv;
 	struct wfx_dev *wdev = wvif->wdev;
@@ -399,7 +399,7 @@ int wfx_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 void wfx_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		 unsigned int link_id)
+		 struct ieee80211_bss_conf *link_conf)
 {
 	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv;
 
diff --git a/drivers/net/wireless/silabs/wfx/sta.h b/drivers/net/wireless/silabs/wfx/sta.h
index 6558c5698cc8..bf2e76167a6f 100644
--- a/drivers/net/wireless/silabs/wfx/sta.h
+++ b/drivers/net/wireless/silabs/wfx/sta.h
@@ -30,9 +30,9 @@ void wfx_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 int wfx_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 void wfx_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 int wfx_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		 unsigned int link_id);
+		 struct ieee80211_bss_conf *link_conf);
 void wfx_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		 unsigned int link_id);
+		 struct ieee80211_bss_conf *link_conf);
 int wfx_join_ibss(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 void wfx_leave_ibss(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 398da2336707..d080d7e38d0f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4092,9 +4092,9 @@ struct ieee80211_ops {
 				  u64 changed);
 
 	int (*start_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			unsigned int link_id);
+			struct ieee80211_bss_conf *link_conf);
 	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			unsigned int link_id);
+			struct ieee80211_bss_conf *link_conf);
 
 	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
 				 struct netdev_hw_addr_list *mc_list);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8a37f1402328..873e1acc8c30 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1296,7 +1296,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
 	}
 
-	err = drv_start_ap(sdata->local, sdata, link_id);
+	err = drv_start_ap(sdata->local, sdata, link_conf);
 	if (err) {
 		old = sdata_dereference(link->u.ap.beacon, sdata);
 
@@ -1457,7 +1457,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 				   GFP_KERNEL);
 	}
 
-	drv_stop_ap(sdata->local, sdata, link_id);
+	drv_stop_ap(sdata->local, sdata, link_conf);
 
 	/* free all potentially still buffered bcast frames */
 	local->total_ps_buffered -= skb_queue_len(&sdata->u.ap.ps.bc_buf);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index eb16a354338c..a04a88d122b7 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -987,32 +987,38 @@ int drv_switch_vif_chanctx(struct ieee80211_local *local,
 
 static inline int drv_start_ap(struct ieee80211_local *local,
 			       struct ieee80211_sub_if_data *sdata,
-			       unsigned int link_id)
+			       struct ieee80211_bss_conf *link_conf)
 {
 	int ret = 0;
 
+	/* make sure link_conf is protected */
+	sdata_assert_lock(sdata);
+
 	might_sleep();
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
-	trace_drv_start_ap(local, sdata, link_id);
+	trace_drv_start_ap(local, sdata, link_conf);
 	if (local->ops->start_ap)
-		ret = local->ops->start_ap(&local->hw, &sdata->vif, link_id);
+		ret = local->ops->start_ap(&local->hw, &sdata->vif, link_conf);
 	trace_drv_return_int(local, ret);
 	return ret;
 }
 
 static inline void drv_stop_ap(struct ieee80211_local *local,
 			       struct ieee80211_sub_if_data *sdata,
-			       unsigned int link_id)
+			       struct ieee80211_bss_conf *link_conf)
 {
+	/* make sure link_conf is protected */
+	sdata_assert_lock(sdata);
+
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	trace_drv_stop_ap(local, sdata, link_id);
+	trace_drv_stop_ap(local, sdata, link_conf);
 	if (local->ops->stop_ap)
-		local->ops->stop_ap(&local->hw, &sdata->vif, link_id);
+		local->ops->stop_ap(&local->hw, &sdata->vif, link_conf);
 	trace_drv_return_void(local);
 }
 
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index b6f12ac91849..75e5c1376351 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1754,9 +1754,9 @@ DEFINE_EVENT(local_sdata_chanctx, drv_unassign_vif_chanctx,
 TRACE_EVENT(drv_start_ap,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 unsigned int link_id),
+		 struct ieee80211_bss_conf *link_conf),
 
-	TP_ARGS(local, sdata, link_id),
+	TP_ARGS(local, sdata, link_conf),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
@@ -1769,17 +1769,12 @@ TRACE_EVENT(drv_start_ap,
 	),
 
 	TP_fast_assign(
-		struct ieee80211_bss_conf *info =
-			sdata_dereference(sdata->vif.link_conf[link_id], sdata);
-
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
-		__entry->link_id = link_id;
-		if (info) {
-			__entry->dtimper = info->dtim_period;
-			__entry->bcnint = info->beacon_int;
-			__entry->hidden_ssid = info->hidden_ssid;
-		}
+		__entry->link_id = link_conf->link_id;
+		__entry->dtimper = link_conf->dtim_period;
+		__entry->bcnint = link_conf->beacon_int;
+		__entry->hidden_ssid = link_conf->hidden_ssid;
 		memcpy(__get_dynamic_array(ssid),
 		       sdata->vif.cfg.ssid,
 		       sdata->vif.cfg.ssid_len);
@@ -1794,9 +1789,9 @@ TRACE_EVENT(drv_start_ap,
 TRACE_EVENT(drv_stop_ap,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 unsigned int link_id),
+		 struct ieee80211_bss_conf *link_conf),
 
-	TP_ARGS(local, sdata, link_id),
+	TP_ARGS(local, sdata, link_conf),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
@@ -1807,7 +1802,7 @@ TRACE_EVENT(drv_stop_ap,
 	TP_fast_assign(
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
-		__entry->link_id = link_id;
+		__entry->link_id = link_conf->link_id;
 	),
 
 	TP_printk(
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 78fb0c3aa4ad..f7c127a434b8 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2576,7 +2576,8 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 				changed |= BSS_CHANGED_AP_PROBE_RESP;
 
 				if (rcu_access_pointer(sdata->deflink.u.ap.beacon))
-					drv_start_ap(local, sdata, 0);
+					drv_start_ap(local, sdata,
+						     sdata->deflink.conf);
 			}
 			fallthrough;
 		case NL80211_IFTYPE_MESH_POINT:
-- 
2.36.1

