Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A384A62AE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 09:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfICHhd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 03:37:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40210 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbfICHhc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 03:37:32 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i53NR-0004Cd-Fh; Tue, 03 Sep 2019 10:37:24 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  3 Sep 2019 10:36:54 +0300
Message-Id: <20190903073714.32278-2-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903073714.32278-1-luca@coelho.fi>
References: <20190903073714.32278-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 01/21] iwlwifi: separate elements from cfg that are needed by trans_alloc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

In order to be able to select the cfg depending on the HW revision or
on the RF ID, we need to set up the trans before selecting the cfg.
To do so, move the elements from cfg that are needed by
iwl_trans_alloc() to a separate struct at the top of the cfg, so it
can be used by other cfg types as well, before selecting the rest of
the configuration.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |  14 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |  26 ++--
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  34 ++---
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |  18 +--
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  44 +++---
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  10 +-
 .../net/wireless/intel/iwlwifi/dvm/devices.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c  |   5 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   6 +-
 .../net/wireless/intel/iwlwifi/dvm/power.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  32 +++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/paging.c    |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  49 ++++---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  10 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |   6 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-read.c  |  14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |   6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  21 +--
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |  18 ++-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  16 +--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/led.c  |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  11 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   4 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  56 ++++----
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  10 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 132 ++++++++++--------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  83 +++++------
 47 files changed, 407 insertions(+), 365 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
