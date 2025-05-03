Return-Path: <linux-wireless+bounces-22377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831B2AA8261
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F071617D8E2
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF861862;
	Sat,  3 May 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTJRozph"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382427EC7C
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301511; cv=none; b=lP6MdtaUo2O67A4z524n4uE07W+LmrDQryQ873pIrmHc48F3rMjOU/JfJTZg7h9rAVzqrrwaKxY8EsQTTPRxndxrdi0dH673oJxlXwaMkbGapEoaqR0NWBfo4OxmMInIxiDyCD6XDuNGqu4rP61BiRmJhjORDLfWbYcXU5B4rpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301511; c=relaxed/simple;
	bh=35l6DVrho25JOp11o4Foto3YcEx5GkQKRQ0iVG0Mbn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlG2Ptfq5thmUK8r+6AZhuGeWnceIMT9p20Pe+1Ctmcf/hH7TI1kdPTKnK0Tj3SgSMbk8QODfBVx3xW0IZ/99FV+6ElUOhYNbL5ntSBPaGjmobEQ/75RjZU3BPqJWaPrGU4zKM1UpnAZjJBRc/94Mxh0arzEzDc5c/jtT8PwA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTJRozph; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301509; x=1777837509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=35l6DVrho25JOp11o4Foto3YcEx5GkQKRQ0iVG0Mbn8=;
  b=OTJRozphbla8LjFNjMe7wnOEoQXlgcw7RoZMSd0LrYtlMXwNksoQb/X0
   fB4LaJLqoj7F1GoU3utE6vFsO6mL3roP9ezky9jJ+xQPHm8tAl8YGOUdL
   eSFixPiKg2BOYGj6l4zVfws2D3s5889PZBlOjhQDmAfeKWI1VRGtfhlE8
   9gOWVvKwBpQ7B/RtyEcWJfDj7FPA0s0P9OI5JCVMd0rmRmBKa5fDMpMIu
   zKAgw7UeKBYF5W5b16BEXmg9qboklj7Hvy+b7D31ZEuEjzVOONMkLJKv5
   zz/rnqUEQYcYyL9IxuIdX+XqvZwlohetlexiA27tOm4DrIhoONkm2LGT0
   w==;
X-CSE-ConnectionGUID: xvHg1X2JTLKn0bsH5emVPg==
X-CSE-MsgGUID: M1hp6SkvTBOtRpIz9i8YtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613267"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613267"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:09 -0700
X-CSE-ConnectionGUID: MDrBgEizTiK0vmAc3gnAIA==
X-CSE-MsgGUID: W7IlLcA9Qi6uMGKB513A5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644341"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: trans: remove hw_wfpm_id
Date: Sat,  3 May 2025 22:44:29 +0300
Message-Id: <20250503224232.4dfa2ae2a844.I46466f2523d8760e93228cd9a93c112d371e002d@changeid>
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

We only need to have this during init in PCIe, so can
just re-read the value. Do that and don't store it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c  | 16 +++++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 627afd27e23b..548cee430bbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -820,7 +820,6 @@ struct iwl_txq {
  * @hw_rf_id: a u32 with the device RF ID
  * @hw_cnv_id: a u32 with the device CNV ID
  * @hw_crf_id: a u32 with the device CRF ID
- * @hw_wfpm_id: a u32 with the device wfpm ID
  * @hw_id: a u32 with the ID of the device / sub-device.
  *	Set during transport allocation.
  * @sku_id: the SKU identifier (for PNVM matching)
@@ -884,7 +883,6 @@ struct iwl_trans {
 	u32 hw_rf_id;
 	u32 hw_crf_id;
 	u32 hw_cnv_id;
-	u32 hw_wfpm_id;
 	u32 hw_id;
 	u32 sku_id[3];
 	bool reduced_cap_sku;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 27023baa6565..e2c5ec091533 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1520,6 +1520,7 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table_size);
 static void get_crf_id(struct iwl_trans *iwl_trans)
 {
 	u32 sd_reg_ver_addr;
+	u32 hw_wfpm_id;
 	u32 val = 0;
 	u8 step;
 
@@ -1562,11 +1563,10 @@ static void get_crf_id(struct iwl_trans *iwl_trans)
 	}
 
 	/* Read cdb info (also contains the jacket info if needed in the future */
-	iwl_trans->hw_wfpm_id =
-		iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
+	hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
 	IWL_INFO(iwl_trans, "Detected crf-id 0x%x, cnv-id 0x%x wfpm id 0x%x\n",
 		 iwl_trans->hw_crf_id, iwl_trans->hw_cnv_id,
-		 iwl_trans->hw_wfpm_id);
+		 hw_wfpm_id);
 }
 
 /*
@@ -1579,9 +1579,11 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 	u32 val = iwl_trans->hw_crf_id;
 	u32 step_id = REG_CRF_ID_STEP(val);
 	u32 slave_id = REG_CRF_ID_SLAVE(val);
-	u32 jacket_id_cnv  = REG_CRF_ID_SLAVE(iwl_trans->hw_cnv_id);
-	u32 jacket_id_wfpm  = WFPM_OTP_CFG1_IS_JACKET(iwl_trans->hw_wfpm_id);
-	u32 cdb_id_wfpm  = WFPM_OTP_CFG1_IS_CDB(iwl_trans->hw_wfpm_id);
+	u32 jacket_id_cnv = REG_CRF_ID_SLAVE(iwl_trans->hw_cnv_id);
+	u32 hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans,
+						    WFPM_OTP_CFG1_ADDR);
+	u32 jacket_id_wfpm = WFPM_OTP_CFG1_IS_JACKET(hw_wfpm_id);
+	u32 cdb_id_wfpm = WFPM_OTP_CFG1_IS_CDB(hw_wfpm_id);
 
 	/* Map between crf id to rf id */
 	switch (REG_CRF_ID_TYPE(val)) {
@@ -1641,7 +1643,7 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 		 REG_CRF_ID_TYPE(val), step_id, slave_id, iwl_trans->hw_rf_id);
 	IWL_INFO(iwl_trans,
 		 "Detected cdb-id 0x%x jacket-id 0x%x from wfpm id 0x%x\n",
-		 cdb_id_wfpm, jacket_id_wfpm, iwl_trans->hw_wfpm_id);
+		 cdb_id_wfpm, jacket_id_wfpm, hw_wfpm_id);
 	IWL_INFO(iwl_trans, "Detected jacket-id 0x%x from cnvi id 0x%x\n",
 		 jacket_id_cnv, iwl_trans->hw_cnv_id);
 
-- 
2.34.1


