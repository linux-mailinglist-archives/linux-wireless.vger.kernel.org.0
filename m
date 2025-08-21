Return-Path: <linux-wireless+bounces-26505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC780B2F8E6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E563B275D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84082322DA1;
	Thu, 21 Aug 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dbaq2M6J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC09322C95
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780314; cv=none; b=Lfss2qydu98LVZf9MWdkUM4an5OevlGVCjetg0ojoSPzgZWGAe5IwLZeo5XlE6whM1sLyoqrObiwYQVTkvz6cPXmDK4lRp+9Gw7zNUyOygICf3S/cbYRb3bUyhmrBMgziyk9jkOQuTFGKkwJJGxnbL8YRGyEus0smIZoBOkFnys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780314; c=relaxed/simple;
	bh=BVS7ifQTty7rEfbCKQiNT42Y1wFh6Fl7Rm95GfkPnbA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ts+VpJlgWt7DpxSoYe/FGG04MovXhgNqpBXTG5LD23BHWSTWGcVDwDdnESRfsVPHDSX/UfNwBa7ncSYy7W2/L4VKFcljUBO493EETf2N6cjPgdSyE1F/wJUkv57guC04lF+aYtSe+hRCbY+KTnFiowryIDXz7PeWjVVJgMFvGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dbaq2M6J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780313; x=1787316313;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=BVS7ifQTty7rEfbCKQiNT42Y1wFh6Fl7Rm95GfkPnbA=;
  b=Dbaq2M6J5MA0Gdb6Q7G6V72+xwiq5a+qsnTC0WuNzOdALlUUqnoB6Nmb
   V6tB/6ypvWYo6ASnHwpUlui8ZwrzSzAI1fUqPLxhQzIQmm0MGEi6s7oBd
   hLjbTdBmcAgSUaE3WeNtoPMmCM+d1jA0+lUmFOEXd6LUZ1MERODHYc/T9
   wD4I7+TXyCbmhgc9jU7KFsCpA+9tYiLBHQVNeEc/C+ppQsS1msVu8nrUR
   TW6k+5jIx+xkiRKH06IfuEGqC4CwPDjMfw0wY0RpYj3r+t6Haivatb/1P
   eZRFvBfQlcu09yYFcHeAbyqNc5WeYSwvxffvV6xKX6Wuifxx87W3QkiLt
   w==;
X-CSE-ConnectionGUID: S8eJr5nSRh2hDvZIhOC/qA==
X-CSE-MsgGUID: siD9tNNtTwiIjRWYYy6KRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895754"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895754"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:13 -0700
X-CSE-ConnectionGUID: l2/pxrFvTd6lK7zDngZcig==
X-CSE-MsgGUID: Q89bFh70RYqezJJRb2vH9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622198"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 10/15] Reapply "wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions"
Date: Thu, 21 Aug 2025 15:44:28 +0300
Message-Id: <20250821124433.2234183-4-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
References: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This reverts commit da75f183fea0 ("wifi: iwlwifi: Revert "wifi: iwlwifi:
remove support of several iwl_ppag_table_cmd versions"").

Now as we no longer support the FWs that required some old versions,
this can be reapplied.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 20 ++++---------------
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 20 ++++++-------------
 2 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 786b3bf4b448..ab84aac6605d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -571,8 +571,7 @@ enum iwl_ppag_flags {
 /**
  * union iwl_ppag_table_cmd - union for all versions of PPAG command
  * @v1: command version 1 structure.
- * @v2: command version from 2 to 6 are same structure as v2.
- *	but has a different format of the flags bitmap
+ * @v2: command version 5 structure.
  * @v3: command version 7 structure.
  * @v1.flags: values from &enum iwl_ppag_flags
  * @v1.gain: table of antenna gain values per chain and sub-band
@@ -593,9 +592,7 @@ union iwl_ppag_table_cmd {
 		__le32 flags;
 		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
 		s8 reserved[2];
-	} __packed v2; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_2, VER3, VER4,
-			* VER5, VER6
-			*/
+	} __packed v2; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_5 */
 	struct {
 		struct bios_value_u32 ppag_config_info;
 		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
@@ -603,20 +600,11 @@ union iwl_ppag_table_cmd {
 	} __packed v3; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_7 */
 } __packed;
 
