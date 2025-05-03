Return-Path: <linux-wireless+bounces-22369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE3DAA8259
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19169189CFC2
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF8427EC78;
	Sat,  3 May 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zno8fqfU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C627E7FA
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301495; cv=none; b=n0roo/L6x41SDPC9MjW2PrY8EyeUzyiuHl1gVvhNe2m8ejV5qseHAOopoMT/UCrZNSi2ejAIQxUuqynvLWocOl5C7iGIGvWMo9C1alrz1e5mDrGKweHGVwvgz6u62w4pliZoF/AaAj4EwK7gHtNY2/gbWL76VdWdJUTMvAv/FPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301495; c=relaxed/simple;
	bh=0e3woT+ENeZB9jvv5PHwMTB9XtfM41LrXl0kD4U/Jvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e9URPKTPf3DfSCMDivt4INty0uvMrwuTehfWgR8UP4sRwQJfH/5MHoSk3YWRYcDB8/4fH1kHgrAr6Vo4Ixb/sPOiExEc7TDZnANgh72apTivBNqheWJmdyrNb8qBv/M9biKW7p+Xk4Mq8v+GVzQDA8Vv5ihcG2K/9rtpqwi1pWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zno8fqfU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301493; x=1777837493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0e3woT+ENeZB9jvv5PHwMTB9XtfM41LrXl0kD4U/Jvg=;
  b=Zno8fqfUwpdGvhzlmagb4nHezX0mAalpB61WLkXNUpmPqPcwV5V7LV6a
   SRsvJO0h8X5oN8yjm+MFnMq0/cX/rhLzMG48hie0/PMw60Z65NZc3f/s8
   yKlocKij84M1M4epN7pZ/Ma8WI8TXTtfWx5FnZ5SE43smh7oBeNs2UNPL
   Qfygerekli/IrOzSPnmwogdKIQULlP0l+oLLdCPL8PjK3u/qx6BHuoAD0
   uCd2Jl53OSzFZVMJjHmClpvXzj8RC6WBgkgAy7L6mXyNewEndcPNhvDWR
   TLoSLYh2ZHsEV/4dmaV9Nxd8PwacgHVvgnIaRwK5bIUo6AsSrXA+RCkkR
   A==;
X-CSE-ConnectionGUID: reYawWJIQW6xK287nFG+lA==
X-CSE-MsgGUID: aIEXWOqARTGUtJSyD3UUMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613258"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613258"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:53 -0700
X-CSE-ConnectionGUID: leSxfU4sRPStaNcizF91VA==
X-CSE-MsgGUID: cZoPzm0kSumOefJy5eUuWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644255"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: pcie: move ME check data to pcie
Date: Sat,  3 May 2025 22:44:21 +0300
Message-Id: <20250503224231.0b74726b2651.I2c6bff6945b9288eadf242895906ab1c2cb76389@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
References: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no reason for this data to be in the generic transport
struct, so move it to pcie.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  6 -----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 23 +++++++++++--------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  6 +++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  5 ++--
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 7dae61fb8f15..e956fcd89821 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -885,9 +885,6 @@ struct iwl_txq {
  * @restart.wk: restart worker
  * @restart.mode: reset/restart error mode information
  * @restart.during_reset: error occurred during previous software reset
- * @me_recheck_wk: worker to recheck WiAMT/CSME presence
- * @me_present: WiAMT/CSME is detected as present (1), not present (0)
- *	or unknown (-1, so can still use it as a boolean safely)
  * @trans_specific: data for the specific transport this is allocated for/with
  * @dsbr_urm_fw_dependent: switch to URM based on fw settings
  * @dsbr_urm_permanent: switch to URM permanently
@@ -973,9 +970,6 @@ struct iwl_trans {
 		bool during_reset;
 	} restart;
 
-	struct delayed_work me_recheck_wk;
-	s8 me_present;
-
 	u8 request_top_reset:1,
 	   do_top_reset:1;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 6bb7de8c43fe..27023baa6565 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1719,21 +1719,23 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_pci_find_dev_info);
 
 static void iwl_pcie_recheck_me_status(struct work_struct *wk)
 {
-	struct iwl_trans *trans = container_of(wk, typeof(*trans),
-					       me_recheck_wk.work);
+	struct iwl_trans_pcie *trans_pcie = container_of(wk,
+							 typeof(*trans_pcie),
+							 me_recheck_wk.work);
 	u32 val;
 
-	val = iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
-	trans->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
+	val = iwl_read32(trans_pcie->trans, CSR_HW_IF_CONFIG_REG);
+	trans_pcie->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
 }
 
 static void iwl_pcie_check_me_status(struct iwl_trans *trans)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 val;
 
