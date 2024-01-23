Return-Path: <linux-wireless+bounces-2401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE583974C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2935B1F2CB71
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882381AC7;
	Tue, 23 Jan 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQpyFk3f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988661674
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033340; cv=none; b=CbGBxiFOF8WCtn/WdUu1zVY+NsJMjms1l7wl950rAG9InHPlNgeFXrUIXdsSblO0yadizXLA8FoSAlDs2irIvCPLb1ZlQPUrtL7jj+puJ77Z89K9K9DO2TNBDDP2WLGMT+56P1aFLvOfiURwVNTKxdv5bl3s2FH9+4WdxisF32U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033340; c=relaxed/simple;
	bh=YOed2LS5Dvtgn5FV/bP2TztOlDu+WRV1nWaE/Eb3NgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7GGuYl7A+uItIJaKlUGPk2fjnmSnJnWA5Kab8ljpIcLa6iaZPctxUzNrRws66644GmXomKWgdlkt3KyK3SyEr8a6HRkllik1a6Y15O+KhFLbvcQoSrNwcuupJZ+pUgwlR1Wi32htDwizdLpTVC+oCBXR1UnV23a6REUPi8yhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQpyFk3f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033339; x=1737569339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YOed2LS5Dvtgn5FV/bP2TztOlDu+WRV1nWaE/Eb3NgU=;
  b=fQpyFk3fQt+iZW1CDuUeoJnTR1ItPhVXU22Jl1h5vFwich6SWtY4Baq7
   VYJgl+kRq4BLBCRzI7QEvlwGzIL3qZUhLWH9iqTQS5olD4sebm3eleBE+
   TdMK0Ayiod+/mQkEQfmzNUwrT8r2u+TUCgNEGc4J9VzpjsvqS+J/Fq6kv
   fm6fqVOz5do7ywNjhBpB+m0fDhPhQ9RR2Nii+iu0pQmcpHEmr4zdEF+IG
   epNsQekclrWkarOFgNWpvGLswwzk0kKxOw37+AUh4Io3oFBaTs7ZI91Z4
   cNP920QGnSYwMxJkJvLVdaCCjlkIOvhvcdG0rJjWbzHGm92ILgZwIDvZj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501791"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501791"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666526"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: limit EHT 320 MHz MCS for STEP URM
Date: Tue, 23 Jan 2024 20:08:14 +0200
Message-Id: <20240123200528.02bae683b7fc.Id5efbb71d45da02c8c4e211d20396637ddd44da8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the STEP (the interface between MAC and PHY) is in URM
(a lower speed mode) then we cannot use 320 MHz MCS > 9.
Therefore, limit the MCS in our capabilities in this case.
Note that this also limits the TX/rate scaling since that
takes both TX and RX capabilities into account.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 5 +++++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      | 3 +++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 5 +++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 67c7cda073e8..8e6ce484db87 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1061,6 +1061,11 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			~IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
 	}
 
+	if (trans->step_urm) {
+		iftype_data->eht_cap.eht_mcs_nss_supp.bw._320.rx_tx_mcs11_max_nss = 0;
+		iftype_data->eht_cap.eht_mcs_nss_supp.bw._320.rx_tx_mcs13_max_nss = 0;
+	}
+
 	if (trans->no_160)
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &=
 			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index dd32c287b983..c1c7d44f421b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -374,6 +374,9 @@ enum {
 #define CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR	0xA29938
 #define CNVI_SCU_SEQ_DATA_DW9				0xA27488
 
+#define CNVI_PMU_STEP_FLOW				0xA2D588
+#define CNVI_PMU_STEP_FLOW_FORCE_URM			BIT(2)
+
 #define PREG_AUX_BUS_WPROT_0		0xA04CC0
 
 /* device family 9000 WPROT register */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9867e29a56ff..fccd05b46df5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1070,6 +1070,7 @@ struct iwl_trans_txqs {
  * @invalid_tx_cmd: invalid TX command buffer
  * @reduced_cap_sku: reduced capability supported SKU
  * @no_160: device not supporting 160Mhz
+ * @step_urm: STEP is in URM, no support for MCS>9 in 320 MHz
  */
 struct iwl_trans {
 	bool csme_own;
@@ -1093,7 +1094,8 @@ struct iwl_trans {
 	char hw_id_str[52];
 	u32 sku_id[3];
 	bool reduced_cap_sku;
-	u8 no_160;
+	u8 no_160:1, step_urm:1;
+
 	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
 
 	bool pm_support;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1252084662c6..b6acf4ade552 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -677,6 +677,11 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
 			       NULL);
 
+	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ)
+		mvm->trans->step_urm = !!(iwl_read_umac_prph(mvm->trans,
+							     CNVI_PMU_STEP_FLOW) &
+						CNVI_PMU_STEP_FLOW_FORCE_URM);
+
 	/* Send init config command to mark that we are sending NVM access
 	 * commands
 	 */
-- 
2.34.1


