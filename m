Return-Path: <linux-wireless+bounces-13664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC648993DF0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEB71F24B0C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928A512C484;
	Tue,  8 Oct 2024 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8Gbrxhm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0E78685
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361545; cv=none; b=gkXy1ZO978Z/au/QJd35jUjjP15uVGLLi3dCMZvjQKpcN1lDhEx6Pw2WRUeOJyifsP6AW7vvtg5x67+Ro30Cucoc6CMR7alM4vbmn+VAwsaAVDN1RI3qxGvms2bFMJeTC/d4BjaU5pS0BAzyQYS+jk5O14SxfrBSKll4AsMC158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361545; c=relaxed/simple;
	bh=L3MA+5QoBakMaIIKTXEC/tMG9cwsxEwzdkYGUEB7yeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BeZxBFEPwf1RUOqMP082ZgtVhPbfc2DFLRQyosMoGX6rF2NWNt2yJmKhW5ufTl4WNge/eZNVGowJQbJs9JCCpGtnZbNOj3szka1VbSyTOt/ihzQ952g/ULWiyAr6wYvdRRt8SXyInk38aZsbGTy7xT7bpaI8fpc/zbRcrdshnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8Gbrxhm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361543; x=1759897543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3MA+5QoBakMaIIKTXEC/tMG9cwsxEwzdkYGUEB7yeY=;
  b=m8Gbrxhmf0SdYeY92Ug7BBlTv5rc7KO+Fj1xLoAhFGQ3Z1lFIrF1GkIr
   +r2XJyNoP9DxFyigfpt85MX2ApRnRqb85VuZWsuShU2umElbHNXQ4uosM
   W+vwq/8FrVvalnOYDU9BL+qjrIUz/8NNz2ALOBmNBuUvZ354G9eqv2Rzd
   qkRYIqsKj81lqLTyA92lXzKDMdFVIbutneDU/gTef6hXg5S7GwDgIX3jz
   /eunXwhKxv8SwMs4EVwVqyfLPCjLOCs14BJsc85rFVMWnvDAfZdMqwlzy
   58GZcKMGXpiQ3vXg7CTqMRomyN5Pip+5ow51EGqVzgAlDzAT+d0p3ciHd
   Q==;
X-CSE-ConnectionGUID: 734REcq7Ty2Jg9qgkU9c4Q==
X-CSE-MsgGUID: zdLAz/KFQwyt6cUvovI4SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024250"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024250"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:43 -0700
X-CSE-ConnectionGUID: bRV1hTtXSS6Fjb4OHMwetA==
X-CSE-MsgGUID: HtIbkny/RPmoIvvudF0C6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486296"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 01/14] wifi: iwlwifi: mvm: Add support for prep_add_interface() callback
Date: Tue,  8 Oct 2024 07:25:15 +0300
Message-Id: <20241008072037.3baf282d0a01.Ife0a929455cb13a95ab197ca765d8db777ff9d89@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Implement the prep_add_interface() callback, so that in case
EMLSR is active and an AP or a P2P interface is do to be added,
EMLSR would be blocked.

Add a delayed work, so that in case that the interface was not
eventually added, EMLSR would be unblocked after 5 seconds.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
This needs "wifi: mac80211: Add support to indicate that a new interface
is to be added"

 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 22 +++++++++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 31 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  7 +++++
 4 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 2b0652168002..19ecd215f1dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -12,6 +12,7 @@
 	HOW(BLOCKED_FW)			\
 	HOW(BLOCKED_NON_BSS)		\
 	HOW(BLOCKED_ROC)		\
+	HOW(BLOCKED_TMP_NON_BSS)	\
 	HOW(EXIT_MISSED_BEACON)		\
 	HOW(EXIT_LOW_RSSI)		\
 	HOW(EXIT_COEX)			\
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 3721d6349cc5..99e017f365e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1731,6 +1731,21 @@ static void iwl_mvm_unblock_esr_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
 	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_TPT);
 }
 
+static void iwl_mvm_unblock_esr_tmp_non_bss(struct wiphy *wiphy,
+					    struct wiphy_work *wk)
+{
+	struct iwl_mvm_vif *mvmvif =
+		container_of(wk, struct iwl_mvm_vif,
+			     unblock_esr_tmp_non_bss_wk.work);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	struct ieee80211_vif *vif =
+		container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
+
+	mutex_lock(&mvm->mutex);
+	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_TMP_NON_BSS);
+	mutex_unlock(&mvm->mutex);
+}
+
 void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 {
 	lockdep_assert_held(&mvm->mutex);
@@ -1749,6 +1764,9 @@ void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 
 	wiphy_work_init(&mvmvif->unblock_esr_tpt_wk,
 			iwl_mvm_unblock_esr_tpt);
+
+	wiphy_delayed_work_init(&mvmvif->unblock_esr_tmp_non_bss_wk,
+				iwl_mvm_unblock_esr_tmp_non_bss);
 }
 
 static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
@@ -1899,6 +1917,8 @@ void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 				  &mvmvif->mlo_int_scan_wk);
 
 	wiphy_work_cancel(mvm->hw->wiphy, &mvmvif->unblock_esr_tpt_wk);
