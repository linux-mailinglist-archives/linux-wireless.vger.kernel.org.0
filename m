Return-Path: <linux-wireless+bounces-13595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B396992AF4
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E390D1F23423
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C66D1D26EA;
	Mon,  7 Oct 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zr4qxudS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0161D1E87
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302490; cv=none; b=FXolH/FDGyXabj7C4+MBfWEn7D1uPKlZ7Ln6YsjkBwMadVf3f1o5TbSPT/ppooPt4a+WMbHtUS9nwgBHlk99Lt6E5Jxp5jY+w19JRknAu6Uf09t4x3oMh/XNQ1U35smlwiThjf3H42CVpQVPxR3Wfq1TYf97ZaQWc3JDi6rFrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302490; c=relaxed/simple;
	bh=hXOfNg3b5qu5INGEIwpHAbZ+rpzMw2+4+p1azlbxzdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cv4hlIBZMMAJ/175mwv46coyA8P58/Q4p8hgh/VFZqsddwTkoJZmZKLn0XaFMPOr2awVbrvijlsrvBV4FMjsU5ln7X4yakV8XbxBq2/nYBkBOqElwLGNQSyzJj3lx9lcEoKDOa/5DaUcg1HyFArUQ3xRQ1O18MjIbFterCY0OP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zr4qxudS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302488; x=1759838488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hXOfNg3b5qu5INGEIwpHAbZ+rpzMw2+4+p1azlbxzdM=;
  b=Zr4qxudS2RrPa2uJdX1XL82q3cRmNtP7V8jqHEO9cbvMULSnqInBnPCg
   81Y7EZMnv3V9sBUqA4D/IPxXKg2+rSczCJVnKkLp1KwWux7T6BJz67Tq1
   HSThgSOi3r1m75Nhp/5SOq0udFRYWJcDnk85ukyytEM+B/kP4DRAV3a9i
   gjaXgKBl9UwuVQgxglickPn7nMypvdwQ+j7uWp/HH491TVZ9we0IjO3Pj
   HTwvdksqU0U3IxV6vE56F3762p6r6Fg9iQNoNxYAKq8mv9V4U0ykJYGbi
   v16Pu66ze2aRhfCDWIeS9nMiwH9sxm8anJ2zVF0XN4vbtlzIJtExQGzz+
   Q==;
X-CSE-ConnectionGUID: ipg190H3R/yQXE1v2C5zWw==
X-CSE-MsgGUID: gc2s1zh+RGmC2UwWCnDoQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099419"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099419"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:28 -0700
X-CSE-ConnectionGUID: ZUWg9y7jS2uarJ0k7GTbvw==
X-CSE-MsgGUID: UCuaM63gRSad8wiPMfAq/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019275"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/14] wifi: mac80211: call rate_control_rate_update() for link STA
Date: Mon,  7 Oct 2024 15:00:54 +0300
Message-Id: <20241007144851.5851b6b5fd41.Ibdf50d96afa4b761dd9b9dfd54a1147e77a75329@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In order to update the right link information, call the update
rate_control_rate_update() with the right link_sta, and then
pass that through to the driver's sta_rc_update() method. The
software rate control still doesn't support it, but that'll be
skipped by not having a rate control ref.

