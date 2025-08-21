Return-Path: <linux-wireless+bounces-26537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E15B4B3016A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E187E1CC7E75
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E308343D87;
	Thu, 21 Aug 2025 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOFD2xoe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B9343D76
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798486; cv=none; b=lN45lzgcZBI4hPgRoiBQ0DOVNKKimEAJ1hCmDJZPhWLgAVV+2hGwZI1Hot+8KZd/HJLNkCqaBvdXXV1MvQoKExbBAKceEAJZHJQ22qTBH0InniLDjO8NlfILxXsPf7iJJ/+dj1Cq28m85a5Jro/74+ksAT0+f+q82oX4aSXjum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798486; c=relaxed/simple;
	bh=BVS7ifQTty7rEfbCKQiNT42Y1wFh6Fl7Rm95GfkPnbA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlxqoZBlO8m0fG3ndHaKlJ8OP/sQE5fndOvJ1AGib+N6wwRTyc7TtMfy2V1sB0U1Mcj7cDd6atlq4yZYn1L2yp1Y+YX76avbSz8W7RuZCJ/UjOshsKEz2i+0w7eotSv4m8YTi0y8ZvQEzvrsO7TaH87xCzw6kj8qAian61Omov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOFD2xoe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798484; x=1787334484;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=BVS7ifQTty7rEfbCKQiNT42Y1wFh6Fl7Rm95GfkPnbA=;
  b=QOFD2xoeAjmS3KWc2xck9/Qw9pnZU2GGzpgQbEEEvoBQWOfrKp0+8+m5
   dOv/JLNz1WAjeOCED3NH0zrjcd6frvKYQCxImgAQ4+T65sTbPNBxrO+T3
   2zajCaA8MgYZ3q3i8QxKWa+pFLCAfRhsm2HD9otbimXfFOO/6yq8+RGaz
   uNWgEwC5gde2RO6mAVsRHn/K3mJYbeoyL2LQYuvunZKY681GoPZ5d3/pq
   21GqtpPx5tL9oiBjypfz2CNS6a6NOKOK62zZlRV2g3EFWp/gGvuzefcby
   X9mU5JWzi2C7TpqK2L1owj/lWB/RujkGwzazzAtvrOZ9CS44CWM2YDWuX
   g==;
X-CSE-ConnectionGUID: OwwzhiR1StyAaf5fDhGxPg==
X-CSE-MsgGUID: Lqng0eEKSh6sTDOZmTQSMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806079"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806079"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:04 -0700
X-CSE-ConnectionGUID: 32b5kfzwQ/2qJKD/d6UjhA==
X-CSE-MsgGUID: /e2e68FfQoacHGk67Aj6xw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 10/15] Reapply "wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions"
Date: Thu, 21 Aug 2025 20:47:21 +0300
Message-Id: <20250821174726.2425334-4-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
References: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
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


