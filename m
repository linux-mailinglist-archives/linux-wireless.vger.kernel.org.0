Return-Path: <linux-wireless+bounces-22782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B05AB1109
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41234172329
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA51628FFFC;
	Fri,  9 May 2025 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amBuCPE5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596928FFF1
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787527; cv=none; b=ZxLFKGoN8/LmaVc4KhkB1f+3HT7vbu/Uh/M8FBa3zxJjtrkTgp7t4yML8BHtfDLKXbHKgrXHwb4j+xUuuCfiM02AS0mqmMgIkMvlIFsfXZ19S6Bdqbs2mrS66xgC2CgCsmcJ8qvv4miS8fy+E8eF2IWAndcG41smC5dlVvmOPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787527; c=relaxed/simple;
	bh=rW8E4O+5XrmPttnAA/dFvH3n6OB4N3ELP5QQFIp9aLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7wznAfI38RvIRbpd1+3rY56eR7b8KM+53K8ZYR0BPUm/qCEONdz5w4HyEKpoVsDurINrRTdpDYuR72NYW5gjDAZE7+YWxXtNifR+0mtnET9CXX+l80x92yx7asNmFdpPRC61WJpPfGt3em8etM45JYOmAtdw4Q0H3Ay37d4oDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amBuCPE5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787526; x=1778323526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rW8E4O+5XrmPttnAA/dFvH3n6OB4N3ELP5QQFIp9aLo=;
  b=amBuCPE5+zogv+mCKizNWK0Njb4oZtIqOhTPlwUtP4Mt8chWaRdQ2grt
   v1p/QoZp5GNk11V298g2yK3BPTr0AoNsxtiTr2gqPuFXdI4B8od7lWMCs
   7NEk0nnUq7Wz7ZfKuqUfJ1Qbkk6uQDyzP8gjLFQH2bkh54EQR9hDe1GVl
   iIw/OQZ9InTNSA7WbtvQLwRcwNYVownVbjPGnfmsKpK1iQAcd8iFB2xwC
   0F8yydyvKqSTdwE/0nK34Cvd1GLOhh4bbjxiqunBSK9vTae28Rjos7F6D
   chC0/+Nq1MFdAmbFV54ZLWZXo24abdLfX/TRTFs7y62ChJZt1HGr/zyiQ
   w==;
X-CSE-ConnectionGUID: jT+bMxTrS/SHnvIrM/2m0A==
X-CSE-MsgGUID: 6/H2+Sc1TGSUjbqTZ4Ev0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239907"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239907"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:25 -0700
X-CSE-ConnectionGUID: a0TWwMGUS3emxt9mx5QhHw==
X-CSE-MsgGUID: EU5QdXvHQSm86jhqduy0Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537055"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: add support for ROC on BSS
Date: Fri,  9 May 2025 13:44:52 +0300
Message-Id: <20250509104454.2582160-14-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
References: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