Since it now operates on a link sta, rename the driver method.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/ath/ath10k/mac.c             |  5 +++--
 drivers/net/wireless/ath/ath11k/mac.c             |  5 +++--
 drivers/net/wireless/ath/ath12k/mac.c             |  5 +++--
 drivers/net/wireless/ath/ath9k/htc_drv_main.c     |  6 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  5 +++--
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c  |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c  |  5 +++--
 drivers/net/wireless/realtek/rtw88/mac80211.c     |  6 ++++--
 drivers/net/wireless/realtek/rtw89/mac80211.c     |  6 ++++--
 drivers/net/wireless/ti/wlcore/main.c             |  5 +++--
 drivers/net/wireless/virtual/mac80211_hwsim.c     |  8 ++++----
 include/net/mac80211.h                            | 12 ++++++------
 net/mac80211/chan.c                               |  2 +-
 net/mac80211/driver-ops.c                         | 15 ++++++++-------
 net/mac80211/driver-ops.h                         |  6 +++---
 net/mac80211/ibss.c                               |  3 ++-
 net/mac80211/mesh_plink.c                         |  3 ++-
 net/mac80211/rate.c                               |  8 ++++----
 net/mac80211/rate.h                               |  3 +--
 net/mac80211/rx.c                                 |  4 ++--
 net/mac80211/tdls.c                               |  3 ++-
 net/mac80211/trace.h                              | 15 +++++++++------
 net/mac80211/vht.c                                |  3 +--
 25 files changed, 80 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 646e1737d4c4..41ab83c3d3f7 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8507,9 +8507,10 @@ static int ath10k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 
 static void ath10k_sta_rc_update(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 struct ieee80211_sta *sta,
+				 struct ieee80211_link_sta *link_sta,
 				 u32 changed)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct ath10k *ar = hw->priv;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k_vif *arvif = (void *)vif->drv_priv;
@@ -9450,7 +9451,7 @@ static const struct ieee80211_ops ath10k_ops = {
 	.reconfig_complete		= ath10k_reconfig_complete,
 	.get_survey			= ath10k_get_survey,
 	.set_bitrate_mask		= ath10k_mac_op_set_bitrate_mask,
-	.sta_rc_update			= ath10k_sta_rc_update,
+	.link_sta_rc_update		= ath10k_sta_rc_update,
 	.offset_tsf			= ath10k_offset_tsf,
 	.ampdu_action			= ath10k_ampdu_action,
 	.get_et_sset_count		= ath10k_debug_get_et_sset_count,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f8068d2e848c..e6acbff06749 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5079,9 +5079,10 @@ static void ath11k_mac_op_sta_set_4addr(struct ieee80211_hw *hw,
 
 static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 					struct ieee80211_vif *vif,
-					struct ieee80211_sta *sta,
+					struct ieee80211_link_sta *link_sta,
 					u32 changed)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct ath11k *ar = hw->priv;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
@@ -9708,7 +9709,7 @@ static const struct ieee80211_ops ath11k_ops = {
 	.sta_state                      = ath11k_mac_op_sta_state,
 	.sta_set_4addr                  = ath11k_mac_op_sta_set_4addr,
 	.sta_set_txpwr			= ath11k_mac_op_sta_set_txpwr,
-	.sta_rc_update			= ath11k_mac_op_sta_rc_update,
+	.link_sta_rc_update		= ath11k_mac_op_sta_rc_update,
 	.conf_tx                        = ath11k_mac_op_conf_tx,
 	.set_antenna			= ath11k_mac_op_set_antenna,
 	.get_antenna			= ath11k_mac_op_get_antenna,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 137394c36460..acf5628adda5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4737,9 +4737,10 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 
 static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 					struct ieee80211_vif *vif,
-					struct ieee80211_sta *sta,
+					struct ieee80211_link_sta *link_sta,
 					u32 changed)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct ath12k *ar;
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
@@ -8681,7 +8682,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.set_rekey_data	                = ath12k_mac_op_set_rekey_data,
 	.sta_state                      = ath12k_mac_op_sta_state,
 	.sta_set_txpwr			= ath12k_mac_op_sta_set_txpwr,
-	.sta_rc_update			= ath12k_mac_op_sta_rc_update,
+	.link_sta_rc_update		= ath12k_mac_op_sta_rc_update,
 	.conf_tx                        = ath12k_mac_op_conf_tx,
 	.set_antenna			= ath12k_mac_op_set_antenna,
 	.get_antenna			= ath12k_mac_op_get_antenna,
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 8a03bcc2789e..57094bd45d98 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1357,8 +1357,10 @@ static int ath9k_htc_sta_remove(struct ieee80211_hw *hw,
 
 static void ath9k_htc_sta_rc_update(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
-				    struct ieee80211_sta *sta, u32 changed)
+				    struct ieee80211_link_sta *link_sta,
+				    u32 changed)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct ath9k_htc_sta *ista = (struct ath9k_htc_sta *) sta->drv_priv;
 
 	if (!(changed & IEEE80211_RC_SUPP_RATES_CHANGED))
@@ -1883,7 +1885,7 @@ struct ieee80211_ops ath9k_htc_ops = {
 	.sta_add            = ath9k_htc_sta_add,
 	.sta_remove         = ath9k_htc_sta_remove,
 	.conf_tx            = ath9k_htc_conf_tx,
-	.sta_rc_update      = ath9k_htc_sta_rc_update,
+	.link_sta_rc_update = ath9k_htc_sta_rc_update,
 	.bss_info_changed   = ath9k_htc_bss_info_changed,
 	.set_key            = ath9k_htc_set_key,
 	.get_tsf            = ath9k_htc_get_tsf,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 11cd1a8fdd9e..3721d6349cc5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4236,8 +4236,9 @@ int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 }
 
 void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta, u32 changed)
