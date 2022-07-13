Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC77573373
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiGMJrE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbiGMJpt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D40BF8953
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1aKFDpa64iFGS2dNyDW1/cvXhrsU195AJVW7XDxevcM=;
        t=1657705532; x=1658915132; b=JHLfC+l1LNShZ1GyEyCMB2IEtv1HQ+pHAg59P9uGwQPos86
        jz2KLrmE/kfIxA3zj0VYzTVKvT5dwJlInw1mFL+y13SxbTEviFY7C9L3mansU5RWffAHNmP9YnTHo
        AzGAy2VVT6OjuIgqALcJNnmhKFrPctc56h6QxIjDa7aSTj3sGOgn5g2q4Vmo7+yx3C1XU/9qwtZCX
        nc0mn4H+yc59mI8zaMhav17jSBZmMeXqiZuRQ+994xMQt9Djv3LIOIz6KlYVgZh+ViYsdlLgda0mI
        dgn/atsfMjJh0AK+lyOMVacen8aB7QBgapl5YJXo2EUQ1YhwcTHxYnkyq18NGdtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvy-00EgvB-66;
        Wed, 13 Jul 2022 11:45:30 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 74/76] wifi: mac80211: replace link_id with link_conf in switch/(un)assign_vif_chanctx()
Date:   Wed, 13 Jul 2022 11:45:00 +0200
Message-Id: <20220713114426.6a4ecdf1bce8.I968eb33364bd1999aeaa32eee7bbd9a6fd495090@changeid>
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

Since mac80211 already has a protected pointer to link_conf,
pass it to the driver to avoid additional RCU locking.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath10k/mac.c         |  4 +--
 drivers/net/wireless/ath/ath11k/mac.c         |  4 +--
 drivers/net/wireless/ath/ath9k/main.c         |  4 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 +--
 drivers/net/wireless/mac80211_hwsim.c         |  4 +--
 drivers/net/wireless/silabs/wfx/sta.c         |  4 +--
 drivers/net/wireless/silabs/wfx/sta.h         |  4 +--
 drivers/net/wireless/ti/wlcore/main.c         |  4 +--
 include/net/mac80211.h                        |  8 +++---
 net/mac80211/chan.c                           |  9 +++----
 net/mac80211/driver-ops.h                     | 26 +++++++++++++------
 net/mac80211/trace.h                          | 16 ++++++------
 net/mac80211/util.c                           |  2 +-
 13 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index ac54396418c9..9dd3b8fba4b0 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8920,7 +8920,7 @@ ath10k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 static int
 ath10k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 unsigned int link_id,
+				 struct ieee80211_bss_conf *link_conf,
 				 struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath10k *ar = hw->priv;
@@ -9000,7 +9000,7 @@ ath10k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 static void
 ath10k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
-				   unsigned int link_id,
+				   struct ieee80211_bss_conf *link_conf,
 				   struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath10k *ar = hw->priv;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ec7b3a3629f3..92e17d3c634e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7073,7 +7073,7 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 static int
 ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 unsigned int link_id,
+				 struct ieee80211_bss_conf *link_conf,
 				 struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath11k *ar = hw->priv;
@@ -7163,7 +7163,7 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 static void
 ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
