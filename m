Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D7E3169EA
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhBJPRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:17:11 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45294 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230339AbhBJPRG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:17:06 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD8-0049kS-AE; Wed, 10 Feb 2021 17:15:23 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:12 +0200
Message-Id: <iwlwifi.20210210171218.50d11cbb073f.Ia44d022a4c549eb5fe0254fb20c62aa8d0bba634@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/12] iwlwifi: remove max_ht_ampdu_exponent config parameter
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This always has the same value, since we don't have any
devices with different values; remove the parameter.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |  8 +++-----
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c | 14 +++++--------
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  1 -
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |  8 +++-----
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c | 20 +++++++------------
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  3 +--
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  6 +-----
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  1 -
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 ---
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |  2 +-
 10 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
index 8a4579bb10d3..44c4fe975390 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -76,8 +76,7 @@ static const struct iwl_eeprom_params iwl1000_eeprom_params = {
 	.nvm_calib_ver = EEPROM_1000_TX_POWER_VERSION,	\
 	.trans.base_params = &iwl1000_base_params,		\
 	.eeprom_params = &iwl1000_eeprom_params,		\
-	.led_mode = IWL_LED_BLINK,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.led_mode = IWL_LED_BLINK
 
 const struct iwl_cfg iwl1000_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 1000 BGN",
@@ -102,8 +101,7 @@ const struct iwl_cfg iwl1000_bg_cfg = {
 	.trans.base_params = &iwl1000_base_params,		\
 	.eeprom_params = &iwl1000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
-	.rx_with_siso_diversity = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.rx_with_siso_diversity = true
 
 const struct iwl_cfg iwl100_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 100 BGN",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
index 7140a5f3ea8b..df6ac00340b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -102,8 +102,7 @@ static const struct iwl_eeprom_params iwl20x0_eeprom_params = {
 	.nvm_calib_ver = EEPROM_2000_TX_POWER_VERSION,		\
 	.trans.base_params = &iwl2000_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
-	.led_mode = IWL_LED_RF_STATE,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.led_mode = IWL_LED_RF_STATE
 
 
 const struct iwl_cfg iwl2000_2bgn_cfg = {
@@ -129,8 +128,7 @@ const struct iwl_cfg iwl2000_2bgn_d_cfg = {
 	.nvm_calib_ver = EEPROM_2000_TX_POWER_VERSION,	\
 	.trans.base_params = &iwl2030_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
-	.led_mode = IWL_LED_RF_STATE,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.led_mode = IWL_LED_RF_STATE
 
 const struct iwl_cfg iwl2030_2bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 2230 BGN",
@@ -150,8 +148,7 @@ const struct iwl_cfg iwl2030_2bgn_cfg = {
 	.trans.base_params = &iwl2000_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
-	.rx_with_siso_diversity = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.rx_with_siso_diversity = true
 
 const struct iwl_cfg iwl105_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 105 BGN",
@@ -177,8 +174,7 @@ const struct iwl_cfg iwl105_bgn_d_cfg = {
 	.trans.base_params = &iwl2030_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
-	.rx_with_siso_diversity = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.rx_with_siso_diversity = true
 
 const struct iwl_cfg iwl135_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 135 BGN",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index f27fb46f82d8..6c87cc121887 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -142,7 +142,6 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.mac_addr_from_csr = true,					\
 	.ht_params = &iwl_22000_ht_params,				\
 	.nvm_ver = IWL_22000_NVM_VERSION,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,		\
 	.trans.use_tfh = true,						\
 	.trans.rf_id = true,						\
 	.trans.gen2 = true,						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
index 3591336dc644..6cdd7d983bda 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -74,8 +74,7 @@ static const struct iwl_eeprom_params iwl5000_eeprom_params = {
 	.nvm_calib_ver = EEPROM_5000_TX_POWER_VERSION,	\
 	.trans.base_params = &iwl5000_base_params,		\
 	.eeprom_params = &iwl5000_eeprom_params,		\
-	.led_mode = IWL_LED_BLINK,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.led_mode = IWL_LED_BLINK
 
 const struct iwl_cfg iwl5300_agn_cfg = {
 	.name = "Intel(R) Ultimate N WiFi Link 5300 AGN",
@@ -138,8 +137,7 @@ const struct iwl_cfg iwl5350_agn_cfg = {
 	.trans.base_params = &iwl5000_base_params,		\
 	.eeprom_params = &iwl5000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
-	.internal_wimax_coex = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.internal_wimax_coex = true
 
 const struct iwl_cfg iwl5150_agn_cfg = {
 	.name = "Intel(R) WiMAX/WiFi Link 5150 AGN",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
index b4a8a6804c39..541a3ec85777 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -123,8 +123,7 @@ static const struct iwl_eeprom_params iwl6000_eeprom_params = {
 	.nvm_calib_ver = EEPROM_6005_TX_POWER_VERSION,	\
 	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
-	.led_mode = IWL_LED_RF_STATE,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.led_mode = IWL_LED_RF_STATE
 
 const struct iwl_cfg iwl6005_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6205 AGN",
@@ -177,8 +176,7 @@ const struct iwl_cfg iwl6005_2agn_mow2_cfg = {
 	.nvm_calib_ver = EEPROM_6030_TX_POWER_VERSION,	\
 	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
-	.led_mode = IWL_LED_RF_STATE,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.led_mode = IWL_LED_RF_STATE
 
 const struct iwl_cfg iwl6030_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6230 AGN",
@@ -213,8 +211,7 @@ const struct iwl_cfg iwl6030_2bg_cfg = {
 	.nvm_calib_ver = EEPROM_6030_TX_POWER_VERSION,	\
 	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
-	.led_mode = IWL_LED_RF_STATE,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.led_mode = IWL_LED_RF_STATE
 
 const struct iwl_cfg iwl6035_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6235 AGN",
@@ -268,8 +265,7 @@ const struct iwl_cfg iwl130_bg_cfg = {
 	.nvm_calib_ver = EEPROM_6000_TX_POWER_VERSION,	\
 	.trans.base_params = &iwl6000_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
-	.led_mode = IWL_LED_BLINK,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.led_mode = IWL_LED_BLINK
 
 const struct iwl_cfg iwl6000i_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6200 AGN",
@@ -301,8 +297,7 @@ const struct iwl_cfg iwl6000i_2bg_cfg = {
 	.trans.base_params = &iwl6050_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
-	.internal_wimax_coex = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.internal_wimax_coex = true
 
 const struct iwl_cfg iwl6050_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 AGN",
@@ -327,8 +322,7 @@ const struct iwl_cfg iwl6050_2abg_cfg = {
 	.trans.base_params = &iwl6050_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
-	.internal_wimax_coex = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
+	.internal_wimax_coex = true
 
 const struct iwl_cfg iwl6150_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BGN",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index c542140e534e..b24dc5523a52 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
@@ -95,7 +95,6 @@ static const struct iwl_ht_params iwl7000_ht_params = {
 	.led_mode = IWL_LED_RF_STATE,				\
 	.nvm_hw_section_num = 0,				\
 	.non_shared_ant = ANT_A,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
 	.dccm_offset = IWL7000_DCCM_OFFSET
 
 #define IWL_DEVICE_7000						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 4ff8a56414a3..a6454287d506 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2014, 2018-2020 Intel Corporation
  * Copyright (C) 2014-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -125,7 +125,6 @@ const struct iwl_cfg iwl8260_2ac_cfg = {
 	IWL_DEVICE_8260,
 	.ht_params = &iwl8000_ht_params,
 	.nvm_ver = IWL8000_NVM_VERSION,
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
 };
 
 const struct iwl_cfg iwl8265_2ac_cfg = {
@@ -134,7 +133,6 @@ const struct iwl_cfg iwl8265_2ac_cfg = {
 	IWL_DEVICE_8265,
 	.ht_params = &iwl8000_ht_params,
 	.nvm_ver = IWL8000_NVM_VERSION,
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
 	.vht_mu_mimo_supported = true,
 };
 
@@ -144,7 +142,6 @@ const struct iwl_cfg iwl8275_2ac_cfg = {
 	IWL_DEVICE_8265,
 	.ht_params = &iwl8000_ht_params,
 	.nvm_ver = IWL8000_NVM_VERSION,
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
 	.vht_mu_mimo_supported = true,
 };
 
@@ -154,7 +151,6 @@ const struct iwl_cfg iwl4165_2ac_cfg = {
 	IWL_DEVICE_8000,
 	.ht_params = &iwl8000_ht_params,
 	.nvm_ver = IWL8000_NVM_VERSION,
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
 };
 
 MODULE_FIRMWARE(IWL8000_MODULE_FIRMWARE(IWL8000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index eb5db204d84b..c4164bf508e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -97,7 +97,6 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.d3_debug_data_length = 92 * 1024,				\
 	.ht_params = &iwl9000_ht_params,				\
 	.nvm_ver = IWL9000_NVM_VERSION,					\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,		\
 	.mon_smem_regs = {						\
 		.write_ptr = {						\
 			.addr = LDBG_M2S_BUF_WPTR,			\
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index e8b7b7618a3c..75f99ff7f908 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -325,8 +325,6 @@ struct iwl_fw_mon_regs {
  * @features: hw features, any combination of feature_passlist
  * @pwr_tx_backoffs: translation table between power limits and backoffs
  * @max_tx_agg_size: max TX aggregation size of the ADDBA request/response
- * @max_ht_ampdu_factor: the exponent of the max length of A-MPDU that the
- *	station can receive in HT
  * @dccm_offset: offset from which DCCM begins
  * @dccm_len: length of DCCM (including runtime stack CCM)
  * @dccm2_offset: offset from which the second DCCM begins
@@ -393,7 +391,6 @@ struct iwl_cfg {
 	u8 non_shared_ant;
 	u8 nvm_hw_section_num;
 	u8 max_tx_agg_size;
-	u8 max_ht_ampdu_exponent;
 	u8 ucode_api_max;
 	u8 ucode_api_min;
 	u16 num_rbds;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index 43a04bc50774..f12b86563728 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -715,7 +715,7 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 	    iwlwifi_mod_params.amsdu_size >= IWL_AMSDU_8K)
 		ht_info->cap |= IEEE80211_HT_CAP_MAX_AMSDU;
 
-	ht_info->ampdu_factor = cfg->max_ht_ampdu_exponent;
+	ht_info->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	ht_info->ampdu_density = IEEE80211_HT_MPDU_DENSITY_4;
 
 	ht_info->mcs.rx_mask[0] = 0xFF;
-- 
2.30.0

