Return-Path: <linux-wireless+bounces-19894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55D1A549F5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CE7188B570
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3112720AF92;
	Thu,  6 Mar 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwAxn54c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AAA2040BF
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261752; cv=none; b=DCkZuLHJ1+gsu32EGJ6hvyh3FFcQAbIsPZ/qAQangYbj38np6mNOgFxtPk59fPPgC3f6LlUwjKef03B1Ll6BIIDq4LbU5lHDutB5pC7K6wEaNotgG/Fy8y8b7U5ctcHWniwOw0JifNxxMKcLvMO+UFTBjeH4AKOeUU6xxUW/C3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261752; c=relaxed/simple;
	bh=xACJd1vmpEBKooE0D3HFij6eW8BkyvDrSkBDkYTvhVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ieUZJyx08WB8CmTyvPCNl9IQTugYa6aGmmY6IXGXkA9slev/TW68GWvBZNbvQmQ3HX3S5l17/Osu/0PXLgQQYtijH8DaxG0aT6rXeyUrPfvLzY9l8tKlMqAGVohcVptbZsK3Ndo3f7bH4NPXDI91hY/e6QdrWxb+V96oNNWzgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwAxn54c; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261751; x=1772797751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xACJd1vmpEBKooE0D3HFij6eW8BkyvDrSkBDkYTvhVQ=;
  b=LwAxn54cPC9O5xAHj1pmDwrxh3Uwbk6DUiAgXwdbM+jfUJZNYWklbtJj
   Syr1C56p7sOKOQhzFH00lmns9oKm6vycPAzMim7Qiwols99/dIQo3SGev
   ERvQGcP5nQbfQ2oxPEAzLfc4Qw7xpq36XbRFJ6QjpCMJR5jiwd0agFDro
   F60qdkJuyVmhjhTTEG0hocCL1d1tGVnhZ+abskah01y8O7/sqIhRqints
   OQ8W76vpbOfplhnqnAwlI+rmDwnjYfn5qZO7e9uYO+LfgnDEz0lAjaG0H
   MThoZMqu9SWkV4ebQFNAlyhRJFKzqyympQSGocBnQV2T1YxEtjMyiE/Ys
   A==;
X-CSE-ConnectionGUID: OwqvmOS1QXqqsF+YAhrPzg==
X-CSE-MsgGUID: U+z2RU0iQe2a7NQl9u02Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474505"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474505"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:11 -0800
X-CSE-ConnectionGUID: r7MbW5XjTmuj2U0DDRQO/w==
X-CSE-MsgGUID: 59012f7LTkyJ8OFCUCaMOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915522"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 02/19] wifi: iwlwifi: add support for BE213
Date: Thu,  6 Mar 2025 13:48:38 +0200
Message-Id: <20250306134558.cc2df19a2a1b.Idaf000dd311358e3b50a511f4efc1cc720abd58b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Add the BE213 device. This is just like BE211 but with a limitation on
the bandwidth.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 ++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 12 +++++++----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 21 ++++++++++++++++---
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index e5c01ae87699..46c2f3f105ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -142,6 +142,8 @@ const struct iwl_cfg_trans_params iwl_sc_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
+const char iwl_sp_name[] = "Intel(R) Wi-Fi 7 BE213 160MHz";
+
 const struct iwl_cfg iwl_cfg_sc = {
 	.fw_name_mac = "sc",
 	IWL_DEVICE_SC,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 5fc9ce2b350e..d27aabea3814 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -550,6 +550,7 @@ extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
 extern const char iwl_fm_name[];
 extern const char iwl_wh_name[];
+extern const char iwl_sp_name[];
 extern const char iwl_gl_name[];
 extern const char iwl_mtp_name[];
 extern const char iwl_dr_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 08269168b2fa..cd1b0048bb6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -944,7 +944,8 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 				       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
 		break;
 	case NL80211_BAND_6GHZ:
-		if (!trans->reduced_cap_sku) {
+		if (!trans->reduced_cap_sku &&
+		    trans->bw_limit >= 320) {
 			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[0] |=
 				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[1] |=
@@ -1098,15 +1099,18 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &=
 			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 
-	if (trans->reduced_cap_sku) {
+	if (trans->bw_limit < 320 || trans->reduced_cap_sku) {
 		memset(&iftype_data->eht_cap.eht_mcs_nss_supp.bw._320, 0,
 		       sizeof(iftype_data->eht_cap.eht_mcs_nss_supp.bw._320));
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[2] &=
+			~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
+	}
+
+	if (trans->reduced_cap_sku) {
 		iftype_data->eht_cap.eht_mcs_nss_supp.bw._80.rx_tx_mcs13_max_nss = 0;
 		iftype_data->eht_cap.eht_mcs_nss_supp.bw._160.rx_tx_mcs13_max_nss = 0;
 		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[8] &=
 			~IEEE80211_EHT_PHY_CAP8_RX_4096QAM_WIDER_BW_DL_OFDMA;
-		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[2] &=
-			~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index cd347cd8176a..88b999886c2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1184,8 +1184,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc, iwl_wh_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
+		      160, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc, iwl_sp_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1199,8 +1204,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2, iwl_wh_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
+		      160, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc2, iwl_sp_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1214,8 +1224,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2f, iwl_wh_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
+		      160, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc2f, iwl_sp_name),
 
 /* Dr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.34.1


