Return-Path: <linux-wireless+bounces-6378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364638A691F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E490DB22E39
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE04112882E;
	Tue, 16 Apr 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGs9D/Cw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0BC128828
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264864; cv=none; b=j7FQIj9XSDSmkDwDa9Ptjf3v9rAKuTfzhXqlWGSOGrocLomS18HGzpkLGPoRJqZaRfE38+KTBAefyj1ax/4lXMMUIzj4NMFYLoFKjBNAzQvFQ6mi79DvhqYQL6fNhwKtqUTqNo0gtzWt7vuEJiAHrlgHlAxGCLzMz0hM3KQwJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264864; c=relaxed/simple;
	bh=du4HEKeyZyqg0psa95HHDPd9ZkEF4ABLURkpUCcIYxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d3TPSmo6ulr4rFElW2Fb3Axs92FHTGQOmPWG1gyR4wyy13XATgyG1LmB4ygvwrzDfoetrCNsLRnFvjFQYk87RF28IgWlk8hu2Zy5XSsArXIOM3AA9z6IZuPfYbVMC+snIMd1p135OtabVPARrw41/8UoXGoUYVhJ8FSJR/ASrPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGs9D/Cw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264863; x=1744800863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=du4HEKeyZyqg0psa95HHDPd9ZkEF4ABLURkpUCcIYxg=;
  b=BGs9D/Cw1nuNm+Gj8E+ojn74rWGkhQ2aDZPNaXoNICQ/7tG9qfTEH4BI
   twWtxfziodAzgQ3A/jvuenNRmnRiYsbt9PT0Tn26G9qEK9judzRgo5m62
   fCS8A6FBQ6n39Th1U/GncA1Vbz05JiEzyFnEKUtzT4rXKr+A78nR+rDde
   1/RCw9Ps3JbTQbJRLVeXvba9Hr7fFK/32Paw7RRni7SegijJ5HpWCjWCC
   4u7n1LnPMLTbTy+8WMbqIhwaTnxKD9ngDFFqLt8P3tN7HD+3hYyWNRPrE
   N6IDOl9ot9oaB/1z8a53W7KiSA893vNcuW6+CKAwjv8Pi8QcbHZm1Y/zL
   Q==;
X-CSE-ConnectionGUID: qx0s1+WRR5uI4xN4X+OMCg==
X-CSE-MsgGUID: IiPmZDTtTdGv89V6GI1QsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556026"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556026"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:22 -0700
X-CSE-ConnectionGUID: kHd0yCJYTjWq4YHufieh2A==
X-CSE-MsgGUID: b2bZrqy1S+q8nhT0+ZWIAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872396"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/16] wifi: iwlwifi: mvm: introduce esr_disable_reason
Date: Tue, 16 Apr 2024 13:53:56 +0300
Message-Id: <20240416134215.94c3590c6f27.I6a190da5025d0523ef483ffac0c64e26675041e6@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will maintain a bitmap of reasons for which we want to avoid
enabling EMLSR.
For now, we have a single reason: BT coexistence, but we will add soon
more reasons. Make it a bitmap to make it easier to manage.

Since we'll impact the parameters that impact the enablement /
disablement of EMLSR from several places, introduce a generic function
that takes into account the current state and execute the decision that
must be taken.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 32 +++++--------------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 29 ++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 18 +++++++++--
 3 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index acbd46747b7b..41afd5d50d81 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2013-2014, 2018-2020, 2022-2023 Intel Corporation
+ * Copyright (C) 2013-2014, 2018-2020, 2022-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  */
 #include <linux/ieee80211.h>
@@ -257,7 +257,6 @@ static void iwl_mvm_bt_coex_enable_esr(struct iwl_mvm *mvm,
 				       struct ieee80211_vif *vif, bool enable)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int link_id;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -265,30 +264,15 @@ static void iwl_mvm_bt_coex_enable_esr(struct iwl_mvm *mvm,
 		return;
 
 	/* Done already */
-	if (mvmvif->bt_coex_esr_disabled == !enable)
+	if ((mvmvif->esr_disable_reason & IWL_MVM_ESR_DISABLE_COEX) == !enable)
 		return;
 
-	mvmvif->bt_coex_esr_disabled = !enable;
-
-	/* Nothing to do */
-	if (mvmvif->esr_active == enable)
-		return;
-
-	if (enable) {
-		/* Try to re-enable eSR*/
-		iwl_mvm_mld_select_links(mvm, vif, false);
-		return;
-	}
-
-	/*
-	 * Find the primary link, as we want to switch to it and drop the
-	 * secondary one.
-	 */
-	link_id = iwl_mvm_mld_get_primary_link(mvm, vif, vif->active_links);
-	WARN_ON(link_id < 0);
+	if (enable)
+		mvmvif->esr_disable_reason &= ~IWL_MVM_ESR_DISABLE_COEX;
+	else
+		mvmvif->esr_disable_reason |= IWL_MVM_ESR_DISABLE_COEX;
 
-	ieee80211_set_active_links_async(vif,
-					 vif->active_links & BIT(link_id));
+	iwl_mvm_recalc_esr(mvm, vif);
 }
 
 /*
@@ -336,7 +320,7 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 	if (!link_rssi)
 		wifi_loss_rate = mvm->last_bt_notif.wifi_loss_mid_high_rssi;
 
-	else if (!mvmvif->bt_coex_esr_disabled)
+	else if (!(mvmvif->esr_disable_reason & IWL_MVM_ESR_DISABLE_COEX))
 		 /* RSSI needs to get really low to disable eSR... */
 		wifi_loss_rate =
 			link_rssi <= -IWL_MVM_BT_COEX_DISABLE_ESR_THRESH ?
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 32ccc3b883b2..7a2a18f8b86e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1258,6 +1258,33 @@ int iwl_mvm_mld_get_primary_link(struct iwl_mvm *mvm,
 	return data[1].link_id;
 }
 
