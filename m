Return-Path: <linux-wireless+bounces-20047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D5CA57E7A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38DB16E15B
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6762080FB;
	Sat,  8 Mar 2025 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dv4T1QgC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2BC1FF61A
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468783; cv=none; b=cPautl+ASjF1vGdg4FkO1W38UaXtS5g2aubOsK4cQe6CZR08IY7YDA1efBFvMLu9RWUMfJhE+iorkXomf76yRFKfCSOEo+R7cojnaaZs9AlImKboR9DqsNWVgzEH7KjL+SlEkkB7R4UZC/uNh7YV/YWfdKcNW5ZA24akXTfLPZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468783; c=relaxed/simple;
	bh=El77FSaeXv2Jz3VNslgdmKdwlHda5ceJfe3PZPQ8xZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o1TkzPu1BCY6YMg2W9+O+SQG8BRyyp3KfVhKZrixnnKlMKNfWgNknoi0GKfKb7BK7OLKGUkrLbl7HKfYWyEDXV+jxwXDG6wrauZN4qJkjHWezpQFit+Oz7N4Nc94XJdQ+5GbXmRVX/kgFjSnUAFSriO+u90fcuZNmPqwbS/27Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dv4T1QgC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468782; x=1773004782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El77FSaeXv2Jz3VNslgdmKdwlHda5ceJfe3PZPQ8xZI=;
  b=dv4T1QgCVO+6UJg8e7nSKIhDCL12vou1rP4w3BWort3El2PsNGlGMFhI
   JuutWbYikVHciyKKgJwRrbeiqmP4oUZqBK5oTA7sNWKKAlyO+Np1Eozd7
   D3V+MqiI/42tEqj3SuzmK7zfM7pXVvHeLGg1nRUoiQXfgQxl/ALzG6DaI
   pyq/y7mGghTbDgtMl8iKATmpwo8LoJi9AU2pfmxAUAvnGm2PxEN1NDuX4
   X8eb3t0RiQDO2esqxHbPBTWX8fh12/hBOrdSQ1/iP7umS+FNBNsihM8SX
   1Phiq+qw6emAbJXwLJ7nwdsEWe/vBJugt1GPcDcntEj/UgfwoORkvHwLB
   Q==;
X-CSE-ConnectionGUID: 5JHTsfKzRmqTyf3QesShfg==
X-CSE-MsgGUID: W/ioSjXWR8qbTHNeH1UaMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052363"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052363"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:40 -0800
X-CSE-ConnectionGUID: VeHraarxQACA05bfBzrkwg==
X-CSE-MsgGUID: 4CAuXd5uReSIt3NPTsQtlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859893"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v3 wireless-next 01/14] wifi: iwlwifi: add support for BE213
Date: Sat,  8 Mar 2025 23:19:12 +0200
Message-Id: <20250308231426.f02f4d7fc73b.Idaf000dd311358e3b50a511f4efc1cc720abd58b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
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
index eb56af9a8411..05cbb80ab575 100644
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
index 7e4864c00780..b9bd89bfdd74 100644
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
index 03f7eb46bbc7..93446c374008 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1187,8 +1187,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
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
@@ -1202,8 +1207,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
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
@@ -1217,8 +1227,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
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