+			   struct ieee80211_link_sta *link_sta, u32 changed)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
 	if (changed & (IEEE80211_RC_BW_CHANGED |
@@ -6562,7 +6563,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.allow_buffered_frames = iwl_mvm_mac_allow_buffered_frames,
 	.release_buffered_frames = iwl_mvm_mac_release_buffered_frames,
 	.set_rts_threshold = iwl_mvm_mac_set_rts_threshold,
-	.sta_rc_update = iwl_mvm_sta_rc_update,
+	.link_sta_rc_update = iwl_mvm_sta_rc_update,
 	.conf_tx = iwl_mvm_mac_conf_tx,
 	.mgd_prepare_tx = iwl_mvm_mac_mgd_prepare_tx,
 	.mgd_complete_tx = iwl_mvm_mac_mgd_complete_tx,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index f2378e0fb2fb..7de6c96646ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1401,7 +1401,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.allow_buffered_frames = iwl_mvm_mac_allow_buffered_frames,
 	.release_buffered_frames = iwl_mvm_mac_release_buffered_frames,
 	.set_rts_threshold = iwl_mvm_mac_set_rts_threshold,
-	.sta_rc_update = iwl_mvm_sta_rc_update,
+	.link_sta_rc_update = iwl_mvm_sta_rc_update,
 	.conf_tx = iwl_mvm_mld_mac_conf_tx,
 	.mgd_prepare_tx = iwl_mvm_mac_mgd_prepare_tx,
 	.mgd_complete_tx = iwl_mvm_mac_mgd_complete_tx,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ef07cff203b0..6246ffce7cf8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2914,7 +2914,7 @@ iwl_mvm_mac_release_buffered_frames(struct ieee80211_hw *hw,
 				    bool more_data);
 int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
 void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta, u32 changed);
+			   struct ieee80211_link_sta *link_sta, u32 changed);
 void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_prep_tx_info *info);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index d75e8dea1fbd..c6f498fc81ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1163,9 +1163,10 @@ static void mt7915_sta_rc_work(void *data, struct ieee80211_sta *sta)
 
 static void mt7915_sta_rc_update(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 struct ieee80211_sta *sta,
+				 struct ieee80211_link_sta *link_sta,
 				 u32 changed)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_dev *dev = phy->dev;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
@@ -1709,7 +1710,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.stop_ap = mt7915_stop_ap,
 	.sta_state = mt76_sta_state,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
