Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69670FCEB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjEXRpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbjEXRpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:45:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2B9A4
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950277; x=1716486277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JjRhdwXY/5Gez+4iZRc0AEmrFWod1wb8Juncfi2ZktM=;
  b=i2K9mvD+sddcgO2x+7dauaRqU2FzlVgaDlsJEy6nU3rMSoBK+LrdiD3K
   zLUBk5CqCcqU5573FHgTh+lleYNGdWR4/SLbazV/DKhyVq8uVWfL5scDp
   U5GJgT41UOoBlzEnw6m2UEgygeJQReM1RVa5jt6yAjMJalcuIHop/iOGQ
   4g+3owO4cP6BBv0LoQ3ZZCH9L9uXYgapHg0blNYyN2UE4uMpuqpwSBpw4
   +PRpfQx4jGBjaLkH5GYvwsxuYpqBvZISMsBF2sYkm49twn15qc2/HYYME
   AhfR+RhH9rnRIVJeRIhYWr54NeCj4Rem5krprerNcuayjsG+wMZlk7VI0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000356"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000356"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769547887"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769547887"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:39 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/14] wifi: iwlwifi: mvm: make internal callback structs const
Date:   Wed, 24 May 2023 20:42:00 +0300
Message-Id: <20230524203151.c41eb6687868.I2dac1158e5723187bda1973aa49fde8a794621c8@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524174211.1482360-1-gregory.greenman@intel.com>
References: <20230524174211.1482360-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no need for these to be writable, so they can
be const (and static).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 28 +++++++++----------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  6 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0f01b62357c6..5e28a53dad26 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3054,7 +3054,7 @@ static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_bss_conf *bss_conf,
 				     u64 changes)
 {
-	struct iwl_mvm_bss_info_changed_ops callbacks = {
+	static const struct iwl_mvm_bss_info_changed_ops callbacks = {
 		.bss_info_changed_sta = iwl_mvm_bss_info_changed_station,
 		.bss_info_changed_ap_ibss = iwl_mvm_bss_info_changed_ap_ibss,
 	};
@@ -3067,7 +3067,7 @@ void
 iwl_mvm_bss_info_changed_common(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *bss_conf,
-				struct iwl_mvm_bss_info_changed_ops *callbacks,
+				const struct iwl_mvm_bss_info_changed_ops *callbacks,
 				u64 changes)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
@@ -3564,7 +3564,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 				 enum ieee80211_sta_state old_state,
 				 enum ieee80211_sta_state new_state)
 {
-	struct iwl_mvm_sta_state_ops callbacks = {
+	static const struct iwl_mvm_sta_state_ops callbacks = {
 		.add_sta = iwl_mvm_add_sta,
 		.update_sta = iwl_mvm_update_sta,
 		.rm_sta = iwl_mvm_rm_sta,
@@ -3672,7 +3672,7 @@ static int
 iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
-				   struct iwl_mvm_sta_state_ops *callbacks)
+				   const struct iwl_mvm_sta_state_ops *callbacks)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	unsigned int i;
@@ -3721,7 +3721,7 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 				struct iwl_mvm *mvm,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
-				struct iwl_mvm_sta_state_ops *callbacks)
+				const struct iwl_mvm_sta_state_ops *callbacks)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
@@ -3778,7 +3778,7 @@ static int
 iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
-				      struct iwl_mvm_sta_state_ops *callbacks)
+				      const struct iwl_mvm_sta_state_ops *callbacks)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
@@ -3813,7 +3813,7 @@ static int
 iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
-				      struct iwl_mvm_sta_state_ops *callbacks)
+				      const struct iwl_mvm_sta_state_ops *callbacks)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
@@ -3851,7 +3851,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 				 struct ieee80211_sta *sta,
 				 enum ieee80211_sta_state old_state,
 				 enum ieee80211_sta_state new_state,
