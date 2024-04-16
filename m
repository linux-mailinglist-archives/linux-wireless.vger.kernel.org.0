Return-Path: <linux-wireless+bounces-6382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D665F8A6923
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AF5281DDB
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907F91292F8;
	Tue, 16 Apr 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Knc192N7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1171129A69
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264872; cv=none; b=Oa4DDmNZ3c3Kn8cPMeXqD1miYUbkST0nlSoS8jr+VF42g5NRy1sAVqW8DLvFUIEpEOww0w6Reci3z/5waJA5+vuUCwnIKNzmdt+Ety74S8//Zl1HzAhS56JLeNL7pgoNAZ04XErctLSigbWdtSwQUh/yYtzq6a4iXV+lrkqDZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264872; c=relaxed/simple;
	bh=irGTfjg2XZ5P7K2TruBXkh50lKZCs54RaFSQMOX34Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTWs1KthcDcsxRrxok3NIHH/3lBppC1FsGtQSSvm6qbkBQ8/7B8ay2DsSl2PNhEp/fEGnz+X+avlQlpzuHaIeN8pNDlIIFLpQHmsYFHgZLidt7P5ABHnujm2SrraXfHymF1O/gwObuJJCFBEpHJGaUvxcWej0rwF9+fZ0vO7jKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Knc192N7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264871; x=1744800871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=irGTfjg2XZ5P7K2TruBXkh50lKZCs54RaFSQMOX34Vc=;
  b=Knc192N7BKywzbufEVsraKspBviYjrXjepp6wlegphtOEsUf7B5PXMPo
   bV8jr2ygbWT+SDr3eG4aBXKnRS+EPYd1ek7YAGv+dnMsxQsAb8w6w6wk5
   ML5O7yMiJ0LEXJWdFyO93EfPlSNAFWG9E6IuKYjeB7eCYYK0iuDkfB3LD
   obJIr+qKmxzJeIQhF3kMlvoxhUmnPSM1tqa9fQM30XMC3qPFOOp32oqQn
   dz6A3lRbVT/DYDUU7wXF3P/6O3TD+VOV1EtBpBJsv/vd5zOX3/TeVV6Qd
   O3eI8eT0L43Ta9HwNtZVjdJiDyc2K8H3Atqop2b+TME02iUwqxrMHtwtt
   g==;
X-CSE-ConnectionGUID: GE31L6x6QTm5m8G2cf/h5Q==
X-CSE-MsgGUID: NlYZjv04SnS9zG5aTfxyQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556040"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556040"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:31 -0700
X-CSE-ConnectionGUID: gaTxBp9ZRnmchvt5th6f2A==
X-CSE-MsgGUID: dlU5WdlfQL2iFhaciuPKQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872461"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 05/16] wifi: iwlwifi: mvm: don't always disable EMLSR due to BT coex
Date: Tue, 16 Apr 2024 13:54:00 +0300
Message-Id: <20240416134215.2841006b5cc4.I45ffd583f593daa950322852ceb9454cbf497e24@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

2.4 GHz/LB (low band) link can't be used in an EMLSR links pair when
BT is on. But EMLSR is still allowed for a pair of links which none of
them operates in LB.
In the existing code, EMLSR will always be disabled if one of the
usable links is in LB (and BT is on).
Move this check to the code that verifies a specific pair of links,
and only if one of these links operates on LB - disable EMLSR.

Fixes: 10159a45666b ("wifi: iwlwifi: disable eSR when BT is active")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 89 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  9 +-
 2 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 25d98ea6db44..797c088ea0c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -652,10 +652,49 @@ struct iwl_mvm_link_sel_data {
 	bool active;
 };
 
-static bool iwl_mvm_mld_valid_link_pair(struct iwl_mvm_link_sel_data *a,
+static bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
+					struct iwl_mvm_link_sel_data *a,
 					struct iwl_mvm_link_sel_data *b)
 {
-	return a->band != b->band;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (a->band == b->band)
+		return false;
+
+	/* BT Coex effects eSR mode only if one of the link is on LB */
+	if (a->band == NL80211_BAND_2GHZ || b->band == NL80211_BAND_2GHZ)
+		return !(mvmvif->esr_disable_reason & IWL_MVM_ESR_DISABLE_COEX);
+
+	return true;
+}
+
+static u8
+iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
+				struct iwl_mvm_link_sel_data *data,
+				unsigned long usable_links)
+{
+	u8 n_data = 0;
+	unsigned long link_id;
+
+	rcu_read_lock();
+
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference(vif->link_conf[link_id]);
+
+		if (WARN_ON_ONCE(!link_conf))
+			continue;
+
+		data[n_data].link_id = link_id;
+		data[n_data].band = link_conf->chanreq.oper.chan->band;
+		data[n_data].width = link_conf->chanreq.oper.width;
+		data[n_data].active = vif->active_links & BIT(link_id);
+		n_data++;
+	}
+
+	rcu_read_unlock();
+
+	return n_data;
 }
 
 void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -665,7 +704,7 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	unsigned long usable_links = ieee80211_vif_usable_links(vif);
 	u32 max_active_links = iwl_mvm_max_active_links(mvm, vif);
 	u16 new_active_links;
