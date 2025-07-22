Return-Path: <linux-wireless+bounces-25784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F522B0D071
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B743AE66E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66D728A73F;
	Tue, 22 Jul 2025 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAXJkJu8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFC1DED5D
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155716; cv=none; b=M4f4vLHpBeOaSWNN8GSEXVP8eWHj5qbLtF8xKBl+F8mZ/VzM5FMWO0EQhhcHsTCF8aVUsVGDNEHwCk0dxSfxxPS1xJew3moSZ2cnm45D0+lsoRoVn/xliDw6eEpWYAINO1VlfAjAH5Oe3Pc3LHj2gdVzgvWEBVZgSoFm5uoxbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155716; c=relaxed/simple;
	bh=fedxfWiJT3tDqebGtIpE0p+0YG+1ZfVe2AnGvAbHFdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3Qfxmg94MYk6NODCVkckTZ7yYBhIcm64RosQQ26K6XbfrFWblXcij80jI2VByyef+Yo85bkM5271Z2e7r0R8ZB4D0cPeX+LLoWvb6owf2Sl3wyP8KrhizfqqCZ7zVD/jDabPJCNlfkqToSbAGv50F0/WocKYf+9mF2h0/j+i1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAXJkJu8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155714; x=1784691714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fedxfWiJT3tDqebGtIpE0p+0YG+1ZfVe2AnGvAbHFdM=;
  b=iAXJkJu8+SGx+jrBBhSlLhYdlI9La9b2ZRF2xSVYClgTi/Hkkyu2tURP
   h6Mg/tTXXe6urZbhGPV5WrqjgQmEPk8241r19fzaWLcGQdWL933LKUAjy
   1kQ0OFpr8KHaOapcp8/gZuCoBnLpVY/3z2bY6Ck0b7NQJo8/dQ2ZZtzOB
   fVO23A/1gxJ3H+mQwCage5GSw/kqK1SalLftGsqyG1wZkGDy25uKF4AkP
   SVbNa6ZVG5gijp2PYalDDY2E+HCy186pxZbArvRsJLFyl7M8pVWl4QNbP
   1Gi1F4qZho2Yk+kUY/PLBaG++yjLj7mPLclG7BZZ17e0+6T9eiqa41+eN
   Q==;
X-CSE-ConnectionGUID: wYsBa2qSSdae58ki5KUPZw==
X-CSE-MsgGUID: kbxrMGZbTRy2U6uH69doTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006156"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006156"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:54 -0700
X-CSE-ConnectionGUID: mcCtIfchSbuiKudsDXK74w==
X-CSE-MsgGUID: 7gJziRbSRm2FDOSABL1SCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338085"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: disable certain features for fips_enabled
Date: Tue, 22 Jul 2025 06:41:15 +0300
Message-Id: <20250722063923.7ca4f6e236fc.I0be27dd329643cc5fdf79a8c8b8f6d2e6fb5c175@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

When fips_enabled is set, keys will not be given to the
hardware by mac80211 since the hardware isn't certified.
In this case, various features cannot work correctly as
the firmware needs to handle frames, but it then cannot
since no keys are available.

Disable features:
 - WoWLAN since no keys etc.
 - MFP since some frames need to be handled in firmware
 - EHT/6GHz since MFP is required

Also restrict A-MSDU size since A-MSDUs cannot be split
up by hardware and thus need to fit into the RX buffers
in one piece.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 25 ++++++++++++++++---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 11 +++++++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 16 +++++++++---
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 4424443d2328..a67b9572aac3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #include <linux/types.h>
+#include <linux/fips.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/etherdevice.h>
@@ -543,16 +544,22 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 	else
 		vht_cap->cap |= IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN;
 
+	/*
+	 * With fips_enabled crypto is done by software, so the HW cannot
+	 * split up A-MSDUs and the real limit that was set applies.
+	 * Note that EHT doesn't honour this (HE copies the VHT value),
+	 * but EHT is also entirely disabled for fips_enabled.
+	 */
 	switch (iwlwifi_mod_params.amsdu_size) {
 	case IWL_AMSDU_DEF:
-		if (trans->mac_cfg->mq_rx_supported)
+		if (trans->mac_cfg->mq_rx_supported && !fips_enabled)
 			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
 		else
 			vht_cap->cap |= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895;
 		break;
 	case IWL_AMSDU_2K:
-		if (trans->mac_cfg->mq_rx_supported)
+		if (trans->mac_cfg->mq_rx_supported && !fips_enabled)
 			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
 		else
@@ -909,7 +916,9 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	bool slow_pcie = (!trans->mac_cfg->integrated &&
 			  trans->info.pcie_link_speed < PCI_EXP_LNKSTA_CLS_8_0GB);
 
-	if (!data->sku_cap_11be_enable || iwlwifi_mod_params.disable_11be)
+	/* EHT needs WPA3/MFP so cannot do it for fips_enabled */
+	if (!data->sku_cap_11be_enable || iwlwifi_mod_params.disable_11be ||
+	    fips_enabled)
 		iftype_data->eht_cap.has_eht = false;
 
 	/* Advertise an A-MPDU exponent extension based on
@@ -1197,11 +1206,19 @@ static void iwl_init_sbands(struct iwl_trans *trans,
 	n_used += iwl_init_sband_channels(data, sband, n_channels,
 					  NL80211_BAND_6GHZ);
 
-	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
+	/*
+	 * 6 GHz requires WPA3 which requires MFP, which FW cannot do
+	 * when fips_enabled, so don't advertise any 6 GHz channels to
+	 * avoid spending time on scanning those channels and perhaps
+	 * even finding APs there that cannot be used.
+	 */
+	if (!fips_enabled && data->sku_cap_11ax_enable &&
+	    !iwlwifi_mod_params.disable_11ax)
 		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains,
 				     fw);
 	else
 		sband->n_channels = 0;
