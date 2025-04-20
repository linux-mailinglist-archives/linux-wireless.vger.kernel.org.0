Return-Path: <linux-wireless+bounces-21762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2145A9474C
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2383B4C38
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6762AD14;
	Sun, 20 Apr 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlXu2YoQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954BA155A30
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745139727; cv=none; b=VGDEb0XKktLa8lRbwLL0Kkl+coYEMKsQHdIATZS3Q8k19PMWUMHBdn8VL51CxFD/ToBsfpPHtkUdpkQDJcdEjQw7sIhEZhpo9Tc3I+/jTztTW+ZQTy4lV0wfIhKaQiuBdOs6hjw7AO39kYkhFdGfsIDvstVEXZoqMHu7jLlVXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745139727; c=relaxed/simple;
	bh=JuEHlT/cDLClpcRPhnrD3tMpsQzTFkIfyQ6NoDDlfJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iEyf9F95T/3uuglylxlBpkeIiQRIcOtPeTSDqkqbs0dz7EgE/4B9P7HjQerlCUfkax01iUaI28WPU34op5KTuBwvBDcALNkopohVcG3tMGgikOPzKuYiTlsRQwQx03taogM9ijJzdJBdwmEcgIx3EMMYRvd2vVdEMkHYVgYG6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RlXu2YoQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745139726; x=1776675726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JuEHlT/cDLClpcRPhnrD3tMpsQzTFkIfyQ6NoDDlfJM=;
  b=RlXu2YoQIaluI7CRENV0At6KI9qgv40D/pTpM/aASjqO19TjLunvDWru
   Jya5OaekO4oh70AISW9SsY9PIWqS+D/bmEy2JrlDT6Vy5HecOii2DKprc
   Sne4+T911+FRTQVmQgwAsxOOVAYl57cX8Dk6cqzis9VtpVvvJrbuRxnCk
   ZcX8z+38hUwPZqfzQSeQIbrB2hbZkSzqNujm4Z4eHQ80l3r4885odea57
   eUq9oHwhhJJzZJZ4L+52cQDcaiKZcgX9bNUSHtV/xZ4cOYXtxA/BdORDf
   DvBwfP7CI/vcMGm+gEv52hl3om682JXzBhr7qy/MUrWwzwLlDyBXRx2th
   w==;
X-CSE-ConnectionGUID: g0TuND7rRKSE258+dEjyjQ==
X-CSE-MsgGUID: rlwlPN5CQSir4alVhQR5Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="56880472"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="56880472"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 02:02:05 -0700
X-CSE-ConnectionGUID: dfwIigYaTPeL05pQQgdjgw==
X-CSE-MsgGUID: OaVhGb9+So2IgMsikzJX5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="136632851"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 02:02:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Todd Brandt <todd.e.brandt@intel.com>
Subject: [PATCH wireless 1/2] Revert "wifi: iwlwifi: add support for BE213"
Date: Sun, 20 Apr 2025 12:01:49 +0300
Message-Id: <20250420115541.581160ae3e4b.Icecc46baee8a797c00ad04fab92d7d1114b84829@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420090150.3508273-1-miriam.rachel.korenblit@intel.com>
References: <20250420090150.3508273-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This reverts commit 16a8d9a739430bec9c11eda69226c5a39f3478aa.

This device needs commit 75a3313f52b7 ("wifi: iwlwifi: make no_160 more generic"),
which has a bug and is being reverted until it is fixed.
Since this device wasn't shipped yet it is ok to not support it.

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220029
Fixes: 16a8d9a73943 ("wifi: iwlwifi: add support for BE213")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 --
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 -
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 12 ++++-------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 21 +++----------------
 4 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 670031fd60dc..59af36960f9c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -142,8 +142,6 @@ const struct iwl_cfg_trans_params iwl_sc_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-const char iwl_sp_name[] = "Intel(R) Wi-Fi 7 BE213 160MHz";
-
 const struct iwl_cfg iwl_cfg_sc = {
 	.fw_name_mac = "sc",
 	IWL_DEVICE_SC,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index b9bd89bfdd74..7e4864c00780 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -550,7 +550,6 @@ extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
 extern const char iwl_fm_name[];
 extern const char iwl_wh_name[];
-extern const char iwl_sp_name[];
 extern const char iwl_gl_name[];
 extern const char iwl_mtp_name[];
 extern const char iwl_dr_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index cd1b0048bb6d..08269168b2fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -944,8 +944,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 				       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
 		break;
 	case NL80211_BAND_6GHZ:
-		if (!trans->reduced_cap_sku &&
-		    trans->bw_limit >= 320) {
+		if (!trans->reduced_cap_sku) {
 			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[0] |=
 				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[1] |=
@@ -1099,18 +1098,15 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &=
 			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 
-	if (trans->bw_limit < 320 || trans->reduced_cap_sku) {
+	if (trans->reduced_cap_sku) {
 		memset(&iftype_data->eht_cap.eht_mcs_nss_supp.bw._320, 0,
 		       sizeof(iftype_data->eht_cap.eht_mcs_nss_supp.bw._320));
-		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[2] &=
-			~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
-	}
-
-	if (trans->reduced_cap_sku) {
 		iftype_data->eht_cap.eht_mcs_nss_supp.bw._80.rx_tx_mcs13_max_nss = 0;
 		iftype_data->eht_cap.eht_mcs_nss_supp.bw._160.rx_tx_mcs13_max_nss = 0;
 		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[8] &=
 			~IEEE80211_EHT_PHY_CAP8_RX_4096QAM_WIDER_BW_DL_OFDMA;
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[2] &=
+			~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b8b616cffb91..bbdfa51d1645 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1187,13 +1187,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc, iwl_wh_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      160, IWL_CFG_ANY, IWL_CFG_ANY,
-		      iwl_cfg_sc, iwl_sp_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1207,13 +1202,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2, iwl_wh_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      160, IWL_CFG_ANY, IWL_CFG_ANY,
-		      iwl_cfg_sc2, iwl_sp_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1227,13 +1217,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2f, iwl_wh_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      160, IWL_CFG_ANY, IWL_CFG_ANY,
-		      iwl_cfg_sc2f, iwl_sp_name),
 
 /* Dr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.34.1