-	u8 link_id, n_data = 0, i, j;
+	u8 n_data, i, j;
 
 	if (!IWL_MVM_AUTO_EML_ENABLE)
 		return;
@@ -690,23 +729,7 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (hweight16(vif->active_links) == max_active_links)
 		return;
 
-	rcu_read_lock();
-
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference(vif->link_conf[link_id]);
-
-		if (WARN_ON_ONCE(!link_conf))
-			continue;
-
-		data[n_data].link_id = link_id;
-		data[n_data].band = link_conf->chanreq.oper.chan->band;
-		data[n_data].width = link_conf->chanreq.oper.width;
-		data[n_data].active = vif->active_links & BIT(link_id);
-		n_data++;
-	}
-
-	rcu_read_unlock();
+	n_data = iwl_mvm_set_link_selection_data(vif, data, usable_links);
 
 	/* this is expected to be the current active link */
 	if (n_data == 1)
@@ -730,7 +753,8 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			if (i == j)
 				continue;
 
-			if (iwl_mvm_mld_valid_link_pair(&data[i], &data[j]))
+			if (iwl_mvm_mld_valid_link_pair(vif, &data[i],
+							&data[j]))
 				break;
 		}
 
@@ -746,7 +770,7 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				if (i == j)
 					continue;
 
-				if (iwl_mvm_mld_valid_link_pair(&data[i],
+				if (iwl_mvm_mld_valid_link_pair(vif, &data[i],
 								&data[j]))
 					break;
 			}
@@ -1343,11 +1367,10 @@ static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
 				  struct ieee80211_vif *vif,
 				  unsigned long desired_links)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u16 usable_links = ieee80211_vif_usable_links(vif);
+	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
 	const struct wiphy_iftype_ext_capab *ext_capa;
-	bool ret = true;
-	int link_id;
+	u8 n_data;
 
 	if (!ieee80211_vif_is_mld(vif) || !vif->cfg.assoc ||
 	    hweight16(usable_links) <= 1)
@@ -1362,21 +1385,13 @@ static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
 	    !(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP))
 		return false;
 
-	for_each_set_bit(link_id, &desired_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_bss_conf *link_conf =
-			link_conf_dereference_protected(vif, link_id);
-
-		if (WARN_ON_ONCE(!link_conf))
-			continue;
+	n_data = iwl_mvm_set_link_selection_data(vif, data, desired_links);
 
-		/* BT Coex effects eSR mode only if one of the link is on LB */
-		if (link_conf->chanreq.oper.chan->band != NL80211_BAND_2GHZ)
-			continue;
+	if (n_data != 2)
+		return false;
 
-		return !(mvmvif->esr_disable_reason & IWL_MVM_ESR_DISABLE_COEX);
-	}
 
-	return ret;
+	return iwl_mvm_mld_valid_link_pair(vif, &data[0], &data[1]);
 }
 
 static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 77786c1a7528..6ac20d42a09c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1589,15 +1589,14 @@ static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
 	struct iwl_trans *trans = mvm->fwrt.trans;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	lockdep_assert_held(&mvm->mutex);
-
 	if (vif->type == NL80211_IFTYPE_AP)
 		return mvm->fw->ucode_capa.num_beacons;
 
+	/* Check if HW supports eSR or STR */
 	if ((iwl_mvm_is_esr_supported(trans) &&
-	     !mvmvif->esr_disable_reason) ||
-	    ((CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
-	     CSR_HW_RFID_IS_CDB(trans->hw_rf_id))))
+	     !(mvmvif->esr_disable_reason & ~IWL_MVM_ESR_DISABLE_COEX)) ||
+	    (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
+	     CSR_HW_RFID_IS_CDB(trans->hw_rf_id)))
 		return IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM;
 
 	return 1;
-- 
2.34.1


