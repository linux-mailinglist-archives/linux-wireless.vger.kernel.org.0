Return-Path: <linux-wireless+bounces-25816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E7B0D49C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CCA3A5E59
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8756C2D63FA;
	Tue, 22 Jul 2025 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btWjQTp5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25FE2C158F
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172976; cv=none; b=o0Dq5g5FPPu0mTg/vpffE61lLq9abCxMi0bWuuTBND5jz7of8alayMBF45wK1rOwtvIMKSnqCI2UcCt4IXjLaR+Cwp4vCB5Ygyxq/tku41DKvnL1zx3bdFb7D2NdEKZdFbQr4JdU+gYXvNpGg3Gv8e+5iRmRVUiVBOAIhM1FLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172976; c=relaxed/simple;
	bh=zyUe+Jwv9uVWMAxJuMxy8bUCZh1Fa/4xtntvkM4zu6I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ud1iAZII8vPJzg61LksVUiOqR3xF0L0C6XAttar6sM5VYkyjMhmikHtCyV0k8mhU07184YTvzBfWi/Q9SwRVW8Hv0AGqq2xO9xO8JHU4rEePmTgECX89cLlSjBjrjkbgfuI8+sfLYMmeAStWBWvKIcJC7Dn5xA8arRV5xgk7wmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btWjQTp5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172975; x=1784708975;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=zyUe+Jwv9uVWMAxJuMxy8bUCZh1Fa/4xtntvkM4zu6I=;
  b=btWjQTp5JbC/olWts6cP6zROaWHhjwaIElY1MKRKgOVBWeldCXYJvaOL
   VyujmWJ/qiLR36IyMUW9NpzhjLhGGut/pLRQgdTCx8+Tz6lf/WMcCb5kt
   sxl8gZAPINmY9aaIARjDszIBDamJKjP9QVo+15uaTXQ0XpaPb4Atv35/x
   DiKKNtvDP+qKGLNqMYngRRLqjpW0uy5LJJpx7fncn+etZY6bTDKpOI/Qp
   G5bYLNeo/VFXyzW97mzyEm7VnZujlYOwZKgaZQyEIJsUeYSYsapKS3yWP
   rVF7ux1BKOIoDA0rxodrX+B+/55XYH+BO73rUYKXqtK7vXg59POwxTy15
   Q==;
X-CSE-ConnectionGUID: IsPCOuY7TuCrb+pLkI191g==
X-CSE-MsgGUID: aTgB2rPCTrqgBSrILah+Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569818"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569818"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:34 -0700
X-CSE-ConnectionGUID: igoocUqtQbiAgUNvrx4fwA==
X-CSE-MsgGUID: QQgfwOW+TiWIL34rGDDAag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124231"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: make ppag versioning clear
Date: Tue, 22 Jul 2025 11:28:56 +0300
Message-Id: <20250722112718.54cb7d62c677.If7898bdf9ef70eed9c12484c03a3cc4f27635682@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
References: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We used to have in iwl_ppag_table_cmd v2, that covered multiple FW
versions of the command (2-6), so we just called it v2, and v3 for FW
version 7. This is a bit confusing, and now v2 actually covers only FW
version 5. Rename v2 to v5 and v3 to v7 so we don't have a different
versioning than the FW has.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 18 ++++++++---------
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 20 +++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index ab84aac6605d..5eb8d10678fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -571,16 +571,16 @@ enum iwl_ppag_flags {
 /**
  * union iwl_ppag_table_cmd - union for all versions of PPAG command
  * @v1: command version 1 structure.
- * @v2: command version 5 structure.
- * @v3: command version 7 structure.
+ * @v5: command version 5 structure.
+ * @v7: command version 7 structure.
  * @v1.flags: values from &enum iwl_ppag_flags
  * @v1.gain: table of antenna gain values per chain and sub-band
  * @v1.reserved: reserved
- * @v2.flags: values from &enum iwl_ppag_flags
- * @v2.gain: table of antenna gain values per chain and sub-band
- * @v3.ppag_config_info: see @struct bios_value_u32
- * @v3.gain: table of antenna gain values per chain and sub-band
- * @v3.reserved: reserved
+ * @v5.flags: values from &enum iwl_ppag_flags
+ * @v5.gain: table of antenna gain values per chain and sub-band
+ * @v7.ppag_config_info: see @struct bios_value_u32
+ * @v7.gain: table of antenna gain values per chain and sub-band
+ * @v7.reserved: reserved
  */
 union iwl_ppag_table_cmd {
 	struct {
@@ -592,12 +592,12 @@ union iwl_ppag_table_cmd {
 		__le32 flags;
 		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
 		s8 reserved[2];
-	} __packed v2; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_5 */
+	} __packed v5; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_5 */
 	struct {
 		struct bios_value_u32 ppag_config_info;
 		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
 		s8 reserved[2];
-	} __packed v3; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_7 */
+	} __packed v7; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_7 */
 } __packed;
 
 #define IWL_PPAG_CMD_V1_MASK (IWL_PPAG_ETSI_MASK | IWL_PPAG_CHINA_MASK)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 80d8373fccfc..00921f86286a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -353,9 +353,9 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		}
 	} else if (cmd_ver == 5) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
-		gain = cmd->v2.gain[0];
-		*cmd_size = sizeof(cmd->v2);
-		cmd->v2.flags = cpu_to_le32(fwrt->ppag_flags & IWL_PPAG_CMD_V5_MASK);
+		gain = cmd->v5.gain[0];
+		*cmd_size = sizeof(cmd->v5);
+		cmd->v5.flags = cpu_to_le32(fwrt->ppag_flags & IWL_PPAG_CMD_V5_MASK);
 		if (fwrt->ppag_bios_rev == 0) {
 			/* in this case FW supports revisions 1,2 or 3 */
 			IWL_DEBUG_RADIO(fwrt,
@@ -363,11 +363,11 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		}
 	} else if (cmd_ver == 7) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
-		gain = cmd->v3.gain[0];
-		*cmd_size = sizeof(cmd->v3);
-		cmd->v3.ppag_config_info.table_source = fwrt->ppag_bios_source;
-		cmd->v3.ppag_config_info.table_revision = fwrt->ppag_bios_rev;
-		cmd->v3.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags);
+		gain = cmd->v7.gain[0];
+		*cmd_size = sizeof(cmd->v7);
+		cmd->v7.ppag_config_info.table_source = fwrt->ppag_bios_source;
+		cmd->v7.ppag_config_info.table_revision = fwrt->ppag_bios_rev;
+		cmd->v7.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags);
 	} else {
 		IWL_DEBUG_RADIO(fwrt, "Unsupported PPAG command version\n");
 		return -EINVAL;
@@ -387,13 +387,13 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		IWL_DEBUG_RADIO(fwrt, "isn't masking ppag China bit\n");
 	}
 
-	/* The 'flags' field is the same in v1 and v2 so we can just
+	/* The 'flags' field is the same in v1 and v5 so we can just
 	 * use v1 to access it.
 	 */
 	IWL_DEBUG_RADIO(fwrt,
 			"PPAG MODE bits going to be sent: %d\n",
 			(cmd_ver < 7) ? le32_to_cpu(cmd->v1.flags) :
-					le32_to_cpu(cmd->v3.ppag_config_info.value));
+					le32_to_cpu(cmd->v7.ppag_config_info.value));
 
 	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
 		for (j = 0; j < num_sub_bands; j++) {
-- 
2.34.1