-#define IWL_PPAG_CMD_V4_MASK (IWL_PPAG_ETSI_MASK | IWL_PPAG_CHINA_MASK)
-#define IWL_PPAG_CMD_V5_MASK (IWL_PPAG_CMD_V4_MASK | \
+#define IWL_PPAG_CMD_V1_MASK (IWL_PPAG_ETSI_MASK | IWL_PPAG_CHINA_MASK)
+#define IWL_PPAG_CMD_V5_MASK (IWL_PPAG_CMD_V1_MASK | \
 			      IWL_PPAG_ETSI_LPI_UHB_MASK | \
 			      IWL_PPAG_USA_LPI_UHB_MASK)
 
-#define IWL_PPAG_CMD_V6_MASK (IWL_PPAG_CMD_V5_MASK |		\
-			      IWL_PPAG_ETSI_VLP_UHB_MASK |	\
-			      IWL_PPAG_ETSI_SP_UHB_MASK |	\
-			      IWL_PPAG_USA_VLP_UHB_MASK |	\
-			      IWL_PPAG_USA_SP_UHB_MASK |	\
-			      IWL_PPAG_CANADA_LPI_UHB_MASK |	\
-			      IWL_PPAG_CANADA_VLP_UHB_MASK |	\
-			      IWL_PPAG_CANADA_SP_UHB_MASK)
-
 #define MCC_TO_SAR_OFFSET_TABLE_ROW_SIZE	26
 #define MCC_TO_SAR_OFFSET_TABLE_COL_SIZE	13
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 3d6d1a85bb51..80d8373fccfc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -344,18 +344,18 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
 		gain = cmd->v1.gain[0];
 		*cmd_size = sizeof(cmd->v1);
-		cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags);
+		cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags & IWL_PPAG_CMD_V1_MASK);
 		if (fwrt->ppag_bios_rev >= 1) {
 			/* in this case FW supports revision 0 */
 			IWL_DEBUG_RADIO(fwrt,
 					"PPAG table rev is %d, send truncated table\n",
 					fwrt->ppag_bios_rev);
 		}
-	} else if (cmd_ver >= 2 && cmd_ver <= 6) {
+	} else if (cmd_ver == 5) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 		gain = cmd->v2.gain[0];
 		*cmd_size = sizeof(cmd->v2);
-		cmd->v2.flags = cpu_to_le32(fwrt->ppag_flags);
+		cmd->v2.flags = cpu_to_le32(fwrt->ppag_flags & IWL_PPAG_CMD_V5_MASK);
 		if (fwrt->ppag_bios_rev == 0) {
 			/* in this case FW supports revisions 1,2 or 3 */
 			IWL_DEBUG_RADIO(fwrt,
@@ -378,17 +378,9 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 			"PPAG MODE bits were read from bios: %d\n",
 			fwrt->ppag_flags);
 
-	if (cmd_ver == 6)
-		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V6_MASK);
-	else if (cmd_ver == 5)
-		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V5_MASK);
-	else if (cmd_ver < 5)
-		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V4_MASK);
-
-	if ((cmd_ver == 1 &&
-	     !fw_has_capa(&fwrt->fw->ucode_capa,
-			  IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) ||
-	    (cmd_ver == 2 && fwrt->ppag_bios_rev >= 2)) {
+	if (cmd_ver == 1 &&
+	    !fw_has_capa(&fwrt->fw->ucode_capa,
+			 IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) {
 		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
 		IWL_DEBUG_RADIO(fwrt, "masking ppag China bit\n");
 	} else {
-- 
2.34.1


