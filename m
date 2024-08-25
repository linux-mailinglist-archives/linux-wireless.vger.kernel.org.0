Return-Path: <linux-wireless+bounces-11893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9256995E22D
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 08:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1175F282778
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 06:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94D29408;
	Sun, 25 Aug 2024 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMXPBO4i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C12207A
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724565668; cv=none; b=el565lzqbrXp3A7G11HrYtf1JaZK8a5SDfac0VegM3Qbuqrb/0AfHAsVdUrp9niCmJ/ilfHrXnvdm2+OSHPDMZps0yV/fzqohSDMh/xFOZCNwROtHVQh1wnYuHH6M5gCoigsLdGMeoRcefkCh5SBH3OJ5If95ptUa+pd1Z/xXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724565668; c=relaxed/simple;
	bh=XqGEFnRfbwhYz8mYx5mrRWPzPsZ+8DtMCXDpwo0nMh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQkBVPdIDFMDib70fPCqCfk0hWBWop4Pa3GdzSbKMfSnF9Qy7PCIcxHQ/mNcNY4Scdr7dCXRqR8hFd7ncC19Ks0WExK3HmuV6XLn9ynkjBHD1ey9l/IS57uFVIMaUp4tsyQVY6nVWJMO91Y/xPf4yG4K9UevpjWYxDWtfRhEJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMXPBO4i; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724565665; x=1756101665;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XqGEFnRfbwhYz8mYx5mrRWPzPsZ+8DtMCXDpwo0nMh0=;
  b=YMXPBO4iGWddZ08lzijD7Ol2RI9bS2DyjGAMJ98nbtCxbXRnuCrqtdl7
   7tUfC5v+EdnGlxdBc+rU3q3T0/UpnjhH8W2iKe8GeqMz6R9gdNqnnj5eF
   ntDZkWFp/MBN2JDSxji/YAmM7cGEacZCHJ/0ZNlsiatdJUfePwbX8GTRV
   u9pcMrczhb7D10dR3Jatt9RCSJQU1cYDbDmMjVMvRrdTrfvIEoLZsRR3L
   vTRaWRIVXjlDyFn1mEG01LKhcIT5keVqaaq4mDmblKC0MZgMa09r+V7T7
   qpXbR15ujDJn/GzYOmqkniRwnuGyuBApPVTu5uW8uzN/M/91AwUn+Shdh
   g==;
X-CSE-ConnectionGUID: j9z8tD1XTAOcwJcHQmXivA==
X-CSE-MsgGUID: kbLrS/DCQiq6PyIgrhBJFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="22869729"
X-IronPort-AV: E=Sophos;i="6.10,174,1719903600"; 
   d="scan'208";a="22869729"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 23:01:05 -0700
X-CSE-ConnectionGUID: tcfIGELFRoyVfijF781m+w==
X-CSE-MsgGUID: 8/qyo259RiWu3MHmDwNPLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,174,1719903600"; 
   d="scan'208";a="67091046"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 23:01:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] wifi: iwlwifi: mvm: handle the new EML OMN failure notification
