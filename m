Return-Path: <linux-wireless+bounces-36166-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJlVJlLvAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36166-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F140506571
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A7163011C40
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C54313522;
	Sun, 10 May 2026 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0uqA+d6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74E64
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446142; cv=none; b=Tri8DDk1llvIwvA3p4uq0JpX8jKq6IMStFUtydFKYO+lH2JMgMK0VUqUWWHHVPWN/E6aIru9VwJPMFGLORQs2tgUZzjiGvL5+TXK6wsUHiZoKiCMlMckvoKfAa7aGy1Kbct5eLyPmulP6csuxreDqEHP64HjIbQztlZG4lT5OWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446142; c=relaxed/simple;
	bh=6ZjC00m5YElCarDjeqPR8h6+PmUItHiIEUe4apIzOGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n0YMKHlf7Jky6ibTRmg7NGqScFIosy4+VNGLnFYPmQXgr084SHiQ3S+P5AN9T5F2UYIOA4amWMIQydKKE0oFu413oQWLzScTkzH8eP3UKBJNG1LtmnPePwzuwbGvfbolpVT13QQ+8NqyqezOz2iaHzWEiVC7IaueXaOKLpdFH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0uqA+d6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446141; x=1809982141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ZjC00m5YElCarDjeqPR8h6+PmUItHiIEUe4apIzOGQ=;
  b=N0uqA+d6ZEOs2AHmKNJsn3WGptAc4BlJ0eTOTLPYyuovtYjGQYQ6b3HT
   /oWDUKyXr1L614msyw/PKniFuAmD7PSI/+ePunC3bCXwvM3TpmFG/vV0G
   U0N116gMJZ3qtyFwjivgDpuZSiW7YlC9SZHs7VKiL0yh5GyA1YjJcuAc2
   rQ/ub5kEEx2tyRye1AmJKOWne54mlexujz8MnmBJICPYW41D2GHx3wRlv
   yMQf5XCE5iecrisRChJHa8HLp6op3zfwTKsKWNgXh1lm7MGkHOxw6eNff
   CEphphUCsZ+sNxesipi0fxvgo+VNZO5YckECd1w/UQsL5jADC1dtNXV1n
   A==;
X-CSE-ConnectionGUID: hrnAOyV0Q4K4yeHnvwwz9w==
X-CSE-MsgGUID: avM7Z8NATdiy98ckcmj3mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904752"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904752"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:00 -0700
X-CSE-ConnectionGUID: WVmiJCm5R+a27aGs046Etg==
X-CSE-MsgGUID: ycDPqEMyQiqn7VEUaQs8YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095037"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:48:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 04/15] wifi: iwlwifi: mld: support NAN and NAN_DATA interfaces
Date: Sun, 10 May 2026 23:48:29 +0300
Message-Id: <20260510234534.dd12944c140b.I3578198660a533faf9f6a94432ef2114f4a9dfae@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
References: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F140506571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36166-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Until now we maintained the NAN vif in the driver only. The fw used the
AUX MAC for sync and discovery operations.
But when we want to configure a local schedule, we need to add the MAC
first.

NAN_DATA interfaces are not added to the FW. Instead, the local
address of these interfaces are configured to the FW via the NAN MAC.

Add the add/remove/update operations for the NAN interface, and fill the
NAN special parameters in it.

Note that this doesn't fully implement the schedule change, but only the
addition/removal of the NAN MAC. The full schedule management
implementation will come in a later patch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 134 ++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  22 +++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  16 ++-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  |  22 +++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |   5 +-
 5 files changed, 184 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 1e85a9168d2b..150ad095e0ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include <net/cfg80211.h>
 
@@ -55,6 +55,9 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 
 	ieee80211_iter_keys(mld->hw, vif, iwl_mld_cleanup_keys_iter, NULL);
 
+	if (vif->type == NL80211_IFTYPE_NAN)
+		mld_vif->nan.mac_added = false;
+
 	CLEANUP_STRUCT(mld_vif);
 }
 
@@ -94,6 +97,8 @@ static int iwl_mld_mac80211_iftype_to_fw(const struct ieee80211_vif *vif)
 		return FW_MAC_TYPE_P2P_DEVICE;
 	case NL80211_IFTYPE_ADHOC:
 		return FW_MAC_TYPE_IBSS;