-	.sta_rc_update = mt7915_sta_rc_update,
+	.link_sta_rc_update = mt7915_sta_rc_update,
 	.set_key = mt7915_set_key,
 	.ampdu_action = mt7915_ampdu_action,
 	.set_rts_threshold = mt7915_set_rts_threshold,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 39f071ece35e..2b34ae5e0cb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1060,9 +1060,10 @@ static void mt7996_sta_rc_work(void *data, struct ieee80211_sta *sta)
 
 static void mt7996_sta_rc_update(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 struct ieee80211_sta *sta,
+				 struct ieee80211_link_sta *link_sta,
 				 u32 changed)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_dev *dev = phy->dev;
 
@@ -1472,7 +1473,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.sta_add = mt7996_sta_add,
 	.sta_remove = mt7996_sta_remove,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
-	.sta_rc_update = mt7996_sta_rc_update,
+	.link_sta_rc_update = mt7996_sta_rc_update,
 	.set_key = mt7996_set_key,
 	.ampdu_action = mt7996_ampdu_action,
 	.set_rts_threshold = mt7996_set_rts_threshold,
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index b39e90fb66b4..026fbf4ad9cc 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -928,8 +928,10 @@ static int rtw_ops_set_sar_specs(struct ieee80211_hw *hw,
 
 static void rtw_ops_sta_rc_update(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
-				  struct ieee80211_sta *sta, u32 changed)
+				  struct ieee80211_link_sta *link_sta,
+				  u32 changed)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 
@@ -973,7 +975,7 @@ const struct ieee80211_ops rtw_ops = {
 	.reconfig_complete	= rtw_reconfig_complete,
 	.hw_scan		= rtw_ops_hw_scan,
 	.cancel_hw_scan		= rtw_ops_cancel_hw_scan,
-	.sta_rc_update		= rtw_ops_sta_rc_update,
+	.link_sta_rc_update	= rtw_ops_sta_rc_update,
 	.set_sar_specs          = rtw_ops_set_sar_specs,
 #ifdef CONFIG_PM
 	.suspend		= rtw_ops_suspend,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 48ad0d0f76bf..82c9c29dbdb4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -923,8 +923,10 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 
 static void rtw89_ops_sta_rc_update(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
-				    struct ieee80211_sta *sta, u32 changed)
+				    struct ieee80211_link_sta *link_sta,
+				    u32 changed)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	rtw89_phy_ra_update_sta(rtwdev, sta, changed);
@@ -1203,7 +1205,7 @@ const struct ieee80211_ops rtw89_ops = {
 	.remain_on_channel		= rtw89_ops_remain_on_channel,
 	.cancel_remain_on_channel	= rtw89_ops_cancel_remain_on_channel,
 	.set_sar_specs		= rtw89_ops_set_sar_specs,
-	.sta_rc_update		= rtw89_ops_sta_rc_update,
+	.link_sta_rc_update	= rtw89_ops_sta_rc_update,
 	.set_tid_config		= rtw89_ops_set_tid_config,
 #ifdef CONFIG_PM
 	.suspend		= rtw89_ops_suspend,
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 0c77b8524160..986b07bfa0ee 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -5789,9 +5789,10 @@ static int wlcore_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
 
 static void wlcore_op_sta_rc_update(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
-				    struct ieee80211_sta *sta,
+				    struct ieee80211_link_sta *link_sta,
 				    u32 changed)
 {
+	struct ieee80211_sta *sta = link_sta->sta;
 	struct wl12xx_vif *wlvif = wl12xx_vif_to_data(vif);
 
 	wl1271_debug(DEBUG_MAC80211, "mac80211 sta_rc_update");
@@ -6052,7 +6053,7 @@ static const struct ieee80211_ops wl1271_ops = {
 	.assign_vif_chanctx = wlcore_op_assign_vif_chanctx,
 	.unassign_vif_chanctx = wlcore_op_unassign_vif_chanctx,
 	.switch_vif_chanctx = wlcore_op_switch_vif_chanctx,
-	.sta_rc_update = wlcore_op_sta_rc_update,
+	.link_sta_rc_update = wlcore_op_sta_rc_update,
 	.sta_statistics = wlcore_op_sta_statistics,
 	.get_expected_throughput = wlcore_op_get_expected_throughput,
 	CFG80211_TESTMODE_CMD(wl1271_tm_cmd)
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index f0e528abb1b4..fe3e2dc1626b 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2594,10 +2594,11 @@ static void mac80211_hwsim_link_info_changed(struct ieee80211_hw *hw,
 static void
 mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta,
+			     struct ieee80211_link_sta *link_sta,
 			     u32 changed)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
+	struct ieee80211_sta *sta = link_sta->sta;
 	u32 bw = U32_MAX;
 	int link_id;
 
@@ -2607,7 +2608,6 @@ mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
 	     link_id++) {
 		enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
 		struct ieee80211_bss_conf *vif_conf;
-		struct ieee80211_link_sta *link_sta;
 
 		link_sta = rcu_dereference(sta->link[link_id]);
 
@@ -2659,7 +2659,7 @@ static int mac80211_hwsim_sta_add(struct ieee80211_hw *hw,
 
 	hwsim_check_magic(vif);
 	hwsim_set_sta_magic(sta);
-	mac80211_hwsim_sta_rc_update(hw, vif, sta, 0);
+	mac80211_hwsim_sta_rc_update(hw, vif, &sta->deflink, 0);
 
 	if (sta->valid_links) {
 		WARN(hweight16(sta->valid_links) > 1,
@@ -3961,7 +3961,7 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 	.link_info_changed = mac80211_hwsim_link_info_changed,  \
 	.tx_last_beacon = mac80211_hwsim_tx_last_beacon,	\
 	.sta_notify = mac80211_hwsim_sta_notify,		\
-	.sta_rc_update = mac80211_hwsim_sta_rc_update,		\
+	.link_sta_rc_update = mac80211_hwsim_sta_rc_update,	\
 	.conf_tx = mac80211_hwsim_conf_tx,			\
 	.get_survey = mac80211_hwsim_get_survey,		\
 	CFG80211_TESTMODE_CMD(mac80211_hwsim_testmode_cmd)	\
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9ed6907a1e3c..af70ad504cf2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4090,8 +4090,8 @@ struct ieee80211_prep_tx_info {
  *	in @sta_state.
  *	The callback can sleep.
  *
- * @sta_rc_update: Notifies the driver of changes to the bitrates that can be
- *	used to transmit to the station. The changes are advertised with bits
+ * @link_sta_rc_update: Notifies the driver of changes to the bitrates that can
+ *	be used to transmit to the station. The changes are advertised with bits
  *	from &enum ieee80211_rate_control_changed and the values are reflected
  *	in the station data. This callback should only be used when the driver
  *	uses hardware rate control (%IEEE80211_HW_HAS_RATE_CONTROL) since
@@ -4581,10 +4581,10 @@ struct ieee80211_ops {
 	void (*sta_pre_rcu_remove)(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta);
-	void (*sta_rc_update)(struct ieee80211_hw *hw,
-			      struct ieee80211_vif *vif,
-			      struct ieee80211_sta *sta,
-			      u32 changed);
+	void (*link_sta_rc_update)(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_link_sta *link_sta,
+				   u32 changed);
 	void (*sta_rate_tbl_update)(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta);
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 97c8480f0f2c..e01302ea9157 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -467,7 +467,7 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 				continue;
 
 			link_sta->pub->bandwidth = new_sta_bw;
-			rate_control_rate_update(local, sband, sta, link_id,
+			rate_control_rate_update(local, sband, link_sta,
 						 IEEE80211_RC_BW_CHANGED);
 		}
 	}
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index fe868b521622..84d048339113 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -181,9 +181,10 @@ int drv_sta_set_txpwr(struct ieee80211_local *local,
 	return ret;
 }
 
-void drv_sta_rc_update(struct ieee80211_local *local,
-		       struct ieee80211_sub_if_data *sdata,
-		       struct ieee80211_sta *sta, u32 changed)
+void drv_link_sta_rc_update(struct ieee80211_local *local,
+			    struct ieee80211_sub_if_data *sdata,
+			    struct ieee80211_link_sta *link_sta,
+			    u32 changed)
 {
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -193,10 +194,10 @@ void drv_sta_rc_update(struct ieee80211_local *local,
 		(sdata->vif.type != NL80211_IFTYPE_ADHOC &&
 		 sdata->vif.type != NL80211_IFTYPE_MESH_POINT));
 
-	trace_drv_sta_rc_update(local, sdata, sta, changed);
-	if (local->ops->sta_rc_update)
-		local->ops->sta_rc_update(&local->hw, &sdata->vif,
-					  sta, changed);
+	trace_drv_link_sta_rc_update(local, sdata, link_sta, changed);
+	if (local->ops->link_sta_rc_update)
+		local->ops->link_sta_rc_update(&local->hw, &sdata->vif,
+					       link_sta, changed);
 
 	trace_drv_return_void(local);
 }
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 48bc2da728c0..edd1e4d4ad9d 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -594,9 +594,9 @@ int drv_sta_set_txpwr(struct ieee80211_local *local,
 		      struct ieee80211_sub_if_data *sdata,
 		      struct sta_info *sta);
 
-void drv_sta_rc_update(struct ieee80211_local *local,
-		       struct ieee80211_sub_if_data *sdata,
-		       struct ieee80211_sta *sta, u32 changed);
+void drv_link_sta_rc_update(struct ieee80211_local *local,
+			    struct ieee80211_sub_if_data *sdata,
+			    struct ieee80211_link_sta *link_sta, u32 changed);
 
 static inline void drv_sta_rate_tbl_update(struct ieee80211_local *local,
 					   struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 08fac295ad5b..a1b4178deccf 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1072,7 +1072,8 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 		if (sta->sta.deflink.rx_nss != rx_nss)
 			changed |= IEEE80211_RC_NSS_CHANGED;
 
-		drv_sta_rc_update(local, sdata, &sta->sta, changed);
+		drv_link_sta_rc_update(local, sdata, &sta->sta.deflink,
+				       changed);
 	}
 
 	rcu_read_unlock();
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 5c32b92aa63f..d75cabf8fa26 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -486,10 +486,11 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 		sta->sta.deflink.bandwidth = IEEE80211_STA_RX_BW_20;
 	}
 
+	/* FIXME: this check is wrong without SW rate control */
 	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
 		rate_control_rate_init(&sta->deflink);
 	else
-		rate_control_rate_update(local, sband, sta, 0, changed);
+		rate_control_rate_update(local, sband, &sta->deflink, changed);
 out:
 	spin_unlock_bh(&sta->mesh->plink_lock);
 }
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 23b4f1af37e0..63fe58311a77 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -113,16 +113,15 @@ void rate_control_tx_status(struct ieee80211_local *local,
 
 void rate_control_rate_update(struct ieee80211_local *local,
 			      struct ieee80211_supported_band *sband,
-			      struct sta_info *sta, unsigned int link_id,
+			      struct link_sta_info *link_sta,
 			      u32 changed)
 {
 	struct rate_control_ref *ref = local->rate_ctrl;
+	struct sta_info *sta = link_sta->sta;
 	struct ieee80211_sta *ista = &sta->sta;
 	void *priv_sta = sta->rate_ctrl_priv;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
-	WARN_ON(link_id != 0);
-
 	if (ref && ref->ops->rate_update) {
 		rcu_read_lock();
 
@@ -140,7 +139,8 @@ void rate_control_rate_update(struct ieee80211_local *local,
 	}
 
 	if (sta->uploaded)
-		drv_sta_rc_update(local, sta->sdata, &sta->sta, changed);
+		drv_link_sta_rc_update(local, sta->sdata, link_sta->pub,
+				       changed);
 }
 
 int ieee80211_rate_control_register(const struct rate_control_ops *ops)
diff --git a/net/mac80211/rate.h b/net/mac80211/rate.h
index 8d3c8903b4ae..673aa9efe30b 100644
--- a/net/mac80211/rate.h
+++ b/net/mac80211/rate.h
@@ -33,8 +33,7 @@ void rate_control_rate_init(struct link_sta_info *link_sta);
 void rate_control_rate_init_all_links(struct sta_info *sta);
 void rate_control_rate_update(struct ieee80211_local *local,
 			      struct ieee80211_supported_band *sband,
-			      struct sta_info *sta,
-			      unsigned int link_id,
+			      struct link_sta_info *link_sta,
 			      u32 changed);
 
 static inline void *rate_control_alloc_sta(struct rate_control_ref *ref,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 59ad24a71141..21a93cc1e0ed 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3568,7 +3568,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 
 			sband = rx->local->hw.wiphy->bands[status->band];
 
-			rate_control_rate_update(local, sband, rx->sta, 0,
+			rate_control_rate_update(local, sband, rx->link_sta,
 						 IEEE80211_RC_SMPS_CHANGED);
 			cfg80211_sta_opmode_change_notify(sdata->dev,
 							  rx->sta->addr,
@@ -3605,7 +3605,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 				ieee80211_sta_rx_bw_to_chan_width(rx->link_sta);
 			sta_opmode.changed = STA_OPMODE_MAX_BW_CHANGED;
 
-			rate_control_rate_update(local, sband, rx->sta, 0,
+			rate_control_rate_update(local, sband, rx->link_sta,
 						 IEEE80211_RC_BW_CHANGED);
 			cfg80211_sta_opmode_change_notify(sdata->dev,
 							  rx->sta->addr,
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index f07b40916485..2f92e7c7f203 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1342,7 +1342,8 @@ static void iee80211_tdls_recalc_chanctx(struct ieee80211_sub_if_data *sdata,
 			bw = min(bw, ieee80211_sta_cap_rx_bw(&sta->deflink));
 			if (bw != sta->sta.deflink.bandwidth) {
 				sta->sta.deflink.bandwidth = bw;
-				rate_control_rate_update(local, sband, sta, 0,
+				rate_control_rate_update(local, sband,
+							 &sta->deflink,
 							 IEEE80211_RC_BW_CHANGED);
 				/*
 				 * if a TDLS peer BW was updated, we need to
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index e6f0ce8e5d43..7a4985fc2b16 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -939,31 +939,34 @@ TRACE_EVENT(drv_sta_set_txpwr,
 	)
 );
 
-TRACE_EVENT(drv_sta_rc_update,
+TRACE_EVENT(drv_link_sta_rc_update,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 struct ieee80211_sta *sta,
+		 struct ieee80211_link_sta *link_sta,
 		 u32 changed),
 
-	TP_ARGS(local, sdata, sta, changed),
+	TP_ARGS(local, sdata, link_sta, changed),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
 		VIF_ENTRY
 		STA_ENTRY
 		__field(u32, changed)
+		__field(u32, link_id)
 	),
 
 	TP_fast_assign(
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
-		STA_ASSIGN;
+		STA_NAMED_ASSIGN(link_sta->sta);
 		__entry->changed = changed;
+		__entry->link_id = link_sta->link_id;
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " changed: 0x%x",
-		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->changed
+		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " (link %d) changed: 0x%x",
+		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->link_id,
+		__entry->changed
 	)
 );
 
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index bf6ef45af757..7c878fb69f9a 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -766,8 +766,7 @@ void ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 
 	if (changed > 0) {
 		ieee80211_recalc_min_chandef(sdata, link_sta->link_id);
-		rate_control_rate_update(local, sband, link_sta->sta,
-					 link_sta->link_id, changed);
+		rate_control_rate_update(local, sband, link_sta, changed);
 	}
 }
 
-- 
2.34.1


