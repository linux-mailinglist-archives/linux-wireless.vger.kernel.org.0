Return-Path: <linux-wireless+bounces-25290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932AFB0208E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D81C1895B1A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52C42ED177;
	Fri, 11 Jul 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVb6UXBP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571A2EE297
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248109; cv=none; b=bstzfimf9OwlS1FoaIdVulXZ/wH+tU+G7wupkWAxpwgyca8BGv+OI75GdwRpstQ30fXkxtb3czSPue4uVPNPm7CF0O0XLB3srqDEUbT8uexKRU3N8BYP5WjRmW+f8E21B8jwDniNz1MpLrNXhUGzuc5Chlbg/l0LmQglk0fslRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248109; c=relaxed/simple;
	bh=jxz6zXxxYTqkahZLLjMRFsxbtlSJneJdnNk5NaT20Gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYapomNWRv20W/64DWZPTo1vXEt2PyxaVkyvZh/5dLWzZv6FXGQdonURLmdMecPdS4eZYzKDin9/OVuLkKgnDxP8aiEZI39RtHAL/UNVu8mZFWnDfQ0TUIYtkAx0IMrskrsxDVXLGFnfyWZMLvRLhAiL2IR3WIjoQ9kZBVHsZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVb6UXBP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248109; x=1783784109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jxz6zXxxYTqkahZLLjMRFsxbtlSJneJdnNk5NaT20Gk=;
  b=kVb6UXBPPcWSKIk899J8s9l00tOq+dQW4s3V12ewy31ycm13l2DRgHQL
   jjfnOYkg/vjspmW+V5sPYtvrvqgkcRuj1cQJyZZw1GFcetF56n7J/noGq
   byez73MfZiLO71tDOQN1igdTz0v7875ANnEurQcgS9KqfNnXK/kOF+xmJ
   p+D33b7btvHZ8s34v2mrINCPK1zwXGilQ+wRLfyfKorlaubhjb7fkp4+l
   AqPPBfaRcK11fJxIW+CtSEccsSpR1XA/LOAHrJYlMyuGnrhJxQJAGjPlX
   MuU8quUbw8AYroYOlxZfIZh3uh/79qgClcYaKwLGzdYHwkxbMGV/cMhPW
   g==;
X-CSE-ConnectionGUID: tH03r0jeTK2aLn5JOkmU4w==
X-CSE-MsgGUID: vN1r0YonQEalLylMikyNCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264175"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264175"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:09 -0700
X-CSE-ConnectionGUID: 0n/QKom+QTykZvw8FIR/nA==
X-CSE-MsgGUID: TwJR8yjBRvKJKY5akh37xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485213"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions
Date: Fri, 11 Jul 2025 18:34:29 +0300
Message-Id: <20250711183056.10d91f675505.Idd3a6da568261ee738918f290168a2ddaa87196b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We only need to support version 1, 5 and 7.
Remove versions 2, 3, 4 and 6.

Reviewed-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
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