index a1aa2956b382..b92255b91b72 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -69,16 +69,16 @@ static const struct iwl_eeprom_params iwl1000_eeprom_params = {
 	.fw_name_pre = IWL1000_FW_PRE,				\
 	.ucode_api_max = IWL1000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL1000_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_1000,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_1000,		\
 	.max_inst_size = IWLAGN_RTC_INST_SIZE,			\
 	.max_data_size = IWLAGN_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_1000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_1000_TX_POWER_VERSION,	\
-	.base_params = &iwl1000_base_params,			\
+	.trans.base_params = &iwl1000_base_params,		\
 	.eeprom_params = &iwl1000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl1000_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 1000 BGN",
@@ -95,17 +95,17 @@ const struct iwl_cfg iwl1000_bg_cfg = {
 	.fw_name_pre = IWL100_FW_PRE,				\
 	.ucode_api_max = IWL100_UCODE_API_MAX,			\
 	.ucode_api_min = IWL100_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_100,			\
+	.trans.device_family = IWL_DEVICE_FAMILY_100,		\
 	.max_inst_size = IWLAGN_RTC_INST_SIZE,			\
 	.max_data_size = IWLAGN_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_1000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_1000_TX_POWER_VERSION,	\
-	.base_params = &iwl1000_base_params,			\
+	.trans.base_params = &iwl1000_base_params,		\
 	.eeprom_params = &iwl1000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl100_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 100 BGN",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
index 4a988b676913..2b1ae0cecc83 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -95,16 +95,16 @@ static const struct iwl_eeprom_params iwl20x0_eeprom_params = {
 	.fw_name_pre = IWL2000_FW_PRE,				\
 	.ucode_api_max = IWL2000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL2000_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_2000,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_2000,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_2000_EEPROM_VERSION,			\
 	.nvm_calib_ver = EEPROM_2000_TX_POWER_VERSION,		\
-	.base_params = &iwl2000_base_params,			\
+	.trans.base_params = &iwl2000_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 
 const struct iwl_cfg iwl2000_2bgn_cfg = {
@@ -123,16 +123,16 @@ const struct iwl_cfg iwl2000_2bgn_d_cfg = {
 	.fw_name_pre = IWL2030_FW_PRE,				\
 	.ucode_api_max = IWL2030_UCODE_API_MAX,			\
 	.ucode_api_min = IWL2030_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_2030,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_2030,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_2000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_2000_TX_POWER_VERSION,	\
-	.base_params = &iwl2030_base_params,			\
+	.trans.base_params = &iwl2030_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl2030_2bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 2230 BGN",
@@ -144,17 +144,17 @@ const struct iwl_cfg iwl2030_2bgn_cfg = {
 	.fw_name_pre = IWL105_FW_PRE,				\
 	.ucode_api_max = IWL105_UCODE_API_MAX,			\
 	.ucode_api_min = IWL105_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_105,			\
+	.trans.device_family = IWL_DEVICE_FAMILY_105,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_2000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_2000_TX_POWER_VERSION,	\
-	.base_params = &iwl2000_base_params,			\
+	.trans.base_params = &iwl2000_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl105_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 105 BGN",
@@ -172,17 +172,17 @@ const struct iwl_cfg iwl105_bgn_d_cfg = {
 	.fw_name_pre = IWL135_FW_PRE,				\
 	.ucode_api_max = IWL135_UCODE_API_MAX,			\
 	.ucode_api_min = IWL135_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_135,			\
+	.trans.device_family = IWL_DEVICE_FAMILY_135,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_2000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_2000_TX_POWER_VERSION,	\
-	.base_params = &iwl2030_base_params,			\
+	.trans.base_params = &iwl2030_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl135_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 135 BGN",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 894c1e4cc582..4ef28d916fd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -169,15 +169,15 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.smem_len = IWL_22000_SMEM_LEN,					\
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.apmg_not_supported = true,					\
-	.mq_rx_supported = true,					\
+	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = true,					\
 	.ht_params = &iwl_22000_ht_params,				\
 	.nvm_ver = IWL_22000_NVM_VERSION,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,		\
-	.use_tfh = true,						\
-	.rf_id = true,							\
-	.gen2 = true,							\
+	.trans.use_tfh = true,						\
+	.trans.rf_id = true,						\
+	.trans.gen2 = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x400000,				\
@@ -190,23 +190,23 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 
 #define IWL_DEVICE_22500						\
 	IWL_DEVICE_22000_COMMON,					\
-	.device_family = IWL_DEVICE_FAMILY_22000,			\
-	.base_params = &iwl_22000_base_params,				\
-	.csr = &iwl_csr_v1,						\
+	.trans.device_family = IWL_DEVICE_FAMILY_22000,			\
+	.trans.base_params = &iwl_22000_base_params,			\
+	.trans.csr = &iwl_csr_v1,					\
 	.gp2_reg_addr = 0xa02c68
 
 #define IWL_DEVICE_22560						\
 	IWL_DEVICE_22000_COMMON,					\
-	.device_family = IWL_DEVICE_FAMILY_22560,			\
-	.base_params = &iwl_22560_base_params,				\
-	.csr = &iwl_csr_v2
+	.trans.device_family = IWL_DEVICE_FAMILY_22560,			\
+	.trans.base_params = &iwl_22560_base_params,			\
+	.trans.csr = &iwl_csr_v2
 
 #define IWL_DEVICE_AX210						\
 	IWL_DEVICE_22000_COMMON,					\
-	.umac_prph_offset = 0x300000,					\
-	.device_family = IWL_DEVICE_FAMILY_AX210,			\
-	.base_params = &iwl_22560_base_params,				\
-	.csr = &iwl_csr_v1,						\
+	.trans.umac_prph_offset = 0x300000,				\
+	.trans.device_family = IWL_DEVICE_FAMILY_AX210,			\
+	.trans.base_params = &iwl_22560_base_params,			\
+	.trans.csr = &iwl_csr_v1,					\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
 	.min_256_ba_txq_size = 512
@@ -336,7 +336,7 @@ const struct iwl_cfg iwl_ax200_cfg_cc = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.bisr_workaround = 1,
+	.trans.bisr_workaround = 1,
 };
 
 const struct iwl_cfg killer1650x_2ax_cfg = {
@@ -349,7 +349,7 @@ const struct iwl_cfg killer1650x_2ax_cfg = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.bisr_workaround = 1,
+	.trans.bisr_workaround = 1,
 };
 
 const struct iwl_cfg killer1650w_2ax_cfg = {
@@ -362,7 +362,7 @@ const struct iwl_cfg killer1650w_2ax_cfg = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.bisr_workaround = 1,
+	.trans.bisr_workaround = 1,
 };
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
index ce25c690d69c..aab4495c6085 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -67,16 +67,16 @@ static const struct iwl_eeprom_params iwl5000_eeprom_params = {
 	.fw_name_pre = IWL5000_FW_PRE,				\
 	.ucode_api_max = IWL5000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL5000_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_5000,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_5000,		\
 	.max_inst_size = IWLAGN_RTC_INST_SIZE,			\
 	.max_data_size = IWLAGN_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_5000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_5000_TX_POWER_VERSION,	\
-	.base_params = &iwl5000_base_params,			\
+	.trans.base_params = &iwl5000_base_params,		\
 	.eeprom_params = &iwl5000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl5300_agn_cfg = {
 	.name = "Intel(R) Ultimate N WiFi Link 5300 AGN",
@@ -115,34 +115,34 @@ const struct iwl_cfg iwl5350_agn_cfg = {
 	.fw_name_pre = IWL5000_FW_PRE,
 	.ucode_api_max = IWL5000_UCODE_API_MAX,
 	.ucode_api_min = IWL5000_UCODE_API_MIN,
-	.device_family = IWL_DEVICE_FAMILY_5000,
+	.trans.device_family = IWL_DEVICE_FAMILY_5000,
 	.max_inst_size = IWLAGN_RTC_INST_SIZE,
 	.max_data_size = IWLAGN_RTC_DATA_SIZE,
 	.nvm_ver = EEPROM_5050_EEPROM_VERSION,
 	.nvm_calib_ver = EEPROM_5050_TX_POWER_VERSION,
-	.base_params = &iwl5000_base_params,
+	.trans.base_params = &iwl5000_base_params,
 	.eeprom_params = &iwl5000_eeprom_params,
 	.ht_params = &iwl5000_ht_params,
 	.led_mode = IWL_LED_BLINK,
 	.internal_wimax_coex = true,
-	.csr = &iwl_csr_v1,
+	.trans.csr = &iwl_csr_v1,
 };
 
 #define IWL_DEVICE_5150						\
 	.fw_name_pre = IWL5150_FW_PRE,				\
 	.ucode_api_max = IWL5150_UCODE_API_MAX,			\
 	.ucode_api_min = IWL5150_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_5150,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_5150,		\
 	.max_inst_size = IWLAGN_RTC_INST_SIZE,			\
 	.max_data_size = IWLAGN_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_5050_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_5050_TX_POWER_VERSION,	\
-	.base_params = &iwl5000_base_params,			\
+	.trans.base_params = &iwl5000_base_params,		\
 	.eeprom_params = &iwl5000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl5150_agn_cfg = {
 	.name = "Intel(R) WiMAX/WiFi Link 5150 AGN",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
index 67d61a1588a9..39ea81903dbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -116,16 +116,16 @@ static const struct iwl_eeprom_params iwl6000_eeprom_params = {
 	.fw_name_pre = IWL6005_FW_PRE,				\
 	.ucode_api_max = IWL6000G2_UCODE_API_MAX,		\
 	.ucode_api_min = IWL6000G2_UCODE_API_MIN,		\
-	.device_family = IWL_DEVICE_FAMILY_6005,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_6005,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_6005_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6005_TX_POWER_VERSION,	\
-	.base_params = &iwl6000_g2_base_params,			\
+	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl6005_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6205 AGN",
@@ -171,16 +171,16 @@ const struct iwl_cfg iwl6005_2agn_mow2_cfg = {
 	.fw_name_pre = IWL6030_FW_PRE,				\
 	.ucode_api_max = IWL6000G2_UCODE_API_MAX,		\
 	.ucode_api_min = IWL6000G2_UCODE_API_MIN,		\
-	.device_family = IWL_DEVICE_FAMILY_6030,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_6030,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_6030_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6030_TX_POWER_VERSION,	\
-	.base_params = &iwl6000_g2_base_params,			\
+	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl6030_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6230 AGN",
@@ -208,16 +208,16 @@ const struct iwl_cfg iwl6030_2bg_cfg = {
 	.fw_name_pre = IWL6030_FW_PRE,				\
 	.ucode_api_max = IWL6035_UCODE_API_MAX,			\
 	.ucode_api_min = IWL6035_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_6030,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_6030,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_6030_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6030_TX_POWER_VERSION,	\
-	.base_params = &iwl6000_g2_base_params,			\
+	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl6035_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6235 AGN",
@@ -262,18 +262,18 @@ const struct iwl_cfg iwl130_bg_cfg = {
 	.fw_name_pre = IWL6000_FW_PRE,				\
 	.ucode_api_max = IWL6000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL6000_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_6000i,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_6000i,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.valid_tx_ant = ANT_BC,		/* .cfg overwrite */	\
 	.valid_rx_ant = ANT_BC,		/* .cfg overwrite */	\
 	.nvm_ver = EEPROM_6000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6000_TX_POWER_VERSION,	\
-	.base_params = &iwl6000_base_params,			\
+	.trans.base_params = &iwl6000_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl6000i_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6200 AGN",
@@ -295,19 +295,19 @@ const struct iwl_cfg iwl6000i_2bg_cfg = {
 	.fw_name_pre = IWL6050_FW_PRE,				\
 	.ucode_api_max = IWL6050_UCODE_API_MAX,			\
 	.ucode_api_min = IWL6050_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_6050,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_6050,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.valid_tx_ant = ANT_AB,		/* .cfg overwrite */	\
 	.valid_rx_ant = ANT_AB,		/* .cfg overwrite */	\
 	.nvm_ver = EEPROM_6050_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6050_TX_POWER_VERSION,	\
-	.base_params = &iwl6050_base_params,			\
+	.trans.base_params = &iwl6050_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl6050_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 AGN",
@@ -324,17 +324,17 @@ const struct iwl_cfg iwl6050_2abg_cfg = {
 	.fw_name_pre = IWL6050_FW_PRE,				\
 	.ucode_api_max = IWL6050_UCODE_API_MAX,			\
 	.ucode_api_min = IWL6050_UCODE_API_MIN,			\
-	.device_family = IWL_DEVICE_FAMILY_6150,		\
+	.trans.device_family = IWL_DEVICE_FAMILY_6150,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_6150_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6150_TX_POWER_VERSION,	\
-	.base_params = &iwl6050_base_params,			\
+	.trans.base_params = &iwl6050_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 const struct iwl_cfg iwl6150_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BGN",
@@ -352,16 +352,16 @@ const struct iwl_cfg iwl6000_3agn_cfg = {
 	.fw_name_pre = IWL6000_FW_PRE,
 	.ucode_api_max = IWL6000_UCODE_API_MAX,
 	.ucode_api_min = IWL6000_UCODE_API_MIN,
-	.device_family = IWL_DEVICE_FAMILY_6000,
+	.trans.device_family = IWL_DEVICE_FAMILY_6000,
 	.max_inst_size = IWL60_RTC_INST_SIZE,
 	.max_data_size = IWL60_RTC_DATA_SIZE,
 	.nvm_ver = EEPROM_6000_EEPROM_VERSION,
 	.nvm_calib_ver = EEPROM_6000_TX_POWER_VERSION,
-	.base_params = &iwl6000_base_params,
+	.trans.base_params = &iwl6000_base_params,
 	.eeprom_params = &iwl6000_eeprom_params,
 	.ht_params = &iwl6000_ht_params,
 	.led_mode = IWL_LED_BLINK,
-	.csr = &iwl_csr_v1,
+	.trans.csr = &iwl_csr_v1,
 };
 
 MODULE_FIRMWARE(IWL6000_MODULE_FIRMWARE(IWL6000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index 289e3c398a12..deb520aeb3f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015        Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015        Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -148,14 +148,14 @@ static const struct iwl_ht_params iwl7000_ht_params = {
 };
 
 #define IWL_DEVICE_7000_COMMON					\
-	.device_family = IWL_DEVICE_FAMILY_7000,		\
-	.base_params = &iwl7000_base_params,			\
+	.trans.device_family = IWL_DEVICE_FAMILY_7000,		\
+	.trans.base_params = &iwl7000_base_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.nvm_hw_section_num = 0,				\
 	.non_shared_ant = ANT_A,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
 	.dccm_offset = IWL7000_DCCM_OFFSET,			\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 #define IWL_DEVICE_7000						\
 	IWL_DEVICE_7000_COMMON,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index d7d17c1cceea..b3cc477140c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -8,7 +8,7 @@
  * Copyright(c) 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2014 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016        Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -30,7 +30,7 @@
  *
  * Copyright(c) 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2014 - 2015 Intel Mobile Communications GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -134,8 +134,8 @@ static const struct iwl_tt_params iwl8000_tt_params = {
 };
 
 #define IWL_DEVICE_8000_COMMON						\
-	.device_family = IWL_DEVICE_FAMILY_8000,			\
-	.base_params = &iwl8000_base_params,				\
+	.trans.device_family = IWL_DEVICE_FAMILY_8000,			\
+	.trans.base_params = &iwl8000_base_params,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.nvm_hw_section_num = 10,					\
 	.features = NETIF_F_RXCSUM,					\
@@ -152,7 +152,7 @@ static const struct iwl_tt_params iwl8000_tt_params = {
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x800000,				\
-	.csr = &iwl_csr_v1
+	.trans.csr = &iwl_csr_v1
 
 #define IWL_DEVICE_8000							\
 	IWL_DEVICE_8000_COMMON,						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 41bdd0eaf62c..e8372b67df03 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -122,8 +122,8 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 #define IWL_DEVICE_9000							\
 	.ucode_api_max = IWL9000_UCODE_API_MAX,				\
 	.ucode_api_min = IWL9000_UCODE_API_MIN,				\
-	.device_family = IWL_DEVICE_FAMILY_9000,			\
-	.base_params = &iwl9000_base_params,				\
+	.trans.device_family = IWL_DEVICE_FAMILY_9000,			\
+	.trans.base_params = &iwl9000_base_params,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.nvm_hw_section_num = 10,					\
 	.non_shared_ant = ANT_B,					\
@@ -136,14 +136,14 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.thermal_params = &iwl9000_tt_params,				\
 	.apmg_not_supported = true,					\
-	.mq_rx_supported = true,					\
+	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = true,					\
-	.rf_id = true,							\
+	.trans.rf_id = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x800000,				\
-	.csr = &iwl_csr_v1,						\
+	.trans.csr = &iwl_csr_v1,					\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 92 * 1024,				\
 	.ht_params = &iwl9000_ht_params,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
index b39f8b1475e1..73b3a947ab7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
@@ -2,6 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
+ * Copyright (C) 2019 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -483,7 +484,7 @@ static void iwl6000_set_ct_threshold(struct iwl_priv *priv)
 /* NIC configuration for 6000 series */
 static void iwl6000_nic_config(struct iwl_priv *priv)
 {
-	switch (priv->cfg->device_family) {
+	switch (priv->cfg->trans.device_family) {
 	case IWL_DEVICE_FAMILY_6005:
 	case IWL_DEVICE_FAMILY_6030:
 	case IWL_DEVICE_FAMILY_6000:
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/led.c b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
index 38fd41fba661..1e1664ecf30b 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
@@ -2,6 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
+ * Copyright (C) 2019 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -120,9 +121,9 @@ static int iwl_led_cmd(struct iwl_priv *priv,
 	}
 
 	led_cmd.on = iwl_blink_compensation(priv, on,
-				priv->cfg->base_params->led_compensation);
+				priv->cfg->trans.base_params->led_compensation);
 	led_cmd.off = iwl_blink_compensation(priv, off,
-				priv->cfg->base_params->led_compensation);
+				priv->cfg->trans.base_params->led_compensation);
 
 	ret = iwl_send_led_cmd(priv, &led_cmd);
 	if (!ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 6c170636110a..c223f26f046e 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -1099,7 +1099,7 @@ static void iwlagn_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto done;
 	}
 
-	scd_queues = BIT(priv->cfg->base_params->num_of_queues) - 1;
+	scd_queues = BIT(priv->cfg->trans.base_params->num_of_queues) - 1;
 	scd_queues &= ~(BIT(IWL_IPAN_CMD_QUEUE_NUM) |
 			BIT(IWL_DEFAULT_CMD_QUEUE_NUM));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index ae5e4570f1c1..8e47a075089f 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -1267,7 +1267,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	priv->cfg = cfg;
 	priv->fw = fw;
 
-	switch (priv->cfg->device_family) {
+	switch (priv->cfg->trans.device_family) {
 	case IWL_DEVICE_FAMILY_1000:
 	case IWL_DEVICE_FAMILY_100:
 		priv->lib = &iwl_dvm_1000_cfg;
@@ -1342,7 +1342,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 					  driver_data[2]);
 
 	WARN_ON(sizeof(priv->transport_queue_stop) * BITS_PER_BYTE <
-		priv->cfg->base_params->num_of_queues);
+		priv->cfg->trans.base_params->num_of_queues);
 
 	ucode_flags = fw->ucode_capa.flags;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/power.c b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
index dcb948068c1d..e4e02fcbcd9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
@@ -2,6 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
+ * Copyright (C) 2019 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -199,7 +200,7 @@ static void iwl_static_sleep_cmd(struct iwl_priv *priv,
 	else
 		cmd->flags &= ~IWL_POWER_SLEEP_OVER_DTIM_MSK;
 
-	if (priv->cfg->base_params->shadow_reg_enable)
+	if (priv->cfg->trans.base_params->shadow_reg_enable)
 		cmd->flags |= IWL_POWER_SHADOW_REG_ENA;
 	else
 		cmd->flags &= ~IWL_POWER_SHADOW_REG_ENA;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 247f41705912..75dc911b8f00 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -2,6 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
+ * Copyright (C) 2019 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -467,7 +468,7 @@ static int iwlagn_alloc_agg_txq(struct iwl_priv *priv, int mq)
 	int q;
 
 	for (q = IWLAGN_FIRST_AMPDU_QUEUE;
-	     q < priv->cfg->base_params->num_of_queues; q++) {
+	     q < priv->cfg->trans.base_params->num_of_queues; q++) {
 		if (!test_and_set_bit(q, priv->agg_q_alloc)) {
 			priv->queue_to_mac80211[q] = mq;
 			return q;
@@ -1281,7 +1282,7 @@ void iwlagn_rx_reply_compressed_ba(struct iwl_priv *priv,
 	 * (in Tx queue's circular buffer) of first TFD/frame in window */
 	u16 ba_resp_scd_ssn = le16_to_cpu(ba_resp->scd_ssn);
 
-	if (scd_flow >= priv->cfg->base_params->num_of_queues) {
+	if (scd_flow >= priv->cfg->trans.base_params->num_of_queues) {
 		IWL_ERR(priv,
 			"BUG_ON scd_flow is bigger than number of queues\n");
 		return;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 04afaec2d80e..ef5c75bbd0dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -243,7 +243,7 @@ static void iwl_fw_dump_rxf(struct iwl_fw_runtime *fwrt,
 		/* Pull RXF2 */
 		iwl_fwrt_dump_rxf(fwrt, dump_data, cfg->rxfifo2_size,
 				  RXF_DIFF_FROM_PREV +
-				  fwrt->trans->cfg->umac_prph_offset, 1);
+				  fwrt->trans->cfg->trans.umac_prph_offset, 1);
 		/* Pull LMAC2 RXF1 */
 		if (fwrt->smem_cfg.num_lmacs > 1)
 			iwl_fwrt_dump_rxf(fwrt, dump_data,
@@ -684,17 +684,18 @@ static void iwl_fw_prph_handler(struct iwl_fw_runtime *fwrt, void *ptr,
 {
 	u32 range_len;
 
-	if (fwrt->trans->cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (fwrt->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_AX210) {
 		range_len = ARRAY_SIZE(iwl_prph_dump_addr_ax210);
 		handler(fwrt, iwl_prph_dump_addr_ax210, range_len, ptr);
-	} else if (fwrt->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+	} else if (fwrt->trans->cfg->trans.device_family >=
+		   IWL_DEVICE_FAMILY_22000) {
 		range_len = ARRAY_SIZE(iwl_prph_dump_addr_22000);
 		handler(fwrt, iwl_prph_dump_addr_22000, range_len, ptr);
 	} else {
 		range_len = ARRAY_SIZE(iwl_prph_dump_addr_comm);
 		handler(fwrt, iwl_prph_dump_addr_comm, range_len, ptr);
 
-		if (fwrt->trans->cfg->mq_rx_supported) {
+		if (fwrt->trans->cfg->trans.mq_rx_supported) {
 			range_len = ARRAY_SIZE(iwl_prph_dump_addr_9000);
 			handler(fwrt, iwl_prph_dump_addr_9000, range_len, ptr);
 		}
@@ -856,7 +857,8 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 			iwl_fw_prph_handler(fwrt, &prph_len,
 					    iwl_fw_get_prph_len);
 
-		if (fwrt->trans->cfg->device_family == IWL_DEVICE_FAMILY_7000 &&
+		if (fwrt->trans->cfg->trans.device_family ==
+		    IWL_DEVICE_FAMILY_7000 &&
 		    iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_RADIO_REG))
 			radio_len = sizeof(*dump_data) + RADIO_REG_MAX_READ;
 	}
@@ -1136,7 +1138,7 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_error_dump_range *range;
 	u32 page_size;
 
-	if (!fwrt->trans->cfg->gen2)
+	if (!fwrt->trans->cfg->trans.gen2)
 		return _iwl_dump_ini_paging_iter(fwrt, reg, range_ptr, idx);
 
 	range = range_ptr;
@@ -1442,7 +1444,7 @@ static void
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
 	u32 write_ptr_addr, write_ptr_msk, cycle_cnt_addr, cycle_cnt_msk;
 
-	switch (fwrt->trans->cfg->device_family) {
+	switch (fwrt->trans->cfg->trans.device_family) {
 	case IWL_DEVICE_FAMILY_9000:
 	case IWL_DEVICE_FAMILY_22000:
 		write_ptr_addr = MON_BUFF_WRPTR_VER2;
@@ -1452,7 +1454,7 @@ static void
 		break;
 	default:
 		IWL_ERR(fwrt, "Unsupported device family %d\n",
-			fwrt->trans->cfg->device_family);
+			fwrt->trans->cfg->trans.device_family);
 		return NULL;
 	}
 
@@ -1469,10 +1471,10 @@ static void
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
 	const struct iwl_cfg *cfg = fwrt->trans->cfg;
 
-	if (fwrt->trans->cfg->device_family != IWL_DEVICE_FAMILY_9000 &&
-	    fwrt->trans->cfg->device_family != IWL_DEVICE_FAMILY_22000) {
+	if (fwrt->trans->cfg->trans.device_family != IWL_DEVICE_FAMILY_9000 &&
+	    fwrt->trans->cfg->trans.device_family != IWL_DEVICE_FAMILY_22000) {
 		IWL_ERR(fwrt, "Unsupported device family %d\n",
-			fwrt->trans->cfg->device_family);
+			fwrt->trans->cfg->trans.device_family);
 		return NULL;
 	}
 
@@ -1493,7 +1495,7 @@ static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
 static u32 iwl_dump_ini_paging_ranges(struct iwl_fw_runtime *fwrt,
 				      struct iwl_fw_ini_region_cfg *reg)
 {
-	if (fwrt->trans->cfg->gen2)
+	if (fwrt->trans->cfg->trans.gen2)
 		return fwrt->trans->init_dram.paging_cnt;
 
 	return fwrt->num_of_paging_blk;
@@ -1541,7 +1543,7 @@ static u32 iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
 	u32 range_header_len = sizeof(struct iwl_fw_ini_error_dump_range);
 	u32 size = sizeof(struct iwl_fw_ini_error_dump);
 
-	if (fwrt->trans->cfg->gen2) {
+	if (fwrt->trans->cfg->trans.gen2) {
 		for (i = 0; i < iwl_dump_ini_paging_ranges(fwrt, reg); i++)
 			size += range_header_len +
 				fwrt->trans->init_dram.paging[i].size;
@@ -2470,7 +2472,7 @@ static int iwl_fw_dbg_suspend_resume_hcmd(struct iwl_trans *trans, bool suspend)
 static void iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
 				      struct iwl_fw_dbg_params *params)
 {
-	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+	if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
 		return;
 	}
@@ -2494,7 +2496,7 @@ static int iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 	if (!params)
 		return -EIO;
 
-	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+	if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
 		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
 		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index deb84ba3dc7e..0c8da5e07854 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -302,7 +302,7 @@ static inline bool iwl_fw_dbg_is_d3_debug_enabled(struct iwl_fw_runtime *fwrt)
 static inline bool iwl_fw_dbg_is_paging_enabled(struct iwl_fw_runtime *fwrt)
 {
 	return iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_PAGING) &&
-		!fwrt->trans->cfg->gen2 &&
+		!fwrt->trans->cfg->trans.gen2 &&
 		fwrt->cur_fw_img < IWL_UCODE_TYPE_MAX &&
 		fwrt->fw->img[fwrt->cur_fw_img].paging_mem_size &&
 		fwrt->fw_paging_db[0].fw_paging_block;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/paging.c b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
index 9b8dd7fe7112..705eeff1a645 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/paging.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -322,7 +322,7 @@ int iwl_init_paging(struct iwl_fw_runtime *fwrt, enum iwl_ucode_type type)
 	const struct fw_img *fw = &fwrt->fw->img[type];
 	int ret;
 
-	if (fwrt->trans->cfg->gen2)
+	if (fwrt->trans->cfg->trans.gen2)
 		return 0;
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/smem.c b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
index 557ee47bffd8..a88117d48ade 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/smem.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
@@ -151,7 +151,7 @@ void iwl_get_shared_mem_conf(struct iwl_fw_runtime *fwrt)
 	}
 
 	pkt = cmd.resp_pkt;
-	if (fwrt->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000)
+	if (fwrt->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000)
 		iwl_parse_shared_mem_22000(fwrt, pkt);
 	else
 		iwl_parse_shared_mem(fwrt, pkt);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 1c1bf1b281cd..02b65e2580a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -161,7 +161,8 @@ static inline u8 num_of_ant(u8 mask)
 		!!((mask) & ANT_C);
 }
 
-/*
+/**
+ * struct iwl_base_params - params not likely to change within a device family
  * @max_ll_items: max number of OTP blocks
  * @shadow_ram_support: shadow support for OTP memory
  * @led_compensation: compensate on the led on/off time per HW according
@@ -330,8 +331,37 @@ struct iwl_csr_params {
 	u32 mac_addr1_strap;
 };
 
+/**
+ * struct iwl_cfg_trans - information needed to start the trans
+ *
+ * These values cannot be changed when multiple configs are used for a
+ * single PCI ID, because they are needed before the HW REV or RFID
+ * can be read.
+ *
+ * @base_params: pointer to basic parameters
+ * @csr: csr flags and addresses that are different across devices
+ * @device_family: the device family
+ * @umac_prph_offset: offset to add to UMAC periphery address
+ * @rf_id: need to read rf_id to determine the firmware image
+ * @use_tfh: use TFH
+ * @gen2: 22000 and on transport operation
+ * @mq_rx_supported: multi-queue rx support
+ */
+struct iwl_cfg_trans_params {
+	const struct iwl_base_params *base_params;
+	const struct iwl_csr_params *csr;
+	enum iwl_device_family device_family;
+	u32 umac_prph_offset;
+	u32 rf_id:1,
+	    use_tfh:1,
+	    gen2:1,
+	    mq_rx_supported:1,
+	    bisr_workaround:1;
+};
+
 /**
  * struct iwl_cfg
+ * @trans: the trans-specific configuration part
  * @name: Official name of the device
  * @fw_name_pre: Firmware filename prefix. The api version and extension
  *	(.ucode) will be added to filename before loading from disk. The
@@ -346,7 +376,6 @@ struct iwl_csr_params {
  * @nvm_ver: NVM version
  * @nvm_calib_ver: NVM calibration version
  * @lib: pointer to the lib ops
- * @base_params: pointer to basic parameters
  * @ht_params: point to ht parameters
  * @led_mode: 0=blinking, 1=On(RF On)/Off(RF Off)
  * @rx_with_siso_diversity: 1x1 device with rx antenna diversity
@@ -358,7 +387,6 @@ struct iwl_csr_params {
  * @mac_addr_from_csr: read HW address from CSR registers
  * @features: hw features, any combination of feature_whitelist
  * @pwr_tx_backoffs: translation table between power limits and backoffs
- * @csr: csr flags and addresses that are different across devices
  * @max_rx_agg_size: max RX aggregation size of the ADDBA request/response
  * @max_tx_agg_size: max TX aggregation size of the ADDBA request/response
  * @max_ht_ampdu_factor: the exponent of the max length of A-MPDU that the
@@ -371,18 +399,14 @@ struct iwl_csr_params {
  * @dccm2_len: length of the second DCCM
  * @smem_offset: offset from which the SMEM begins
  * @smem_len: the length of SMEM
- * @mq_rx_supported: multi-queue rx support
  * @vht_mu_mimo_supported: VHT MU-MIMO support
- * @rf_id: need to read rf_id to determine the firmware image
  * @integrated: discrete or integrated
- * @gen2: 22000 and on transport operation
  * @cdb: CDB support
  * @nvm_type: see &enum iwl_nvm_type
  * @d3_debug_data_base_addr: base address where D3 debug data is stored
  * @d3_debug_data_length: length of the D3 debug data
  * @bisr_workaround: BISR hardware workaround (for 22260 series devices)
  * @min_txq_size: minimum number of slots required in a TX queue
- * @umac_prph_offset: offset to add to UMAC periphery address
  * @uhb_supported: ultra high band channels supported
  * @min_256_ba_txq_size: minimum number of slots required in a TX queue which
  *	supports 256 BA aggregation
@@ -392,19 +416,16 @@ struct iwl_csr_params {
  * and/or the uCode API version instead.
  */
 struct iwl_cfg {
+	struct iwl_cfg_trans_params trans;
 	/* params specific to an individual device within a device family */
 	const char *name;
 	const char *fw_name_pre;
-	/* params not likely to change within a device family */
-	const struct iwl_base_params *base_params;
 	/* params likely to change within a device family */
 	const struct iwl_ht_params *ht_params;
 	const struct iwl_eeprom_params *eeprom_params;
 	const struct iwl_pwr_tx_backoff *pwr_tx_backoffs;
 	const char *default_nvm_file_C_step;
 	const struct iwl_tt_params *thermal_params;
-	const struct iwl_csr_params *csr;
-	enum iwl_device_family device_family;
 	enum iwl_led_mode led_mode;
 	enum iwl_nvm_type nvm_type;
 	u32 max_data_size;
@@ -428,15 +449,10 @@ struct iwl_cfg {
 	    lp_xtal_workaround:1,
 	    disable_dummy_notification:1,
 	    apmg_not_supported:1,
-	    mq_rx_supported:1,
 	    vht_mu_mimo_supported:1,
-	    rf_id:1,
 	    integrated:1,
-	    use_tfh:1,
-	    gen2:1,
 	    cdb:1,
 	    dbgc_supported:1,
-	    bisr_workaround:1,
 	    uhb_supported:1;
 	u8 valid_tx_ant;
 	u8 valid_rx_ant;
@@ -453,7 +469,6 @@ struct iwl_cfg {
 	u32 d3_debug_data_base_addr;
 	u32 d3_debug_data_length;
 	u32 min_txq_size;
-	u32 umac_prph_offset;
 	u32 fw_mon_smem_write_ptr_addr;
 	u32 fw_mon_smem_write_ptr_msk;
 	u32 fw_mon_smem_cycle_cnt_ptr_addr;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index ae61ad129f06..a204ecbdacaf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -215,7 +215,7 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 	const struct iwl_cfg *cfg = drv->trans->cfg;
 	char tag[8];
 
-	if (drv->trans->cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
+	if (drv->trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_9000 &&
 	    (CSR_HW_REV_STEP(drv->trans->hw_rev) != SILICON_B_STEP &&
 	     CSR_HW_REV_STEP(drv->trans->hw_rev) != SILICON_C_STEP)) {
 		IWL_ERR(drv,
@@ -1120,7 +1120,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*dbg_ptrs))
 				goto invalid_tlv_len;
-			if (drv->trans->cfg->device_family <
+			if (drv->trans->cfg->trans.device_family <
 			    IWL_DEVICE_FAMILY_22000)
 				break;
 			drv->trans->dbg.umac_error_event_table =
@@ -1136,7 +1136,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*dbg_ptrs))
 				goto invalid_tlv_len;
-			if (drv->trans->cfg->device_family <
+			if (drv->trans->cfg->trans.device_family <
 			    IWL_DEVICE_FAMILY_22000)
 				break;
 			drv->trans->dbg.lmac_error_event_table[0] =
@@ -1522,14 +1522,14 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 		fw->init_evtlog_size = (pieces->init_evtlog_size - 16)/12;
 	else
 		fw->init_evtlog_size =
-			drv->trans->cfg->base_params->max_event_log_size;
+			drv->trans->cfg->trans.base_params->max_event_log_size;
 	fw->init_errlog_ptr = pieces->init_errlog_ptr;
 	fw->inst_evtlog_ptr = pieces->inst_evtlog_ptr;
 	if (pieces->inst_evtlog_size)
 		fw->inst_evtlog_size = (pieces->inst_evtlog_size - 16)/12;
 	else
 		fw->inst_evtlog_size =
-			drv->trans->cfg->base_params->max_event_log_size;
+			drv->trans->cfg->trans.base_params->max_event_log_size;
 	fw->inst_errlog_ptr = pieces->inst_errlog_ptr;
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index 04338c3a6205..75e7053f6807 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Mobile Communications GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,7 +29,7 @@
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Mobile Communications GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -765,7 +765,7 @@ void iwl_init_ht_hw_capab(const struct iwl_cfg *cfg,
 	if (cfg->ht_params->ldpc)
 		ht_info->cap |= IEEE80211_HT_CAP_LDPC_CODING;
 
-	if ((cfg->mq_rx_supported &&
+	if ((cfg->trans.mq_rx_supported &&
 	     iwlwifi_mod_params.amsdu_size == IWL_AMSDU_DEF) ||
 	     iwlwifi_mod_params.amsdu_size >= IWL_AMSDU_8K)
 		ht_info->cap |= IEEE80211_HT_CAP_MAX_AMSDU;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
index 82e87192119e..88f38e4cf7ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,7 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -193,7 +193,7 @@ static int iwl_init_otp_access(struct iwl_trans *trans)
 {
 	int ret;
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
 	if (ret)
 		return ret;
 
@@ -207,7 +207,7 @@ static int iwl_init_otp_access(struct iwl_trans *trans)
 	 * CSR auto clock gate disable bit -
 	 * this is only applicable for HW with OTP shadow RAM
 	 */
-	if (trans->cfg->base_params->shadow_ram_support)
+	if (trans->cfg->trans.base_params->shadow_ram_support)
 		iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 			    CSR_RESET_LINK_PWR_MGMT_DISABLED);
 
@@ -328,7 +328,7 @@ static int iwl_find_otp_image(struct iwl_trans *trans,
 		}
 		/* more in the link list, continue */
 		usedblocks++;
-	} while (usedblocks <= trans->cfg->base_params->max_ll_items);
+	} while (usedblocks <= trans->cfg->trans.base_params->max_ll_items);
 
 	/* OTP has no valid blocks */
 	IWL_DEBUG_EEPROM(trans->dev, "OTP has no valid blocks\n");
@@ -361,7 +361,7 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 	if (nvm_is_otp < 0)
 		return nvm_is_otp;
 
-	sz = trans->cfg->base_params->eeprom_size;
+	sz = trans->cfg->trans.base_params->eeprom_size;
 	IWL_DEBUG_EEPROM(trans->dev, "NVM size = %d\n", sz);
 
 	e = kmalloc(sz, GFP_KERNEL);
@@ -396,7 +396,7 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 			    CSR_OTP_GP_REG_ECC_CORR_STATUS_MSK |
 			    CSR_OTP_GP_REG_ECC_UNCORR_STATUS_MSK);
 		/* traversing the linked list if no shadow ram supported */
-		if (!trans->cfg->base_params->shadow_ram_support) {
+		if (!trans->cfg->trans.base_params->shadow_ram_support) {
 			ret = iwl_find_otp_image(trans, &validblockaddr);
 			if (ret)
 				goto err_unlock;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index c6a534303936..dfaad564ef09 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,7 +29,7 @@
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -127,7 +127,7 @@
 static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 					     unsigned int chnl)
 {
-	if (trans->cfg->use_tfh) {
+	if (trans->cfg->trans.use_tfh) {
 		WARN_ON_ONCE(chnl >= 64);
 		return TFH_TFDQ_CBB_TABLE + 8 * chnl;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index a704e25af810..7561a3891788 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -304,10 +304,10 @@ IWL_EXPORT_SYMBOL(iwl_clear_bits_prph);
 
 void iwl_force_nmi(struct iwl_trans *trans)
 {
-	if (trans->cfg->device_family < IWL_DEVICE_FAMILY_9000)
+	if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_9000)
 		iwl_write_prph(trans, DEVICE_SET_NMI_REG,
 			       DEVICE_SET_NMI_VAL_DRV);
-	else if (trans->cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	else if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_NIC_SET_NMI_DRIVER,
 				UREG_NIC_SET_NMI_DRIVER_NMI_FROM_DRIVER_MSK);
 	else
@@ -458,7 +458,7 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 		FH_TSSR_TX_ERROR_REG
 	};
 
-	if (trans->cfg->mq_rx_supported)
+	if (trans->cfg->trans.mq_rx_supported)
 		return iwl_dump_rfh(trans, buf);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -492,11 +492,12 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 	return 0;
 }
 
-int iwl_finish_nic_init(struct iwl_trans *trans)
+int iwl_finish_nic_init(struct iwl_trans *trans,
+			const struct iwl_cfg_trans_params *cfg_trans)
 {
 	int err;
 
-	if (trans->cfg->bisr_workaround) {
+	if (cfg_trans->bisr_workaround) {
 		/* ensure the TOP FSM isn't still in previous reset */
 		mdelay(2);
 	}
@@ -506,9 +507,9 @@ int iwl_finish_nic_init(struct iwl_trans *trans)
 	 * D0U* --> D0A* (powered-up active) state.
 	 */
 	iwl_set_bit(trans, CSR_GP_CNTRL,
-		    BIT(trans->cfg->csr->flag_init_done));
+		    BIT(cfg_trans->csr->flag_init_done));
 
-	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_8000)
+	if (cfg_trans->device_family == IWL_DEVICE_FAMILY_8000)
 		udelay(2);
 
 	/*
@@ -517,13 +518,13 @@ int iwl_finish_nic_init(struct iwl_trans *trans)
 	 * and accesses to uCode SRAM.
 	 */
 	err = iwl_poll_bit(trans, CSR_GP_CNTRL,
-			   BIT(trans->cfg->csr->flag_mac_clock_ready),
-			   BIT(trans->cfg->csr->flag_mac_clock_ready),
+			   BIT(cfg_trans->csr->flag_mac_clock_ready),
+			   BIT(cfg_trans->csr->flag_mac_clock_ready),
 			   25000);
 	if (err < 0)
 		IWL_DEBUG_INFO(trans, "Failed to wake NIC\n");
 
-	if (trans->cfg->bisr_workaround) {
+	if (cfg_trans->bisr_workaround) {
 		/* ensure BISR shift has finished */
 		udelay(200);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.h b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
index 920e2146ea3f..f8e4f0f5de0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.h
@@ -99,7 +99,8 @@ void iwl_set_bits_mask_prph(struct iwl_trans *trans, u32 ofs,
 void iwl_clear_bits_prph(struct iwl_trans *trans, u32 ofs, u32 mask);
 void iwl_force_nmi(struct iwl_trans *trans);
 
-int iwl_finish_nic_init(struct iwl_trans *trans);
+int iwl_finish_nic_init(struct iwl_trans *trans,
+			const struct iwl_cfg_trans_params *cfg_trans);
 
 /* Error handling */
 int iwl_dump_fh(struct iwl_trans *trans, char **buf);
@@ -111,35 +112,38 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf);
  */
 static inline u32 iwl_umac_prph(struct iwl_trans *trans, u32 ofs)
 {
-	return ofs + trans->cfg->umac_prph_offset;
+	return ofs + trans->cfg->trans.umac_prph_offset;
 }
 
 static inline u32 iwl_read_umac_prph_no_grab(struct iwl_trans *trans, u32 ofs)
 {
-	return iwl_read_prph_no_grab(trans, ofs + trans->cfg->umac_prph_offset);
+	return iwl_read_prph_no_grab(trans, ofs +
+				     trans->cfg->trans.umac_prph_offset);
 }
 
 static inline u32 iwl_read_umac_prph(struct iwl_trans *trans, u32 ofs)
 {
-	return iwl_read_prph(trans, ofs + trans->cfg->umac_prph_offset);
+	return iwl_read_prph(trans, ofs + trans->cfg->trans.umac_prph_offset);
 }
 
 static inline void iwl_write_umac_prph_no_grab(struct iwl_trans *trans, u32 ofs,
 					       u32 val)
 {
-	iwl_write_prph_no_grab(trans,  ofs + trans->cfg->umac_prph_offset, val);
+	iwl_write_prph_no_grab(trans,  ofs + trans->cfg->trans.umac_prph_offset,
+			       val);
 }
 
 static inline void iwl_write_umac_prph(struct iwl_trans *trans, u32 ofs,
 				       u32 val)
 {
-	iwl_write_prph(trans,  ofs + trans->cfg->umac_prph_offset, val);
+	iwl_write_prph(trans,  ofs + trans->cfg->trans.umac_prph_offset, val);
 }
 
 static inline int iwl_poll_umac_prph_bit(struct iwl_trans *trans, u32 addr,
 					 u32 bits, u32 mask, int timeout)
 {
-	return iwl_poll_prph_bit(trans, addr + trans->cfg->umac_prph_offset,
+	return iwl_poll_prph_bit(trans, addr +
+				 trans->cfg->trans.umac_prph_offset,
 				 bits, mask, timeout);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 6d95941f56a7..10aef19680d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -434,14 +434,14 @@ static void iwl_init_vht_hw_capab(const struct iwl_cfg *cfg,
 
 	switch (iwlwifi_mod_params.amsdu_size) {
 	case IWL_AMSDU_DEF:
-		if (cfg->mq_rx_supported)
+		if (cfg->trans.mq_rx_supported)
 			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
 		else
 			vht_cap->cap |= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895;
 		break;
 	case IWL_AMSDU_2K:
-		if (cfg->mq_rx_supported)
+		if (cfg->trans.mq_rx_supported)
 			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
 		else
@@ -793,10 +793,10 @@ static void iwl_set_hw_address_from_csr(struct iwl_trans *trans,
 {
 	__le32 mac_addr0 =
 		cpu_to_le32(iwl_read32(trans,
-				       trans->cfg->csr->mac_addr0_strap));
+				       trans->cfg->trans.csr->mac_addr0_strap));
 	__le32 mac_addr1 =
 		cpu_to_le32(iwl_read32(trans,
-				       trans->cfg->csr->mac_addr1_strap));
+				       trans->cfg->trans.csr->mac_addr1_strap));
 
 	iwl_flip_hw_address(mac_addr0, mac_addr1, data->hw_addr);
 	/*
@@ -807,9 +807,9 @@ static void iwl_set_hw_address_from_csr(struct iwl_trans *trans,
 		return;
 
 	mac_addr0 = cpu_to_le32(iwl_read32(trans,
-					   trans->cfg->csr->mac_addr0_otp));
+					trans->cfg->trans.csr->mac_addr0_otp));
 	mac_addr1 = cpu_to_le32(iwl_read32(trans,
-					   trans->cfg->csr->mac_addr1_otp));
+					trans->cfg->trans.csr->mac_addr1_otp));
 
 	iwl_flip_hw_address(mac_addr0, mac_addr1, data->hw_addr);
 }
@@ -908,7 +908,7 @@ iwl_nvm_no_wide_in_5ghz(struct device *dev, const struct iwl_cfg *cfg,
 	 * in 5GHz otherwise the FW will throw a sysassert when we try
 	 * to use them.
 	 */
-	if (cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+	if (cfg->trans.device_family == IWL_DEVICE_FAMILY_7000) {
 		/*
 		 * Unlike the other sections in the NVM, the hw
 		 * section uses big-endian.
@@ -1301,7 +1301,7 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
 			 le32_to_cpu(dword_buff[3]));
 
 		/* nvm file validation, dword_buff[2] holds the file version */
-		if (trans->cfg->device_family == IWL_DEVICE_FAMILY_8000 &&
+		if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_8000 &&
 		    CSR_HW_REV_STEP(trans->hw_rev) == SILICON_C_STEP &&
 		    le32_to_cpu(dword_buff[2]) < 0xE4A) {
 			ret = -EFAULT;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 2bf5b83e116c..cd067653814c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1050,7 +1050,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	 * recording before entering D3. In later devices the FW stops the
 	 * recording automatically.
 	 */
-	if (mvm->trans->cfg->device_family < IWL_DEVICE_FAMILY_9000)
+	if (mvm->trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_9000)
 		iwl_fw_dbg_stop_restart_recording(&mvm->fwrt, NULL, true);
 
 	/* must be last -- this switches firmware state */
@@ -1658,7 +1658,7 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 		mvm_ap_sta->tid_data[i].seq_number = seq;
 	}
 
-	if (mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+	if (mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000) {
 		i = mvm->offload_tid;
 		iwl_trans_set_q_ptrs(mvm->trans,
 				     mvm_ap_sta->tid_data[i].txq_id,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 994a4ba07204..2dbb02666851 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1173,8 +1173,8 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 	struct iwl_rx_mpdu_desc *desc;
 	int bin_len = count / 2;
 	int ret = -EINVAL;
-	size_t mpdu_cmd_hdr_size =
-		(mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) ?
+	size_t mpdu_cmd_hdr_size = (mvm->trans->cfg->trans.device_family >=
+				    IWL_DEVICE_FAMILY_22560) ?
 		sizeof(struct iwl_rx_mpdu_desc) :
 		IWL_RX_DESC_SIZE_V1;
 
@@ -1182,7 +1182,7 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 		return -EIO;
 
 	/* supporting only 9000 descriptor */
-	if (!mvm->trans->cfg->mq_rx_supported)
+	if (!mvm->trans->cfg->trans.mq_rx_supported)
 		return -ENOTSUPP;
 
 	rxb._page = alloc_pages(GFP_ATOMIC, 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f09f24089fe7..474e61f436a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -357,13 +357,14 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 			iwl_fw_dbg_error_collect(&mvm->fwrt,
 						 FW_DBG_TRIGGER_ALIVE_TIMEOUT);
 
-		if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000)
+		if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000)
 			IWL_ERR(mvm,
 				"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
 				iwl_read_umac_prph(trans, UMAG_SB_CPU_1_STATUS),
 				iwl_read_umac_prph(trans,
 						   UMAG_SB_CPU_2_STATUS));
-		else if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+		else if (trans->cfg->trans.device_family >=
+			 IWL_DEVICE_FAMILY_8000)
 			IWL_ERR(mvm,
 				"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
 				iwl_read_prph(trans, SB_CPU_1_STATUS),
@@ -557,7 +558,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 		goto remove_notif;
 	}
 
-	if (mvm->cfg->device_family < IWL_DEVICE_FAMILY_8000) {
+	if (mvm->cfg->trans.device_family < IWL_DEVICE_FAMILY_8000) {
 		ret = iwl_mvm_send_bt_init_conf(mvm);
 		if (ret)
 			goto remove_notif;
@@ -1333,7 +1334,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		goto error;
 
 	/* Init RSS configuration */
-	if (mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+	if (mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000) {
 		ret = iwl_configure_rxq(mvm);
 		if (ret) {
 			IWL_ERR(mvm, "Failed to configure RX queues: %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/led.c b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
index 4348bb00e761..64298aec893a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,7 +29,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -156,7 +156,7 @@ void iwl_mvm_leds_sync(struct iwl_mvm *mvm)
 	 * if we control through the register, we're doing it
 	 * even when the firmware isn't up, so no need to sync
 	 */
-	if (mvm->cfg->device_family < IWL_DEVICE_FAMILY_8000)
+	if (mvm->cfg->trans.device_family < IWL_DEVICE_FAMILY_8000)
 		return;
 
 	iwl_mvm_led_set(mvm, mvm->led.brightness > 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 07763f97d5c5..126e63c7f4c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -400,7 +400,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	 * for older devices. We also don't see this issue on any newer
 	 * devices.
 	 */
-	if (mvm->cfg->device_family >= IWL_DEVICE_FAMILY_9000)
+	if (mvm->cfg->trans.device_family >= IWL_DEVICE_FAMILY_9000)
 		ieee80211_hw_set(hw, TX_AMSDU);
 	ieee80211_hw_set(hw, TX_FRAG_LIST);
 
@@ -3320,7 +3320,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
-		if (!mvm->trans->cfg->gen2) {
+		if (!mvm->trans->cfg->trans.gen2) {
 			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIC;
 			key->flags |= IEEE80211_KEY_FLAG_PUT_IV_SPACE;
 		} else if (vif->type == NL80211_IFTYPE_STATION) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 0ea0f72880af..7d3484144891 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1356,13 +1356,13 @@ static inline bool iwl_mvm_has_new_rx_api(struct iwl_mvm *mvm)
 static inline bool iwl_mvm_has_new_tx_api(struct iwl_mvm *mvm)
 {
 	/* TODO - replace with TLV once defined */
-	return mvm->trans->cfg->use_tfh;
+	return mvm->trans->cfg->trans.use_tfh;
 }
 
 static inline bool iwl_mvm_has_unified_ucode(struct iwl_mvm *mvm)
 {
 	/* TODO - better define this */
-	return mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000;
+	return mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000;
 }
 
 static inline bool iwl_mvm_is_cdb_supported(struct iwl_mvm *mvm)
@@ -1387,7 +1387,7 @@ static inline bool iwl_mvm_cdb_scan_api(struct iwl_mvm *mvm)
 	 * but then there's a little bit of code in scan that won't make
 	 * any sense...
 	 */
-	return mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000;
+	return mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000;
 }
 
 static inline bool iwl_mvm_is_scan_ext_chan_supported(struct iwl_mvm *mvm)
@@ -1922,7 +1922,7 @@ void iwl_mvm_vif_set_low_latency(struct iwl_mvm_vif *mvmvif, bool set,
  */
 static inline u32 iwl_mvm_flushable_queues(struct iwl_mvm *mvm)
 {
-	return ((BIT(mvm->cfg->base_params->num_of_queues) - 1) &
+	return ((BIT(mvm->cfg->trans.base_params->num_of_queues) - 1) &
 		~BIT(IWL_MVM_DQA_CMD_QUEUE));
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index a9bb43a2f27b..e2855efc2afd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -249,7 +249,7 @@ static int iwl_nvm_read_section(struct iwl_mvm *mvm, u16 section,
 	while (ret == length) {
 		/* Check no memory assumptions fail and cause an overflow */
 		if ((size_read + offset + length) >
-		    mvm->cfg->base_params->eeprom_size) {
+		    mvm->cfg->trans.base_params->eeprom_size) {
 			IWL_ERR(mvm, "EEPROM size is too small for NVM\n");
 			return -ENOBUFS;
 		}
@@ -372,7 +372,7 @@ int iwl_nvm_init(struct iwl_mvm *mvm)
 	/* Read From FW NVM */
 	IWL_DEBUG_EEPROM(mvm->trans->dev, "Read from NVM\n");
 
-	nvm_buffer = kmalloc(mvm->cfg->base_params->eeprom_size,
+	nvm_buffer = kmalloc(mvm->cfg->trans.base_params->eeprom_size,
 			     GFP_KERNEL);
 	if (!nvm_buffer)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index efd694fd8b79..c30ce004af14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -173,7 +173,7 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 	 * unrelated errors. Need to further investigate this, but for now
 	 * we'll separate cases.
 	 */
-	if (mvm->trans->cfg->device_family < IWL_DEVICE_FAMILY_8000)
+	if (mvm->trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_8000)
 		reg_val |= CSR_HW_IF_CONFIG_REG_BIT_RADIO_SI;
 
 	if (iwl_fw_dbg_is_d3_debug_enabled(&mvm->fwrt))
@@ -664,7 +664,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (iwl_mvm_has_new_rx_api(mvm)) {
 		op_mode->ops = &iwl_mvm_ops_mq;
 		trans->rx_mpdu_cmd_hdr_size =
-			(trans->cfg->device_family >=
+			(trans->cfg->trans.device_family >=
 			 IWL_DEVICE_FAMILY_22560) ?
 			sizeof(struct iwl_rx_mpdu_desc) :
 			IWL_RX_DESC_SIZE_V1;
@@ -728,7 +728,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans_cfg.no_reclaim_cmds = no_reclaim_cmds;
 	trans_cfg.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
 
-	if (mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
 		rb_size_default = IWL_AMSDU_2K;
 	else
 		rb_size_default = IWL_AMSDU_4K;
@@ -757,7 +757,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	trans->wide_cmd_header = true;
 	trans_cfg.bc_table_dword =
-		mvm->trans->cfg->device_family < IWL_DEVICE_FAMILY_22560;
+		mvm->trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_22560;
 
 	trans_cfg.command_groups = iwl_mvm_groups;
 	trans_cfg.command_groups_size = ARRAY_SIZE(iwl_mvm_groups);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index fcd1b15d2fa0..7300eea03b4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3338,7 +3338,7 @@ static void rs_build_rates_table_from_fixed(struct iwl_mvm *mvm,
 	if (num_of_ant(ant) == 1)
 		lq_cmd->single_stream_ant_msk = ant;
 
-	if (!mvm->trans->cfg->gen2)
+	if (!mvm->trans->cfg->trans.gen2)
 		lq_cmd->agg_frame_cnt_limit = LINK_QUAL_AGG_FRAME_LIMIT_DEF;
 	else
 		lq_cmd->agg_frame_cnt_limit =
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 854edd7d7103..65a8f0ad5f29 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -349,7 +349,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
 		    !(status & IWL_RX_MPDU_RES_STATUS_TTAK_OK))
 			return 0;
 
-		if (mvm->trans->cfg->gen2 &&
+		if (mvm->trans->cfg->trans.gen2 &&
 		    !(status & RX_MPDU_RES_STATUS_MIC_OK))
 			stats->flag |= RX_FLAG_MMIC_ERROR;
 
@@ -366,7 +366,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
 
 		if (pkt_flags & FH_RSCSR_RADA_EN) {
 			stats->flag |= RX_FLAG_ICV_STRIPPED;
-			if (mvm->trans->cfg->gen2)
+			if (mvm->trans->cfg->trans.gen2)
 				stats->flag |= RX_FLAG_MMIC_STRIPPED;
 		}
 
@@ -1504,7 +1504,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
 
-	if (mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560) {
 		rate_n_flags = le32_to_cpu(desc->v3.rate_n_flags);
 		channel = desc->v3.channel;
 		gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
@@ -1605,7 +1605,8 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (likely(!(phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD))) {
 		u64 tsf_on_air_rise;
 
-		if (mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+		if (mvm->trans->cfg->trans.device_family >=
+		    IWL_DEVICE_FAMILY_22560)
 			tsf_on_air_rise = le64_to_cpu(desc->v3.tsf_on_air_rise);
 		else
 			tsf_on_air_rise = le64_to_cpu(desc->v1.tsf_on_air_rise);
@@ -1731,7 +1732,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 			*qc &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
 
-			if (mvm->trans->cfg->device_family ==
+			if (mvm->trans->cfg->trans.device_family ==
 			    IWL_DEVICE_FAMILY_9000) {
 				iwl_mvm_flip_address(hdr->addr3);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index aa0a2a3e0875..ca7e51313381 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1604,7 +1604,7 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 	mvm_sta->mac_id_n_color = FW_CMD_ID_AND_COLOR(mvmvif->id,
 						      mvmvif->color);
 	mvm_sta->vif = vif;
-	if (!mvm->trans->cfg->gen2)
+	if (!mvm->trans->cfg->trans.gen2)
 		mvm_sta->max_agg_bufsize = LINK_QUAL_AGG_FRAME_LIMIT_DEF;
 	else
 		mvm_sta->max_agg_bufsize = LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF;
@@ -1954,8 +1954,8 @@ static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 *queue,
 					  u8 sta_id, u8 fifo)
 {
 	unsigned int wdg_timeout = iwlmvm_mod_params.tfd_q_hang_detect ?
-					mvm->cfg->base_params->wd_timeout :
-					IWL_WATCHDOG_DISABLED;
+		mvm->cfg->trans.base_params->wd_timeout :
+		IWL_WATCHDOG_DISABLED;
 
 	if (iwl_mvm_has_new_tx_api(mvm)) {
 		int tvqm_queue =
@@ -2813,7 +2813,7 @@ int iwl_mvm_sta_tx_agg_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * to align the wrap around of ssn so we compare relevant values.
 	 */
 	normalized_ssn = tid_data->ssn;
-	if (mvm->trans->cfg->gen2)
+	if (mvm->trans->cfg->trans.gen2)
 		normalized_ssn &= 0xff;
 
 	if (normalized_ssn == tid_data->next_reclaimed) {
@@ -3853,7 +3853,7 @@ u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data)
 	 * In 22000 HW, the next_reclaimed index is only 8 bit, so we'll need
 	 * to align the wrap around of ssn so we compare relevant values.
 	 */
-	if (mvm->trans->cfg->gen2)
+	if (mvm->trans->cfg->trans.gen2)
 		sn &= 0xff;
 
 	return ieee80211_sn_sub(sn, tid_data->next_reclaimed);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 4effb90b4f75..48d305c9b737 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -546,7 +546,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 							    hdr->frame_control);
 		}
 
-		if (mvm->trans->cfg->device_family >=
+		if (mvm->trans->cfg->trans.device_family >=
 		    IWL_DEVICE_FAMILY_22560) {
 			struct iwl_tx_cmd_gen3 *cmd = (void *)dev_cmd->payload;
 
@@ -1272,7 +1272,7 @@ static void iwl_mvm_check_ratid_empty(struct iwl_mvm *mvm,
 	 * to align the wrap around of ssn so we compare relevant values.
 	 */
 	normalized_ssn = tid_data->ssn;
-	if (mvm->trans->cfg->gen2)
+	if (mvm->trans->cfg->trans.gen2)
 		normalized_ssn &= 0xff;
 
 	if (normalized_ssn != tid_data->next_reclaimed)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 06ef853fb84a..f8d6e5672867 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -531,7 +531,7 @@ static void iwl_mvm_dump_lmac_error_log(struct iwl_mvm *mvm, u8 lmac_num)
 		/* reset the device */
 		iwl_trans_sw_reset(trans);
 
-		err = iwl_finish_nic_init(trans);
+		err = iwl_finish_nic_init(trans, &trans->cfg->trans);
 		if (err)
 			return;
 	}
@@ -939,8 +939,9 @@ unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
 {
 	struct iwl_fw_dbg_trigger_tlv *trigger;
 	struct iwl_fw_dbg_trigger_txq_timer *txq_timer;
-	unsigned int default_timeout =
-		cmd_q ? IWL_DEF_WD_TIMEOUT : mvm->cfg->base_params->wd_timeout;
+	unsigned int default_timeout = cmd_q ?
+		IWL_DEF_WD_TIMEOUT :
+		mvm->cfg->trans.base_params->wd_timeout;
 
 	if (!iwl_fw_dbg_trigger_enabled(mvm->fw, FW_DBG_TRIGGER_TXQ_TIMERS)) {
 		/*
@@ -984,7 +985,7 @@ unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
 		return default_timeout;
 	default:
 		WARN_ON(1);
-		return mvm->cfg->base_params->wd_timeout;
+		return mvm->cfg->trans.base_params->wd_timeout;
 	}
 }
 
@@ -1430,7 +1431,7 @@ u32 iwl_mvm_get_systime(struct iwl_mvm *mvm)
 {
 	u32 reg_addr = DEVICE_SYSTEM_TIME_REG;
 
-	if (mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000 &&
+	if (mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000 &&
 	    mvm->trans->cfg->gp2_reg_addr)
 		reg_addr = mvm->trans->cfg->gp2_reg_addr;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 9b27c955b8dc..1b5de527f141 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -180,7 +180,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 	iwl_set_bit(trans, CSR_CTXT_INFO_BOOT_CTRL,
 		    CSR_AUTO_FUNC_BOOT_ENA);
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_CPU_INIT_RUN, 1);
 	else
 		iwl_set_bit(trans, CSR_GP_CNTRL, CSR_AUTO_FUNC_INIT);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 3927d5590bb3..63d9cc801e9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -995,7 +995,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct iwl_trans *iwl_trans;
 	int ret;
 
-	if (WARN_ONCE(!cfg->csr, "CSR addresses aren't configured\n"))
+	if (WARN_ONCE(!cfg->trans.csr, "CSR addresses aren't configured\n"))
 		return -EINVAL;
 
 	iwl_trans = iwl_trans_pcie_alloc(pdev, ent, cfg);
@@ -1022,7 +1022,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		iwl_trans->cfg = cfg_7265d;
 	}
 
-	if (iwl_trans->cfg->rf_id && cfg == &iwl22000_2ac_cfg_hr_cdb &&
+	if (iwl_trans->cfg->trans.rf_id && cfg == &iwl22000_2ac_cfg_hr_cdb &&
 	    iwl_trans->hw_rev != CSR_HW_REV_TYPE_HR_CDB) {
 		u32 rf_id_chp = CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id);
 		u32 jf_chp_id = CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_JF);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 906e1da3923d..53999ea7bb04 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -253,7 +253,8 @@ struct iwl_dma_ptr {
  */
 static inline int iwl_queue_inc_wrap(struct iwl_trans *trans, int index)
 {
-	return ++index & (trans->cfg->base_params->max_tfd_queue_size - 1);
+	return ++index &
+		(trans->cfg->trans.base_params->max_tfd_queue_size - 1);
 }
 
 /**
@@ -263,7 +264,7 @@ static inline int iwl_queue_inc_wrap(struct iwl_trans *trans, int index)
 static inline __le16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
 					    struct iwl_rxq *rxq)
 {
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560) {
 		__le16 *rb_stts = rxq->rb_stts;
 
 		return READ_ONCE(*rb_stts);
@@ -280,7 +281,8 @@ static inline __le16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
  */
 static inline int iwl_queue_dec_wrap(struct iwl_trans *trans, int index)
 {
-	return --index & (trans->cfg->base_params->max_tfd_queue_size - 1);
+	return --index &
+		(trans->cfg->trans.base_params->max_tfd_queue_size - 1);
 }
 
 struct iwl_cmd_meta {
@@ -704,7 +706,7 @@ void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 static inline u16 iwl_pcie_tfd_tb_get_len(struct iwl_trans *trans, void *_tfd,
 					  u8 idx)
 {
-	if (trans->cfg->use_tfh) {
+	if (trans->cfg->trans.use_tfh) {
 		struct iwl_tfh_tfd *tfd = _tfd;
 		struct iwl_tfh_tb *tb = &tfd->tbs[idx];
 
@@ -910,7 +912,7 @@ static inline void *iwl_pcie_get_tfd(struct iwl_trans *trans,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	if (trans->cfg->use_tfh)
+	if (trans->cfg->trans.use_tfh)
 		idx = iwl_pcie_get_cmd_index(txq, idx);
 
 	return txq->tfds + trans_pcie->tfd_size * idx;
@@ -954,7 +956,7 @@ static inline void iwl_enable_rfkill_int(struct iwl_trans *trans)
 					   MSIX_HW_INT_CAUSES_REG_RF_KILL);
 	}
 
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_9000) {
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_9000) {
 		/*
 		 * On 9000-series devices this bit isn't enabled by default, so
 		 * when we power down the device we need set the bit to allow it
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index a2d709642b2a..79b012e881f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -200,12 +200,12 @@ static inline __le32 iwl_pcie_dma_addr2rbd_ptr(dma_addr_t dma_addr)
  */
 int iwl_pcie_rx_stop(struct iwl_trans *trans)
 {
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560) {
 		/* TODO: remove this for 22560 once fw does it */
 		iwl_write_umac_prph(trans, RFH_RXF_DMA_CFG_GEN3, 0);
 		return iwl_poll_umac_prph_bit(trans, RFH_GEN_STATUS_GEN3,
 					      RXF_DMA_IDLE, RXF_DMA_IDLE, 1000);
-	} else if (trans->cfg->mq_rx_supported) {
+	} else if (trans->cfg->trans.mq_rx_supported) {
 		iwl_write_prph(trans, RFH_RXF_DMA_CFG, 0);
 		return iwl_poll_prph_bit(trans, RFH_GEN_STATUS,
 					   RXF_DMA_IDLE, RXF_DMA_IDLE, 1000);
@@ -232,7 +232,7 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 1. shadow registers aren't enabled
 	 * 2. there is a chance that the NIC is asleep
 	 */
-	if (!trans->cfg->base_params->shadow_reg_enable &&
+	if (!trans->cfg->trans.base_params->shadow_reg_enable &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		reg = iwl_read32(trans, CSR_UCODE_DRV_GP1);
 
@@ -240,18 +240,18 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 			IWL_DEBUG_INFO(trans, "Rx queue requesting wakeup, GP1 = 0x%x\n",
 				       reg);
 			iwl_set_bit(trans, CSR_GP_CNTRL,
-				    BIT(trans->cfg->csr->flag_mac_access_req));
+				    BIT(trans->cfg->trans.csr->flag_mac_access_req));
 			rxq->need_update = true;
 			return;
 		}
 	}
 
 	rxq->write_actual = round_down(rxq->write, 8);
-	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_22560)
+	if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_22560)
 		iwl_write32(trans, HBUS_TARG_WRPTR,
 			    (rxq->write_actual |
 			     ((FIRST_RX_QUEUE + rxq->id) << 16)));
-	else if (trans->cfg->mq_rx_supported)
+	else if (trans->cfg->trans.mq_rx_supported)
 		iwl_write32(trans, RFH_Q_FRBDCB_WIDX_TRG(rxq->id),
 			    rxq->write_actual);
 	else
@@ -279,7 +279,7 @@ static void iwl_pcie_restock_bd(struct iwl_trans *trans,
 				struct iwl_rxq *rxq,
 				struct iwl_rx_mem_buffer *rxb)
 {
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560) {
 		struct iwl_rx_transfer_desc *bd = rxq->bd;
 
 		BUILD_BUG_ON(sizeof(*bd) != 2 * sizeof(u64));
@@ -405,7 +405,7 @@ static void iwl_pcie_rxsq_restock(struct iwl_trans *trans,
 static
 void iwl_pcie_rxq_restock(struct iwl_trans *trans, struct iwl_rxq *rxq)
 {
-	if (trans->cfg->mq_rx_supported)
+	if (trans->cfg->trans.mq_rx_supported)
 		iwl_pcie_rxmq_restock(trans, rxq);
 	else
 		iwl_pcie_rxsq_restock(trans, rxq);
@@ -682,7 +682,7 @@ static int iwl_pcie_free_bd_size(struct iwl_trans *trans, bool use_rx_td)
 	if (use_rx_td)
 		return sizeof(*rx_td);
 	else
-		return trans->cfg->mq_rx_supported ? sizeof(__le64) :
+		return trans->cfg->trans.mq_rx_supported ? sizeof(__le64) :
 			sizeof(__le32);
 }
 
@@ -690,7 +690,7 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 				  struct iwl_rxq *rxq)
 {
 	struct device *dev = trans->dev;
-	bool use_rx_td = (trans->cfg->device_family >=
+	bool use_rx_td = (trans->cfg->trans.device_family >=
 			  IWL_DEVICE_FAMILY_22560);
 	int free_size = iwl_pcie_free_bd_size(trans, use_rx_td);
 
@@ -712,7 +712,7 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 	rxq->used_bd_dma = 0;
 	rxq->used_bd = NULL;
 
-	if (trans->cfg->device_family < IWL_DEVICE_FAMILY_22560)
+	if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_22560)
 		return;
 
 	if (rxq->tr_tail)
@@ -735,13 +735,13 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	struct device *dev = trans->dev;
 	int i;
 	int free_size;
-	bool use_rx_td = (trans->cfg->device_family >=
+	bool use_rx_td = (trans->cfg->trans.device_family >=
 			  IWL_DEVICE_FAMILY_22560);
 	size_t rb_stts_size = use_rx_td ? sizeof(__le16) :
 			      sizeof(struct iwl_rb_status);
 
 	spin_lock_init(&rxq->lock);
-	if (trans->cfg->mq_rx_supported)
+	if (trans->cfg->trans.mq_rx_supported)
 		rxq->queue_size = MQ_RX_TABLE_SIZE;
 	else
 		rxq->queue_size = RX_QUEUE_SIZE;
@@ -757,7 +757,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	if (!rxq->bd)
 		goto err;
 
-	if (trans->cfg->mq_rx_supported) {
+	if (trans->cfg->trans.mq_rx_supported) {
 		rxq->used_bd = dma_alloc_coherent(dev,
 						  (use_rx_td ? sizeof(*rxq->cd) : sizeof(__le32)) * rxq->queue_size,
 						  &rxq->used_bd_dma,
@@ -807,7 +807,7 @@ int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_rb_allocator *rba = &trans_pcie->rba;
 	int i, ret;
-	size_t rb_stts_size = trans->cfg->device_family >=
+	size_t rb_stts_size = trans->cfg->trans.device_family >=
 			      IWL_DEVICE_FAMILY_22560 ?
 			      sizeof(__le16) : sizeof(struct iwl_rb_status);
 
@@ -1074,8 +1074,8 @@ int _iwl_pcie_rx_init(struct iwl_trans *trans)
 		rxq->read = 0;
 		rxq->write = 0;
 		rxq->write_actual = 0;
-		memset(rxq->rb_stts, 0,
-		       (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) ?
+		memset(rxq->rb_stts, 0, (trans->cfg->trans.device_family >=
+					 IWL_DEVICE_FAMILY_22560) ?
 		       sizeof(__le16) : sizeof(struct iwl_rb_status));
 
 		iwl_pcie_rx_init_rxb_lists(rxq);
@@ -1088,7 +1088,7 @@ int _iwl_pcie_rx_init(struct iwl_trans *trans)
 	}
 
 	/* move the pool to the default queue and allocator ownerships */
-	queue_size = trans->cfg->mq_rx_supported ?
+	queue_size = trans->cfg->trans.mq_rx_supported ?
 		     MQ_RX_NUM_RBDS : RX_QUEUE_SIZE;
 	allocator_pool_size = trans->num_rx_queues *
 		(RX_CLAIM_REQ_ALLOC - RX_POST_REQ_ALLOC);
@@ -1120,7 +1120,7 @@ int iwl_pcie_rx_init(struct iwl_trans *trans)
 	if (ret)
 		return ret;
 
-	if (trans->cfg->mq_rx_supported)
+	if (trans->cfg->trans.mq_rx_supported)
 		iwl_pcie_rx_mq_hw_init(trans);
 	else
 		iwl_pcie_rx_hw_init(trans, trans_pcie->rxq);
@@ -1151,7 +1151,7 @@ void iwl_pcie_rx_free(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_rb_allocator *rba = &trans_pcie->rba;
 	int i;
-	size_t rb_stts_size = trans->cfg->device_family >=
+	size_t rb_stts_size = trans->cfg->trans.device_family >=
 			      IWL_DEVICE_FAMILY_22560 ?
 			      sizeof(__le16) : sizeof(struct iwl_rb_status);
 
@@ -1347,7 +1347,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		}
 
 		page_stolen |= rxcb._page_stolen;
-		if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+		if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
 			break;
 		offset += ALIGN(len, FH_RSCSR_FRAME_ALIGN);
 	}
@@ -1392,14 +1392,14 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 
 	BUILD_BUG_ON(sizeof(struct iwl_rx_completion_desc) != 32);
 
-	if (!trans->cfg->mq_rx_supported) {
+	if (!trans->cfg->trans.mq_rx_supported) {
 		rxb = rxq->queue[i];
 		rxq->queue[i] = NULL;
 		return rxb;
 	}
 
 	/* used_bd is a 32/16 bit but only 12 are used to retrieve the vid */
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
 		vid = le16_to_cpu(rxq->cd[i].rbid) & 0x0FFF;
 	else
 		vid = le32_to_cpu(rxq->bd_32[i]) & 0x0FFF;
@@ -1515,7 +1515,7 @@ static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
 	/* Backtrack one entry */
 	rxq->read = i;
 	/* update cr tail with the rxq read pointer */
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
 		*rxq->cr_tail = cpu_to_le16(r);
 	spin_unlock(&rxq->lock);
 
@@ -1597,7 +1597,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 		return;
 	}
 
-	for (i = 0; i < trans->cfg->base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->cfg->trans.base_params->num_of_queues; i++) {
 		if (!trans_pcie->txq[i])
 			continue;
 		del_timer(&trans_pcie->txq[i]->stuck_timer);
@@ -1838,7 +1838,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 	if (inta & CSR_INT_BIT_ALIVE) {
 		IWL_DEBUG_ISR(trans, "Alive interrupt\n");
 		isr_stats->alive++;
-		if (trans->cfg->gen2) {
+		if (trans->cfg->trans.gen2) {
 			/*
 			 * We can restock, since firmware configured
 			 * the RFH
@@ -2179,13 +2179,13 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_ALIVE) {
 		IWL_DEBUG_ISR(trans, "Alive interrupt\n");
 		isr_stats->alive++;
-		if (trans->cfg->gen2) {
+		if (trans->cfg->trans.gen2) {
 			/* We can restock, since firmware configured the RFH */
 			iwl_pcie_rxmq_restock(trans, trans_pcie->rxq);
 		}
 	}
 
-	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_22560 &&
+	if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_22560 &&
 	    inta_hw & MSIX_HW_INT_CAUSES_REG_IPC) {
 		/* Reflect IML transfer status */
 		int res = iwl_read32(trans, CSR_IML_RESP_ADDR);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index c099ad8b003f..919b69ab836d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -92,7 +92,7 @@ int iwl_pcie_gen2_apm_init(struct iwl_trans *trans)
 
 	iwl_pcie_apm_config(trans);
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
 	if (ret)
 		return ret;
 
@@ -133,7 +133,7 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->csr->flag_init_done));
+		      BIT(trans->cfg->trans.csr->flag_init_done));
 }
 
 void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
@@ -168,14 +168,14 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	}
 
 	iwl_pcie_ctxt_info_free_paging(trans);
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
 		iwl_pcie_ctxt_info_gen3_free(trans);
 	else
 		iwl_pcie_ctxt_info_free(trans);
 
 	/* Make sure (redundant) we've released our request to stay awake */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->csr->flag_mac_access_req));
+		      BIT(trans->cfg->trans.csr->flag_mac_access_req));
 
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_gen2_apm_stop(trans, false);
@@ -340,7 +340,7 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 		goto out;
 	}
 
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
 		ret = iwl_pcie_ctxt_info_gen3_init(trans, fw);
 	else
 		ret = iwl_pcie_ctxt_info_init(trans, fw);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 90b3e26ee979..567f613572d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -184,8 +184,8 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 static void iwl_trans_pcie_sw_reset(struct iwl_trans *trans)
 {
 	/* Reset entire device - do controller reset (results in SHRD_HW_RST) */
-	iwl_set_bit(trans, trans->cfg->csr->addr_sw_reset,
-		    BIT(trans->cfg->csr->flag_sw_reset));
+	iwl_set_bit(trans, trans->cfg->trans.csr->addr_sw_reset,
+		    BIT(trans->cfg->trans.csr->flag_sw_reset));
 	usleep_range(5000, 6000);
 }
 
@@ -341,7 +341,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	 */
 
 	/* Disable L0S exit timer (platform NMI Work/Around) */
-	if (trans->cfg->device_family < IWL_DEVICE_FAMILY_8000)
+	if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_8000)
 		iwl_set_bit(trans, CSR_GIO_CHICKEN_BITS,
 			    CSR_GIO_CHICKEN_BITS_REG_BIT_DIS_L0S_EXIT_TIMER);
 
@@ -365,10 +365,10 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	iwl_pcie_apm_config(trans);
 
 	/* Configure analog phase-lock-loop before activating to D0A */
-	if (trans->cfg->base_params->pll_cfg)
+	if (trans->cfg->trans.base_params->pll_cfg)
 		iwl_set_bit(trans, CSR_ANA_PLL_CFG, CSR50_ANA_PLL_CFG_VAL);
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
 	if (ret)
 		return ret;
 
@@ -440,7 +440,7 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 
 	iwl_trans_pcie_sw_reset(trans);
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
 	if (WARN_ON(ret)) {
 		/* Release XTAL ON request */
 		__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
@@ -490,7 +490,7 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->csr->flag_init_done));
+		      BIT(trans->cfg->trans.csr->flag_init_done));
 
 	/* Activates XTAL resources monitor */
 	__iwl_trans_pcie_set_bit(trans, CSR_MONITOR_CFG_REG,
@@ -512,12 +512,12 @@ void iwl_pcie_apm_stop_master(struct iwl_trans *trans)
 	int ret;
 
 	/* stop device's busmaster DMA activity */
-	iwl_set_bit(trans, trans->cfg->csr->addr_sw_reset,
-		    BIT(trans->cfg->csr->flag_stop_master));
+	iwl_set_bit(trans, trans->cfg->trans.csr->addr_sw_reset,
+		    BIT(trans->cfg->trans.csr->flag_stop_master));
 
-	ret = iwl_poll_bit(trans, trans->cfg->csr->addr_sw_reset,
-			   BIT(trans->cfg->csr->flag_master_dis),
-			   BIT(trans->cfg->csr->flag_master_dis), 100);
+	ret = iwl_poll_bit(trans, trans->cfg->trans.csr->addr_sw_reset,
+			   BIT(trans->cfg->trans.csr->flag_master_dis),
+			   BIT(trans->cfg->trans.csr->flag_master_dis), 100);
 	if (ret < 0)
 		IWL_WARN(trans, "Master Disable Timed Out, 100 usec\n");
 
@@ -533,10 +533,11 @@ static void iwl_pcie_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 			iwl_pcie_apm_init(trans);
 
 		/* inform ME that we are leaving */
-		if (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000)
+		if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_7000)
 			iwl_set_bits_prph(trans, APMG_PCIDEV_STT_REG,
 					  APMG_PCIDEV_STT_VAL_WAKE_ME);
-		else if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_8000) {
+		else if (trans->cfg->trans.device_family >=
+			 IWL_DEVICE_FAMILY_8000) {
 			iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 				    CSR_RESET_LINK_PWR_MGMT_DISABLED);
 			iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
@@ -566,7 +567,7 @@ static void iwl_pcie_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->csr->flag_init_done));
+		      BIT(trans->cfg->trans.csr->flag_init_done));
 }
 
 static int iwl_pcie_nic_init(struct iwl_trans *trans)
@@ -593,7 +594,7 @@ static int iwl_pcie_nic_init(struct iwl_trans *trans)
 	if (iwl_pcie_tx_init(trans))
 		return -ENOMEM;
 
-	if (trans->cfg->base_params->shadow_reg_enable) {
+	if (trans->cfg->trans.base_params->shadow_reg_enable) {
 		/* enable shadow regs in HW */
 		iwl_set_bit(trans, CSR_MAC_SHADOW_REG_CTRL, 0x800FFFFF);
 		IWL_DEBUG_INFO(trans, "Enabling shadow registers in device\n");
@@ -831,7 +832,7 @@ static int iwl_pcie_load_cpu_sections_8000(struct iwl_trans *trans,
 
 	iwl_enable_interrupts(trans);
 
-	if (trans->cfg->use_tfh) {
+	if (trans->cfg->trans.use_tfh) {
 		if (cpu == 1)
 			iwl_write_prph(trans, UREG_UCODE_LOAD_STATUS,
 				       0xFFFF);
@@ -963,7 +964,7 @@ void iwl_pcie_apply_destination(struct iwl_trans *trans)
 		iwl_write_prph(trans, le32_to_cpu(dest->base_reg),
 			       trans->dbg.fw_mon[0].physical >>
 			       dest->base_shift);
-		if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+		if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000)
 			iwl_write_prph(trans, le32_to_cpu(dest->end_reg),
 				       (trans->dbg.fw_mon[0].physical +
 					trans->dbg.fw_mon[0].size - 256) >>
@@ -1005,7 +1006,7 @@ static int iwl_pcie_load_given_ucode(struct iwl_trans *trans,
 
 	/* supported for 7000 only for the moment */
 	if (iwlwifi_mod_params.fw_monitor &&
-	    trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+	    trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_pcie_alloc_fw_monitor(trans, 0);
 
 		if (trans->dbg.fw_mon[0].size) {
@@ -1134,7 +1135,7 @@ static void iwl_pcie_map_non_rx_causes(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
 	int val = trans_pcie->def_irq | MSIX_NON_AUTO_CLEAR_CAUSE;
 	int i, arr_size =
-		(trans->cfg->device_family != IWL_DEVICE_FAMILY_22560) ?
+		(trans->cfg->trans.device_family != IWL_DEVICE_FAMILY_22560) ?
 		ARRAY_SIZE(causes_list) : ARRAY_SIZE(causes_list_v2);
 
 	/*
@@ -1144,7 +1145,8 @@ static void iwl_pcie_map_non_rx_causes(struct iwl_trans *trans)
 	 */
 	for (i = 0; i < arr_size; i++) {
 		struct iwl_causes_list *causes =
-			(trans->cfg->device_family != IWL_DEVICE_FAMILY_22560) ?
+			(trans->cfg->trans.device_family !=
+			 IWL_DEVICE_FAMILY_22560) ?
 			causes_list : causes_list_v2;
 
 		iwl_write8(trans, CSR_MSIX_IVAR(causes[i].addr), val);
@@ -1188,7 +1190,7 @@ void iwl_pcie_conf_msix_hw(struct iwl_trans_pcie *trans_pcie)
 	struct iwl_trans *trans = trans_pcie->trans;
 
 	if (!trans_pcie->msix_enabled) {
-		if (trans->cfg->mq_rx_supported &&
+		if (trans->cfg->trans.mq_rx_supported &&
 		    test_bit(STATUS_DEVICE_ENABLED, &trans->status))
 			iwl_write_umac_prph(trans, UREG_CHICK,
 					    UREG_CHICK_MSI_ENABLE);
@@ -1269,7 +1271,7 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 
 	/* Make sure (redundant) we've released our request to stay awake */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->csr->flag_mac_access_req));
+		      BIT(trans->cfg->trans.csr->flag_mac_access_req));
 
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_apm_stop(trans, false);
@@ -1396,7 +1398,7 @@ static int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 	iwl_write32(trans, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
 
 	/* Load the given image to the HW */
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000)
 		ret = iwl_pcie_load_given_ucode_8000(trans, fw);
 	else
 		ret = iwl_pcie_load_given_ucode(trans, fw);
@@ -1469,7 +1471,7 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
 	IWL_WARN(trans, "reporting RF_KILL (radio %s)\n",
 		 state ? "disabled" : "enabled");
 	if (iwl_op_mode_hw_rf_kill(trans->op_mode, state)) {
-		if (trans->cfg->gen2)
+		if (trans->cfg->trans.gen2)
 			_iwl_trans_pcie_gen2_stop_device(trans);
 		else
 			_iwl_trans_pcie_stop_device(trans);
@@ -1499,9 +1501,9 @@ static void iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test,
 	iwl_pcie_synchronize_irqs(trans);
 
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->csr->flag_mac_access_req));
+		      BIT(trans->cfg->trans.csr->flag_mac_access_req));
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->csr->flag_init_done));
+		      BIT(trans->cfg->trans.csr->flag_init_done));
 
 	if (reset) {
 		/*
@@ -1530,9 +1532,9 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 	}
 
 	iwl_set_bit(trans, CSR_GP_CNTRL,
-		    BIT(trans->cfg->csr->flag_mac_access_req));
+		    BIT(trans->cfg->trans.csr->flag_mac_access_req));
 
-	ret = iwl_finish_nic_init(trans);
+	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
 	if (ret)
 		return ret;
 
@@ -1552,7 +1554,7 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 
 	if (!reset) {
 		iwl_clear_bit(trans, CSR_GP_CNTRL,
-			      BIT(trans->cfg->csr->flag_mac_access_req));
+			      BIT(trans->cfg->trans.csr->flag_mac_access_req));
 	} else {
 		iwl_trans_pcie_tx_reset(trans);
 
@@ -1583,7 +1585,7 @@ static void iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 	int max_irqs, num_irqs, i, ret;
 	u16 pci_cmd;
 
-	if (!trans->cfg->mq_rx_supported)
+	if (!trans->cfg->trans.mq_rx_supported)
 		goto enable_msi;
 
 	max_irqs = min_t(u32, num_online_cpus() + 2, IWL_MAX_RX_HW_QUEUES);
@@ -1704,7 +1706,7 @@ static int iwl_trans_pcie_clear_persistence_bit(struct iwl_trans *trans)
 {
 	u32 hpm, wprot;
 
-	switch (trans->cfg->device_family) {
+	switch (trans->cfg->trans.device_family) {
 	case IWL_DEVICE_FAMILY_9000:
 		wprot = PREG_PRPH_WPROT_9000;
 		break;
@@ -1819,7 +1821,7 @@ static u32 iwl_trans_pcie_read32(struct iwl_trans *trans, u32 ofs)
 
 static u32 iwl_trans_pcie_prph_msk(struct iwl_trans *trans)
 {
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
 		return 0x00FFFFFF;
 	else
 		return 0x000FFFFF;
@@ -1890,7 +1892,7 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 
 	iwl_pcie_synchronize_irqs(trans);
 
-	if (trans->cfg->gen2)
+	if (trans->cfg->trans.gen2)
 		iwl_pcie_gen2_tx_free(trans);
 	else
 		iwl_pcie_tx_free(trans);
@@ -1972,8 +1974,8 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
 
 	/* this bit wakes up the NIC */
 	__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
-				 BIT(trans->cfg->csr->flag_mac_access_req));
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+				 BIT(trans->cfg->trans.csr->flag_mac_access_req));
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000)
 		udelay(2);
 
 	/*
@@ -1997,8 +1999,8 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
 	 * and do not save/restore SRAM when power cycling.
 	 */
 	ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
-			   BIT(trans->cfg->csr->flag_val_mac_access_en),
-			   (BIT(trans->cfg->csr->flag_mac_clock_ready) |
+			   BIT(trans->cfg->trans.csr->flag_val_mac_access_en),
+			   (BIT(trans->cfg->trans.csr->flag_mac_clock_ready) |
 			    CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP), 15000);
 	if (unlikely(ret < 0)) {
 		u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);
@@ -2080,7 +2082,7 @@ static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans,
 		goto out;
 
 	__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-				   BIT(trans->cfg->csr->flag_mac_access_req));
+				   BIT(trans->cfg->trans.csr->flag_mac_access_req));
 	/*
 	 * Above we read the CSR_GP_CNTRL register, which will flush
 	 * any previous writes, but we need the write that clears the
@@ -2187,7 +2189,7 @@ static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	for (i = 0; i < trans->cfg->base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->cfg->trans.base_params->num_of_queues; i++) {
 		struct iwl_txq *txq = trans_pcie->txq[i];
 
 		if (i == trans_pcie->cmd_queue)
@@ -2218,7 +2220,7 @@ void iwl_trans_pcie_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
 	bool active;
 	u8 fifo;
 
-	if (trans->cfg->use_tfh) {
+	if (trans->cfg->trans.use_tfh) {
 		IWL_ERR(trans, "Queue %d is stuck %d %d\n", txq_id,
 			txq->read_ptr, txq->write_ptr);
 		/* TODO: access new SCD registers and dump them */
@@ -2235,9 +2237,9 @@ void iwl_trans_pcie_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
 		jiffies_to_msecs(txq->wd_timeout),
 		txq->read_ptr, txq->write_ptr,
 		iwl_read_prph(trans, SCD_QUEUE_RDPTR(txq_id)) &
-			(trans->cfg->base_params->max_tfd_queue_size - 1),
+			(trans->cfg->trans.base_params->max_tfd_queue_size - 1),
 		iwl_read_prph(trans, SCD_QUEUE_WRPTR(txq_id)) &
-			(trans->cfg->base_params->max_tfd_queue_size - 1),
+			(trans->cfg->trans.base_params->max_tfd_queue_size - 1),
 		iwl_read_direct32(trans, FH_TX_TRB_REG(fifo)));
 }
 
@@ -2326,7 +2328,9 @@ static int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 	int ret = 0;
 
 	/* waiting for all the tx frames complete might take a while */
-	for (cnt = 0; cnt < trans->cfg->base_params->num_of_queues; cnt++) {
+	for (cnt = 0;
+	     cnt < trans->cfg->trans.base_params->num_of_queues;
+	     cnt++) {
 
 		if (cnt == trans_pcie->cmd_queue)
 			continue;
@@ -2470,7 +2474,8 @@ static ssize_t iwl_dbgfs_tx_queue_read(struct file *file,
 	int ret;
 	size_t bufsz;
 
-	bufsz = sizeof(char) * 75 * trans->cfg->base_params->num_of_queues;
+	bufsz = sizeof(char) * 75 *
+		trans->cfg->trans.base_params->num_of_queues;
 
 	if (!trans_pcie->txq_memory)
 		return -EAGAIN;
@@ -2479,7 +2484,9 @@ static ssize_t iwl_dbgfs_tx_queue_read(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
-	for (cnt = 0; cnt < trans->cfg->base_params->num_of_queues; cnt++) {
+	for (cnt = 0;
+	     cnt < trans->cfg->trans.base_params->num_of_queues;
+	     cnt++) {
 		txq = trans_pcie->txq[cnt];
 		pos += scnprintf(buf + pos, bufsz - pos,
 				"hwq %.2d: read=%u write=%u use=%d stop=%d need_update=%d frozen=%d%s\n",
@@ -2949,7 +2956,7 @@ static u32 iwl_trans_pcie_fh_regs_dump(struct iwl_trans *trans,
 	(*data)->len = cpu_to_le32(fh_regs_len);
 	val = (void *)(*data)->data;
 
-	if (!trans->cfg->gen2)
+	if (!trans->cfg->trans.gen2)
 		for (i = FH_MEM_LOWER_BOUND; i < FH_MEM_UPPER_BOUND;
 		     i += sizeof(u32))
 			*val++ = cpu_to_le32(iwl_trans_pcie_read32(trans, i));
@@ -2997,7 +3004,7 @@ iwl_trans_pcie_dump_pointers(struct iwl_trans *trans,
 {
 	u32 base, base_high, write_ptr, write_ptr_val, wrap_cnt;
 
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_AX210) {
 		base = DBGC_CUR_DBGBUF_BASE_ADDR_LSB;
 		base_high = DBGC_CUR_DBGBUF_BASE_ADDR_MSB;
 		write_ptr = DBGC_CUR_DBGBUF_STATUS;
@@ -3017,7 +3024,7 @@ iwl_trans_pcie_dump_pointers(struct iwl_trans *trans,
 		cpu_to_le32(iwl_read_prph(trans, wrap_cnt));
 	fw_mon_data->fw_mon_base_ptr =
 		cpu_to_le32(iwl_read_prph(trans, base));
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_AX210) {
 		fw_mon_data->fw_mon_base_high_ptr =
 			cpu_to_le32(iwl_read_prph(trans, base_high));
 		write_ptr_val &= DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK;
@@ -3034,8 +3041,8 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 
 	if (trans->dbg.dest_tlv ||
 	    (trans->dbg.num_blocks &&
-	     (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000 ||
-	      trans->cfg->device_family >= IWL_DEVICE_FAMILY_AX210))) {
+	     (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_7000 ||
+	      trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_AX210))) {
 		struct iwl_fw_error_dump_fw_mon *fw_mon_data;
 
 		(*data)->type = cpu_to_le32(IWL_FW_ERROR_DUMP_FW_MONITOR);
@@ -3118,7 +3125,7 @@ static int iwl_trans_get_fw_monitor_len(struct iwl_trans *trans, u32 *len)
 			      trans->dbg.dest_tlv->end_shift;
 
 			/* Make "end" point to the actual end */
-			if (trans->cfg->device_family >=
+			if (trans->cfg->trans.device_family >=
 			    IWL_DEVICE_FAMILY_8000 ||
 			    trans->dbg.dest_tlv->monitor_mode == MARBH_MODE)
 				end += (1 << trans->dbg.dest_tlv->end_shift);
@@ -3144,7 +3151,7 @@ static struct iwl_trans_dump_data
 	u32 len, num_rbs = 0, monitor_len = 0;
 	int i, ptr;
 	bool dump_rbs = test_bit(STATUS_FW_ERROR, &trans->status) &&
-			!trans->cfg->mq_rx_supported &&
+			!trans->cfg->trans.mq_rx_supported &&
 			dump_mask & BIT(IWL_FW_ERROR_DUMP_RB);
 
 	if (!dump_mask)
@@ -3169,7 +3176,7 @@ static struct iwl_trans_dump_data
 
 	/* FH registers */
 	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_FH_REGS)) {
-		if (trans->cfg->gen2)
+		if (trans->cfg->trans.gen2)
 			len += sizeof(*data) +
 			       (iwl_umac_prph(trans, FH_MEM_UPPER_BOUND_GEN2) -
 				iwl_umac_prph(trans, FH_MEM_LOWER_BOUND_GEN2));
@@ -3193,7 +3200,7 @@ static struct iwl_trans_dump_data
 	}
 
 	/* Paged memory for gen2 HW */
-	if (trans->cfg->gen2 && dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING))
+	if (trans->cfg->trans.gen2 && dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING))
 		for (i = 0; i < trans->init_dram.paging_cnt; i++)
 			len += sizeof(*data) +
 			       sizeof(struct iwl_fw_error_dump_paging) +
@@ -3248,7 +3255,8 @@ static struct iwl_trans_dump_data
 		len += iwl_trans_pcie_dump_rbs(trans, &data, num_rbs);
 
 	/* Paged memory for gen2 HW */
-	if (trans->cfg->gen2 && dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING)) {
+	if (trans->cfg->trans.gen2 &&
+	    dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING)) {
 		for (i = 0; i < trans->init_dram.paging_cnt; i++) {
 			struct iwl_fw_error_dump_paging *paging;
 			u32 page_len = trans->init_dram.paging[i].size;
@@ -3374,7 +3382,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (cfg->gen2)
+	if (cfg->trans.gen2)
 		trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie),
 					&pdev->dev, cfg, &trans_ops_pcie_gen2);
 	else
@@ -3398,7 +3406,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	}
 	trans_pcie->debug_rfkill = -1;
 
-	if (!cfg->base_params->pcie_l1_allowed) {
+	if (!cfg->trans.base_params->pcie_l1_allowed) {
 		/*
 		 * W/A - seems to solve weird behavior. We need to remove this
 		 * if we don't want to stay in L1 all the time. This wastes a
@@ -3411,7 +3419,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie->def_rx_queue = 0;
 
-	if (cfg->use_tfh) {
+	if (cfg->trans.use_tfh) {
 		addr_size = 64;
 		trans_pcie->max_tbs = IWL_TFH_NUM_TBS;
 		trans_pcie->tfd_size = sizeof(struct iwl_tfh_tfd);
@@ -3473,7 +3481,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	 * "dash" value). To keep hw_rev backwards compatible - we'll store it
 	 * in the old format.
 	 */
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_8000) {
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000) {
 		unsigned long flags;
 
 		trans->hw_rev = (trans->hw_rev & 0xfff0) |
@@ -3489,7 +3497,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		 * in-order to recognize C step driver should read chip version
 		 * id located at the AUX bus MISC address space.
 		 */
-		ret = iwl_finish_nic_init(trans);
+		ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
 		if (ret)
 			goto out_no_pci;
 
@@ -3516,7 +3524,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 #if IS_ENABLED(CONFIG_IWLMVM)
 	trans->hw_rf_id = iwl_read32(trans, CSR_HW_RF_ID);
 
-	if (cfg == &iwlax210_2ax_cfg_so_hr_a0) {
+	if (trans->cfg == &iwlax210_2ax_cfg_so_hr_a0) {
 		if (trans->hw_rev == CSR_HW_REV_TYPE_TY) {
 			trans->cfg = &iwlax210_2ax_cfg_ty_gf_a0;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 6c19711d5a10..8fcda4d4bc46 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -117,7 +117,7 @@ void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 	num_fetch_chunks = DIV_ROUND_UP(filled_tfd_size, 64) - 1;
 
 	bc_ent = cpu_to_le16(len | (num_fetch_chunks << 12));
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
 		scd_bc_tbl_gen3->tfd_offset[idx] = bc_ent;
 	else
 		scd_bc_tbl->tfd_offset[idx] = bc_ent;
@@ -541,7 +541,7 @@ struct iwl_tfh_tfd *iwl_pcie_gen2_build_tfd(struct iwl_trans *trans,
 
 	memset(tfd, 0, sizeof(*tfd));
 
-	if (trans->cfg->device_family < IWL_DEVICE_FAMILY_22560)
+	if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_22560)
 		len = sizeof(struct iwl_tx_cmd_gen2);
 	else
 		len = sizeof(struct iwl_tx_cmd_gen3);
@@ -623,7 +623,7 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		return -1;
 	}
 
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560) {
 		struct iwl_tx_cmd_gen3 *tx_cmd_gen3 =
 			(void *)dev_cmd->payload;
 
@@ -1123,7 +1123,7 @@ int iwl_trans_pcie_dyn_txq_alloc_dma(struct iwl_trans *trans,
 	if (!txq)
 		return -ENOMEM;
 	ret = iwl_pcie_alloc_dma_ptr(trans, &txq->bc_tbl,
-				     (trans->cfg->device_family >=
+				     (trans->cfg->trans.device_family >=
 				      IWL_DEVICE_FAMILY_22560) ?
 				     sizeof(struct iwl_gen3_bc_tbl) :
 				     sizeof(struct iwlagn_scd_bc_tbl));
@@ -1187,7 +1187,7 @@ int iwl_trans_pcie_txq_alloc_response(struct iwl_trans *trans,
 
 	txq->id = qid;
 	trans_pcie->txq[qid] = txq;
-	wr_ptr &= (trans->cfg->base_params->max_tfd_queue_size - 1);
+	wr_ptr &= (trans->cfg->trans.base_params->max_tfd_queue_size - 1);
 
 	/* Place first TFD at index corresponding to start sequence number */
 	txq->read_ptr = wr_ptr;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 8b7b918e71ad..774c8bfe8450 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -113,17 +113,17 @@ int iwl_queue_space(struct iwl_trans *trans, const struct iwl_txq *q)
 	 * If q->n_window is smaller than max_tfd_queue_size, there is no need
 	 * to reserve any queue entries for this purpose.
 	 */
-	if (q->n_window < trans->cfg->base_params->max_tfd_queue_size)
+	if (q->n_window < trans->cfg->trans.base_params->max_tfd_queue_size)
 		max = q->n_window;
 	else
-		max = trans->cfg->base_params->max_tfd_queue_size - 1;
+		max = trans->cfg->trans.base_params->max_tfd_queue_size - 1;
 
 	/*
 	 * max_tfd_queue_size is a power of 2, so the following is equivalent to
 	 * modulo by max_tfd_queue_size and is well defined.
 	 */
 	used = (q->write_ptr - q->read_ptr) &
-		(trans->cfg->base_params->max_tfd_queue_size - 1);
+		(trans->cfg->trans.base_params->max_tfd_queue_size - 1);
 
 	if (WARN_ON(used > max))
 		return 0;
@@ -292,7 +292,7 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 2. NIC is woken up for CMD regardless of shadow outside this function
 	 * 3. there is a chance that the NIC is asleep
 	 */
-	if (!trans->cfg->base_params->shadow_reg_enable &&
+	if (!trans->cfg->trans.base_params->shadow_reg_enable &&
 	    txq_id != trans_pcie->cmd_queue &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		/*
@@ -306,7 +306,7 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 			IWL_DEBUG_INFO(trans, "Tx queue %d requesting wakeup, GP1 = 0x%x\n",
 				       txq_id, reg);
 			iwl_set_bit(trans, CSR_GP_CNTRL,
-				    BIT(trans->cfg->csr->flag_mac_access_req));
+				    BIT(trans->cfg->trans.csr->flag_mac_access_req));
 			txq->need_update = true;
 			return;
 		}
@@ -327,7 +327,7 @@ void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	for (i = 0; i < trans->cfg->base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->cfg->trans.base_params->num_of_queues; i++) {
 		struct iwl_txq *txq = trans_pcie->txq[i];
 
 		if (!test_bit(i, trans_pcie->queue_used))
@@ -346,7 +346,7 @@ static inline dma_addr_t iwl_pcie_tfd_tb_get_addr(struct iwl_trans *trans,
 						  void *_tfd, u8 idx)
 {
 
-	if (trans->cfg->use_tfh) {
+	if (trans->cfg->trans.use_tfh) {
 		struct iwl_tfh_tfd *tfd = _tfd;
 		struct iwl_tfh_tb *tb = &tfd->tbs[idx];
 
@@ -389,7 +389,7 @@ static inline void iwl_pcie_tfd_set_tb(struct iwl_trans *trans, void *tfd,
 
 static inline u8 iwl_pcie_tfd_get_num_tbs(struct iwl_trans *trans, void *_tfd)
 {
-	if (trans->cfg->use_tfh) {
+	if (trans->cfg->trans.use_tfh) {
 		struct iwl_tfh_tfd *tfd = _tfd;
 
 		return le16_to_cpu(tfd->num_tbs) & 0x1f;
@@ -436,7 +436,7 @@ static void iwl_pcie_tfd_unmap(struct iwl_trans *trans,
 
 	meta->tbs = 0;
 
-	if (trans->cfg->use_tfh) {
+	if (trans->cfg->trans.use_tfh) {
 		struct iwl_tfh_tfd *tfd_fh = (void *)tfd;
 
 		tfd_fh->num_tbs = 0;
@@ -524,14 +524,14 @@ int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	size_t tfd_sz = trans_pcie->tfd_size *
-		trans->cfg->base_params->max_tfd_queue_size;
+		trans->cfg->trans.base_params->max_tfd_queue_size;
 	size_t tb0_buf_sz;
 	int i;
 
 	if (WARN_ON(txq->entries || txq->tfds))
 		return -EINVAL;
 
-	if (trans->cfg->use_tfh)
+	if (trans->cfg->trans.use_tfh)
 		tfd_sz = trans_pcie->tfd_size * slots_num;
 
 	timer_setup(&txq->stuck_timer, iwl_pcie_txq_stuck_timer, 0);
@@ -590,7 +590,8 @@ int iwl_pcie_txq_init(struct iwl_trans *trans, struct iwl_txq *txq,
 		      int slots_num, bool cmd_queue)
 {
 	int ret;
-	u32 tfd_queue_max_size = trans->cfg->base_params->max_tfd_queue_size;
+	u32 tfd_queue_max_size =
+		trans->cfg->trans.base_params->max_tfd_queue_size;
 
 	txq->need_update = false;
 
@@ -638,14 +639,14 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 
 	lockdep_assert_held(&trans_pcie->reg_lock);
 
-	if (!trans->cfg->base_params->apmg_wake_up_wa)
+	if (!trans->cfg->trans.base_params->apmg_wake_up_wa)
 		return;
 	if (WARN_ON(!trans_pcie->cmd_hold_nic_awake))
 		return;
 
 	trans_pcie->cmd_hold_nic_awake = false;
 	__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-				   BIT(trans->cfg->csr->flag_mac_access_req));
+				   BIT(trans->cfg->trans.csr->flag_mac_access_req));
 }
 
 /*
@@ -725,7 +726,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	if (txq->tfds) {
 		dma_free_coherent(dev,
 				  trans_pcie->tfd_size *
-				  trans->cfg->base_params->max_tfd_queue_size,
+				  trans->cfg->trans.base_params->max_tfd_queue_size,
 				  txq->tfds, txq->dma_addr);
 		txq->dma_addr = 0;
 		txq->tfds = NULL;
@@ -747,7 +748,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int nq = trans->cfg->base_params->num_of_queues;
+	int nq = trans->cfg->trans.base_params->num_of_queues;
 	int chan;
 	u32 reg_val;
 	int clear_dwords = (SCD_TRANS_TBL_OFFSET_QUEUE(nq) -
@@ -774,7 +775,7 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 	/* The chain extension of the SCD doesn't work well. This feature is
 	 * enabled by default by the HW, so we need to disable it manually.
 	 */
-	if (trans->cfg->base_params->scd_chain_ext_wa)
+	if (trans->cfg->trans.base_params->scd_chain_ext_wa)
 		iwl_write_prph(trans, SCD_CHAINEXT_EN, 0);
 
 	iwl_trans_ac_txq_enable(trans, trans_pcie->cmd_queue,
@@ -796,7 +797,7 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 			   reg_val | FH_TX_CHICKEN_BITS_SCD_AUTO_RETRY_EN);
 
 	/* Enable L1-Active */
-	if (trans->cfg->device_family < IWL_DEVICE_FAMILY_8000)
+	if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_8000)
 		iwl_clear_bits_prph(trans, APMG_PCIDEV_STT_REG,
 				    APMG_PCIDEV_STT_VAL_L1_ACT_DIS);
 }
@@ -810,13 +811,13 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans)
 	 * we should never get here in gen2 trans mode return early to avoid
 	 * having invalid accesses
 	 */
-	if (WARN_ON_ONCE(trans->cfg->gen2))
+	if (WARN_ON_ONCE(trans->cfg->trans.gen2))
 		return;
 
-	for (txq_id = 0; txq_id < trans->cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->cfg->trans.base_params->num_of_queues;
 	     txq_id++) {
 		struct iwl_txq *txq = trans_pcie->txq[txq_id];
-		if (trans->cfg->use_tfh)
+		if (trans->cfg->trans.use_tfh)
 			iwl_write_direct64(trans,
 					   FH_MEM_CBBC_QUEUE(trans, txq_id),
 					   txq->dma_addr);
@@ -899,7 +900,7 @@ int iwl_pcie_tx_stop(struct iwl_trans *trans)
 		return 0;
 
 	/* Unmap DMA from host system and free skb's */
-	for (txq_id = 0; txq_id < trans->cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->cfg->trans.base_params->num_of_queues;
 	     txq_id++)
 		iwl_pcie_txq_unmap(trans, txq_id);
 
@@ -921,7 +922,7 @@ void iwl_pcie_tx_free(struct iwl_trans *trans)
 	/* Tx queues */
 	if (trans_pcie->txq_memory) {
 		for (txq_id = 0;
-		     txq_id < trans->cfg->base_params->num_of_queues;
+		     txq_id < trans->cfg->trans.base_params->num_of_queues;
 		     txq_id++) {
 			iwl_pcie_txq_free(trans, txq_id);
 			trans_pcie->txq[txq_id] = NULL;
@@ -945,9 +946,10 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	int ret;
 	int txq_id, slots_num;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	u16 bc_tbls_size = trans->cfg->base_params->num_of_queues;
+	u16 bc_tbls_size = trans->cfg->trans.base_params->num_of_queues;
 
-	bc_tbls_size *= (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) ?
+	bc_tbls_size *= (trans->cfg->trans.device_family >=
+			 IWL_DEVICE_FAMILY_22560) ?
 		sizeof(struct iwl_gen3_bc_tbl) :
 		sizeof(struct iwlagn_scd_bc_tbl);
 
@@ -972,8 +974,9 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 		goto error;
 	}
 
-	trans_pcie->txq_memory = kcalloc(trans->cfg->base_params->num_of_queues,
-					 sizeof(struct iwl_txq), GFP_KERNEL);
+	trans_pcie->txq_memory =
+		kcalloc(trans->cfg->trans.base_params->num_of_queues,
+			sizeof(struct iwl_txq), GFP_KERNEL);
 	if (!trans_pcie->txq_memory) {
 		IWL_ERR(trans, "Not enough memory for txq\n");
 		ret = -ENOMEM;
@@ -981,7 +984,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	}
 
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
-	for (txq_id = 0; txq_id < trans->cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->cfg->trans.base_params->num_of_queues;
 	     txq_id++) {
 		bool cmd_queue = (txq_id == trans_pcie->cmd_queue);
 
@@ -1035,7 +1038,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	spin_unlock(&trans_pcie->irq_lock);
 
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
-	for (txq_id = 0; txq_id < trans->cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->cfg->trans.base_params->num_of_queues;
 	     txq_id++) {
 		bool cmd_queue = (txq_id == trans_pcie->cmd_queue);
 
@@ -1063,7 +1066,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	}
 
 	iwl_set_bits_prph(trans, SCD_GP_CTRL, SCD_GP_CTRL_AUTO_ACTIVE_MODE);
-	if (trans->cfg->base_params->num_of_queues > 20)
+	if (trans->cfg->trans.base_params->num_of_queues > 20)
 		iwl_set_bits_prph(trans, SCD_GP_CTRL,
 				  SCD_GP_CTRL_ENABLE_31_QUEUES);
 
@@ -1135,7 +1138,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		IWL_ERR(trans,
 			"%s: Read index for txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
 			__func__, txq_id, last_to_free,
-			trans->cfg->base_params->max_tfd_queue_size,
+			trans->cfg->trans.base_params->max_tfd_queue_size,
 			txq->write_ptr, txq->read_ptr);
 		goto out;
 	}
@@ -1158,7 +1161,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 
 		txq->entries[read_ptr].skb = NULL;
 
-		if (!trans->cfg->use_tfh)
+		if (!trans->cfg->trans.use_tfh)
 			iwl_pcie_txq_inval_byte_cnt_tbl(trans, txq);
 
 		iwl_pcie_txq_free_tfd(trans, txq);
@@ -1250,19 +1253,19 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	 * returned. This needs to be done only on NICs that have
 	 * apmg_wake_up_wa set.
 	 */
-	if (cfg->base_params->apmg_wake_up_wa &&
+	if (cfg->trans.base_params->apmg_wake_up_wa &&
 	    !trans_pcie->cmd_hold_nic_awake) {
 		__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
-					 BIT(cfg->csr->flag_mac_access_req));
+					 BIT(cfg->trans.csr->flag_mac_access_req));
 
 		ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
-				   BIT(cfg->csr->flag_val_mac_access_en),
-				   (BIT(cfg->csr->flag_mac_clock_ready) |
+				   BIT(cfg->trans.csr->flag_val_mac_access_en),
+				   (BIT(cfg->trans.csr->flag_mac_clock_ready) |
 				    CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP),
 				   15000);
 		if (ret < 0) {
 			__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-					BIT(cfg->csr->flag_mac_access_req));
+					BIT(cfg->trans.csr->flag_mac_access_req));
 			IWL_ERR(trans, "Failed to wake NIC for hcmd\n");
 			return -EIO;
 		}
@@ -1292,12 +1295,12 @@ void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 	idx = iwl_pcie_get_cmd_index(txq, idx);
 	r = iwl_pcie_get_cmd_index(txq, txq->read_ptr);
 
-	if (idx >= trans->cfg->base_params->max_tfd_queue_size ||
+	if (idx >= trans->cfg->trans.base_params->max_tfd_queue_size ||
 	    (!iwl_queue_used(txq, idx))) {
 		WARN_ONCE(test_bit(txq_id, trans_pcie->queue_used),
 			  "%s: Read index for DMA queue txq id (%d), index %d is out of range [0-%d] %d %d.\n",
 			  __func__, txq_id, idx,
-			  trans->cfg->base_params->max_tfd_queue_size,
+			  trans->cfg->trans.base_params->max_tfd_queue_size,
 			  txq->write_ptr, txq->read_ptr);
 		return;
 	}
@@ -1411,7 +1414,7 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 		 * this sad hardware issue.
 		 * This bug has been fixed on devices 9000 and up.
 		 */
-		scd_bug = !trans->cfg->mq_rx_supported &&
+		scd_bug = !trans->cfg->trans.mq_rx_supported &&
 			!((ssn - txq->write_ptr) & 0x3f) &&
 			(ssn != txq->write_ptr);
 		if (scd_bug)
-- 
2.23.0.rc1