add support for remain on channel on BSS vif for iwlmld.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Message-Id: <20250509134302.0cac670cfbfe.I4318f40866181927da17e6cbfada59107cd3c458@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mld/roc.c  | 53 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 22 +++++++-
 5 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 15b437110351..49e2ce65557d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -141,8 +141,8 @@ struct iwl_mld_emlsr {
  * @use_ps_poll: use ps_poll frames
  * @disable_bf: disable beacon filter
  * @dbgfs_slink: debugfs symlink for this interface
- * @roc_activity: the id of the roc_activity running. Relevant for p2p device
- *	only. Set to %ROC_NUM_ACTIVITIES when not in use.
+ * @roc_activity: the id of the roc_activity running. Relevant for STA and
+ *	p2p device only. Set to %ROC_NUM_ACTIVITIES when not in use.
  * @aux_sta: station used for remain on channel. Used in P2P device.
  */
 struct iwl_mld_vif {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 1a2c44f44eff..74fcaad85a32 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -127,6 +127,7 @@
  *	cleanup using iwl_mld_free_internal_sta
  * @netdetect: indicates the FW is in suspend mode with netdetect configured
  * @p2p_device_vif: points to the p2p device vif if exists
+ * @bss_roc_vif: points to the BSS vif that has an active ROC.
  * @dev: pointer to device struct. For printing purposes
  * @trans: pointer to the transport layer
  * @cfg: pointer to the device configuration
@@ -212,6 +213,7 @@ struct iwl_mld {
 		bool netdetect;
 #endif /* CONFIG_PM_SLEEP */
 		struct ieee80211_vif *p2p_device_vif;
+		struct ieee80211_vif *bss_roc_vif;
 		struct iwl_bt_coex_profile_notif last_bt_notif;
 	);
 	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_STATION_COUNT_MAX];
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/roc.c b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
index cfd010c1ca80..944d70901de5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/roc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
@@ -49,29 +49,36 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	/* TODO: task=Hotspot 2.0 */
-	if (vif->type != NL80211_IFTYPE_P2P_DEVICE) {
+	if (vif->type != NL80211_IFTYPE_P2P_DEVICE &&
+	    vif->type != NL80211_IFTYPE_STATION) {
 		IWL_ERR(mld, "NOT SUPPORTED: ROC on vif->type %d\n",
 			vif->type);
 
 		return -EOPNOTSUPP;
 	}
 
-	switch (type) {
-	case IEEE80211_ROC_TYPE_NORMAL:
-		activity = ROC_ACTIVITY_P2P_DISC;
-		break;
-	case IEEE80211_ROC_TYPE_MGMT_TX:
-		activity = ROC_ACTIVITY_P2P_NEG;
-		break;
-	default:
-		WARN_ONCE(1, "Got an invalid P2P ROC type\n");
-		return -EINVAL;
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		switch (type) {
+		case IEEE80211_ROC_TYPE_NORMAL:
+			activity = ROC_ACTIVITY_P2P_DISC;
+			break;
+		case IEEE80211_ROC_TYPE_MGMT_TX:
+			activity = ROC_ACTIVITY_P2P_NEG;
+			break;
+		default:
+			WARN_ONCE(1, "Got an invalid P2P ROC type\n");
+			return -EINVAL;
+		}
+	} else {
+		activity = ROC_ACTIVITY_HOTSPOT;
 	}
 
 	if (WARN_ON(mld_vif->roc_activity != ROC_NUM_ACTIVITIES))
 		return -EBUSY;
 
+	if (vif->type == NL80211_IFTYPE_STATION && mld->bss_roc_vif)
+		return -EBUSY;
+
 	ieee80211_iterate_active_interfaces_mtx(mld->hw,
 						IEEE80211_IFACE_ITER_NORMAL,
 						iwl_mld_vif_iter_emlsr_block_roc,
@@ -88,9 +95,6 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	cmd.channel_info.channel = cpu_to_le32(channel->hw_value);
 	cmd.channel_info.band = iwl_mld_nl80211_band_to_fw(channel->band);
 	cmd.channel_info.width = IWL_PHY_CHANNEL_MODE20;
-	/* TODO: task=Hotspot 2.0, revisit those parameters when we add an ROC
-	 * on the BSS vif
-	 */
 	cmd.max_delay = cpu_to_le32(AUX_ROC_MAX_DELAY);
 	cmd.duration = cpu_to_le32(MSEC_TO_TU(duration));
 
@@ -102,8 +106,12 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		IWL_ERR(mld, "Couldn't send the ROC_CMD\n");
 		return ret;
 	}
+
 	mld_vif->roc_activity = activity;
 
+	if (vif->type == NL80211_IFTYPE_STATION)
+		mld->bss_roc_vif = vif;
+
 	return 0;
 }
 
@@ -122,6 +130,9 @@ static void iwl_mld_destroy_roc(struct iwl_mld *mld,
 {
 	mld_vif->roc_activity = ROC_NUM_ACTIVITIES;
 
+	if (vif->type == NL80211_IFTYPE_STATION)
+		mld->bss_roc_vif = NULL;
+
 	ieee80211_iterate_active_interfaces_mtx(mld->hw,
 						IEEE80211_IFACE_ITER_NORMAL,
 						iwl_mld_vif_iter_emlsr_unblock_roc,
@@ -153,8 +164,8 @@ int iwl_mld_cancel_roc(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	/* TODO: task=Hotspot 2.0 */
-	if (WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE))
+	if (WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE &&
+		    vif->type != NL80211_IFTYPE_STATION))
 		return -EOPNOTSUPP;
 
 	/* No roc activity running it's probably already done */
@@ -189,9 +200,13 @@ void iwl_mld_handle_roc_notif(struct iwl_mld *mld,
 {
 	const struct iwl_roc_notif *notif = (void *)pkt->data;
 	u32 activity = le32_to_cpu(notif->activity);
-	/* TODO: task=Hotspot 2.0 - roc can run on BSS */
-	struct ieee80211_vif *vif = mld->p2p_device_vif;
 	struct iwl_mld_vif *mld_vif;
+	struct ieee80211_vif *vif;
+
+	if (activity == ROC_ACTIVITY_HOTSPOT)
+		vif = mld->bss_roc_vif;
+	else
+		vif = mld->p2p_device_vif;
 
 	if (WARN_ON(!vif))
 		return;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index bc5313f44fde..8fb51209b4a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -1164,8 +1164,8 @@ void iwl_mld_remove_aux_sta(struct iwl_mld *mld,
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 
-	/* TODO: Hotspot 2.0 */
-	if (WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE))
+	if (WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE &&
+		    vif->type != NL80211_IFTYPE_STATION))
 		return;
 
 	iwl_mld_remove_internal_sta(mld, &mld_vif->aux_sta, false,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 96ea6320c084..4d4d3308a90d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -638,8 +638,11 @@ iwl_mld_get_tx_queue_id(struct iwl_mld *mld, struct ieee80211_txq *txq,
 	case NL80211_IFTYPE_P2P_DEVICE:
 		mld_vif = iwl_mld_vif_from_mac80211(info->control.vif);
 
-		if (mld_vif->roc_activity == ROC_NUM_ACTIVITIES) {
-			IWL_DEBUG_DROP(mld, "Drop tx outside ROC\n");
+		if (mld_vif->roc_activity != ROC_ACTIVITY_P2P_DISC &&
+		    mld_vif->roc_activity != ROC_ACTIVITY_P2P_NEG) {
+			IWL_DEBUG_DROP(mld,
+				       "Drop tx outside ROC with activity %d\n",
+				       mld_vif->roc_activity);
 			return IWL_MLD_INVALID_DROP_TX;
 		}
 
@@ -649,6 +652,21 @@ iwl_mld_get_tx_queue_id(struct iwl_mld *mld, struct ieee80211_txq *txq,
 	case NL80211_IFTYPE_MONITOR:
 		mld_vif = iwl_mld_vif_from_mac80211(info->control.vif);
 		return mld_vif->deflink.mon_sta.queue_id;
+	case NL80211_IFTYPE_STATION:
+		mld_vif = iwl_mld_vif_from_mac80211(info->control.vif);
+
+		if (!(info->flags & IEEE80211_TX_CTL_TX_OFFCHAN)) {
+			IWL_DEBUG_DROP(mld, "Drop tx not off-channel\n");
+			return IWL_MLD_INVALID_DROP_TX;
+		}
+
+		if (mld_vif->roc_activity != ROC_ACTIVITY_HOTSPOT) {
+			IWL_DEBUG_DROP(mld, "Drop tx outside ROC\n");
+			return IWL_MLD_INVALID_DROP_TX;
+		}
+
+		WARN_ON(!ieee80211_is_mgmt(fc));
+		return mld_vif->aux_sta.queue_id;
 	default:
 		WARN_ONCE(1, "Unsupported vif type\n");
 		break;
-- 
2.34.1


