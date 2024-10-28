Return-Path: <linux-wireless+bounces-14613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C489B3653
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 17:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6FA1F232A2
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 16:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDF7188CCA;
	Mon, 28 Oct 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsE68O88"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318B1DE4C0
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132363; cv=none; b=ONvyzu0TbxCveh18acupr8fkYAO0zsSpbKQLtl7qtDdKxQ0n3MwPyPf2PGcMoJBNlI3UvpwG0hB1gqXES4kevR09tYMlXmYfWX8Af37HxxR1roMCPhDJvU8rkhlbSXZc1fp/3dEy6EridIguRhFwe0DmiTR3QJmC/I/eD09BWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132363; c=relaxed/simple;
	bh=oRvcPlVdFz+AqOFmW4Mumu3yqyPPOG2MWzbo9WCUCD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jJaSAUE7cIPC3yc6hoewKUgVnJTGMCAjZxcWz8M2Dl3Yex/O5qpd8xGcm9JPmb9WFHIgSyeiooHNAP29oTnSFFw+cRli8D63jHx0S1i8YBXQiql43s2MKHUqVSLgw4Mn3VW5QkEJalANlHbruNryKc3acJobuuDRU9C8goXraZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsE68O88; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730132361; x=1761668361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oRvcPlVdFz+AqOFmW4Mumu3yqyPPOG2MWzbo9WCUCD8=;
  b=HsE68O88LZ1BI5dmsOwBY8Xh4ylqCLunpOhy2nUm0whYXkAuZcjIyzft
   TvtvCzpHpHYtd7EHR+5ZaW4S623UZiexETC4q+GeNIEl1JrjZMwKxtkbt
   e72omyormX+qtliKYobmnBVjD3S4K0Q3moHwEn/dRHLd4pDX2yecygvDY
   9nLtqTOgczRRXiEBM3aTIvfP1h+Lg/2/VMnfC/UgE6kaFU0FudbPupCtr
   UITpdvYw7s3k6KgP39qZbyz+5BUWzNrNJ182yKgsRnpVYaG+udWXXoOhS
   Z55bBkg7LGf3aqUezUBTJ2hLJ9MmYGc8JlfC60BwYqReY878HlIaG7ux6
   g==;
X-CSE-ConnectionGUID: qh2dnaJhQRehKoNajwJi9w==
X-CSE-MsgGUID: uTlKa8+jQteisIEtgCGkmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41099902"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="41099902"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:21 -0700
X-CSE-ConnectionGUID: R1g1Vcp0RCieGVjS/eA52w==
X-CSE-MsgGUID: /1pGfDKrQHGn1jlm/a6wMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81561564"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/5] wifi: mac80211: change disassoc sequence a bit
Date: Mon, 28 Oct 2024 18:19:01 +0200
Message-Id: <20241028181512.fa06eb2cc873.I7815d33415aa1d65c0120b54be7a15a45388f807@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
References: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Currently, the sequence goes like this (among others):
1. flush all stations (including the AP ones) -> this will tell the
   drivers to remove the stations
2. notify the driver the vif is not associated.

Which means that in between 1 and 2, the state is that the vif is
associated, but there is no AP station, which makes no sense, and may be
problematic for some drivers (for example iwlwifi)

Change the sequence to:
1. flush the TDLS stations
2. move the AP station to IEEE80211_STA_NONE
3. notify the driver about the vif being unassociated
4. flush the AP station

In order to not break other drivers, add a vif flag to indicate whether
the driver wants to new sequence or not. If the flag is not set, then
things will be done in the old sequence.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 29 ++-------------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 35 ++-----------------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  5 ---
 include/net/mac80211.h                        |  4 +++
 net/mac80211/mlme.c                           | 24 +++++++++++--
 5 files changed, 30 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4db7c3ee6bf5..0dfa2c0453e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1790,6 +1790,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	mvmvif->deflink.active = 0;
 	mvmvif->link[0] = &mvmvif->deflink;
 
+	vif->driver_flags = IEEE80211_VIF_REMOVE_AP_AFTER_DISASSOC;
+
 	ret = iwl_mvm_set_link_mapping(mvm, vif, &vif->bss_conf);
 	if (ret)
 		goto out;
@@ -2955,33 +2957,6 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 					    &mvm->status),
 				  "Failed to update SF upon disassociation\n");
 
-			/*
-			 * If we get an assert during the connection (after the
-			 * station has been added, but before the vif is set
-			 * to associated), mac80211 will re-add the station and
-			 * then configure the vif. Since the vif is not
-			 * associated, we would remove the station here and
-			 * this would fail the recovery.
-			 */
-			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
-				      &mvm->status)) {
-				/* first remove remaining keys */
-				iwl_mvm_sec_key_remove_ap(mvm, vif,
-							  &mvmvif->deflink, 0);
-
-				/*
-				 * Remove AP station now that
-				 * the MAC is unassoc
-				 */
-				ret = iwl_mvm_rm_sta_id(mvm, vif,
-							mvmvif->deflink.ap_sta_id);
-				if (ret)
-					IWL_ERR(mvm,
-						"failed to remove AP station\n");
-
-				mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
-			}
-
 			/* remove quota for this interface */
 			ret = iwl_mvm_update_quotas(mvm, false, NULL);
 			if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index a5c38f389c69..de7b53353ea8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -18,6 +18,8 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 
 	mvmvif->mvm = mvm;
 