+	case NL80211_IFTYPE_NAN:
+		return FW_MAC_TYPE_NAN;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -362,6 +367,42 @@ static void iwl_mld_fill_mac_cmd_ibss(struct iwl_mld *mld,
 					 MAC_CFG_FILTER_ACCEPT_GRP);
 }
 
+static int iwl_mld_fill_mac_cmd_nan(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_vif *ndi_being_added,
+				    struct iwl_mac_config_cmd *cmd)
+{
+	struct ieee80211_vif *iter;
+	u32 idx = 0;
+
+	cmd->filter_flags = cpu_to_le32(MAC_CFG_FILTER_ACCEPT_CONTROL_AND_MGMT);
+
+	/*
+	 * A NAN_DATA vif might be in the process of being added - it won't
+	 * be found by the iteration below since it's not yet active/in-driver.
+	 * In hw restart, the iteration below will find the ndi_being_added.
+	 */
+	if (ndi_being_added && !mld->fw_status.in_hw_restart) {
+		memcpy(cmd->nan.ndi_addrs[idx].addr, ndi_being_added->addr, ETH_ALEN);
+		idx++;
+	}
+
+	for_each_active_interface(iter, mld->hw) {
+		if (iter->type != NL80211_IFTYPE_NAN_DATA)
+			continue;
+
+		if (WARN_ON_ONCE(idx >= ARRAY_SIZE(cmd->nan.ndi_addrs)))
+			return -EINVAL;
+
+		memcpy(cmd->nan.ndi_addrs[idx].addr, iter->addr, ETH_ALEN);
+		idx++;
+	}
+
+	cmd->nan.ndi_addrs_count = cpu_to_le32(idx);
+
+	return 0;
+}
+
 static int
 iwl_mld_rm_mac_from_fw(struct iwl_mld *mld, struct ieee80211_vif *vif)
 {
@@ -374,16 +415,23 @@ iwl_mld_rm_mac_from_fw(struct iwl_mld *mld, struct ieee80211_vif *vif)
 	return iwl_mld_send_mac_cmd(mld, &cmd);
 }
 
-int iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
-			  u32 action)
+static int
+__iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			u32 action, struct ieee80211_vif *ndi_being_added)
 {
 	struct iwl_mac_config_cmd cmd = {};
+	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	/* NAN interface type is not known to FW */
-	if (vif->type == NL80211_IFTYPE_NAN)
-		return 0;
+	/* NAN_DATA interface type is not known to FW */
+	if (WARN_ON(vif->type == NL80211_IFTYPE_NAN_DATA))
+		return -EINVAL;
+
+	/* ndi_being_added is only relevant for NAN and when adding a NAN_DATA interface */
+	if (WARN_ON(ndi_being_added &&
+		    (vif->type != NL80211_IFTYPE_NAN || action != FW_CTXT_ACTION_MODIFY)))
+		return -EINVAL;
 
 	if (action == FW_CTXT_ACTION_REMOVE)
 		return iwl_mld_rm_mac_from_fw(mld, vif);
@@ -411,6 +459,11 @@ int iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	case NL80211_IFTYPE_ADHOC:
 		iwl_mld_fill_mac_cmd_ibss(mld, vif, &cmd);
 		break;
+	case NL80211_IFTYPE_NAN:
+		ret = iwl_mld_fill_mac_cmd_nan(mld, vif, ndi_being_added, &cmd);
+		if (ret)
+			return ret;
+		break;
 	default:
 		WARN(1, "not supported yet\n");
 		return -EOPNOTSUPP;
@@ -419,6 +472,12 @@ int iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	return iwl_mld_send_mac_cmd(mld, &cmd);
 }
 
+int iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			  u32 action)
+{
+	return __iwl_mld_mac_fw_action(mld, vif, action, NULL);
+}
+
 static void iwl_mld_mlo_scan_start_wk(struct wiphy *wiphy,
 				      struct wiphy_work *wk)
 {
@@ -459,6 +518,24 @@ iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 	iwl_mld_init_internal_sta(&mld_vif->aux_sta);
 }
 
