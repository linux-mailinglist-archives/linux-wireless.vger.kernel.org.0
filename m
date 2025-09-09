Return-Path: <linux-wireless+bounces-27120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE33B49FEF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B711B2468E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1C7265CA7;
	Tue,  9 Sep 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiNbNlRc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC27D515
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388119; cv=none; b=VIAVyIIlMayrIJR2kTxEaKWcilSQjyuB1GLMcMJF4h2pD/2diOzNHAlwsdg8g/eY2X9ZgkbwoaHcywLWZFPgghYUZxiCBjRY8pHWT7gonp1jD/zHzq4iowHk/uea0ZKCM/QuqUmqGNOOGQOQ2oi00hM99fPKX2Rb3Vq4ByFI1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388119; c=relaxed/simple;
	bh=7Evz+ny2QIoXFXpRrBgQdSRP15ZA0Rq8ekvCtpojYJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjDgnFR0vlErvIJRYYlcEmnwh7lrU0yZBmSQSRR+w2Fh7nXTnfkpzGxyQcCjmzqsnervcSt6kH2Z2gNtDotva5ACYXcRCGnCGtmUY7vjrSgYSfqQidAEvhT1yWqtbqZnsrpme6Oa1LcUuI3ok/yp45IZGw8K+3Q7SDEuLgZyDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiNbNlRc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388118; x=1788924118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Evz+ny2QIoXFXpRrBgQdSRP15ZA0Rq8ekvCtpojYJU=;
  b=JiNbNlRcYHR90k7SZKIvMWlo6MmJLTIhkXvhY9HVPYTpspD5GJVKVXSS
   4RMGVsjBv9pamKrHxd9LJLL1Z50xegEgnuhfFyfHmCzPknNuvMcZdhhVu
   ArcANIURWHSzEvEGWICwar/3jOEv3i953kzoitusj8AEfyVan7nb2SQ/F
   roaVI6TFUWmE+6B+WGvI7eqfQomOqyNU8iX72Kygwk67TNwE3uC3clBsx
   pBebpIWs3QIffiuNZORDHA5J3c7BuCKm2GqYFC7oy7XI87DEQOQa3IuWy
   Ce89vS1jcupkca2FcO82tTun7D5UFvwCfsdLNNmTn7a0Ne7sbzCC/Iapv
   A==;
X-CSE-ConnectionGUID: 2zK8stbuTYGuEQt7rwFMkQ==
X-CSE-MsgGUID: v/jpsN6AQpqnDkmgFOgwMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281050"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:21:57 -0700
X-CSE-ConnectionGUID: YEwEl4xmRg27n7PoQ9sxFQ==
X-CSE-MsgGUID: FamICVFDSCyq5bYzTQNYkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950289"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:21:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH v2 iwlwifi-next 01/15] wifi: iwlwifi: add STATUS_FW_ERROR API
Date: Tue,  9 Sep 2025 06:21:14 +0300
Message-Id: <20250909061931.23f5160b3265.Iba325ffa4c6c6f7fc3a702fb6c1827b0857d0db3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Rotem Kerem <rotem.kerem@intel.com>

Add iwl_trans_notify_fw_error() and iwl_trans_is_fw_error() for use by
op modes. These helpers provide a clean interface for marking and
checking firmware error state. This hides the trans internal
implementation details from callers.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 14 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |  6 ++----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  5 ++---
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |  2 +-
 5 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 10d016308d77..2ce55859641c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -830,7 +830,7 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 	}
 
 	/* reading RXF/TXF sizes */
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status)) {
+	if (iwl_trans_is_fw_error(fwrt->trans)) {
 		fifo_len = iwl_fw_rxf_len(fwrt, mem_cfg);
 		fifo_len += iwl_fw_txf_len(fwrt, mem_cfg);
 
@@ -3116,7 +3116,7 @@ static void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
 		.len[0] = sizeof(hcmd_data),
 	};
 
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
+	if (iwl_trans_is_fw_error(fwrt->trans))
 		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9f09629e2ac5..b9e41b8e2f15 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1209,6 +1209,20 @@ static inline bool iwl_trans_is_dead(struct iwl_trans *trans)
 	return test_bit(STATUS_TRANS_DEAD, &trans->status);
 }
 
+static inline bool iwl_trans_is_fw_error(struct iwl_trans *trans)
+{
+	return test_bit(STATUS_FW_ERROR, &trans->status);
+}
+
+/*
+ * This function notifies the transport layer of firmware error, the recovery
+ * will be handled by the op mode
+ */
+static inline void iwl_trans_notify_fw_error(struct iwl_trans *trans)
+{
+	trans->state = IWL_TRANS_NO_FW;
+	set_bit(STATUS_FW_ERROR, &trans->status);
+}
 /*****************************************************
  * PCIe handling
  *****************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 8cd9d61a92e8..f10732d31242 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1213,8 +1213,7 @@ static int iwl_mld_wait_d3_notif(struct iwl_mld *mld,
 	ret = iwl_trans_d3_resume(mld->trans, false);
 	if (ret) {
 		/* Avoid sending commands if the FW is dead */
-		mld->trans->state = IWL_TRANS_NO_FW;
-		set_bit(STATUS_FW_ERROR, &mld->trans->status);
+		iwl_trans_notify_fw_error(mld->trans);
 		iwl_remove_notification(&mld->notif_wait, &wait_d3_notif);
 		return ret;
 	}
@@ -1267,8 +1266,7 @@ int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld)
 	if (ret) {
 		IWL_ERR(mld, "d3 suspend: trans_d3_suspend failed %d\n", ret);
 		/* We are going to stop the FW. Avoid sending commands in that flow */
-		mld->trans->state = IWL_TRANS_NO_FW;
-		set_bit(STATUS_FW_ERROR, &mld->trans->status);
+		iwl_trans_notify_fw_error(mld->trans);
 	} else {
 		/* Async notification might send hcmds, which is not allowed in suspend */
 		iwl_mld_cancel_async_notifications(mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 38832f5e4068..431504195e33 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3102,7 +3102,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm)
 
 	rt_status = iwl_mvm_check_rt_status(mvm, vif);
 	if (rt_status != FW_ALIVE) {
-		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
+		iwl_trans_notify_fw_error(mvm->trans);
 		if (rt_status == FW_ERROR) {
 			IWL_ERR(mvm, "FW Error occurred during suspend. Restarting.\n");
 			iwl_mvm_dump_nic_error_log(mvm);
@@ -3272,7 +3272,7 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 
 	rt_status = iwl_mvm_check_rt_status(mvm, NULL);
 	if (rt_status != FW_ALIVE) {
-		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
+		iwl_trans_notify_fw_error(mvm->trans);
 		if (rt_status == FW_ERROR) {
 			IWL_ERR(mvm,
 				"iwl_mvm_check_rt_status failed, device is gone during suspend\n");
@@ -3284,7 +3284,6 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 						&iwl_dump_desc_assert,
 						false, 0);
 		}
-		mvm->trans->state = IWL_TRANS_NO_FW;
 		ret = -ENODEV;
 
 		goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index cda7c51b307c..f281d91475b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -3539,7 +3539,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 	struct iwl_trans_dump_data *dump_data;
 	u32 len, num_rbs = 0, monitor_len = 0;
 	int i, ptr;
-	bool dump_rbs = test_bit(STATUS_FW_ERROR, &trans->status) &&
+	bool dump_rbs = iwl_trans_is_fw_error(trans) &&
 			!trans->mac_cfg->mq_rx_supported &&
 			dump_mask & BIT(IWL_FW_ERROR_DUMP_RB);
 
-- 
2.34.1


