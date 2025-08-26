Return-Path: <linux-wireless+bounces-26647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1834DB36F12
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 17:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5517ABE67
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E0350D54;
	Tue, 26 Aug 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpqsN8Kh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C23164DB
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223753; cv=none; b=uktxaPLyTR2y1lzJVKD2lP+ixJ/bqNcWoIYVRPzdooXDa4hR2OaIiHvXj/XxXfStJOrHFNB2UpmTZi/m8mub2sruXAgNPvP6hD+KIw2bREr0mpYAJWAR7036LAyp50fJ/Y2LujYKH0EOXf5rHaBRNF66xX0a9g2g2Q54r68RNQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223753; c=relaxed/simple;
	bh=rkkSSYEZvJSnFZJVM568BkeOcRndW6Sr31YrMhIH1FA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADiBHjabp+dSNqwb9xKNht3DQTnw/SbdH806ohIbKOV1n5Q+vmEr0SHlO5eMVV/0nzueJsICDgoGg/HKRSwywz1vHD+lpMTjztVj6dw4BMA4q7bWIqdigfI9NmKkVmiRfYfyc7zy8Xy7WrO3AZ6BgCxRsrogdRPCfEdm4NzFr40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpqsN8Kh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223751; x=1787759751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rkkSSYEZvJSnFZJVM568BkeOcRndW6Sr31YrMhIH1FA=;
  b=FpqsN8KhgwVXopu4zn1tFQ8sdnhU4Q04+7vTWAPT42ATE4k2YX1zIvgP
   n1OsQYD7FYA18/ShkLSDyTCfJURcg0CZoi+IyQiyhDSpAUGvWFvGnD9Z4
   xNp0Z3/fDsVlLfYJ6Juvk21vN/bcVTIBzhN3OtVgciF87+TcxpXwiQ4P4
   ECqgkhKaq+uetv2Kxge5Jz+1k/CtS3HTE3fDA5lIhyFRxDsF/8P7VB/mO
   9Spk7bFdOwW66adIa8IKWrluqoJk0Ke4DKwB+Kcdo/L8SZOgFRRicGzjc
   jXaodIOA+WZRoHlPSHOO6DIyuKLQj8kIJ8Wa8oBzOLXmIgunYP6JysimN
   g==;
X-CSE-ConnectionGUID: wMJM572QQMKz1vfu4UR8xw==
X-CSE-MsgGUID: 9HoIwfQPSKum8vQGvgik4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108428"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108428"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:43 -0700
X-CSE-ConnectionGUID: o5FMwvbvTomKOugS/egJ9Q==
X-CSE-MsgGUID: BMjHOX1cSYuYsV57W+a+oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218310"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: trans: remove d3 test code
Date: Tue, 26 Aug 2025 18:54:59 +0300
Message-Id: <20250826184046.4742846b17ed.I08c70ac544364d68baae03f830b1e01ce702b06d@changeid>
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

This is no longer needed. Remove it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  8 ++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  6 +--
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  4 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 37 +++++--------------
 7 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 0771a46bd552..f1a39169eb4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -378,7 +378,7 @@ static int iwlagn_mac_suspend(struct ieee80211_hw *hw,
 	iwl_write32(priv->trans, CSR_UCODE_DRV_GP1_SET,
 		    CSR_UCODE_DRV_GP1_BIT_D3_CFG_COMPLETE);
 
-	iwl_trans_d3_suspend(priv->trans, false, true);
+	iwl_trans_d3_suspend(priv->trans, true);
 
 	goto out;
 
@@ -451,7 +451,7 @@ static int iwlagn_mac_resume(struct ieee80211_hw *hw)
 	/* we'll clear ctx->vif during iwlagn_prepare_restart() */
 	vif = ctx->vif;
 
-	ret = iwl_trans_d3_resume(priv->trans, &d3_status, false, true);
+	ret = iwl_trans_d3_resume(priv->trans, &d3_status, true);
 	if (ret)
 		goto out_unlock;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 3694b41d6621..c5944e9fa6c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -507,13 +507,13 @@ iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
 					sanitize_ops, sanitize_ctx);
 }
 