-				 struct iwl_mvm_sta_state_ops *callbacks)
+				 const struct iwl_mvm_sta_state_ops *callbacks)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -4578,7 +4578,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 		       int duration,
 		       enum ieee80211_roc_type type)
 {
-	struct iwl_mvm_roc_ops ops = {
+	static const struct iwl_mvm_roc_ops ops = {
 		.add_aux_sta_for_hs20 = iwl_mvm_add_aux_sta_for_hs20,
 		.switch_phy_ctxt = iwl_mvm_roc_switch_binding,
 	};
@@ -4590,7 +4590,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_channel *channel, int duration,
 		       enum ieee80211_roc_type type,
-		       struct iwl_mvm_roc_ops *ops)
+		       const struct iwl_mvm_roc_ops *ops)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -5097,7 +5097,7 @@ static void iwl_mvm_unassign_vif_chanctx(struct ieee80211_hw *hw,
 static int
 iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 				struct ieee80211_vif_chanctx_switch *vifs,
-				struct iwl_mvm_switch_vif_chanctx_ops *ops)
+				const struct iwl_mvm_switch_vif_chanctx_ops *ops)
 {
 	int ret;
 
@@ -5156,7 +5156,7 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 static int
 iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 				    struct ieee80211_vif_chanctx_switch *vifs,
-				    struct iwl_mvm_switch_vif_chanctx_ops *ops)
+				    const struct iwl_mvm_switch_vif_chanctx_ops *ops)
 {
 	int ret;
 
@@ -5199,7 +5199,7 @@ iwl_mvm_switch_vif_chanctx_common(struct ieee80211_hw *hw,
 				  struct ieee80211_vif_chanctx_switch *vifs,
 				  int n_vifs,
 				  enum ieee80211_chanctx_switch_mode mode,
-				  struct iwl_mvm_switch_vif_chanctx_ops *ops)
+				  const struct iwl_mvm_switch_vif_chanctx_ops *ops)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
@@ -5228,7 +5228,7 @@ static int iwl_mvm_switch_vif_chanctx(struct ieee80211_hw *hw,
 				      int n_vifs,
 				      enum ieee80211_chanctx_switch_mode mode)
 {
-	struct iwl_mvm_switch_vif_chanctx_ops ops = {
+	static const struct iwl_mvm_switch_vif_chanctx_ops ops = {
 		.__assign_vif_chanctx = __iwl_mvm_assign_vif_chanctx,
 		.__unassign_vif_chanctx = __iwl_mvm_unassign_vif_chanctx,
 	};
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index fbc2d5ed1006..9dfb07db396e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -492,7 +492,7 @@ static int iwl_mvm_mld_mac_sta_state(struct ieee80211_hw *hw,
 				     enum ieee80211_sta_state old_state,
 				     enum ieee80211_sta_state new_state)
 {
-	struct iwl_mvm_sta_state_ops callbacks = {
+	static const struct iwl_mvm_sta_state_ops callbacks = {
 		.add_sta = iwl_mvm_mld_add_sta,
 		.update_sta = iwl_mvm_mld_update_sta,
 		.rm_sta = iwl_mvm_mld_rm_sta,
@@ -779,7 +779,7 @@ iwl_mvm_mld_switch_vif_chanctx(struct ieee80211_hw *hw,
 			       int n_vifs,
 			       enum ieee80211_chanctx_switch_mode mode)
 {
-	struct iwl_mvm_switch_vif_chanctx_ops ops = {
+	static const struct iwl_mvm_switch_vif_chanctx_ops ops = {
 		.__assign_vif_chanctx = __iwl_mvm_mld_assign_vif_chanctx,
 		.__unassign_vif_chanctx = __iwl_mvm_mld_unassign_vif_chanctx,
 	};
@@ -871,7 +871,7 @@ static int iwl_mvm_mld_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct ieee80211_channel *channel, int duration,
 			   enum ieee80211_roc_type type)
 {
-	struct iwl_mvm_roc_ops ops = {
+	static const struct iwl_mvm_roc_ops ops = {
 		.add_aux_sta_for_hs20 = iwl_mvm_mld_add_aux_sta,
 		.switch_phy_ctxt = iwl_mvm_link_switch_phy_ctx,
 	};
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b9975af671db..0f278a73a997 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1888,7 +1888,7 @@ void
 iwl_mvm_bss_info_changed_common(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *bss_conf,
-				struct iwl_mvm_bss_info_changed_ops *callbacks,
+				const struct iwl_mvm_bss_info_changed_ops *callbacks,
 				u64 changes);
 void
 iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
@@ -1922,7 +1922,7 @@ struct iwl_mvm_roc_ops {
 int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_channel *channel, int duration,
 		       enum ieee80211_roc_type type,
-		       struct iwl_mvm_roc_ops *ops);
+		       const struct iwl_mvm_roc_ops *ops);
 int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif);
 /*Session Protection */
@@ -2420,7 +2420,7 @@ iwl_mvm_switch_vif_chanctx_common(struct ieee80211_hw *hw,
 				  struct ieee80211_vif_chanctx_switch *vifs,
 				  int n_vifs,
 				  enum ieee80211_chanctx_switch_mode mode,
-				  struct iwl_mvm_switch_vif_chanctx_ops *ops);
+				  const struct iwl_mvm_switch_vif_chanctx_ops *ops);
 
 /* Channel info utils */
 static inline bool iwl_mvm_has_ultra_hb_channel(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index a61d4f88125f..f5f8d41f5134 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -616,7 +616,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 				 struct ieee80211_sta *sta,
 				 enum ieee80211_sta_state old_state,
 				 enum ieee80211_sta_state new_state,
-				 struct iwl_mvm_sta_state_ops *callbacks);
+				 const struct iwl_mvm_sta_state_ops *callbacks);
 
 /* New MLD STA related APIs */
 /* STA */
-- 
2.38.1

