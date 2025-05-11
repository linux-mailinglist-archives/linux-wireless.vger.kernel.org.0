Return-Path: <linux-wireless+bounces-22842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9999EAB29C4
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E96175D23
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5D25D540;
	Sun, 11 May 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQbjPWSA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872225D1F7
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982421; cv=none; b=bFBtzQbUsLNFXqPh/gGjZ3QOUfPsZjlJRGdK0eHDEnkb9LYId6rMllSyw8N47cfgVZCx30GoU1+lhMXq29Mv73ZUneulLVWlFUCEeieywG5c2GIJd+L96PhWUtabN4mJAoJ4z2a3Kwl/lx+AksxOlfX7b2L2wiYjAp9QdbPMdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982421; c=relaxed/simple;
	bh=pgxUzgoyME5YrzT/4T33pLeMb5aYnmug88KWc1Vvscw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RqIRtUyiSpusJs0C3OzyQI3SkOasuWF8+As/z9f4icVYdQIOcgIiqfiqvRly6beVDtXQPsU5U8vpT5jIFZqoTx5hgQIe1HGd7FKIA/Uc+gGtZsO5NdMg+aWDAsWm0L7G/yytvvNTUHKly9V6q8ULeDutKZwpk3ilpMQRUX8fTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQbjPWSA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982420; x=1778518420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgxUzgoyME5YrzT/4T33pLeMb5aYnmug88KWc1Vvscw=;
  b=BQbjPWSAZUAX24jmXzTt++UFYFm+C/m6JafsymAqyM51xAlPqmL9ikFV
   TY66DWcZj4YRbKbxS1rUwfdz40CX0zGE6m27zYqaTYQaHoKRkFndtiSd+
   1xcFusfthTE0uDyAOeDRvPYQR/5dQsoepM/jVveMB/tDZEbvZ/ExDyKx3
   2FZS+J6wrep7dz9j7zDhVOR/pUmlFg7YDEBgATllVD4DHryJaQHArU/cM
   BTu/zlyqen7X2kzHpQQFkZi+KcD+37J5/2KHpHosYy87ofrREzbwbbk3L
   yvZ8RfDFk24L+uLKFVxdX4P5u+qMuy61Ye4XLlIC1AABJWMcEd96ZCOXf
   Q==;
X-CSE-ConnectionGUID: FrUMn0J/T6Cc430ETScnjA==
X-CSE-MsgGUID: dKKVz5x0QLK9csF2WmuPdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582682"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582682"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:40 -0700
X-CSE-ConnectionGUID: lZrzB2pXQGWElbLrZW+aZQ==
X-CSE-MsgGUID: sPYndWa5RgS+4mzewP5qdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655030"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: cfg: clean up dr/br configs
Date: Sun, 11 May 2025 19:53:09 +0300
Message-Id: <20250511195137.15e2056ec40f.I75a6ce4ad0b14d2b4413615f05523a8f62f08954@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We don't need the configs that won't end up being used, such as
the "br" config for discrete devices, remove them. Also remove
the module firmware for test chips, that's never needed.

For now keep the iwl_dr_mac_cfg even if it's unused, we'll add
platforms with it once we have their PCI IDs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   | 23 +------------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 ---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  3 ---
 3 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index ecf36a8a1135..45e55cef42ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -19,15 +19,9 @@
 #define IWL_DR_SMEM_LEN			0xD0000
 
 #define IWL_DR_A_PE_A_FW_PRE		"iwlwifi-dr-a0-pe-a0"
-#define IWL_BR_A_PET_A_FW_PRE		"iwlwifi-br-a0-petc-a0"
-#define IWL_BR_A_PE_A_FW_PRE		"iwlwifi-br-a0-pe-a0"
 
 #define IWL_DR_A_PE_A_FW_MODULE_FIRMWARE(api) \
 	IWL_DR_A_PE_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BR_A_PET_A_FW_MODULE_FIRMWARE(api) \
-	IWL_BR_A_PET_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BR_A_PE_A_FW_MODULE_FIRMWARE(api) \
-	IWL_BR_A_PE_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_family_base_params iwl_dr_base = {
 	.num_of_queues = 512,
@@ -95,20 +89,5 @@ const struct iwl_mac_cfg iwl_dr_mac_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-const char iwl_dr_name[] = "Intel(R) TBD Dr device";
-
-const struct iwl_mac_cfg iwl_br_mac_cfg = {
-	.device_family = IWL_DEVICE_FAMILY_DR,
-	.base = &iwl_dr_base,
-	.mq_rx_supported = true,
-	.gen2 = true,
-	.umac_prph_offset = 0x300000,
-	.xtal_latency = 12000,
-	.low_latency_xtal = true,
-};
-
-const char iwl_br_name[] = "Intel(R) TBD Br device";
-
 MODULE_FIRMWARE(IWL_DR_A_PE_A_FW_MODULE_FIRMWARE(IWL_DR_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BR_A_PET_A_FW_MODULE_FIRMWARE(IWL_DR_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BR_A_PE_A_FW_MODULE_FIRMWARE(IWL_DR_UCODE_API_MAX));
+
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 363ef060d68e..84befef470cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -536,7 +536,6 @@ extern const struct iwl_mac_cfg iwl_bz_mac_cfg;
 extern const struct iwl_mac_cfg iwl_gl_mac_cfg;
 extern const struct iwl_mac_cfg iwl_sc_mac_cfg;
 extern const struct iwl_mac_cfg iwl_dr_mac_cfg;
-extern const struct iwl_mac_cfg iwl_br_mac_cfg;
 
 extern const char iwl1000_bgn_name[];
 extern const char iwl1000_bg_name[];
@@ -652,8 +651,6 @@ extern const char iwl_killer_bn1850i_name[];
 extern const char iwl_bn201_name[];
 extern const char iwl_be221_name[];
 extern const char iwl_be223_name[];
-extern const char iwl_dr_name[];
-extern const char iwl_br_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_rf_cfg iwl5300_agn_cfg;
 extern const struct iwl_rf_cfg iwl5350_agn_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d270dfaa6c83..8ffc3a0e7862 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -545,9 +545,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xE340, PCI_ANY_ID, iwl_sc_mac_cfg)},
 	{IWL_PCI_DEVICE(0xD340, PCI_ANY_ID, iwl_sc_mac_cfg)},
 	{IWL_PCI_DEVICE(0x6E70, PCI_ANY_ID, iwl_sc_mac_cfg)},
-
-/* Dr devices */
-	{IWL_PCI_DEVICE(0x272F, PCI_ANY_ID, iwl_dr_mac_cfg)},
 #endif /* CONFIG_IWLMLD */
 
 	{0}
-- 
2.34.1