-	trans->me_present = -1;
+	trans_pcie->me_present = -1;
 
-	INIT_DELAYED_WORK(&trans->me_recheck_wk,
+	INIT_DELAYED_WORK(&trans_pcie->me_recheck_wk,
 			  iwl_pcie_recheck_me_status);
 
 	/* we don't have a good way of determining this until BZ */
@@ -1742,7 +1744,7 @@ static void iwl_pcie_check_me_status(struct iwl_trans *trans)
 
 	val = iwl_read_prph(trans, CNVI_SCU_REG_FOR_ECO_1);
 	if (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN) {
-		trans->me_present =
+		trans_pcie->me_present =
 			!!(val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT);
 		return;
 	}
@@ -1750,12 +1752,12 @@ static void iwl_pcie_check_me_status(struct iwl_trans *trans)
 	val = iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
 	if (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
 		   CSR_HW_IF_CONFIG_REG_IAMT_UP)) {
-		trans->me_present = 1;
+		trans_pcie->me_present = 1;
 		return;
 	}
 
 	/* recheck again later, ME might still be initializing */
-	schedule_delayed_work(&trans->me_recheck_wk, HZ);
+	schedule_delayed_work(&trans_pcie->me_recheck_wk, HZ);
 }
 
 static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1904,11 +1906,12 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 static void iwl_pci_remove(struct pci_dev *pdev)
 {
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	if (!trans)
 		return;
 
-	cancel_delayed_work_sync(&trans->me_recheck_wk);
+	cancel_delayed_work_sync(&trans_pcie->me_recheck_wk);
 
 	iwl_drv_stop(trans->drv);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index c0a670994ce7..2cf2936dbf2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -420,6 +420,9 @@ struct iwl_pcie_txqs {
  * @isr_stats: interrupt statistics
  * @napi_dev: (fake) netdev for NAPI registration
  * @txqs: transport tx queues data.
+ * @me_present: WiAMT/CSME is detected as present (1), not present (0)
+ *	or unknown (-1, so can still use it as a boolean safely)
+ * @me_recheck_wk: worker to recheck WiAMT/CSME presence
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
@@ -519,6 +522,9 @@ struct iwl_trans_pcie {
 	char rf_name[32];
 
 	struct iwl_pcie_txqs txqs;
+
+	s8 me_present;
+	struct delayed_work me_recheck_wk;
 };
 
 static inline struct iwl_trans_pcie *
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 904922581b42..547adc45f164 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2348,6 +2348,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
 
 void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_trans_pcie_removal *removal;
 	char _msg = 0, *msg = &_msg;
 
@@ -2358,9 +2359,9 @@ void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode)
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return;
 
-	if (trans->me_present && mode == IWL_RESET_MODE_PROD_RESET) {
+	if (trans_pcie->me_present && mode == IWL_RESET_MODE_PROD_RESET) {
 		mode = IWL_RESET_MODE_FUNC_RESET;
-		if (trans->me_present < 0)
+		if (trans_pcie->me_present < 0)
 			msg = " instead of product reset as ME may be present";
 		else
 			msg = " instead of product reset as ME is present";
-- 
2.34.1