+static int iwl_mld_update_nan_mac(struct iwl_mld *mld,
+				  struct ieee80211_vif *ndi_being_added)
+{
+	struct ieee80211_vif *vif = mld->nan_device_vif;
+	struct iwl_mld_vif *mld_vif;
+
+	if (WARN_ON_ONCE(!vif))
+		return -ENODEV;
+
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	if (!iwl_mld_vif_fw_id_valid(mld_vif))
+		return 0;
+
+	return __iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_MODIFY,
+				       ndi_being_added);
+}
+
 int iwl_mld_add_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
@@ -468,10 +545,14 @@ int iwl_mld_add_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 
 	iwl_mld_init_vif(mld, vif);
 
-	/* NAN interface type is not known to FW */
+	/* NAN MACs are added to FW only when a schedule is set */
 	if (vif->type == NL80211_IFTYPE_NAN)
 		return 0;
 
+	/* NAN_DATA interface type is not known to FW, but we need to update NAN MAC */
+	if (vif->type == NL80211_IFTYPE_NAN_DATA)
+		return iwl_mld_update_nan_mac(mld, vif);
+
 	ret = iwl_mld_allocate_vif_fw_id(mld, &mld_vif->fw_id, vif);
 	if (ret)
 		return ret;
@@ -483,23 +564,52 @@ int iwl_mld_add_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 	return ret;
 }
 
+int iwl_mld_add_nan_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_NAN))
+		return -EINVAL;
+
+	ret = iwl_mld_allocate_vif_fw_id(mld, &mld_vif->fw_id, vif);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_ADD);
+	if (ret) {
+		RCU_INIT_POINTER(mld->fw_id_to_vif[mld_vif->fw_id], NULL);
+		return ret;
+	}
+
+	mld_vif->nan.mac_added = true;
+
+	return 0;
+}
+
 void iwl_mld_rm_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	/* NAN interface type is not known to FW */
-	if (vif->type == NL80211_IFTYPE_NAN)
+	if (vif->type == NL80211_IFTYPE_NAN_DATA) {
+		iwl_mld_update_nan_mac(mld, NULL);
 		return;
+	}
 
-	iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_REMOVE);
-
-	if (WARN_ON(mld_vif->fw_id >= ARRAY_SIZE(mld->fw_id_to_vif)))
+	if (!iwl_mld_vif_fw_id_valid(mld_vif))
 		return;
 
+	iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_REMOVE);
+
 	RCU_INIT_POINTER(mld->fw_id_to_vif[mld_vif->fw_id], NULL);
 