Date: Sun, 25 Aug 2024 09:00:54 +0300
Message-Id: <20240825090005.01ff45fa69db.I9f2d3ea851050f6031ac07bbe69eb38000fd5683@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Take the proper action upon EML OMN frame failure.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: - remove the internal  'ticket' tag
    - fix selecting the link to go back to

 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 42 +++++++++++++++++++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 6a2c5bed357e..7af580d1c99c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -710,7 +710,7 @@ enum iwl_esr_trans_fail_code {
 /**
  * struct iwl_esr_trans_fail_notif - FW reports a failure in EMLSR transition
  *
- * @link_id: the link_id that was activated / de-activated
+ * @link_id: the link_id that still works after the failure
  * @activation: true if the link was activated, false otherwise
  * @err_code: see &enum iwl_esr_trans_fail_code
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 3a6e0a90a3ef..d151d935e12a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -17,7 +17,8 @@
 	HOW(EXIT_COEX)			\
 	HOW(EXIT_BANDWIDTH)		\
 	HOW(EXIT_CSA)			\
-	HOW(EXIT_LINK_USAGE)
+	HOW(EXIT_LINK_USAGE)		\
+	HOW(EXIT_FAIL_ENTRY)
 
 static const char *const iwl_mvm_esr_states_names[] = {
 #define NAME_ENTRY(x) [ilog2(IWL_MVM_ESR_##x)] = #x,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f9e676374daa..65b66f01bef9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -368,6 +368,7 @@ struct iwl_mvm_vif_link_info {
  *	preventing the enablement of EMLSR
  * @IWL_MVM_ESR_EXIT_CSA: CSA happened, so exit EMLSR
  * @IWL_MVM_ESR_EXIT_LINK_USAGE: Exit EMLSR due to low tpt on secondary link
+ * @IWL_MVM_ESR_EXIT_FAIL_ENTRY: Exit EMLSR due to entry failure
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
@@ -382,6 +383,7 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_EXIT_BANDWIDTH	= 0x80000,
 	IWL_MVM_ESR_EXIT_CSA		= 0x100000,
 	IWL_MVM_ESR_EXIT_LINK_USAGE	= 0x200000,
+	IWL_MVM_ESR_EXIT_FAIL_ENTRY	= 0x400000,
 };
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 0b91877592a8..f207ac46b8ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -159,6 +159,43 @@ static void iwl_mvm_rx_esr_mode_notif(struct iwl_mvm *mvm,
 				  iwl_mvm_get_primary_link(vif));
 }
 
+static void iwl_mvm_rx_esr_trans_fail_notif(struct iwl_mvm *mvm,
+					    struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_esr_trans_fail_notif *notif = (void *)pkt->data;
+	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
+	u8 fw_link_id = le32_to_cpu(notif->link_id);
+	struct ieee80211_bss_conf *bss_conf;
+
+	if (IS_ERR_OR_NULL(vif))
+		return;
+
+	IWL_DEBUG_INFO(mvm, "Failed to %s eSR on link %d, reason %d\n",
+		       le32_to_cpu(notif->activation) ? "enter" : "exit",
+		       le32_to_cpu(notif->link_id),
+		       le32_to_cpu(notif->err_code));
+
+	/* we couldn't go back to single link, disconnect */
+	if (!le32_to_cpu(notif->activation)) {
+		iwl_mvm_connection_loss(mvm, vif, "emlsr exit failed");
+		return;
+	}
+
+	bss_conf = iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, fw_link_id, false);
+	if (IWL_FW_CHECK(mvm, !bss_conf,
+			 "FW reported failure to activate EMLSR on a non-existing link: %d\n",
+			 fw_link_id))
+		return;
+
+	/*
+	 * We failed to activate the second link and enter EMLSR, we need to go
+	 * back to single link.
+	 */
+	iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_FAIL_ENTRY,
+			 bss_conf->link_id);
+}
+
 static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 				     struct iwl_rx_cmd_buffer *rxb)
 {
@@ -486,6 +523,10 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(SCAN_GROUP, CHANNEL_SURVEY_NOTIF,
 		       iwl_mvm_rx_channel_survey_notif, RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_umac_scan_channel_survey_notif),
+	RX_HANDLER_GRP(MAC_CONF_GROUP, EMLSR_TRANS_FAIL_NOTIF,
+		       iwl_mvm_rx_esr_trans_fail_notif,
+		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
+		       struct iwl_esr_trans_fail_notif),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -616,6 +657,7 @@ static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
 	HCMD_NAME(STA_REMOVE_CMD),
 	HCMD_NAME(STA_DISABLE_TX_CMD),
 	HCMD_NAME(ROC_CMD),
+	HCMD_NAME(EMLSR_TRANS_FAIL_NOTIF),
 	HCMD_NAME(ROC_NOTIF),
 	HCMD_NAME(CHANNEL_SWITCH_ERROR_NOTIF),
 	HCMD_NAME(MISSED_VAP_NOTIF),
-- 
2.34.1


