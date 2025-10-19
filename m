Return-Path: <linux-wireless+bounces-28058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D76FABEE0E9
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D540E4E47F8
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D629D29B;
	Sun, 19 Oct 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKbk3GCZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798B227BB5
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863535; cv=none; b=IbajTSQI18qjvcZtb9ckXGvNJJNfYLczgG0+t5E/C9884YCDHuL/B+pmUNUJqAOTTupKBLJNQNS3gBSz6UtHTNu5RCPWhHh+9k4bwbHyQIBAKhFn3+Y4lC6gyAFnIjkuiUv696mvITitpZB1yeVBRE5VCvAa4zTgLGkj/dLp9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863535; c=relaxed/simple;
	bh=rj8c9GzAEhEdwew1KtVpGExhGG5PWqRvN2PxtdR543o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTVIhXpjmcm1LHR4MApRTqt2A7zruRJCST2XZBW5VjkJhNBA1mb5mq5Hq2zxY2LbDy0aMWUCyJzn2LwQ82uQN9ugExaAcb0pUbgI7kWrmB13DLRI7kaQTkJzGLwUUYUQdjbrsMqLlrtHUU3ekprujJ7eWWRJ5L4Z4mfs1fGPa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKbk3GCZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863533; x=1792399533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rj8c9GzAEhEdwew1KtVpGExhGG5PWqRvN2PxtdR543o=;
  b=kKbk3GCZFKwhILiwoIkpJTxdQQhW05muQVVIglIrsBGey2TtDM13KSWC
   B7e5D6WYMF4dvETMC7YB6jla4P2Y5koDF3mpaRwz7ZBvlKlTfNXekAteE
   NvpaQ/JGRC0YVd9JW33nXhIKQeftyow/vbXKj2wZrYBEiISXfQ+M9Q5B+
   VPfW2tAgDOxqlKxdfcyfkZDOaHaSwRNuQw6LZFbAZCNPeUCV9LpiyRj4V
   PV8lVFzRXE23lateQ6B/EmjoiBNa9MIqusiv/e3LnGQCa3Q4AyDekUFHS
   yochtNL+kmcZHYc8wJyD+1tIJkgVc1ErjoMhnrUCWy5t8dVpPG/3tKJRt
   g==;
X-CSE-ConnectionGUID: Q/zVEr2JRkauoCg7MQJQuQ==
X-CSE-MsgGUID: WSDt+UEKSAWGtP/fQI9JOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363181"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363181"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:33 -0700
X-CSE-ConnectionGUID: RattKZpjQniU4nmIUVsEzA==
X-CSE-MsgGUID: 9yxjaz+7Q9WEJ/B354yPjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279867"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Nidhish A N <nidhish.a.n@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: fw: remove support of several iwl_lari_config_change_cmd versions
Date: Sun, 19 Oct 2025 11:45:04 +0300
Message-Id: <20251019114304.5c3de58594e8.I6e6f8707eb66a2b540fb19303c06393f13e1f68e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Nidhish A N <nidhish.a.n@intel.com>

We only need versions 1, 6, 8 and 12.
Remove versions 2, 3, 4, 5, 7, 9, 10, 11.

Signed-off-by: Nidhish A N <nidhish.a.n@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 134 +-----------------
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  26 +---
 2 files changed, 11 insertions(+), 149 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index e90f3187e55c..4644fc1aa1ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -18,13 +18,8 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 
 	/**
 	 * @LARI_CONFIG_CHANGE: &struct iwl_lari_config_change_cmd_v1,
-	 *	&struct iwl_lari_config_change_cmd_v2,
-	 *	&struct iwl_lari_config_change_cmd_v3,
-	 *	&struct iwl_lari_config_change_cmd_v4,
-	 *	&struct iwl_lari_config_change_cmd_v5,
 	 *	&struct iwl_lari_config_change_cmd_v6,
-	 *	&struct iwl_lari_config_change_cmd_v7,
-	 *	&struct iwl_lari_config_change_cmd_v10 or
+	 *	&struct iwl_lari_config_change_cmd_v8,
 	 *	&struct iwl_lari_config_change_cmd
 	 */
 	LARI_CONFIG_CHANGE = 0x1,
@@ -564,74 +559,6 @@ struct iwl_lari_config_change_cmd_v1 {
 	__le32 config_bitmap;
 } __packed; /* LARI_CHANGE_CONF_CMD_S_VER_1 */
 