+void iwl_mvm_recalc_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	bool enable = !mvmvif->esr_disable_reason;
+	int link_id;
+
+	/* Nothing to do */
+	if (mvmvif->esr_active == enable)
+		return;
+
+	if (enable) {
+		/* Try to re-enable eSR */
+		iwl_mvm_mld_select_links(mvm, vif, false);
+		return;
+	}
+
+	/*
+	 * Find the primary link, as we want to switch to it and drop the
+	 * secondary one.
+	 */
+	link_id = iwl_mvm_mld_get_primary_link(mvm, vif, vif->active_links);
+	WARN_ON(link_id < 0);
+
+	ieee80211_set_active_links_async(vif,
+					 vif->active_links & BIT(link_id));
+}
+
 /*
  * This function receives a bitmap of usable links and check if we can enter
  * eSR on those links.
@@ -1300,7 +1327,7 @@ static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
 							 primary_link);
 		// Mark eSR as disabled for the next time
 		if (!ret)
-			mvmvif->bt_coex_esr_disabled = true;
+			mvmvif->esr_disable_reason |= IWL_MVM_ESR_DISABLE_COEX;
 		break;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a3f42dec97d2..0dd83e0171ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -345,6 +345,14 @@ struct iwl_mvm_vif_link_info {
 	struct iwl_mvm_link_bf_data bf_data;
 };
 
+/**
+ * enum iwl_mvm_esr_disable_reason - reasons for which we can't enable EMLSR
+ * @IWL_MVM_ESR_DISABLE_COEX: COEX is preventing the enablement of EMLSR
+ */
+enum iwl_mvm_esr_disable_reason {
+	IWL_MVM_ESR_DISABLE_COEX	= BIT(0),
+};
+
 /**
  * struct iwl_mvm_vif - data per Virtual Interface, it is a MAC context
  * @mvm: pointer back to the mvm struct
@@ -360,7 +368,6 @@ struct iwl_mvm_vif_link_info {
  * @pm_enabled - indicate if MAC power management is allowed
  * @monitor_active: indicates that monitor context is configured, and that the
  *	interface should get quota etc.
- * @bt_coex_esr_disabled: indicates if esr is disabled due to bt coex
  * @low_latency: bit flags for low latency
  *	see enum &iwl_mvm_low_latency_cause for causes.
  * @low_latency_actual: boolean, indicates low latency is set,
@@ -379,6 +386,7 @@ struct iwl_mvm_vif_link_info {
  * @deflink: default link data for use in non-MLO
  * @link: link data for each link in MLO
  * @esr_active: indicates eSR mode is active
+ * @esr_disable_reason: a bitmap of enum iwl_mvm_esr_disable_reason
  * @pm_enabled: indicates powersave is enabled
  */
 struct iwl_mvm_vif {
@@ -393,7 +401,6 @@ struct iwl_mvm_vif {
 	bool pm_enabled;
 	bool monitor_active;
 	bool esr_active;
-	bool bt_coex_esr_disabled;
 
 	u8 low_latency: 6;
 	u8 low_latency_actual: 1;
@@ -401,6 +408,7 @@ struct iwl_mvm_vif {
 	u8 authorized:1;
 	bool ps_disabled;
 
+	u32 esr_disable_reason;
 	u32 ap_beacon_time;
 	bool bf_enabled;
 	bool ba_enabled;
@@ -1587,7 +1595,7 @@ static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
 		return mvm->fw->ucode_capa.num_beacons;
 
 	if ((iwl_mvm_is_esr_supported(trans) &&
-	     !mvmvif->bt_coex_esr_disabled) ||
+	     !mvmvif->esr_disable_reason) ||
 	    ((CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
 	     CSR_HW_RFID_IS_CDB(trans->hw_rf_id))))
 		return IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM;
@@ -2808,4 +2816,8 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 			struct ieee80211_channel *channel,
 			struct ieee80211_vif *vif,
 			int duration, u32 activity);
+
+/* EMLSR */
+void iwl_mvm_recalc_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+
 #endif /* __IWL_MVM_H__ */
-- 
2.34.1


