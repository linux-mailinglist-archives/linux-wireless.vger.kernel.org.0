Return-Path: <linux-wireless+bounces-19949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2BA55953
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4C81897A39
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC627C84F;
	Thu,  6 Mar 2025 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1BZSS3d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF025C709
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298722; cv=none; b=H+nj7ca/0YdKiIcxxLxwxZKDo0bMm8SiQtYomLX0SYDwbclgY1Ry2pUuONbzkp0tdBEyBE0bm1d6RlMy6UbzZcPJXDsx2reqAu0MXJv+x7fhG6W/W9AqWBDRIsMelPhVBw5J23B5WBgN1cgSTqcA+6iyLGCThBCSFEV1Ds+NLVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298722; c=relaxed/simple;
	bh=Fdhe8LOAuCkCUmDReNXyM/ZFsBgc8ZmpMHkeGbiRBxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHTLQ2nH5QQtD1UHcsUh9d237X6a2b6Zanmh3GecIGsIZO7+t6pxC6N0z0wJ13C7zPOHv5xlLphcBwLHtfyJuz7mL4hp5HCr5HDc093CyXau2FP3iz2ZnD/wyy/dCtbGRVmMFM7S4VN90pogiEtpx2uxCZVReMntOegQbikq3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1BZSS3d; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298721; x=1772834721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fdhe8LOAuCkCUmDReNXyM/ZFsBgc8ZmpMHkeGbiRBxk=;
  b=l1BZSS3d6gwhTgGEYVq7p1/JdaUlkLDrTY5JHQ1Ih6Wdb//i64Uxw3Pf
   Ibc/TfC9vsD1Pn7dJzzMsuqgwHBEQtJxCv1mjnUi4oHsBHdUMCY9F8QyD
   kxwQTuL0eD81H9sxksWHpP8W60WjuaTwBFdUPrFCWSTD1IkQ3RRN37TyT
   sAze+g109Dh7T5vdfWaDymJ0OVHu7VshJxkxAv9rPyOxKw9A6+54gsAxw
   CByhKz81MN5WWVEmnv/XWxJkMhTTgttojHKeMV1WEkUBZp7zZ7VazRhRI
   1lg/D8PNPSLde4Oa+1nbLE1tpZkiDxmEMQBbHDPjTRmdva9YzjOiJIV4G
   Q==;
X-CSE-ConnectionGUID: +1d0a8AOQvWZG613evVU9g==
X-CSE-MsgGUID: Qicq68LIRkOT4dtt6sVXdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474262"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474262"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:18 -0800
X-CSE-ConnectionGUID: qjEeF1q6R/6A6uPm7QHFnw==
X-CSE-MsgGUID: KCYuk6QGRMmB0dok5spBqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061886"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH wireless-next 05/15] wifi: iwlwifi: mvm: cleanup of TAS structure and enums
Date: Fri,  7 Mar 2025 00:04:44 +0200
Message-Id: <20250307000213.b789036a734c.Ic2678dcb5afdacc2ca234d4aa4901e7e1f6e8dbb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Removed mvm prefix from the following structures and enum names:
1. struct iwl_tas_status_per_mac
2. struct iwl_tas_status_resp
3. enum iwl_tas_dyna_status
4. enum iwl_tas_statically_disabled_reason
As these structures and enums are not specific to mvm.

