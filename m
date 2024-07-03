Return-Path: <linux-wireless+bounces-9919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B39257A3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184B528C859
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEAC142905;
	Wed,  3 Jul 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0i4Ltr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969516F0E6
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000783; cv=none; b=nZUHsGnAlE+OmGu2Qs4CpyL9ABek8yxvRgLTz9U+BkVJsl/j4oUd3/V1v7CMXKmoEFYqvIXZyvI1/XcsHTsNEPj8GoBHqg9Ye/89tetf2JEHvKDzp+rotOCbXzd0Z/Afcwou9cEzvqA8UwzqNiEsljC3VomdakVkaTXlBBCEg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000783; c=relaxed/simple;
	bh=A4HMTY115Ghhq//clgzAPbpbn6CwwJ7qz41+buMGSUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5jbMMHSeCBZUXMlG1STGtHPMkujHCaHSM9Qzi/uFhTPRcPFjtBOzclfKfoQqaHnjeSAH+AHPASive9kFmni1GkSiOSsPWeG21akx8J2f42yLGdhjtjCD8oYWYe4mXXzRYSAovWtDg4FnZ6iLYKSLxNyBG4unBZHhf9+mUuFJaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0i4Ltr2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000782; x=1751536782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A4HMTY115Ghhq//clgzAPbpbn6CwwJ7qz41+buMGSUk=;
  b=W0i4Ltr29JtP6jvp3+90CN2V6ov8lLQzF7oPjlVMHmx+2sx6OK4wKKmO
   pVaRHDFACDqyN0xmDWI2/PHzSWMBFMuNdFZtvJ0+k65VOusWzuNeQnpO/
   HJ+jMqKERYqQkrKVP8SKrAuBZIO3KogNIUHz+A2dpc+FNCVlU0LnIPU83
   k/hJCy+jm7ixQuyKw/L/GWxyX7bW9me3tIQX7oRA4iG+EVRxaGpqK+/dd
   JmFtw61CwVXOGXQjS6Cm9ITh1l4N/CnIZvxAMvhVDINAIxkZHHnmVhAQk
   kDA9F6JGxgFoXPdDC1/ozc+8YnjLART4QbU0VyDf8qzbVC2M6CRDLQAUV
   w==;
X-CSE-ConnectionGUID: hw6RCdoLRlOrSvDPH54OtQ==
X-CSE-MsgGUID: IakCfQafQ868uv+1QxE7lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837573"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837573"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:41 -0700
X-CSE-ConnectionGUID: 5FBxpjqGTlmNu+/TF3mShQ==
X-CSE-MsgGUID: guieIP4UQOW79b4HrJE4Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987886"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 18/18] wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v12
Date: Wed,  3 Jul 2024 12:59:06 +0300
Message-Id: <20240703125541.674604cbb6d1.Ibb946ae8ce7a760940a3c9d101e7f4f1808c43e4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add support for activate/deactivate unii4 in USA, Canada and WW by
reading DSM function 8 from UEFI or ACPI and sending it to the FW.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h | 6 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c  | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 9ff5d7e538fd..d424d0126367 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -704,6 +704,8 @@ struct iwl_lari_config_change_cmd_v10 {
  *	Each bit represents a country or region, and a band to activate
  *	according to the BIOS definitions.
  *	For LARI cmd version 11 - bits 0:4 are supported.
+ *	For LARI cmd version 12 - bits 0:6 are supported and bits 7:31 are
+ *	reserved. No need to mask out the reserved bits.
  * @force_disable_channels_bitmap: Bitmap of disabled bands/channels.
  *	Each bit represents a set of channels in a specific band that should be
  *	disabled
@@ -731,9 +733,11 @@ struct iwl_lari_config_change_cmd {
 	__le32 oem_11be_allow_bitmap;
 } __packed;
 /* LARI_CHANGE_CONF_CMD_S_VER_11 */
+/* LARI_CHANGE_CONF_CMD_S_VER_12 */
 
 /* Activate UNII-1 (5.2GHz) for World Wide */
-#define ACTIVATE_5G2_IN_WW_MASK	BIT(4)
+#define ACTIVATE_5G2_IN_WW_MASK			BIT(4)
+#define CHAN_STATE_ACTIVE_BITMAP_CMD_V11	0x1F
 
 /**
  * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 5228b837a9ef..560a91998cc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -497,6 +497,7 @@ static size_t iwl_get_lari_config_cmd_size(u8 cmd_ver)
 	size_t cmd_size;
 
 	switch (cmd_ver) {
+	case 12:
 	case 11:
 		cmd_size = sizeof(struct iwl_lari_config_change_cmd);
 		break;
@@ -563,6 +564,9 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 	if (!ret) {
 		if (cmd_ver < 8)
 			value &= ~ACTIVATE_5G2_IN_WW_MASK;
+		if (cmd_ver < 12)
+			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V11;
+
 		cmd->chan_state_active_bitmap = cpu_to_le32(value);
 	}
 
-- 
2.34.1


