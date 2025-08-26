Return-Path: <linux-wireless+bounces-26649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A112FB36F62
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65984466592
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085AE314A98;
	Tue, 26 Aug 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSK0IvBe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2D34F48A
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223753; cv=none; b=cefoL1fQOUQpiKbuPUmKcN39QgwDnlLH4NuxMKQPuqZb/7Y8eqyQpTbzToGJbBbQEMxzRVM+KxsVZZk7KaIjKPGIKH8wWAFfiWlvPdAIKzHrVNdP7chzJnGKjUhbSctuiVVLY2t3w9Tj5P3RWUeauT/ShTVfqQPwKKl6UMr5jSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223753; c=relaxed/simple;
	bh=bdH+n81bt6YmeNY3r9P/BFPJxM22cD7PrknwiT71hqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iXJr1sucuRBS5iIMf5/+HFT3XfOgPi4r2YCwmGgZjBH+BYSREdktR2YNvOKJa5FRHYrd60Qs6cqOH4978Eul67IImxvWZxvDoRw9FV1XeNRVFmcnqxQN6GAHzdgRTud956Nxki6dPhF04EehKUPRwU3dtFUnvLm3Y/bF9tab600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSK0IvBe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223752; x=1787759752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bdH+n81bt6YmeNY3r9P/BFPJxM22cD7PrknwiT71hqU=;
  b=HSK0IvBek/Lni/dH2TmIKxUJnpVMiywRgXMNhoTBcKOF8kmVhiVHB0Nq
   +igJEr0M1ugX0NxmS2I/b8cW+TmhWs8UMoNetMe1QDa/7u4EIS9WUypj7
   1vwkv+EW68L1IaZujCe2ZXT3ucScF5xtpKDFcJPAg5O5Ge1azKBszw42l
   0xb0brYUZlvKsiM5uHNldAcATde1yEVCqj9vZM0xBFK4lvPVwfwPnqswq
   RXBsWdM2xFLT+MRB80rmUA8RplRngOi4Y/0B+B87rGILy4AZl2YfOr0CG
   1nwjnRXSBNS6NZJk+oCa6iZEvUSME7WNRyOJTFM4hXF+Ih4sL7kK3zAyo
   w==;
X-CSE-ConnectionGUID: qhlcW3bgRHuooec5KuIGSQ==
X-CSE-MsgGUID: XFT4vBTeSI+ArHfSxHlNeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108435"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108435"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:46 -0700
X-CSE-ConnectionGUID: FB/W0h/gSWCzNAGXbe/gIQ==
X-CSE-MsgGUID: CZ5asecXQmOJpSOynsVk1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218338"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: simplify iwl_trans_pcie_d3_resume
Date: Tue, 26 Aug 2025 18:55:01 +0300
Message-Id: <20250826184046.5fa2d909c75d.Ida19d8d8d73eddf12b30f1d473ea675f415778b2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If iwl_trans_d3_resume succeeded but the hw requested a reset, this will
be indicated to the opmode via the iwl_d3_status parameter while the return
value will be 0.

But the opmode doesn't really care if the resume failed or if a restart
is required. It acts the same in both cases (beside different logs, but
this can be done in iwl_trans_pcie_d3_resume)

This complicates the code for no good reason.

Change the iwl_trans_pcie_d3_resume to return an error value also in the
case that everything went successfully but a restart is required,
and add more logs so we can differentiate between the cases.

This makes iwl_d3_status redundant. Remove it as well.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |  8 +-------
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  5 ++---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 13 +------------
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        | 11 ++---------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  8 +-------
 .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h  |  1 -
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 14 +++++++-------
 7 files changed, 14 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index f1a39169eb4d..a0a26ef482a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -422,7 +422,6 @@ static int iwlagn_mac_resume(struct ieee80211_hw *hw)
 	struct ieee80211_vif *vif;
 	u32 base;
 	int ret;
-	enum iwl_d3_status d3_status;
 	struct error_table_start {
 		/* cf. struct iwl_error_event_table */
 		u32 valid;
@@ -451,15 +450,10 @@ static int iwlagn_mac_resume(struct ieee80211_hw *hw)
 	/* we'll clear ctx->vif during iwlagn_prepare_restart() */
 	vif = ctx->vif;
 
-	ret = iwl_trans_d3_resume(priv->trans, &d3_status, true);
+	ret = iwl_trans_d3_resume(priv->trans, true);
 	if (ret)
 		goto out_unlock;
 
-	if (d3_status != IWL_D3_STATUS_ALIVE) {
-		IWL_INFO(priv, "Device was reset during suspend\n");
-		goto out_unlock;
-	}
-
 	/* uCode is no longer operating by itself */
 	iwl_write32(priv->trans, CSR_UCODE_DRV_GP1_CLR,
 		    CSR_UCODE_DRV_GP1_BIT_D3_CFG_COMPLETE);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index d68a820c3d48..a19ffff2fffb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -510,12 +510,11 @@ int iwl_trans_d3_suspend(struct iwl_trans *trans, bool reset)
 }
 IWL_EXPORT_SYMBOL(iwl_trans_d3_suspend);
 