Replaced TAS_LMAC_BAND_LB, TAS_LMAC_BAND_HB, and TAS_LMAC_BAND_UHB macros
with a generic BAND macro, as these macros are not specific to TAS.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 39 ++++++++-----------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 28 +++++--------
 2 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index aa88e91d117e..e1b6795c1f64 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -51,7 +51,7 @@ enum iwl_debug_cmds {
 	/**
 	 * @GET_TAS_STATUS:
 	 * sends command to fw to get TAS status
-	 * the response is &struct iwl_mvm_tas_status_resp
+	 * the response is &struct iwl_tas_status_resp
 	 */
 	GET_TAS_STATUS = 0xA,
 	/**
@@ -439,25 +439,20 @@ struct iwl_dbg_dump_complete_cmd {
 	__le32 tp_data;
 } __packed; /* FW_DUMP_COMPLETE_CMD_API_S_VER_1 */
 
-#define TAS_LMAC_BAND_HB       0
-#define TAS_LMAC_BAND_LB       1
-#define TAS_LMAC_BAND_UHB      2
-#define TAS_LMAC_BAND_INVALID  3
-
 /**
- * struct iwl_mvm_tas_status_per_mac - tas status per lmac
+ * struct iwl_tas_status_per_mac - tas status per lmac
  * @static_status: tas statically enabled or disabled per lmac - TRUE/FALSE
  * @static_dis_reason: TAS static disable reason, uses
- *	&enum iwl_mvm_tas_statically_disabled_reason
+ *	&enum iwl_tas_statically_disabled_reason
  * @dynamic_status: Current TAS  status. uses
- *	&enum iwl_mvm_tas_dyna_status
+ *	&enum iwl_tas_dyna_status
  * @near_disconnection: is TAS currently near disconnection per lmac? - TRUE/FALSE
  * @max_reg_pwr_limit: Regulatory power limits in dBm
  * @sar_limit: SAR limits per lmac in dBm
  * @band: Band per lmac
  * @reserved: reserved
  */
-struct iwl_mvm_tas_status_per_mac {
+struct iwl_tas_status_per_mac {
 	u8 static_status;
 	u8 static_dis_reason;
 	u8 dynamic_status;
@@ -466,35 +461,35 @@ struct iwl_mvm_tas_status_per_mac {
 	__le16 sar_limit;
 	u8 band;
 	u8 reserved[3];
-} __packed; /*DEBUG_GET_TAS_STATUS_PER_MAC_S_VER_1*/
+} __packed; /* DEBUG_GET_TAS_STATUS_PER_MAC_S_VER_1 */
 
 /**
- * struct iwl_mvm_tas_status_resp - Response to GET_TAS_STATUS
+ * struct iwl_tas_status_resp - Response to GET_TAS_STATUS
  * @tas_fw_version: TAS FW version
  * @is_uhb_for_usa_enable: is UHB enabled in USA? - TRUE/FALSE
  * @curr_mcc: current mcc
  * @block_list: country block list
  * @tas_status_mac: TAS status per lmac, uses
- *	&struct iwl_mvm_tas_status_per_mac
+ *	&struct iwl_tas_status_per_mac
  * @in_dual_radio: is TAS in dual radio? - TRUE/FALSE
  * @uhb_allowed_flags: see &enum iwl_tas_uhb_allowed_flags.
  *	This member is valid only when fw has
  *	%IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT capability.
  * @reserved: reserved
  */
-struct iwl_mvm_tas_status_resp {
+struct iwl_tas_status_resp {
 	u8 tas_fw_version;
 	u8 is_uhb_for_usa_enable;
 	__le16 curr_mcc;
 	__le16 block_list[16];
-	struct iwl_mvm_tas_status_per_mac tas_status_mac[2];
+	struct iwl_tas_status_per_mac tas_status_mac[2];
 	u8 in_dual_radio;
 	u8 uhb_allowed_flags;
 	u8 reserved[2];
-} __packed; /*DEBUG_GET_TAS_STATUS_RSP_API_S_VER_3*/
+} __packed; /* DEBUG_GET_TAS_STATUS_RSP_API_S_VER_3 */
 
 /**
- * enum iwl_mvm_tas_dyna_status - TAS current running status
+ * enum iwl_tas_dyna_status - TAS current running status
  * @TAS_DYNA_INACTIVE: TAS status is inactive
  * @TAS_DYNA_INACTIVE_MVM_MODE: TAS is disabled due because FW is in MVM mode
  *	or is in softap mode.
@@ -507,7 +502,7 @@ struct iwl_mvm_tas_status_resp {
  * @TAS_DYNA_ACTIVE: TAS is currently active
  * @TAS_DYNA_STATUS_MAX: TAS status max value
  */
-enum iwl_mvm_tas_dyna_status {
+enum iwl_tas_dyna_status {
 	TAS_DYNA_INACTIVE,
 	TAS_DYNA_INACTIVE_MVM_MODE,
 	TAS_DYNA_INACTIVE_TRIGGER_MODE,
@@ -516,16 +511,16 @@ enum iwl_mvm_tas_dyna_status {
 	TAS_DYNA_ACTIVE,
 
 	TAS_DYNA_STATUS_MAX,
-}; /*_TAS_DYNA_STATUS_E*/
+};
 
 /**
- * enum iwl_mvm_tas_statically_disabled_reason - TAS statically disabled reason
+ * enum iwl_tas_statically_disabled_reason - TAS statically disabled reason
  * @TAS_DISABLED_DUE_TO_BIOS: TAS is disabled because TAS is disabled in BIOS
  * @TAS_DISABLED_DUE_TO_SAR_6DBM: TAS is disabled because SAR limit is less than 6 Dbm
  * @TAS_DISABLED_REASON_INVALID: TAS disable reason is invalid
  * @TAS_DISABLED_REASON_MAX: TAS disable reason max value
  */
-enum iwl_mvm_tas_statically_disabled_reason {
+enum iwl_tas_statically_disabled_reason {
 	TAS_DISABLED_DUE_TO_BIOS,
 	TAS_DISABLED_DUE_TO_SAR_6DBM,
 	TAS_DISABLED_REASON_INVALID,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 83e3c1160362..b453ad0000c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023, 2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -542,7 +542,7 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 					     size_t count, loff_t *ppos)
 {
 	struct iwl_mvm *mvm = file->private_data;
-	struct iwl_mvm_tas_status_resp *rsp = NULL;
+	struct iwl_tas_status_resp *rsp = NULL;
 	static const size_t bufsz = 1024;
 	char *buff, *pos, *endpos;
 	const char * const tas_dis_reason[TAS_DISABLED_REASON_MAX] = {
@@ -598,23 +598,19 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 
 	pos += scnprintf(pos, endpos - pos, "TAS Conclusion:\n");
 	for (i = 0; i < rsp->in_dual_radio + 1; i++) {
-		if (rsp->tas_status_mac[i].band != TAS_LMAC_BAND_INVALID &&
-		    rsp->tas_status_mac[i].dynamic_status & BIT(TAS_DYNA_ACTIVE)) {
+		if (rsp->tas_status_mac[i].dynamic_status &
+		    BIT(TAS_DYNA_ACTIVE)) {
 			pos += scnprintf(pos, endpos - pos, "\tON for ");
 			switch (rsp->tas_status_mac[i].band) {
-			case TAS_LMAC_BAND_HB:
+			case PHY_BAND_5:
 				pos += scnprintf(pos, endpos - pos, "HB\n");
 				break;
-			case TAS_LMAC_BAND_LB:
+			case PHY_BAND_24:
 				pos += scnprintf(pos, endpos - pos, "LB\n");
 				break;
-			case TAS_LMAC_BAND_UHB:
+			case PHY_BAND_6:
 				pos += scnprintf(pos, endpos - pos, "UHB\n");
 				break;
-			case TAS_LMAC_BAND_INVALID:
-				pos += scnprintf(pos, endpos - pos,
-						 "INVALID BAND\n");
-				break;
 			default:
 				pos += scnprintf(pos, endpos - pos,
 						 "Unsupported band (%d)\n",
@@ -668,20 +664,16 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 
 		pos += scnprintf(pos, endpos - pos, "TAS status for ");
 		switch (rsp->tas_status_mac[i].band) {
-		case TAS_LMAC_BAND_HB:
+		case PHY_BAND_5:
 			pos += scnprintf(pos, endpos - pos, "High band\n");
 			break;
-		case TAS_LMAC_BAND_LB:
+		case PHY_BAND_24:
 			pos += scnprintf(pos, endpos - pos, "Low band\n");
 			break;
-		case TAS_LMAC_BAND_UHB:
+		case PHY_BAND_6:
 			pos += scnprintf(pos, endpos - pos,
 					 "Ultra high band\n");
 			break;
-		case TAS_LMAC_BAND_INVALID:
-			pos += scnprintf(pos, endpos - pos,
-					 "INVALID band\n");
-			break;
 		default:
 			pos += scnprintf(pos, endpos - pos,
 					 "Unsupported band (%d)\n",
-- 
2.34.1