+	vif->driver_flags |= IEEE80211_VIF_REMOVE_AP_AFTER_DISASSOC;
+
 	/* Not much to do here. The stack will not allow interface
 	 * types or combinations that we didn't advertise, so we
 	 * don't really have to check the types.
@@ -823,30 +825,6 @@ static bool iwl_mvm_mld_vif_have_valid_ap_sta(struct iwl_mvm_vif *mvmvif)
 	return false;
 }
 
-static void iwl_mvm_mld_vif_delete_all_stas(struct iwl_mvm *mvm,
-					    struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int i, ret;
-
-	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-		return;
-
-	for_each_mvm_vif_valid_link(mvmvif, i) {
-		struct iwl_mvm_vif_link_info *link = mvmvif->link[i];
-
-		if (!link)
-			continue;
-
-		iwl_mvm_sec_key_remove_ap(mvm, vif, link, i);
-		ret = iwl_mvm_mld_rm_sta_id(mvm, link->ap_sta_id);
-		if (ret)
-			IWL_ERR(mvm, "failed to remove AP station\n");
-
-		link->ap_sta_id = IWL_MVM_INVALID_STA;
-	}
-}
-
 static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 						struct ieee80211_vif *vif,
 						u64 changes)
@@ -930,15 +908,6 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 				  !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
 					    &mvm->status),
 				  "Failed to update SF upon disassociation\n");
-
-			/* If we get an assert during the connection (after the
-			 * station has been added, but before the vif is set
-			 * to associated), mac80211 will re-add the station and
-			 * then configure the vif. Since the vif is not
-			 * associated, we would remove the station here and
-			 * this would fail the recovery.
-			 */
-			iwl_mvm_mld_vif_delete_all_stas(mvm, vif);
 		}
 
 		iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 703d7b2db47a..112b78c1b0e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2065,15 +2065,10 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
 	    mvm_link->ap_sta_id == sta_id) {
-		/* if associated - we can't remove the AP STA now */
-		if (vif->cfg.assoc)
-			return true;
-
 		/* first remove remaining keys */
 		iwl_mvm_sec_key_remove_ap(mvm, vif, mvm_link,
 					  link_sta->link_id);
 
-		/* unassoc - go ahead - remove the AP STA now */
 		mvm_link->ap_sta_id = IWL_MVM_INVALID_STA;
 	}
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b4f246cdcca4..c7b43465c28a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1855,6 +1855,9 @@ struct ieee80211_channel_switch {
  *	operation on this interface and request a channel context without
  *	the AP definition. Use this e.g. because the device is able to
  *	handle OFDMA (downlink and trigger for uplink) on a per-AP basis.
+ * @IEEE80211_VIF_REMOVE_AP_AFTER_DISASSOC: indicates that the AP sta should
+ *	be removed only after setting the vif as unassociated, and not the
+ *	opposite. Only relevant for STA vifs.
  */
 enum ieee80211_vif_flags {
 	IEEE80211_VIF_BEACON_FILTER		= BIT(0),
@@ -1863,6 +1866,7 @@ enum ieee80211_vif_flags {
 	IEEE80211_VIF_GET_NOA_UPDATE		= BIT(3),
 	IEEE80211_VIF_EML_ACTIVE	        = BIT(4),
 	IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW	= BIT(5),
+	IEEE80211_VIF_REMOVE_AP_AFTER_DISASSOC	= BIT(6),
 };
 
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 480b664151c9..27bdbca3adfb 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3601,6 +3601,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
+	struct sta_info *ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 	unsigned int link_id;
 	u64 changed = 0;
 	struct ieee80211_prep_tx_info info = {
@@ -3611,6 +3612,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (WARN_ON(!ap_sta))
+		return;
+
 	if (WARN_ON_ONCE(tx && !frame_buf))
 		return;
 
@@ -3674,8 +3678,16 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	sdata->vif.cfg.ssid_len = 0;
 
-	/* remove AP and TDLS peers */
-	sta_info_flush(sdata, -1);
+	/* Remove TDLS peers */
+	__sta_info_flush(sdata, false, -1, ap_sta);
+
+	if (sdata->vif.driver_flags & IEEE80211_VIF_REMOVE_AP_AFTER_DISASSOC) {
+		/* Only move the AP state */
+		sta_info_move_state(ap_sta, IEEE80211_STA_NONE);
+	} else {
+		/* Remove AP peer */
+		sta_info_flush(sdata, -1);
+	}
 
 	/* finally reset all BSS / config parameters */
 	if (!ieee80211_vif_is_mld(&sdata->vif))
@@ -3726,6 +3738,14 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 		ieee80211_vif_cfg_change_notify(sdata, changed);
 	}
 
+	if (sdata->vif.driver_flags & IEEE80211_VIF_REMOVE_AP_AFTER_DISASSOC) {
+		/*
+		 * After notifying the driver about the disassoc,
+		 * remove the ap sta.
+		 */
+		sta_info_flush(sdata, -1);
+	}
+
 	/* disassociated - set to defaults now */
 	ieee80211_set_wmm_default(&sdata->deflink, false, false);
 
-- 
2.34.1