-/**
- * struct iwl_lari_config_change_cmd_v2 - change LARI configuration
- * @config_bitmap: bit map of the config commands. each bit will trigger a
- * different predefined FW config operation
- * @oem_uhb_allow_bitmap: bitmap of UHB enabled MCC sets
- */
-struct iwl_lari_config_change_cmd_v2 {
-	__le32 config_bitmap;
-	__le32 oem_uhb_allow_bitmap;
-} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_2 */
-
-/**
- * struct iwl_lari_config_change_cmd_v3 - change LARI configuration
- * @config_bitmap: bit map of the config commands. each bit will trigger a
- * different predefined FW config operation
- * @oem_uhb_allow_bitmap: bitmap of UHB enabled MCC sets
- * @oem_11ax_allow_bitmap: bitmap of 11ax allowed MCCs.
- * For each supported country, a pair of regulatory override bit and 11ax mode exist
- * in the bit field.
- */
-struct iwl_lari_config_change_cmd_v3 {
-	__le32 config_bitmap;
-	__le32 oem_uhb_allow_bitmap;
-	__le32 oem_11ax_allow_bitmap;
-} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_3 */
-
-/**
- * struct iwl_lari_config_change_cmd_v4 - change LARI configuration
- * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
- *     different predefined FW config operation.
- * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
- * @oem_11ax_allow_bitmap: Bitmap of 11ax allowed MCCs. There are two bits
- *     per country, one to indicate whether to override and the other to
- *     indicate the value to use.
- * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
- *     per country, one to indicate whether to override and the other to
- *     indicate allow/disallow unii4 channels.
- */
-struct iwl_lari_config_change_cmd_v4 {
-	__le32 config_bitmap;
-	__le32 oem_uhb_allow_bitmap;
-	__le32 oem_11ax_allow_bitmap;
-	__le32 oem_unii4_allow_bitmap;
-} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_4 */
-
-/**
- * struct iwl_lari_config_change_cmd_v5 - change LARI configuration
- * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
- *     different predefined FW config operation.
- * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
- * @oem_11ax_allow_bitmap: Bitmap of 11ax allowed MCCs. There are two bits
- *     per country, one to indicate whether to override and the other to
- *     indicate the value to use.
- * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
- *     per country, one to indicate whether to override and the other to
- *     indicate allow/disallow unii4 channels.
- * @chan_state_active_bitmap: Bitmap for overriding channel state to active.
- *     Each bit represents a country or region to activate, according to the BIOS
- *     definitions.
- */
-struct iwl_lari_config_change_cmd_v5 {
-	__le32 config_bitmap;
-	__le32 oem_uhb_allow_bitmap;
-	__le32 oem_11ax_allow_bitmap;
-	__le32 oem_unii4_allow_bitmap;
-	__le32 chan_state_active_bitmap;
-} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_5 */
-
 /**
  * struct iwl_lari_config_change_cmd_v6 - change LARI configuration
  * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
@@ -659,8 +586,7 @@ struct iwl_lari_config_change_cmd_v6 {
 } __packed; /* LARI_CHANGE_CONF_CMD_S_VER_6 */
 
 /**
- * struct iwl_lari_config_change_cmd_v7 - change LARI configuration
- * This structure is used also for lari cmd version 8 and 9.
+ * struct iwl_lari_config_change_cmd_v8 - change LARI configuration
  * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
  *     different predefined FW config operation.
  * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
@@ -670,21 +596,19 @@ struct iwl_lari_config_change_cmd_v6 {
  * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
  *     per country, one to indicate whether to override and the other to
  *     indicate allow/disallow unii4 channels.
- *     For LARI cmd version 4 to 8 - bits 0:3 are supported.
- *     For LARI cmd version 9 - bits 0:5 are supported.
+ *     bit 0 - 3: supported.
  * @chan_state_active_bitmap: Bitmap to enable different bands per country
  *     or region.
  *     Each bit represents a country or region, and a band to activate
  *     according to the BIOS definitions.
- *     For LARI cmd version 7 - bits 0:3 are supported.
- *     For LARI cmd version 8 - bits 0:4 are supported.
+ *     bit 0 - 4: supported.
  * @force_disable_channels_bitmap: Bitmap of disabled bands/channels.
  *     Each bit represents a set of channels in a specific band that should be
  *     disabled
  * @edt_bitmap: Bitmap of energy detection threshold table.
  *	Disable/enable the EDT optimization method for different band.
  */
