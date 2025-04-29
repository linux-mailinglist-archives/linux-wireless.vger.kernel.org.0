Return-Path: <linux-wireless+bounces-22219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C32AA1BA4
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2867A809F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E0226158C;
	Tue, 29 Apr 2025 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFUmsJYq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B5267B96
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956467; cv=none; b=uMcG6PxBOM49Kf9tQ/E3Jd1L9P4PwCTCq8pW4M2St+ThlVSD9GGQlzCUBPrCHAlkEmVRuD7/+KI3FLzBAMYnrbiPoBEZqyMb1ikzoW96h2nS4bUNwL2ltj3IaEeznkFF1yU7Kro/lJmAf04TtRR+mqWiM8egd7LhZnUTiQ3pjn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956467; c=relaxed/simple;
	bh=QgA+IsgrOyY4nbCOzwqXC4kH+0KnQ9lDR9eozxnesvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKcT9Q0pmmZjyddPnzAIDAoP+Qq58f61l07nxgF3zLc047WgGGdpfdOiPpFvc22yavx8s0rTyZjsaTL+oBLzq/VPQ+zF/NGzLWTecGIqjIkiaLxk75mkbmS+y8Sz8pq0UNCedZPcUPl4aRxy9GOz2yy/OGVwoYb9SF7m6cXuHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFUmsJYq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956466; x=1777492466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QgA+IsgrOyY4nbCOzwqXC4kH+0KnQ9lDR9eozxnesvc=;
  b=aFUmsJYq891OpXHEFyxRqRaTpVbh7nR80acL8g2/8SIqUcANoQyaID7o
   NX1ZnLP52cjPpwVfRlYTD5W/Ai4vl8h6OYjZ8MM4lGuE9Rgmw7IDJMDZy
   FEWv5HHn0pPBwq5QIvf6M7jW5O6y8U+xHNqSK+HpNTAYyoeH0w5mWo+7A
   viulzsbKFK5FJwvyJYkGRw+EhSDVJLV4n58fVFxqGSmeks/sU5H/cIWFY
   eHE6wfsPQUAi4Z25ux02HsRTJuhVIpzuLiOCNFdkKqVe9QiuXxRTeA5Ir
   NQqj7ZVS/gRc8w/Wr9+hJGXdi1/qjonFOuNf7g95pCxImFoKAUtU1h9Ne
   A==;
X-CSE-ConnectionGUID: qVS2Eyd5QZWaIMP2FpG8sw==
X-CSE-MsgGUID: /WqswrIqS363kkINm5v51A==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713604"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713604"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:26 -0700
X-CSE-ConnectionGUID: BDHmxlQ8R+i/imoiSeEepQ==
X-CSE-MsgGUID: oplZ/JOCRpaMrkw+ORW4VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171155049"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 14/14] wifi: iwlwifi: fw: support PPAG command version 7
Date: Tue, 29 Apr 2025 22:53:44 +0300
Message-Id: <20250429224932.1f2fe524869c.Iad78f6cec617d1f111b704352795dde81af71a99@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

PPAG command version 7 will send exact data read from BIOS to
firmware without filtering/altering BIOS data. This enables the
driver to become purely a pipe for this feature.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  1 +
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 23 ++++++++++++++-----
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 22 ++++++++++++------
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  1 +
 5 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index a1c949d15d94..bee7d92293b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -912,6 +912,7 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 		}
 	}
 
+	fwrt->ppag_bios_source = BIOS_SOURCE_ACPI;
 	ret = 0;
 
 out_free:
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 1c09c30055b1..23140205ccb9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -7,6 +7,8 @@
 #ifndef __iwl_fw_api_power_h__
 #define __iwl_fw_api_power_h__
 
+#include "nvm-reg.h"
+
 /* Power Management Commands, Responses, Notifications */
 
 /**
@@ -629,28 +631,37 @@ enum iwl_ppag_flags {
 
 /**
  * union iwl_ppag_table_cmd - union for all versions of PPAG command
- * @v1: version 1
- * @v2: version 2
- * version 3, 4, 5 and 6 are the same structure as v2,
+ * @v1: command version 1 structure.
+ * @v2: command version from 2 to 6 are same structure as v2.
  *	but has a different format of the flags bitmap
+ * @v3: command version 7 structure.
  * @v1.flags: values from &enum iwl_ppag_flags
  * @v1.gain: table of antenna gain values per chain and sub-band
  * @v1.reserved: reserved
  * @v2.flags: values from &enum iwl_ppag_flags
  * @v2.gain: table of antenna gain values per chain and sub-band
- * @v2.reserved: reserved
+ * @v3.ppag_config_info: see @struct bios_value_u32
+ * @v3.gain: table of antenna gain values per chain and sub-band
+ * @v3.reserved: reserved
  */
 union iwl_ppag_table_cmd {
 	struct {
 		__le32 flags;
 		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V1];
 		s8 reserved[2];
-	} v1;
+	} __packed v1; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_1 */
 	struct {
 		__le32 flags;
 		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
 		s8 reserved[2];
-	} v2;
+	} __packed v2; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_2, VER3, VER4,
+			* VER5, VER6
+			*/
+	struct {
+		struct bios_value_u32 ppag_config_info;
+		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
+		s8 reserved[2];
+	} __packed v3; /* PER_PLAT_ANTENNA_GAIN_CMD_API_S_VER_7 */
 } __packed;
 
 #define IWL_PPAG_CMD_V4_MASK (IWL_PPAG_ETSI_MASK | IWL_PPAG_CHINA_MASK)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 4508de2508d7..4038de2df75e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -339,16 +339,12 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		return -EINVAL;
 	}
 
