Return-Path: <linux-wireless+bounces-25780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C84B0D06D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49059543E2A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA02B1876;
	Tue, 22 Jul 2025 03:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGp4GaNi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A205234
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155710; cv=none; b=lgv+Qp9oJkFaCqb473ulxb4iwBsAn0YfP9IOXf299pOAbASquKS2ZSON8L4WOk8wUO0wusN+rdJ5Q7yfVecrgvPSlwauBI1zW4tHRUtytP2xjZPBxkH+uINIn65/ezdrzhxVPhOsRCMTMYxeD9kDTDzata+7DvyVMX4QT300eeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155710; c=relaxed/simple;
	bh=zyUe+Jwv9uVWMAxJuMxy8bUCZh1Fa/4xtntvkM4zu6I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gA3bpJ4NFHDOXeu29vjqITbP2VluS4D+EOgv6K7puJQL2tkdydqA9igjSddtGanNcRuTTWon5tG3u1xY9kF952aG7NVZODf9dOfpQ4AlUWIB1vrRqL8qlm1Karfado74W1TVAwds9QWPJ/dKxn6KUcH0pBUhVu4X2hLIoCbiiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGp4GaNi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155709; x=1784691709;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=zyUe+Jwv9uVWMAxJuMxy8bUCZh1Fa/4xtntvkM4zu6I=;
  b=DGp4GaNiC/uesRkSCsmzLo2sJj/GeqhB3nMmGiLrQgQiAyfDTXQjZZ9f
   M8cIJcB39BPQaK+mSfY6xT10nwTLCcpFNX8Ad6xH3mFiFYdNl/MIKjtf8
   AuqwS+z5Jw5c9waN9WULae+A7ASibZ4ZtHv8XF2CsKuxWiRF0CIWGXpnr
   5Ujw7zGLsyd0kJ53K0Sao4pYeQpmXaYni8apDc8wpEFrJsnmb0L1GI7p6
   uKMATgviKZA4TMiuoy9tVhQhxnNtWWQa3sg1RAHqTFdVgSm4Vko6NiE5i
   CBWYG8caQz2y+lAA/jO/poblEaTrtbdkosGdMH98tZ88NrX1CmFW+VLqO
   g==;
X-CSE-ConnectionGUID: eaVoonFsTy2Wb8jNzbBgNg==
X-CSE-MsgGUID: Ljd0MTfdTVaUxUbDI0Vh7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006150"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006150"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:48 -0700
X-CSE-ConnectionGUID: SBbAMv+eTXS3QYJCoppGWQ==
X-CSE-MsgGUID: P/oMHCK5S9+peLT0lURJew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338047"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: make ppag versioning clear
Date: Tue, 22 Jul 2025 06:41:11 +0300
Message-Id: <20250722063923.54cb7d62c677.If7898bdf9ef70eed9c12484c03a3cc4f27635682@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
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