-struct iwl_lari_config_change_cmd_v7 {
+struct iwl_lari_config_change_cmd_v8 {
 	__le32 config_bitmap;
 	__le32 oem_uhb_allow_bitmap;
 	__le32 oem_11ax_allow_bitmap;
@@ -693,48 +617,8 @@ struct iwl_lari_config_change_cmd_v7 {
 	__le32 force_disable_channels_bitmap;
 	__le32 edt_bitmap;
 } __packed;
-/* LARI_CHANGE_CONF_CMD_S_VER_7 */
 /* LARI_CHANGE_CONF_CMD_S_VER_8 */
-/* LARI_CHANGE_CONF_CMD_S_VER_9 */
 
-/**
- * struct iwl_lari_config_change_cmd_v10 - change LARI configuration
- * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
- *	different predefined FW config operation.
- * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
- * @oem_11ax_allow_bitmap: Bitmap of 11ax allowed MCCs. There are two bits
- *	per country, one to indicate whether to override and the other to
- *	indicate the value to use.
- * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
- *	per country, one to indicate whether to override and the other to
- *	indicate allow/disallow unii4 channels.
- *	For LARI cmd version 10 - bits 0:5 are supported.
- * @chan_state_active_bitmap: Bitmap to enable different bands per country
- *	or region.
- *	Each bit represents a country or region, and a band to activate
- *	according to the BIOS definitions.
- *	For LARI cmd version 10 - bits 0:4 are supported.
- * @force_disable_channels_bitmap: Bitmap of disabled bands/channels.
- *	Each bit represents a set of channels in a specific band that should be
- *	disabled
- * @edt_bitmap: Bitmap of energy detection threshold table.
- *	Disable/enable the EDT optimization method for different band.
- * @oem_320mhz_allow_bitmap: 320Mhz bandwidth enablement bitmap per MCC.
- *	bit0: enable 320Mhz in Japan.
- *	bit1: enable 320Mhz in South Korea.
- *	bit 2 - 31: reserved.
- */
-struct iwl_lari_config_change_cmd_v10 {
-	__le32 config_bitmap;
-	__le32 oem_uhb_allow_bitmap;
-	__le32 oem_11ax_allow_bitmap;
-	__le32 oem_unii4_allow_bitmap;
-	__le32 chan_state_active_bitmap;
-	__le32 force_disable_channels_bitmap;
-	__le32 edt_bitmap;
-	__le32 oem_320mhz_allow_bitmap;
-} __packed;
-/* LARI_CHANGE_CONF_CMD_S_VER_10 */
 
 /**
  * struct iwl_lari_config_change_cmd - change LARI configuration
@@ -747,14 +631,11 @@ struct iwl_lari_config_change_cmd_v10 {
  * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
  *	per country, one to indicate whether to override and the other to
  *	indicate allow/disallow unii4 channels.
- *	For LARI cmd version 11 - bits 0:5 are supported.
  * @chan_state_active_bitmap: Bitmap to enable different bands per country
  *	or region.
  *	Each bit represents a country or region, and a band to activate
  *	according to the BIOS definitions.
- *	For LARI cmd version 11 - bits 0:4 are supported.
- *	For LARI cmd version 12 - bits 0:6 are supported and bits 7:31 are
- *	reserved.
+ *	bit 0 - 6: supported.
  * @force_disable_channels_bitmap: Bitmap of disabled bands/channels.
  *	Each bit represents a set of channels in a specific band that should be
  *	disabled
@@ -781,12 +662,11 @@ struct iwl_lari_config_change_cmd {
 	__le32 oem_320mhz_allow_bitmap;
 	__le32 oem_11be_allow_bitmap;
 } __packed;
-/* LARI_CHANGE_CONF_CMD_S_VER_11 */
 /* LARI_CHANGE_CONF_CMD_S_VER_12 */
 
 /* Activate UNII-1 (5.2GHz) for World Wide */
 #define ACTIVATE_5G2_IN_WW_MASK			BIT(4)
-#define CHAN_STATE_ACTIVE_BITMAP_CMD_V11	0x1F
+#define CHAN_STATE_ACTIVE_BITMAP_CMD_V8		0x1F
 #define CHAN_STATE_ACTIVE_BITMAP_CMD_V12	0x7F
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index e1f28b053253..d2ad169ae880 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -543,32 +543,14 @@ static size_t iwl_get_lari_config_cmd_size(u8 cmd_ver)
 
 	switch (cmd_ver) {
 	case 12:
-	case 11:
 		cmd_size = sizeof(struct iwl_lari_config_change_cmd);
 		break;
-	case 10:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v10);
-		break;
-	case 9:
 	case 8:
-	case 7:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v7);
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v8);
 		break;
 	case 6:
 		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v6);
 		break;
-	case 5:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v5);
-		break;
-	case 4:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v4);
-		break;
-	case 3:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v3);
-		break;
-	case 2:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v2);
-		break;
 	default:
 		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v1);
 		break;
@@ -609,11 +591,11 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 		if (!has_raw_dsm_capa)
 			value &= DSM_UNII4_ALLOW_BITMAP;
 
-		/* Since version 9, bits 4 and 5 are supported
+		/* Since version 12, bits 4 and 5 are supported
 		 * regardless of this capability, By pass this masking
 		 * if firmware has capability of accepting raw DSM table.
 		 */
-		if (!has_raw_dsm_capa && cmd_ver < 9 &&
+		if (!has_raw_dsm_capa && cmd_ver < 12 &&
 		    !fw_has_capa(&fwrt->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA))
 			value &= ~(DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK |
@@ -637,7 +619,7 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 		if (!has_raw_dsm_capa && cmd_ver < 12 &&
 		    !fw_has_capa(&fwrt->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_UNII4_US_CA))
-			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V11;
+			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V8;
 
 		cmd->chan_state_active_bitmap = cpu_to_le32(value);
 	}
-- 
2.34.1