+	if (vif->type == NL80211_IFTYPE_NAN)
+		mld_vif->nan.mac_added = false;
+
 	iwl_mld_cancel_notifications_of_object(mld, IWL_MLD_OBJECT_TYPE_VIF,
 					       mld_vif->fw_id);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 8dfc79fed253..1ac14996985c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -152,6 +152,8 @@ struct iwl_mld_emlsr {
  *	p2p device only. Set to %ROC_NUM_ACTIVITIES when not in use.
  * @aux_sta: station used for remain on channel. Used in P2P device.
  * @mlo_scan_start_wk: worker to start a deferred MLO scan
+ * @nan: NAN parameters
+ * @nan.mac_added: track whether or not the MAC was added to FW
  */
 struct iwl_mld_vif {
 	/* Add here fields that need clean up on restart */
@@ -175,6 +177,11 @@ struct iwl_mld_vif {
 	struct iwl_mld_link deflink;
 	struct iwl_mld_link __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
+	struct {
+		/* use only with wiphy protection */
+		bool mac_added;
+	} nan;
+
 	struct iwl_mld_emlsr emlsr;
 
 #ifdef CONFIG_PM_SLEEP
@@ -206,6 +213,20 @@ iwl_mld_vif_to_mac80211(struct iwl_mld_vif *mld_vif)
 /* Call only for interfaces that were added to the driver! */
 static inline bool iwl_mld_vif_fw_id_valid(struct iwl_mld_vif *mld_vif)
 {
+	struct ieee80211_vif *vif = iwl_mld_vif_to_mac80211(mld_vif);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_NAN_DATA:
+		return false;
+	case NL80211_IFTYPE_NAN:
+		if (!mld_vif->nan.mac_added)
+			return false;
+		break;
+	default:
+		break;
+	}
+
+	/* Should be added to FW */
 	if (WARN_ON(mld_vif->fw_id >= ARRAY_SIZE(mld_vif->mld->fw_id_to_vif)))
 		return false;
 
@@ -235,6 +256,7 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif);
 int iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			  u32 action);
 int iwl_mld_add_vif(struct iwl_mld *mld, struct ieee80211_vif *vif);
+int iwl_mld_add_nan_vif(struct iwl_mld *mld, struct ieee80211_vif *vif);
 void iwl_mld_rm_vif(struct iwl_mld *mld, struct ieee80211_vif *vif);
 void iwl_mld_set_vif_associated(struct iwl_mld *mld,
 				struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index e66b304f345a..3c84c6b0faaa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -677,6 +677,9 @@ int iwl_mld_mac80211_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		return ret;
 
+	if (vif->type == NL80211_IFTYPE_NAN_DATA)
+		return 0;
+
 	/*
 	 * Add the default link, but not if this is an MLD vif as that implies
 	 * the HW is restarting and it will be configured by change_vif_links.
@@ -745,7 +748,7 @@ void iwl_mld_mac80211_remove_interface(struct ieee80211_hw *hw,
 
 	if (vif->type == NL80211_IFTYPE_NAN)
 		mld->nan_device_vif = NULL;
-	else
+	else if (vif->type != NL80211_IFTYPE_NAN_DATA)
 		iwl_mld_remove_link(mld, &vif->bss_conf);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -1371,6 +1374,10 @@ iwl_mld_mac80211_link_info_changed(struct ieee80211_hw *hw,
 		if (changes & BSS_CHANGED_MU_GROUPS)
 			iwl_mld_update_mu_groups(mld, link_conf);
 		break;
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
+		/* NAN has no links */
+		break;
 	default:
 		/* shouldn't happen */
 		WARN_ON_ONCE(1);
@@ -1418,6 +1425,11 @@ void iwl_mld_mac80211_vif_cfg_changed(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
+	if (vif->type == NL80211_IFTYPE_NAN) {
+		iwl_mld_nan_vif_cfg_changed(mld, vif, changes);
+		return;
+	}
+
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
@@ -1613,7 +1625,7 @@ iwl_mld_mac80211_conf_tx(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	if (vif->type == NL80211_IFTYPE_NAN)
+	if (vif->type == NL80211_IFTYPE_NAN || vif->type == NL80211_IFTYPE_NAN_DATA)
 		return 0;
 
 	link = iwl_mld_link_dereference_check(mld_vif, link_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 4d8e85f2bd7c..96e79ba5234a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -296,3 +296,25 @@ void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
 	wdev = ieee80211_vif_to_wdev(mld->nan_device_vif);
 	cfg80211_next_nan_dw_notif(wdev, chan, GFP_KERNEL);
 }
+
+void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
+				 struct ieee80211_vif *vif,
+				 u64 changes)
+{
+	struct ieee80211_nan_sched_cfg *sched_cfg = &vif->cfg.nan_sched;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	bool has_sched = memchr_inv(sched_cfg->schedule, 0,
+				    sizeof(sched_cfg->schedule));
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (!(changes & BSS_CHANGED_NAN_LOCAL_SCHED))
+		return;
+
+	if (has_sched && !mld_vif->nan.mac_added) {
+		if (iwl_mld_add_nan_vif(mld, vif))
+			IWL_ERR(mld, "Failed to add NAN vif\n");
+	} else if (!has_sched && mld_vif->nan.mac_added) {
+		iwl_mld_rm_vif(mld, vif);
+	}
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index c04d77208971..9487155cf6b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2025 Intel Corporation
+ * Copyright (C) 2025-2026 Intel Corporation
  */
 #ifndef __iwl_mld_nan_h__
 #define __iwl_mld_nan_h__
@@ -27,5 +27,8 @@ bool iwl_mld_cancel_nan_cluster_notif(struct iwl_mld *mld,
 bool iwl_mld_cancel_nan_dw_end_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt,
 				     u32 obj_id);
+void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
+				 struct ieee80211_vif *vif,
+				 u64 changes);
 
 #endif /* __iwl_mld_nan_h__ */
-- 
2.34.1


