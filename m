Return-Path: <linux-wireless+bounces-25907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68E3B0EAE7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DA95801C4
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7C27146A;
	Wed, 23 Jul 2025 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuP5QNr+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6D272E67
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253163; cv=none; b=DlK0U6ZmLgMCDWzqihGSLpEneo2H3VlNCNB7p45rWTjsLrDGoDSSZAfK2BWIdfztZ9hT5Ao0kJA99UW9etEXVF6wSDgGJUexfi/z1WklFvKoLbaKMbkz8OdO5RLf0VJMPC6qjxg1artMuODk1hJe9AYWzX353n/xeTLYcl8/8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253163; c=relaxed/simple;
	bh=C45N6RlwdV4lfdn8ZN4+yCnCVy2dzOFewUUeudmWiI0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gbj+sdJlFYACAOFBls+kDa1393sqoWYj/Dh7l1i87NOLKSHee4xYtmLvAnu9IJhxMoXTj1BXgnDsmg6kLbcFra3pGsLqAw4R3sIEGNXumXGVXn5MIK225ajHfaYHeqn+hzW8OptcWK+SByVSY74Az8nWaWH1lskea1zSUTw10c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuP5QNr+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253161; x=1784789161;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=C45N6RlwdV4lfdn8ZN4+yCnCVy2dzOFewUUeudmWiI0=;
  b=iuP5QNr+qKrKAvK+Lo8MUYEf4wWTz+5Ba2Y71X2GzJAsPHVp7QZoA4FY
   wnVrFwYBQCc+ZrlwXJ6m8KG5br1tJDlyjq91Jo3KwoSJfS5yAYzGUqqMK
   88Qed8+kpq7Unue3fQKSZZrqucxCpA6Kmpgwgqo80d0tELVNfQQHCY4Wx
   hSB35E1ZOn9UtsjRU4C+2WYqpXar+ijIoKrF4Ki12ulEsVUZqxmg0Mxx8
   X2vxn/gSwpMkYHNzdf6B8+LmKHvwzVGKyCHg7pTYN5WK4sE8u/mCERqRW
   XYbYqcb42qSmvbrv2pwGDAajQsSPreYJkxK2IWbMFqBiKhUdDCOa6y8VX
   Q==;
X-CSE-ConnectionGUID: WEZ/cUgAT+Kyc03dGvR6dg==
X-CSE-MsgGUID: TjkXMuR0QmeBKhd8UeqYrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340793"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340793"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:58 -0700
X-CSE-ConnectionGUID: ZeeH0jvuSL+KMNrFhyFOPg==
X-CSE-MsgGUID: yL1odJ6SRg2mJVFzFsQXSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918117"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 14/14] wifi: iwlwifi: Revert "wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions"
Date: Wed, 23 Jul 2025 09:45:15 +0300
Message-Id: <20250723064515.2084903-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
References: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

It turns out that version 6 is still needed.
This change will be brought back once the FW that supports version 6 will no
longer be supported.