-int iwl_trans_d3_resume(struct iwl_trans *trans, enum iwl_d3_status *status,
-			bool reset)
+int iwl_trans_d3_resume(struct iwl_trans *trans, bool reset)
 {
 	might_sleep();
 
-	return iwl_trans_pcie_d3_resume(trans, status, reset);
+	return iwl_trans_pcie_d3_resume(trans, reset);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_d3_resume);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 0fca6992ec5b..b0bf88a889b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -274,16 +274,6 @@ static inline void iwl_free_rxb(struct iwl_rx_cmd_buffer *r)
 #define IWL_MAX_RX_HW_QUEUES	16
 #define IWL_9000_MAX_RX_HW_QUEUES	1
 
-/**
- * enum iwl_d3_status - WoWLAN image/device status
- * @IWL_D3_STATUS_ALIVE: firmware is still running after resume
- * @IWL_D3_STATUS_RESET: device was reset while suspended
- */
-enum iwl_d3_status {
-	IWL_D3_STATUS_ALIVE,
-	IWL_D3_STATUS_RESET,
-};
-
 /**
  * enum iwl_trans_status: transport status flags
  * @STATUS_SYNC_HCMD_ACTIVE: a SYNC command is being processed
@@ -951,8 +941,7 @@ void iwl_trans_stop_device(struct iwl_trans *trans);
 
 int iwl_trans_d3_suspend(struct iwl_trans *trans, bool reset);
 
-int iwl_trans_d3_resume(struct iwl_trans *trans, enum iwl_d3_status *status,
-			bool reset);
+int iwl_trans_d3_resume(struct iwl_trans *trans, bool reset);
 
 struct iwl_trans_dump_data *
 iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index aad944f8ab02..5d24292c45a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1195,7 +1195,6 @@ static int iwl_mld_wait_d3_notif(struct iwl_mld *mld,
 		WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION)
 	};
 	struct iwl_notification_wait wait_d3_notif;
-	enum iwl_d3_status d3_status;
 	int ret;
 
 	if (with_wowlan)
@@ -1211,14 +1210,8 @@ static int iwl_mld_wait_d3_notif(struct iwl_mld *mld,
 					   iwl_mld_handle_d3_notif,
 					   resume_data);
 
-	ret = iwl_trans_d3_resume(mld->trans, &d3_status, false);
-	if (ret || d3_status != IWL_D3_STATUS_ALIVE) {
-		if (d3_status != IWL_D3_STATUS_ALIVE) {
-			IWL_INFO(mld, "Device was reset during suspend\n");
-			ret = -ENOENT;
-		} else {
-			IWL_ERR(mld, "Transport resume failed\n");
-		}
+	ret = iwl_trans_d3_resume(mld->trans, false);
+	if (ret) {
 		iwl_remove_notification(&mld->notif_wait, &wait_d3_notif);
 		return ret;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index d22ee06ff2c9..38832f5e4068 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2984,7 +2984,6 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm)
 {
 	int ret;
-	enum iwl_d3_status d3_status;
 	struct iwl_host_cmd cmd = {
 		.id = D0I3_END_CMD,
 		.flags = CMD_WANT_SKB,
@@ -2992,15 +2991,10 @@ static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm)
 	bool reset = fw_has_capa(&mvm->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 
-	ret = iwl_trans_d3_resume(mvm->trans, &d3_status, !reset);
+	ret = iwl_trans_d3_resume(mvm->trans, !reset);
 	if (ret)
 		return ret;
 
-	if (d3_status != IWL_D3_STATUS_ALIVE) {
-		IWL_INFO(mvm, "Device was reset during suspend\n");
-		return -ENOENT;
-	}
-
 	/*
 	 * We should trigger resume flow using command only for 22000 family
 	 * AX210 and above don't need the command since they have
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index b6ff9d62fab7..54b978830043 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1064,7 +1064,6 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 			 const struct iwl_dump_sanitize_ops *sanitize_ops,
 			 void *sanitize_ctx);
 int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
-			     enum iwl_d3_status *status,
 			     bool reset);
 int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool reset);
 void iwl_trans_pci_interrupts(struct iwl_trans *trans, bool enable);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index ff0979d0b8b0..0946ea223e46 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1530,7 +1530,6 @@ int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool reset)
 }
 
 int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
-			     enum iwl_d3_status *status,
 			     bool reset)
 {
 	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -1545,8 +1544,11 @@ int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 			    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
 	ret = iwl_finish_nic_init(trans);
-	if (ret)
+	if (ret) {
+		IWL_ERR(trans, "Failed to init nic upon resume. err = %d\n",
+			ret);
 		return ret;
+	}
 
 	/*
 	 * Reconfigure IVAR table in case of MSIX or reset ict table in
@@ -1581,14 +1583,12 @@ int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 
 	val = iwl_read32(trans, CSR_RESET);
 	if (val & CSR_RESET_REG_FLAG_NEVO_RESET) {
-		*status = IWL_D3_STATUS_RESET;
+		IWL_INFO(trans, "Device was reset during suspend\n");
 		trans->state = IWL_TRANS_NO_FW;
-	} else {
-		*status = IWL_D3_STATUS_ALIVE;
-		return iwl_pcie_d3_handshake(trans, false);
+		return -ENOENT;
 	}
 
-	return 0;
+	return iwl_pcie_d3_handshake(trans, false);
 }
 
 static void
-- 
2.34.1