-				   unsigned int link_id,
+				   struct ieee80211_bss_conf *link_conf,
 				   struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath11k *ar = hw->priv;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index d2c20c332c7a..a4197c14f0a9 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -2597,7 +2597,7 @@ static void ath9k_change_chanctx(struct ieee80211_hw *hw,
 
 static int ath9k_assign_vif_chanctx(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
-				    unsigned int link_id,
+				    struct ieee80211_bss_conf *link_conf,
 				    struct ieee80211_chanctx_conf *conf)
 {
 	struct ath_softc *sc = hw->priv;
@@ -2629,7 +2629,7 @@ static int ath9k_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 static void ath9k_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
-				       unsigned int link_id,
+				       struct ieee80211_bss_conf *link_conf,
 				       struct ieee80211_chanctx_conf *conf)
 {
 	struct ath_softc *sc = hw->priv;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 126106ea62d3..5eb28f8ee87e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4264,7 +4264,7 @@ static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
 }
 static int iwl_mvm_assign_vif_chanctx(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
-				      unsigned int link_id,
+				      struct ieee80211_bss_conf *link_conf,
 				      struct ieee80211_chanctx_conf *ctx)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
@@ -4338,7 +4338,7 @@ static void __iwl_mvm_unassign_vif_chanctx(struct iwl_mvm *mvm,
 
 static void iwl_mvm_unassign_vif_chanctx(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
-					 unsigned int link_id,
+					 struct ieee80211_bss_conf *link_conf,
 					 struct ieee80211_chanctx_conf *ctx)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 5243508bbfab..715661298f2a 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2794,7 +2794,7 @@ static void mac80211_hwsim_change_chanctx(struct ieee80211_hw *hw,
 
 static int mac80211_hwsim_assign_vif_chanctx(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif,
-					     unsigned int link_id,
+					     struct ieee80211_bss_conf *link_conf,
 					     struct ieee80211_chanctx_conf *ctx)
 {
 	hwsim_check_magic(vif);
@@ -2805,7 +2805,7 @@ static int mac80211_hwsim_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 static void mac80211_hwsim_unassign_vif_chanctx(struct ieee80211_hw *hw,
 						struct ieee80211_vif *vif,
-						unsigned int link_id,
+						struct ieee80211_bss_conf *link_conf,
 						struct ieee80211_chanctx_conf *ctx)
 {
 	hwsim_check_magic(vif);
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 920bd1a4a1b1..626dfb4b7a55 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -683,7 +683,7 @@ void wfx_change_chanctx(struct ieee80211_hw *hw, struct ieee80211_chanctx_conf *
 }
 
 int wfx_assign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			   unsigned int link_id,
+			   struct ieee80211_bss_conf *link_conf,
 			   struct ieee80211_chanctx_conf *conf)
 {
 	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv;
@@ -696,7 +696,7 @@ int wfx_assign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 void wfx_unassign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			      unsigned int link_id,
+			      struct ieee80211_bss_conf *link_conf,
 			      struct ieee80211_chanctx_conf *conf)
 {
 	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.h b/drivers/net/wireless/silabs/wfx/sta.h
index bf2e76167a6f..888db5cd3206 100644
--- a/drivers/net/wireless/silabs/wfx/sta.h
+++ b/drivers/net/wireless/silabs/wfx/sta.h
@@ -51,10 +51,10 @@ int wfx_add_chanctx(struct ieee80211_hw *hw, struct ieee80211_chanctx_conf *conf
 void wfx_remove_chanctx(struct ieee80211_hw *hw, struct ieee80211_chanctx_conf *conf);
 void wfx_change_chanctx(struct ieee80211_hw *hw, struct ieee80211_chanctx_conf *conf, u32 changed);
 int wfx_assign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			   unsigned int link_id,
+			   struct ieee80211_bss_conf *link_conf,
 			   struct ieee80211_chanctx_conf *conf);
 void wfx_unassign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			      unsigned int link_id,
+			      struct ieee80211_bss_conf *link_conf,
 			      struct ieee80211_chanctx_conf *conf);
 
 /* Hardware API Callbacks */
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 1edec9f3c0d8..3e3922d4c788 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -4701,7 +4701,7 @@ static void wlcore_op_change_chanctx(struct ieee80211_hw *hw,
 
 static int wlcore_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 					struct ieee80211_vif *vif,
-					unsigned int link_id,
+					struct ieee80211_bss_conf *link_conf,
 					struct ieee80211_chanctx_conf *ctx)
 {
 	struct wl1271 *wl = hw->priv;
@@ -4752,7 +4752,7 @@ static int wlcore_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 static void wlcore_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
-					   unsigned int link_id,
+					   struct ieee80211_bss_conf *link_conf,
 					   struct ieee80211_chanctx_conf *ctx)
 {
 	struct wl1271 *wl = hw->priv;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d080d7e38d0f..6e5e0708cfff 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -261,13 +261,13 @@ enum ieee80211_chanctx_switch_mode {
  * done.
  *
  * @vif: the vif that should be switched from old_ctx to new_ctx
- * @link_id: the link ID that's switching
+ * @link_conf: the link conf that's switching
  * @old_ctx: the old context to which the vif was assigned
  * @new_ctx: the new context to which the vif must be assigned
  */
 struct ieee80211_vif_chanctx_switch {
 	struct ieee80211_vif *vif;
-	unsigned int link_id;
+	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_chanctx_conf *old_ctx;
 	struct ieee80211_chanctx_conf *new_ctx;
 };
@@ -4297,11 +4297,11 @@ struct ieee80211_ops {
 			       u32 changed);
 	int (*assign_vif_chanctx)(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
-				  unsigned int link_id,
+				  struct ieee80211_bss_conf *link_conf,
 				  struct ieee80211_chanctx_conf *ctx);
 	void (*unassign_vif_chanctx)(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
-				     unsigned int link_id,
+				     struct ieee80211_bss_conf *link_conf,
 				     struct ieee80211_chanctx_conf *ctx);
 	int (*switch_vif_chanctx)(struct ieee80211_hw *hw,
 				  struct ieee80211_vif_chanctx_switch *vifs,
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 2e9bc285f0a5..f247daa41563 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -835,7 +835,6 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 					 struct ieee80211_chanctx *new_ctx)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	unsigned int link_id = link->link_id;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *curr_ctx = NULL;
@@ -850,13 +849,13 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	if (conf) {
 		curr_ctx = container_of(conf, struct ieee80211_chanctx, conf);
 
-		drv_unassign_vif_chanctx(local, sdata, link_id, curr_ctx);
+		drv_unassign_vif_chanctx(local, sdata, link->conf, curr_ctx);
 		conf = NULL;
 		list_del(&link->assigned_chanctx_list);
 	}
 
 	if (new_ctx) {
-		ret = drv_assign_vif_chanctx(local, sdata, link_id, new_ctx);
+		ret = drv_assign_vif_chanctx(local, sdata, link->conf, new_ctx);
 		if (ret)
 			goto out;
 
@@ -1276,7 +1275,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	vif_chsw[0].vif = &sdata->vif;
 	vif_chsw[0].old_ctx = &old_ctx->conf;
 	vif_chsw[0].new_ctx = &new_ctx->conf;
-	vif_chsw[0].link_id = link->link_id;
+	vif_chsw[0].link_conf = link->conf;
 
 	list_del(&link->reserved_chanctx_list);
 	link->reserved_chanctx = NULL;
@@ -1440,7 +1439,7 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 			vif_chsw[i].vif = &link->sdata->vif;
 			vif_chsw[i].old_ctx = &old_ctx->conf;
 			vif_chsw[i].new_ctx = &ctx->conf;
-			vif_chsw[i].link_id = link->link_id;
+			vif_chsw[i].link_conf = link->conf;
 
 			i++;
 		}
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index a04a88d122b7..0f06081c68ca 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -937,22 +937,31 @@ static inline void drv_change_chanctx(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline void drv_verify_link_exists(struct ieee80211_sub_if_data *sdata,
+					  struct ieee80211_bss_conf *link_conf)
+{
+	/* deflink always exists, so need to check only for other links */
+	if (sdata->deflink.conf != link_conf)
+		sdata_assert_lock(sdata);
+}
+
 static inline int drv_assign_vif_chanctx(struct ieee80211_local *local,
 					 struct ieee80211_sub_if_data *sdata,
-					 unsigned int link_id,
+					 struct ieee80211_bss_conf *link_conf,
 					 struct ieee80211_chanctx *ctx)
 {
 	int ret = 0;
 
+	drv_verify_link_exists(sdata, link_conf);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
-	trace_drv_assign_vif_chanctx(local, sdata, link_id, ctx);
+	trace_drv_assign_vif_chanctx(local, sdata, link_conf, ctx);
 	if (local->ops->assign_vif_chanctx) {
 		WARN_ON_ONCE(!ctx->driver_present);
 		ret = local->ops->assign_vif_chanctx(&local->hw,
 						     &sdata->vif,
-						     link_id,
+						     link_conf,
 						     &ctx->conf);
 	}
 	trace_drv_return_int(local, ret);
@@ -962,20 +971,21 @@ static inline int drv_assign_vif_chanctx(struct ieee80211_local *local,
 
 static inline void drv_unassign_vif_chanctx(struct ieee80211_local *local,
 					    struct ieee80211_sub_if_data *sdata,
-					    unsigned int link_id,
+					    struct ieee80211_bss_conf *link_conf,
 					    struct ieee80211_chanctx *ctx)
 {
 	might_sleep();
 
+	drv_verify_link_exists(sdata, link_conf);
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	trace_drv_unassign_vif_chanctx(local, sdata, link_id, ctx);
+	trace_drv_unassign_vif_chanctx(local, sdata, link_conf, ctx);
 	if (local->ops->unassign_vif_chanctx) {
 		WARN_ON_ONCE(!ctx->driver_present);
 		local->ops->unassign_vif_chanctx(&local->hw,
 						 &sdata->vif,
-						 link_id,
+						 link_conf,
 						 &ctx->conf);
 	}
 	trace_drv_return_void(local);
@@ -992,7 +1002,7 @@ static inline int drv_start_ap(struct ieee80211_local *local,
 	int ret = 0;
 
 	/* make sure link_conf is protected */
-	sdata_assert_lock(sdata);
+	drv_verify_link_exists(sdata, link_conf);
 
 	might_sleep();
 
@@ -1011,7 +1021,7 @@ static inline void drv_stop_ap(struct ieee80211_local *local,
 			       struct ieee80211_bss_conf *link_conf)
 {
 	/* make sure link_conf is protected */
-	sdata_assert_lock(sdata);
+	drv_verify_link_exists(sdata, link_conf);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 75e5c1376351..402110f439f8 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1669,7 +1669,7 @@ TRACE_EVENT(drv_switch_vif_chanctx,
 
 				SWITCH_ENTRY_ASSIGN(vif.vif_type, vif->type);
 				SWITCH_ENTRY_ASSIGN(vif.p2p, vif->p2p);
-				SWITCH_ENTRY_ASSIGN(link_id, link_id);
+				SWITCH_ENTRY_ASSIGN(link_id, link_conf->link_id);
 				strncpy(local_vifs[i].vif.vif_name,
 					sdata->name,
 					sizeof(local_vifs[i].vif.vif_name));
@@ -1710,10 +1710,10 @@ TRACE_EVENT(drv_switch_vif_chanctx,
 DECLARE_EVENT_CLASS(local_sdata_chanctx,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 unsigned int link_id,
+		 struct ieee80211_bss_conf *link_conf,
 		 struct ieee80211_chanctx *ctx),
 
-	TP_ARGS(local, sdata, link_id, ctx),
+	TP_ARGS(local, sdata, link_conf, ctx),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
@@ -1726,7 +1726,7 @@ DECLARE_EVENT_CLASS(local_sdata_chanctx,
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		CHANCTX_ASSIGN;
-		__entry->link_id = link_id;
+		__entry->link_id = link_conf->link_id;
 	),
 
 	TP_printk(
@@ -1738,17 +1738,17 @@ DECLARE_EVENT_CLASS(local_sdata_chanctx,
 DEFINE_EVENT(local_sdata_chanctx, drv_assign_vif_chanctx,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 unsigned int link_id,
+		 struct ieee80211_bss_conf *link_conf,
 		 struct ieee80211_chanctx *ctx),
-	TP_ARGS(local, sdata, link_id, ctx)
+	TP_ARGS(local, sdata, link_conf, ctx)
 );
 
 DEFINE_EVENT(local_sdata_chanctx, drv_unassign_vif_chanctx,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 unsigned int link_id,
+		 struct ieee80211_bss_conf *link_conf,
 		 struct ieee80211_chanctx *ctx),
-	TP_ARGS(local, sdata, link_id, ctx)
+	TP_ARGS(local, sdata, link_conf, ctx)
 );
 
 TRACE_EVENT(drv_start_ap,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index cb44fa9a5048..994a49b892a6 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2267,7 +2267,7 @@ static void ieee80211_assign_chanctx(struct ieee80211_local *local,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (conf) {
 		ctx = container_of(conf, struct ieee80211_chanctx, conf);
-		drv_assign_vif_chanctx(local, sdata, link->link_id, ctx);
+		drv_assign_vif_chanctx(local, sdata, link->conf, ctx);
 	}
 	mutex_unlock(&local->chanctx_mtx);
 }
-- 
2.36.1