This reverts commit 24bc49d158c7 ("wifi: iwlwifi: remove support of several
iwl_ppag_table_cmd versions")
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 20 +++++++++++++++----
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 20 +++++++++++++------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index ab84aac6605d..786b3bf4b448 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -571,7 +571,8 @@ enum iwl_ppag_flags {
 /**
  * union iwl_ppag_table_cmd - union for all versions of PPAG command
  * @v1: command version 1 structure.
- * @v2: command version 5 structure.
+ * @v2: command version from 2 to 6 are same structure as v2.
+ *	but has a different format of the flags bitmap
  * @v3: command version 7 structure.
  * @v1.flags: values from &enum iwl_ppag_flags
  * @v1.gain: table of antenna gain values per chain and sub-band
@@ -592,7 +593,9 @@ union iwl_ppag_table_cmd {
 		__le32 flags;
 		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
 		s8 reserved[2];
-	} __packed v2; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_5 */
+	} __packed v2; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_2, VER3, VER4,
+			* VER5, VER6
+			*/
 	struct {
 		struct bios_value_u32 ppag_config_info;
 		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
@@ -600,11 +603,20 @@ union iwl_ppag_table_cmd {
 	} __packed v3; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_7 */
 } __packed;
 
-#define IWL_PPAG_CMD_V1_MASK (IWL_PPAG_ETSI_MASK | IWL_PPAG_CHINA_MASK)
-#define IWL_PPAG_CMD_V5_MASK (IWL_PPAG_CMD_V1_MASK | \
+#define IWL_PPAG_CMD_V4_MASK (IWL_PPAG_ETSI_MASK | IWL_PPAG_CHINA_MASK)
+#define IWL_PPAG_CMD_V5_MASK (IWL_PPAG_CMD_V4_MASK | \
 			      IWL_PPAG_ETSI_LPI_UHB_MASK | \
 			      IWL_PPAG_USA_LPI_UHB_MASK)
 
+#define IWL_PPAG_CMD_V6_MASK (IWL_PPAG_CMD_V5_MASK |		\
+			      IWL_PPAG_ETSI_VLP_UHB_MASK |	\
+			      IWL_PPAG_ETSI_SP_UHB_MASK |	\
+			      IWL_PPAG_USA_VLP_UHB_MASK |	\
+			      IWL_PPAG_USA_SP_UHB_MASK |	\
+			      IWL_PPAG_CANADA_LPI_UHB_MASK |	\
+			      IWL_PPAG_CANADA_VLP_UHB_MASK |	\
+			      IWL_PPAG_CANADA_SP_UHB_MASK)
+
 #define MCC_TO_SAR_OFFSET_TABLE_ROW_SIZE	26
 #define MCC_TO_SAR_OFFSET_TABLE_COL_SIZE	13
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 80d8373fccfc..3d6d1a85bb51 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -344,18 +344,18 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
 		gain = cmd->v1.gain[0];
 		*cmd_size = sizeof(cmd->v1);
-		cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags & IWL_PPAG_CMD_V1_MASK);
+		cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags);
 		if (fwrt->ppag_bios_rev >= 1) {
 			/* in this case FW supports revision 0 */
 			IWL_DEBUG_RADIO(fwrt,
 					"PPAG table rev is %d, send truncated table\n",
 					fwrt->ppag_bios_rev);
 		}
-	} else if (cmd_ver == 5) {
+	} else if (cmd_ver >= 2 && cmd_ver <= 6) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 		gain = cmd->v2.gain[0];
 		*cmd_size = sizeof(cmd->v2);
-		cmd->v2.flags = cpu_to_le32(fwrt->ppag_flags & IWL_PPAG_CMD_V5_MASK);
+		cmd->v2.flags = cpu_to_le32(fwrt->ppag_flags);
 		if (fwrt->ppag_bios_rev == 0) {
 			/* in this case FW supports revisions 1,2 or 3 */
 			IWL_DEBUG_RADIO(fwrt,
@@ -378,9 +378,17 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 			"PPAG MODE bits were read from bios: %d\n",
 			fwrt->ppag_flags);
 
-	if (cmd_ver == 1 &&
-	    !fw_has_capa(&fwrt->fw->ucode_capa,
-			 IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) {
+	if (cmd_ver == 6)
+		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V6_MASK);
+	else if (cmd_ver == 5)
+		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V5_MASK);
+	else if (cmd_ver < 5)
+		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V4_MASK);
+
+	if ((cmd_ver == 1 &&
+	     !fw_has_capa(&fwrt->fw->ucode_capa,
+			  IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) ||
+	    (cmd_ver == 2 && fwrt->ppag_bios_rev >= 2)) {
 		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
 		IWL_DEBUG_RADIO(fwrt, "masking ppag China bit\n");
 	} else {
-- 
2.34.1