-int iwl_trans_d3_suspend(struct iwl_trans *trans, bool test, bool reset)
+int iwl_trans_d3_suspend(struct iwl_trans *trans, bool reset)
 {
 	int err;
 
 	might_sleep();
 
-	err = iwl_trans_pcie_d3_suspend(trans, test, reset);
+	err = iwl_trans_pcie_d3_suspend(trans, reset);
 
 	if (!err)
 		set_bit(STATUS_SUSPENDED, &trans->status);
@@ -523,13 +523,13 @@ int iwl_trans_d3_suspend(struct iwl_trans *trans, bool test, bool reset)
 IWL_EXPORT_SYMBOL(iwl_trans_d3_suspend);
 
 int iwl_trans_d3_resume(struct iwl_trans *trans, enum iwl_d3_status *status,
-			bool test, bool reset)
+			bool reset)
 {
 	int err;
 
 	might_sleep();
 
-	err = iwl_trans_pcie_d3_resume(trans, status, test, reset);
+	err = iwl_trans_pcie_d3_resume(trans, status, reset);
 
 	clear_bit(STATUS_SUSPENDED, &trans->status);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 52f4a09c740f..b7e2355ece30 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -952,10 +952,10 @@ int iwl_trans_start_fw(struct iwl_trans *trans, const struct iwl_fw *fw,
 
 void iwl_trans_stop_device(struct iwl_trans *trans);
 
-int iwl_trans_d3_suspend(struct iwl_trans *trans, bool test, bool reset);
+int iwl_trans_d3_suspend(struct iwl_trans *trans, bool reset);
 
 int iwl_trans_d3_resume(struct iwl_trans *trans, enum iwl_d3_status *status,
-			bool test, bool reset);
+			bool reset);
 
 struct iwl_trans_dump_data *
 iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index dd8764029581..aad944f8ab02 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1211,7 +1211,7 @@ static int iwl_mld_wait_d3_notif(struct iwl_mld *mld,
 					   iwl_mld_handle_d3_notif,
 					   resume_data);
 
-	ret = iwl_trans_d3_resume(mld->trans, &d3_status, false, false);
+	ret = iwl_trans_d3_resume(mld->trans, &d3_status, false);
 	if (ret || d3_status != IWL_D3_STATUS_ALIVE) {
 		if (d3_status != IWL_D3_STATUS_ALIVE) {
 			IWL_INFO(mld, "Device was reset during suspend\n");
@@ -1272,7 +1272,7 @@ int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld)
 		goto out;
 	}
 
-	ret = iwl_trans_d3_suspend(mld->trans, false, false);
+	ret = iwl_trans_d3_suspend(mld->trans, false);
 	if (ret) {
 		IWL_ERR(mld, "d3 suspend: trans_d3_suspend failed %d\n", ret);
 	} else {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 9b1e96f1767f..d22ee06ff2c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1361,7 +1361,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 	clear_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status);
 
-	ret = iwl_trans_d3_suspend(mvm->trans, false, !unified_image);
+	ret = iwl_trans_d3_suspend(mvm->trans, !unified_image);
  out:
 	if (ret < 0) {
 		iwl_mvm_free_nd(mvm);
@@ -2992,7 +2992,7 @@ static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm)
 	bool reset = fw_has_capa(&mvm->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 
-	ret = iwl_trans_d3_resume(mvm->trans, &d3_status, false, !reset);
+	ret = iwl_trans_d3_resume(mvm->trans, &d3_status, !reset);
 	if (ret)
 		return ret;
 
@@ -3255,7 +3255,7 @@ void iwl_mvm_fast_suspend(struct iwl_mvm *mvm)
 		IWL_ERR(mvm,
 			"fast suspend: couldn't send D3_CONFIG_CMD %d\n", ret);
 
-	ret = iwl_trans_d3_suspend(mvm->trans, false, false);
+	ret = iwl_trans_d3_suspend(mvm->trans, false);
 	if (ret)
 		IWL_ERR(mvm, "fast suspend: trans_d3_suspend failed %d\n", ret);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index eca524c6a9f3..b6ff9d62fab7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1065,8 +1065,8 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 			 void *sanitize_ctx);
 int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 			     enum iwl_d3_status *status,
-			     bool test,  bool reset);
-int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test, bool reset);
+			     bool reset);
+int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool reset);
 void iwl_trans_pci_interrupts(struct iwl_trans *trans, bool enable);
 void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans);
 void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 3e50a935e1d0..ff0979d0b8b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1437,17 +1437,10 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq)
 }
 
 static void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
-					 bool test, bool reset)
+					 bool reset)
 {
 	iwl_disable_interrupts(trans);
 
-	/*
-	 * in testing mode, the host stays awake and the
-	 * hardware won't be reset (not even partially)
-	 */
-	if (test)
-		return;
-
 	iwl_pcie_disable_ict(trans);
 
 	iwl_pcie_synchronize_irqs(trans);
@@ -1518,7 +1511,7 @@ static int iwl_pcie_d3_handshake(struct iwl_trans *trans, bool suspend)
 	return ret;
 }
 
-int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test, bool reset)
+int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool reset)
 {
 	int ret;
 
@@ -1531,26 +1524,19 @@ int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test, bool reset)
 	if (ret)
 		return ret;
 
-	iwl_pcie_d3_complete_suspend(trans, test, reset);
+	iwl_pcie_d3_complete_suspend(trans, reset);
 
 	return 0;
 }
 
 int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 			     enum iwl_d3_status *status,
-			     bool test,  bool reset)
+			     bool reset)
 {
 	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 val;
 	int ret;
 
-	if (test) {
-		iwl_enable_interrupts(trans);
-		*status = IWL_D3_STATUS_ALIVE;
-		ret = 0;
-		goto out;
-	}
-
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
@@ -1594,18 +1580,15 @@ int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 			iwl_read_umac_prph(trans, WFPM_GP2));
 
 	val = iwl_read32(trans, CSR_RESET);
-	if (val & CSR_RESET_REG_FLAG_NEVO_RESET)
+	if (val & CSR_RESET_REG_FLAG_NEVO_RESET) {
 		*status = IWL_D3_STATUS_RESET;
-	else
-		*status = IWL_D3_STATUS_ALIVE;
-
-out:
-	if (*status == IWL_D3_STATUS_ALIVE)
-		ret = iwl_pcie_d3_handshake(trans, false);
-	else
 		trans->state = IWL_TRANS_NO_FW;
+	} else {
+		*status = IWL_D3_STATUS_ALIVE;
+		return iwl_pcie_d3_handshake(trans, false);
+	}
 
-	return ret;
+	return 0;
 }
 
 static void
-- 
2.34.1