+	wiphy_delayed_work_cancel(mvm->hw->wiphy,
+				  &mvmvif->unblock_esr_tmp_non_bss_wk);
 
 	cancel_delayed_work_sync(&mvmvif->csa_work);
 }
@@ -4075,6 +4095,8 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 					  &mvmvif->mlo_int_scan_wk);
 
 		wiphy_work_cancel(mvm->hw->wiphy, &mvmvif->unblock_esr_tpt_wk);
+		wiphy_delayed_work_cancel(mvm->hw->wiphy,
+					  &mvmvif->unblock_esr_tmp_non_bss_wk);
 
 		/* No need for the periodic statistics anymore */
 		if (ieee80211_vif_is_mld(vif) && mvmvif->esr_active)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 7de6c96646ca..3947f6a0e0cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1376,6 +1376,36 @@ iwl_mvm_mld_mac_pre_channel_switch(struct ieee80211_hw *hw,
 	return ret;
 }
 
+#define IWL_MVM_MLD_UNBLOCK_ESR_NON_BSS_TIMEOUT (5 * HZ)
+
+static void iwl_mvm_mld_prep_add_interface(struct ieee80211_hw *hw,
+					   enum nl80211_iftype type)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
+	struct iwl_mvm_vif *mvmvif;
+	int ret;
+
+	IWL_DEBUG_MAC80211(mvm, "prep_add_interface: type=%u\n",
+			   type);
+
+	if (IS_ERR_OR_NULL(bss_vif) ||
+	    !(type == NL80211_IFTYPE_AP ||
+	      type == NL80211_IFTYPE_P2P_GO ||
+	      type == NL80211_IFTYPE_P2P_CLIENT))
+		return;
+
+	mvmvif = iwl_mvm_vif_from_mac80211(bss_vif);
+	ret = iwl_mvm_block_esr_sync(mvm, bss_vif,
+				     IWL_MVM_ESR_BLOCKED_TMP_NON_BSS);
+	if (ret)
+		return;
+
+	wiphy_delayed_work_queue(mvmvif->mvm->hw->wiphy,
+				 &mvmvif->unblock_esr_tmp_non_bss_wk,
+				 IWL_MVM_MLD_UNBLOCK_ESR_NON_BSS_TIMEOUT);
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
@@ -1472,4 +1502,5 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.change_sta_links = iwl_mvm_mld_change_sta_links,
 	.can_activate_links = iwl_mvm_mld_can_activate_links,
 	.can_neg_ttlm = iwl_mvm_mld_can_neg_ttlm,
+	.prep_add_interface = iwl_mvm_mld_prep_add_interface,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 6246ffce7cf8..3f7b6465130a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -361,6 +361,9 @@ struct iwl_mvm_vif_link_info {
  * @IWL_MVM_ESR_BLOCKED_NON_BSS: An active non-BSS interface's link is
  *	preventing EMLSR
  * @IWL_MVM_ESR_BLOCKED_ROC: remain-on-channel is preventing EMLSR
+ * @IWL_MVM_ESR_BLOCKED_TMP_NON_BSS: An expected active non-BSS interface's link
+ *      is preventing EMLSR. This is a temporary blocking that is set when there
+ *      is an indication that a non-BSS interface is to be added.
  * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
  * @IWL_MVM_ESR_EXIT_LOW_RSSI: link is deactivated/not allowed for EMLSR
  *	due to low RSSI.
@@ -379,6 +382,7 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_FW		= 0x8,
 	IWL_MVM_ESR_BLOCKED_NON_BSS	= 0x10,
 	IWL_MVM_ESR_BLOCKED_ROC		= 0x20,
+	IWL_MVM_ESR_BLOCKED_TMP_NON_BSS	= 0x40,
 	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
 	IWL_MVM_ESR_EXIT_LOW_RSSI	= 0x20000,
 	IWL_MVM_ESR_EXIT_COEX		= 0x40000,
@@ -452,6 +456,8 @@ struct iwl_mvm_esr_exit {
  * @prevent_esr_done_wk: work that should be done when esr prevention ends.
  * @mlo_int_scan_wk: work for the internal MLO scan.
  * @unblock_esr_tpt_wk: work for unblocking EMLSR when tpt is high enough.
+ * @unblock_esr_tmp_non_bss_wk: work for removing the
+ *      IWL_MVM_ESR_BLOCKED_TMP_NON_BSS blocking for EMLSR.
  * @roc_activity: currently running ROC activity for this vif (or
  *	ROC_NUM_ACTIVITIES if no activity is running).
  * @session_prot_connection_loss: the connection was lost due to session
@@ -588,6 +594,7 @@ struct iwl_mvm_vif {
 	struct wiphy_delayed_work prevent_esr_done_wk;
 	struct wiphy_delayed_work mlo_int_scan_wk;
 	struct wiphy_work unblock_esr_tpt_wk;
+	struct wiphy_delayed_work unblock_esr_tmp_non_bss_wk;
 
 	struct iwl_mvm_vif_link_info deflink;
 	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
-- 
2.34.1


