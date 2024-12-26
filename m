Return-Path: <linux-wireless+bounces-16813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3C9FCBA7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0161418832B5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B949659;
	Thu, 26 Dec 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILGh7c3/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA713E028
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227926; cv=none; b=BcoxSbpHmSfNV0cB8AxbWi0ZlNep7pKWIn54uYQWe6k5qn7sZKgfBER3aH3kwhCwxvQcQRMZe08D9HG/zKsGTDvE8ip/LGD8bcqpwDBeFp1imytE8bMAaTrvk5Jfc4H2eznPCj20EVT9tv8WhwfcCKd7iXhU+6mECNC/8wKd4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227926; c=relaxed/simple;
	bh=KOSvsdu91QMZ39cvGBgSPyYOOVAV3RYMEYrbxEwZRMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8PaIzS0ELXVWIm0By9wV9eE3yYMHM2S6nq2QkaPvdUaqmIWohi+RC9EnLcNrUKqQ6dbTCnpAFfPDOHHxlCriooi3W1jT0tdEyobxPWk4Ixl/PaDyseOUQOZt9Q+tnBiPQssGbv36N2YA2DNdMXA+MSxSBn/QYZn7x94BSf9cO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILGh7c3/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227924; x=1766763924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KOSvsdu91QMZ39cvGBgSPyYOOVAV3RYMEYrbxEwZRMo=;
  b=ILGh7c3/qkdj7oiQOG3cqITtHwpWJq8b7Q4N04i8CMPj4RGbrWXgluiN
   Actjxmb4b+eLC0DLsQCcKbCBbIyQYw7Exbv4UPb2jqBCq82B+EEf1PxG+
   68zv6+ouKH5qOginFfzLOQiGWMSWIeEoETaXoeUQ4G+4/bnU3CCu1G91I
   8D05rVZSZMkZlh9xycwvKcC6oKOtY7ALM2p2ThsnNy1Lt4W4Kw2k6BnPF
   1wWcuCEPTiIKG9zNq7f3jTXBeBZFR8hT5EO3uZ+MTQ4vGelwMioDS0/rr
   cxt22/7KUX3mSAvECR9Z6cOvPpfgX6GUAalqU7ctf08eve+TygqGep/Yn
   g==;
X-CSE-ConnectionGUID: UrJ+eK8xSNKNnyylqp41Jw==
X-CSE-MsgGUID: 7JJT7LwMQkKqMQctj0wdmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878147"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878147"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:23 -0800
X-CSE-ConnectionGUID: Xc3AXcGUTo6CTSEz+rsx5w==
X-CSE-MsgGUID: BfA9BLodTeGOIaU2NY1eMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99777995"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: support BIOS override for 5G9 in CA also in LARI version 8
Date: Thu, 26 Dec 2024 17:44:49 +0200
Message-Id: <20241226174257.dc5836f84514.I1e38f94465a36731034c94b9811de10cb6ee5921@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Commit 6b3e87cc0ca5 ("iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD
cmd v9")
added a few bits to iwl_lari_config_change_cmd::oem_unii4_allow_bitmap
if the FW has LARI version >= 9.
But we also need to send those bits for version 8 if the FW is capable
of this feature (indicated with capability bits)
Add the FW capability bit, and set the additional bits in the cmd when
the version is 8 and the FW capability bit is set.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |  3 +++
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 14 ++++++++++----
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h | 11 +++++------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 784667830816..f5fbe7692f6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -398,6 +398,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  * @IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT: Support secure LTF measurement.
  * @IWL_UCODE_TLV_CAPA_MONITOR_PASSIVE_CHANS: Support monitor mode on otherwise
  *	passive channels
+ * @IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA: supports (de)activating 5G9
+ *	for CA from BIOS.
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -498,6 +500,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)117,
 	IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT		= (__force iwl_ucode_tlv_capa_t)121,
 	IWL_UCODE_TLV_CAPA_MONITOR_PASSIVE_CHANS	= (__force iwl_ucode_tlv_capa_t)122,
+	IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA	= (__force iwl_ucode_tlv_capa_t)123,
 	NUM_IWL_UCODE_TLV_CAPA
 /*
  * This construction make both sparse (which cannot increment the previous
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 5e655adce926..4b5eeff4a140 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -552,10 +552,16 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
 	if (!ret) {
-		if (cmd_ver < 9)
-			value &= DSM_UNII4_ALLOW_BITMAP_CMD_V8;
-		else
-			value &= DSM_UNII4_ALLOW_BITMAP;
+		value &= DSM_UNII4_ALLOW_BITMAP;
+
+		/* Since version 9, bits 4 and 5 are supported
+		 * regardless of this capability.
+		 */
+		if (cmd_ver < 9 &&
+		    !fw_has_capa(&fwrt->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA))
+			value &= ~(DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK |
+				   DSM_VALUE_UNII4_CANADA_EN_MSK);
 
 		cmd->oem_unii4_allow_bitmap = cpu_to_le32(value);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 81787501d4a4..4ced1711d913 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -144,12 +144,11 @@ enum iwl_dsm_unii4_bitmap {
 	DSM_VALUE_UNII4_CANADA_EN_MSK		= BIT(5),
 };
 
-#define DSM_UNII4_ALLOW_BITMAP_CMD_V8 (DSM_VALUE_UNII4_US_OVERRIDE_MSK | \
-				       DSM_VALUE_UNII4_US_EN_MSK | \
-				       DSM_VALUE_UNII4_ETSI_OVERRIDE_MSK | \
-				       DSM_VALUE_UNII4_ETSI_EN_MSK)
-#define DSM_UNII4_ALLOW_BITMAP (DSM_UNII4_ALLOW_BITMAP_CMD_V8 | \
-				DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK | \
+#define DSM_UNII4_ALLOW_BITMAP (DSM_VALUE_UNII4_US_OVERRIDE_MSK		|\
+				DSM_VALUE_UNII4_US_EN_MSK		|\
+				DSM_VALUE_UNII4_ETSI_OVERRIDE_MSK	|\
+				DSM_VALUE_UNII4_ETSI_EN_MSK		|\
+				DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK	|\
 				DSM_VALUE_UNII4_CANADA_EN_MSK)
 
 enum iwl_dsm_values_rfi {
-- 
2.34.1