+
 	if (n_channels != n_used)
 		IWL_ERR_DEV(dev, "NVM: used only %d of %d channels\n",
 			    n_used, n_channels);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index c6e61c843f77..3ea6d4c1b779 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -4,6 +4,7 @@
  */
 
 #include <net/mac80211.h>
+#include <linux/fips.h>
 #include <linux/ip.h>
 
 #include "mld.h"
@@ -156,6 +157,9 @@ static void iwl_mld_hw_set_security(struct iwl_mld *mld)
 		WLAN_CIPHER_SUITE_BIP_GMAC_256
 	};
 
+	if (fips_enabled)
+		return;
+
 	hw->wiphy->n_cipher_suites = ARRAY_SIZE(mld_ciphers);
 	hw->wiphy->cipher_suites = mld_ciphers;
 
@@ -180,6 +184,9 @@ static void iwl_mld_hw_set_pm(struct iwl_mld *mld)
 	if (!device_can_wakeup(mld->trans->dev))
 		return;
 
+	if (fips_enabled)
+		return;
+
 	mld->wowlan.flags |= WIPHY_WOWLAN_MAGIC_PKT |
 			     WIPHY_WOWLAN_DISCONNECT |
 			     WIPHY_WOWLAN_EAP_IDENTITY_REQ |
@@ -284,9 +291,11 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 			WIPHY_FLAG_SUPPORTS_TDLS |
 			WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK;
 
+	/* For fips_enabled, don't support WiFi7 due to WPA3/MFP requirements */
 	if (mld->nvm_data->sku_cap_11be_enable &&
 	    !iwlwifi_mod_params.disable_11ax &&
-	    !iwlwifi_mod_params.disable_11be)
+	    !iwlwifi_mod_params.disable_11be &&
+	    !fips_enabled)
 		wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
 
 	/* the firmware uses u8 for num of iterations, but 0xff is saved for
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fa9d5e0b6609..55ae1caded53 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #include <linux/kernel.h>
+#include <linux/fips.h>
 #include <linux/slab.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
@@ -461,7 +462,9 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		IWL_ERR(mvm,
 			"iwlmvm doesn't allow to disable BT Coex, check bt_coex_active module parameter\n");
 
-	ieee80211_hw_set(hw, MFP_CAPABLE);
+	if (!fips_enabled)
+		ieee80211_hw_set(hw, MFP_CAPABLE);
+
 	mvm->ciphers[hw->wiphy->n_cipher_suites] = WLAN_CIPHER_SUITE_AES_CMAC;
 	hw->wiphy->n_cipher_suites++;
 	if (iwl_mvm_has_new_rx_api(mvm)) {
@@ -485,12 +488,17 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->pmsr_capa = &iwl_mvm_pmsr_capa;
 	}
 
-	if (sec_key_ver &&
+	/*
+	 * beacon protection must be handled by firmware,
+	 * so cannot be done with fips_enabled
+	 */
+	if (!fips_enabled && sec_key_ver &&
 	    fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_BIGTK_TX_SUPPORT))
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_BEACON_PROTECTION);
-	else if (fw_has_capa(&mvm->fw->ucode_capa,
+	else if (!fips_enabled &&
+		 fw_has_capa(&mvm->fw->ucode_capa,
 			     IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT))
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT);
@@ -730,7 +738,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 #ifdef CONFIG_PM_SLEEP
 	if ((unified || mvm->fw->img[IWL_UCODE_WOWLAN].num_sec) &&
-	    device_can_wakeup(mvm->trans->dev)) {
+	    device_can_wakeup(mvm->trans->dev) && !fips_enabled) {
 		mvm->wowlan.flags |= WIPHY_WOWLAN_MAGIC_PKT |
 				     WIPHY_WOWLAN_DISCONNECT |
 				     WIPHY_WOWLAN_EAP_IDENTITY_REQ |
-- 
2.34.1