-	/* The 'flags' field is the same in v1 and in v2 so we can just
-	 * use v1 to access it.
-	 */
-	cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags);
-
 	IWL_DEBUG_RADIO(fwrt, "PPAG cmd ver is %d\n", cmd_ver);
 	if (cmd_ver == 1) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
 		gain = cmd->v1.gain[0];
 		*cmd_size = sizeof(cmd->v1);
+		cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags);
 		if (fwrt->ppag_bios_rev >= 1) {
 			/* in this case FW supports revision 0 */
 			IWL_DEBUG_RADIO(fwrt,
@@ -359,11 +355,19 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 		gain = cmd->v2.gain[0];
 		*cmd_size = sizeof(cmd->v2);
+		cmd->v2.flags = cpu_to_le32(fwrt->ppag_flags);
 		if (fwrt->ppag_bios_rev == 0) {
 			/* in this case FW supports revisions 1,2 or 3 */
 			IWL_DEBUG_RADIO(fwrt,
 					"PPAG table rev is 0, send padded table\n");
 		}
+	} else if (cmd_ver == 7) {
+		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
+		gain = cmd->v3.gain[0];
+		*cmd_size = sizeof(cmd->v3);
+		cmd->v3.ppag_config_info.table_source = fwrt->ppag_bios_source;
+		cmd->v3.ppag_config_info.table_revision = fwrt->ppag_bios_rev;
+		cmd->v3.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags);
 	} else {
 		IWL_DEBUG_RADIO(fwrt, "Unsupported PPAG command version\n");
 		return -EINVAL;
@@ -372,7 +376,7 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 	/* ppag mode */
 	IWL_DEBUG_RADIO(fwrt,
 			"PPAG MODE bits were read from bios: %d\n",
-			le32_to_cpu(cmd->v1.flags));
+			fwrt->ppag_flags);
 
 	if (cmd_ver == 6)
 		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V6_MASK);
@@ -391,9 +395,13 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		IWL_DEBUG_RADIO(fwrt, "isn't masking ppag China bit\n");
 	}
 
+	/* The 'flags' field is the same in v1 and v2 so we can just
+	 * use v1 to access it.
+	 */
 	IWL_DEBUG_RADIO(fwrt,
 			"PPAG MODE bits going to be sent: %d\n",
-			le32_to_cpu(cmd->v1.flags));
+			(cmd_ver < 7) ? le32_to_cpu(cmd->v1.flags) :
+					le32_to_cpu(cmd->v3.ppag_config_info.value));
 
 	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
 		for (j = 0; j < num_sub_bands; j++) {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 8ff85a243075..0444a736c2b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -112,6 +112,7 @@ struct iwl_txf_iter_data {
  * @geo_profiles: geographic profiles as read from WGDS BIOS table
  * @phy_filters: specific phy filters as read from WPFC BIOS table
  * @ppag_bios_rev: PPAG BIOS revision
+ * @ppag_bios_source: see &enum bios_source
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
@@ -181,6 +182,7 @@ struct iwl_fw_runtime {
 	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
 	u32 ppag_flags;
 	u8 ppag_bios_rev;
+	u8 ppag_bios_source;
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
 	struct iwl_mcc_allowed_ap_type_cmd uats_table;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 74b7984e8ebe..d31492035089 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -564,6 +564,7 @@ int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	BUILD_BUG_ON(sizeof(fwrt->ppag_chains) != sizeof(data->ppag_chains));
 	memcpy(&fwrt->ppag_chains, &data->ppag_chains,
 	       sizeof(data->ppag_chains));
+	fwrt->ppag_bios_source = BIOS_SOURCE_UEFI;
 out:
 	kfree(data);
 	return ret;
-- 
2.34.1


