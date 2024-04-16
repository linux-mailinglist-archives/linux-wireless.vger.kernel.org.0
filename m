Return-Path: <linux-wireless+bounces-6383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006F8A6924
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFB9281FDA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C169128809;
	Tue, 16 Apr 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxOqBhWR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E65127E3D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264874; cv=none; b=ZqxH5zlHeq66DPBSWDdhQjyYMUHfEcO5dUST+jaTf3i43CVwYWoNUoTaH0+lol43sAr5rMAvN9zAxtKKOoHPoHkoVrbqzotHdPJwlTyx0Z7O0Rh4v4+jvmk/3R1joZ4i6YcDoCfO/3vJpnMVEPI4KcLXAXG6QFRdjwvNBj1hjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264874; c=relaxed/simple;
	bh=Ku/S4C7BkulmrxqwGVpnQaL85LAb7BZeskB3z3NRnog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GvfnT6PGubDz8nmtFfGDgTj1MsyNGUYjJWNUzJPtprMR3tTNNFpE7WFbFOaBwBQVU+yv6KZ8kf86wbZ83/QZaH54hUP+3O1fqB78JEd7qJzkie6bkf6rdXkT7hJdq9+LgNENgWSLXt6Ci3gW1/BPE3+TV6crNFexVN8Am2F8K8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxOqBhWR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264873; x=1744800873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ku/S4C7BkulmrxqwGVpnQaL85LAb7BZeskB3z3NRnog=;
  b=JxOqBhWRdv3/P7l6Nw6EJybEYEyBRUt8QjjXSXaCDyYkPRxuWLxYKGcN
   rCVFWYSxERZQt3t2l7X0nevZKkxkEy2xr/vqTqWRVd4VGwLgWSwMZ5nEy
   BPFBiaHCTg++TWhvWw6JTAbNaSENbMUYp877QnScbRBwHW8c3fVzVggut
   wnQzb8ODuklVvh96+nwM9iB8uNXv1vArbfnIGWw/5U6wpjfJmExmurT6X
   Ir9L21YIOH54TF5Ed/384att/DhnG1Fh9+kp3pky3sJKI/GGigPKVNbuy
   PVbjxS7Plr3Jw3XfpWW4AcE7DCp9/tU/BsZJzAxSAhCGbBUqx9TAiYmjM
   g==;
X-CSE-ConnectionGUID: t9N+fogjTNyOefQKavuWxQ==
X-CSE-MsgGUID: k/whV5XFRcWU5cEmZ9UTMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556042"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556042"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:32 -0700
X-CSE-ConnectionGUID: DfrXQmRNRBOEXsbS7JTBvg==
X-CSE-MsgGUID: LYH2YQ9hSIOHSriG76dZIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872483"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/16] wifi: iwlwifi: mvm: check if EMLSR is allowed before selecting links
Date: Tue, 16 Apr 2024 13:54:01 +0300
Message-Id: <20240416134215.3578a93feb1a.I1cd91608bb73fbe19b8dfdf90e14ce40b98c3430@changeid>
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

Currenty iwl_mvm_mld_select_links() doesn't fully check that
EMLSR is allowed before selecting the 2 best links.
Although it will fail in ieee80211_set_active_links(), it is preferred
to avoid the redundent calculations.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 44 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +-
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 797c088ea0c8..33440fff762c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -697,6 +697,30 @@ iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
 	return n_data;
 }
 
+static bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	const struct wiphy_iftype_ext_capab *ext_capa;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!ieee80211_vif_is_mld(vif) || !vif->cfg.assoc ||
+	    hweight16(ieee80211_vif_usable_links(vif)) == 1)
+		return false;
+
+	if (!(vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP))
+		return false;
+
+	ext_capa = cfg80211_get_iftype_ext_capa(mvm->hw->wiphy,
+						ieee80211_vif_type_p2p(vif));
+	if (!ext_capa ||
+	    !(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP))
+		return false;
+
+	return !(mvmvif->esr_disable_reason & ~IWL_MVM_ESR_DISABLE_COEX);
+}
+
 void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			      bool valid_links_changed)
 {
@@ -709,9 +733,6 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (!IWL_MVM_AUTO_EML_ENABLE)
 		return;
 
-	if (!ieee80211_vif_is_mld(vif) || usable_links == 1)
-		return;
-
 	/* The logic below is a simple version that doesn't suit more than 2
 	 * links
 	 */
@@ -729,6 +750,9 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (hweight16(vif->active_links) == max_active_links)
 		return;
 
+	if (!iwl_mvm_esr_allowed_on_vif(mvm, vif))
+		return;
+
 	n_data = iwl_mvm_set_link_selection_data(vif, data, usable_links);
 
 	/* this is expected to be the current active link */
@@ -1367,22 +1391,10 @@ static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
 				  struct ieee80211_vif *vif,
 				  unsigned long desired_links)
 {
-	u16 usable_links = ieee80211_vif_usable_links(vif);
 	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
-	const struct wiphy_iftype_ext_capab *ext_capa;
 	u8 n_data;
 
-	if (!ieee80211_vif_is_mld(vif) || !vif->cfg.assoc ||
-	    hweight16(usable_links) <= 1)
-		return false;
-
-	if (!(vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP))
-		return false;
-
-	ext_capa = cfg80211_get_iftype_ext_capa(mvm->hw->wiphy,
-						ieee80211_vif_type_p2p(vif));
-	if (!ext_capa ||
-	    !(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP))
+	if (!iwl_mvm_esr_allowed_on_vif(mvm, vif))
 		return false;
 
 	n_data = iwl_mvm_set_link_selection_data(vif, data, desired_links);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 6ac20d42a09c..c887263a2159 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1587,14 +1587,12 @@ static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
 					   struct ieee80211_vif *vif)
 {
 	struct iwl_trans *trans = mvm->fwrt.trans;
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	if (vif->type == NL80211_IFTYPE_AP)
 		return mvm->fw->ucode_capa.num_beacons;
 
 	/* Check if HW supports eSR or STR */
-	if ((iwl_mvm_is_esr_supported(trans) &&
-	     !(mvmvif->esr_disable_reason & ~IWL_MVM_ESR_DISABLE_COEX)) ||
+	if (iwl_mvm_is_esr_supported(trans) ||
 	    (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
 	     CSR_HW_RFID_IS_CDB(trans->hw_rf_id)))
 		return IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM;
-- 
2.34.1


