Return-Path: <linux-wireless+bounces-5057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E375881917
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD141F2214B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B136B08;
	Wed, 20 Mar 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ood4kt6B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB885C65
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970041; cv=none; b=bNRXSX/Zo96t7yx79AczhufK+VFx2I/aBkIHw0dHfkHcm6LGe/RuFDqgEftuyMI52z+pQq52Q9Rkuw+s5Mw/42ZLcTcFdnzGffdru+hiXRDAg/gst9Cp7MUv6rz9v6V2dsGslUHQ9lK3mt4aLn7b8Ffim10gQVRylfNBtZ/HOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970041; c=relaxed/simple;
	bh=kF8RqkWGKpsSZiC5vI1jIDNMrjiBNxUyTQ/OG7YIuYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cX3VLkiakC2tU13GBGmFmnp4S4NIFNxShGTsJzXurP2OsgnRGz5tdlFxTjyfPtBEFQfBL0nz1rIzWSoUEhUxXmFI/COkRmY1rhh/fy0k9Sc5N9Bfs4Xphu5SjXPv5Bm9MY6oFgRgI28ZeXkkoSNZxlb8MFMgZWzYc/gjy0KfIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ood4kt6B; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970038; x=1742506038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kF8RqkWGKpsSZiC5vI1jIDNMrjiBNxUyTQ/OG7YIuYo=;
  b=Ood4kt6BsZ1v0JX96dPdQ6ZuP2dA67aYrQk6jchPdw8KF6ADhWIxOn1T
   2wbTVzefnRWIFY1Y/gIjUQoPapfkHKLdSzFtfPIS7x9cFxP67kZdLqvf4
   k3rrKRRP+0E3kDi3aOhQOnTRNua9q9hKo+uxIbHQtsnmnKIEgaEUbEbJ5
   W4a3lnsxF5nUrDMbxSSLuLkpeRFKBkPnG1sea+dpBiqrmXvW0gAM1besE
   XR7tb+Y/1tumAz/5jIC1f6cIKx4mDiz29paMaHFaJ3BWclFu2sIJKupOy
   58ciVI0PeTb5TfJxU2FpMFZn6VdbUpAjSig61YipYQwUtP+CJk5elIg8N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698127"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698127"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184191"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Subject: [PATCH 13/17] wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD cmd v9
Date: Wed, 20 Mar 2024 23:26:34 +0200
Message-Id: <20240320232419.5c31ccd73119.I0363992efc3607368648d34a7918b2534150a3ca@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

There is a requirement from OEMs to support new bits in DSM function 7,
which will indicate enablement of 5.9 GHz in Canada.
Add support for this by reading those bits from BIOS and sending it to the
FW. mask unii4 allow bitmap based on LARI_CONFIG_CHANGE_CMD version

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  5 ++++-
 .../wireless/intel/iwlwifi/fw/regulatory.h    | 19 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  9 ++++++++-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 58034dfa7e70..988b5421a629 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -609,7 +609,7 @@ struct iwl_lari_config_change_cmd_v6 {
 
 /**
  * struct iwl_lari_config_change_cmd_v7 - change LARI configuration
- * This structure is used also for lari cmd version 8.
+ * This structure is used also for lari cmd version 8 and 9.
  * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
  *     different predefined FW config operation.
  * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
@@ -619,6 +619,8 @@ struct iwl_lari_config_change_cmd_v6 {
  * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
  *     per country, one to indicate whether to override and the other to
  *     indicate allow/disallow unii4 channels.
+ *     For LARI cmd version 4 to 8 - bits 0:3 are supported.
+ *     For LARI cmd version 9 - bits 0:5 are supported.
  * @chan_state_active_bitmap: Bitmap to enable different bands per country
  *     or region.
  *     Each bit represents a country or region, and a band to activate
@@ -642,6 +644,7 @@ struct iwl_lari_config_change_cmd_v7 {
 } __packed;
 /* LARI_CHANGE_CONF_CMD_S_VER_7 */
 /* LARI_CHANGE_CONF_CMD_S_VER_8 */
+/* LARI_CHANGE_CONF_CMD_S_VER_9 */
 
 /* Activate UNII-1 (5.2GHz) for World Wide */
 #define ACTIVATE_5G2_IN_WW_MASK	BIT(4)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 28e774766847..a0cb8881e629 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023-2024 Intel Corporation
  */
 
 #ifndef __fw_regulatory_h__
@@ -132,6 +132,23 @@ enum iwl_dsm_values_indonesia {
 	DSM_VALUE_INDONESIA_MAX
 };
 
+enum iwl_dsm_unii4_bitmap {
+	DSM_VALUE_UNII4_US_OVERRIDE_MSK		= BIT(0),
+	DSM_VALUE_UNII4_US_EN_MSK		= BIT(1),
+	DSM_VALUE_UNII4_ETSI_OVERRIDE_MSK	= BIT(2),
+	DSM_VALUE_UNII4_ETSI_EN_MSK		= BIT(3),
+	DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK	= BIT(4),
+	DSM_VALUE_UNII4_CANADA_EN_MSK		= BIT(5),
+};
+
+#define DSM_UNII4_ALLOW_BITMAP_CMD_V8 (DSM_VALUE_UNII4_US_OVERRIDE_MSK | \
+				       DSM_VALUE_UNII4_US_EN_MSK | \
+				       DSM_VALUE_UNII4_ETSI_OVERRIDE_MSK | \
+				       DSM_VALUE_UNII4_ETSI_EN_MSK)
+#define DSM_UNII4_ALLOW_BITMAP (DSM_UNII4_ALLOW_BITMAP_CMD_V8 | \
+				DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK | \
+				DSM_VALUE_UNII4_CANADA_EN_MSK)
+
 enum iwl_dsm_values_rfi {
 	DSM_VALUE_RFI_DLVR_DISABLE	= BIT(0),
 	DSM_VALUE_RFI_DDR_DISABLE	= BIT(1),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index df3b29b998cf..1f8d4723512f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1239,8 +1239,14 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 		cmd.oem_11ax_allow_bitmap = cpu_to_le32(value);
 
 	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
-	if (!ret)
+	if (!ret) {
+		if (cmd_ver < 9)
+			value &= DSM_UNII4_ALLOW_BITMAP_CMD_V8;
+		else
+			value &= DSM_UNII4_ALLOW_BITMAP;
+
 		cmd.oem_unii4_allow_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
 	if (!ret) {
@@ -1273,6 +1279,7 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 		size_t cmd_size;
 
 		switch (cmd_ver) {
+		case 9:
 		case 8:
 		case 7:
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v7);
-- 
2.34.1


