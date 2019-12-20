Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38856127B51
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLTMvt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54120 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727269AbfLTMvt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHks-0007lx-An; Fri, 20 Dec 2019 14:51:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:24 +0200
Message-Id: <20191220125124.1315679-12-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220125124.1315679-1-luca@coelho.fi>
References: <20191220125124.1315679-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 11/11] iwlwifi: remove CSR registers abstraction
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We needed this abstraction for some CSR registers for
IWL_DEVICE_22560, but that has been removed, so we don't need the
abstraction anymore.  Remove it.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |  6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c | 12 ++---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 -
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |  7 +--
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c | 19 +++----
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  1 -
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 50 -------------------
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  | 27 +++++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   | 37 ++------------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 14 ++----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  6 ---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  5 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 37 ++++++--------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 12 ++---
 17 files changed, 74 insertions(+), 169 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
index b92255b91b72..8a4579bb10d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
@@ -77,8 +77,7 @@ static const struct iwl_eeprom_params iwl1000_eeprom_params = {
 	.trans.base_params = &iwl1000_base_params,		\
 	.eeprom_params = &iwl1000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl1000_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 1000 BGN",
@@ -104,8 +103,7 @@ const struct iwl_cfg iwl1000_bg_cfg = {
 	.eeprom_params = &iwl1000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl100_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 100 BGN",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
index 2b1ae0cecc83..7140a5f3ea8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
@@ -103,8 +103,7 @@ static const struct iwl_eeprom_params iwl20x0_eeprom_params = {
 	.trans.base_params = &iwl2000_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 
 const struct iwl_cfg iwl2000_2bgn_cfg = {
@@ -131,8 +130,7 @@ const struct iwl_cfg iwl2000_2bgn_d_cfg = {
 	.trans.base_params = &iwl2030_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl2030_2bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 2230 BGN",
@@ -153,8 +151,7 @@ const struct iwl_cfg iwl2030_2bgn_cfg = {
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl105_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 105 BGN",
@@ -181,8 +178,7 @@ const struct iwl_cfg iwl105_bgn_d_cfg = {
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl135_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N 135 BGN",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 1d3dc7cf4d63..837c06891f5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -199,7 +199,6 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	IWL_DEVICE_22000_COMMON,					\
 	.trans.device_family = IWL_DEVICE_FAMILY_22000,			\
 	.trans.base_params = &iwl_22000_base_params,			\
-	.trans.csr = &iwl_csr_v1,					\
 	.gp2_reg_addr = 0xa02c68,					\
 	.mon_dram_regs = {						\
 		.write_ptr = {						\
@@ -217,7 +216,6 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.trans.umac_prph_offset = 0x300000,				\
 	.trans.device_family = IWL_DEVICE_FAMILY_AX210,			\
 	.trans.base_params = &iwl_ax210_base_params,			\
-	.trans.csr = &iwl_csr_v1,					\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
 	.min_256_ba_txq_size = 512,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
index aab4495c6085..3591336dc644 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -75,8 +75,7 @@ static const struct iwl_eeprom_params iwl5000_eeprom_params = {
 	.trans.base_params = &iwl5000_base_params,		\
 	.eeprom_params = &iwl5000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl5300_agn_cfg = {
 	.name = "Intel(R) Ultimate N WiFi Link 5300 AGN",
@@ -125,7 +124,6 @@ const struct iwl_cfg iwl5350_agn_cfg = {
 	.ht_params = &iwl5000_ht_params,
 	.led_mode = IWL_LED_BLINK,
 	.internal_wimax_coex = true,
-	.trans.csr = &iwl_csr_v1,
 };
 
 #define IWL_DEVICE_5150						\
@@ -141,8 +139,7 @@ const struct iwl_cfg iwl5350_agn_cfg = {
 	.eeprom_params = &iwl5000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl5150_agn_cfg = {
 	.name = "Intel(R) WiMAX/WiFi Link 5150 AGN",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
index 39ea81903dbe..b4a8a6804c39 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
@@ -124,8 +124,7 @@ static const struct iwl_eeprom_params iwl6000_eeprom_params = {
 	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl6005_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6205 AGN",
@@ -179,8 +178,7 @@ const struct iwl_cfg iwl6005_2agn_mow2_cfg = {
 	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl6030_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6230 AGN",
@@ -216,8 +214,7 @@ const struct iwl_cfg iwl6030_2bg_cfg = {
 	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl6035_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6235 AGN",
@@ -272,8 +269,7 @@ const struct iwl_cfg iwl130_bg_cfg = {
 	.trans.base_params = &iwl6000_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl6000i_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N 6200 AGN",
@@ -306,8 +302,7 @@ const struct iwl_cfg iwl6000i_2bg_cfg = {
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl6050_2agn_cfg = {
 	.name = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 AGN",
@@ -333,8 +328,7 @@ const struct iwl_cfg iwl6050_2abg_cfg = {
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true,				\
-	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.trans.csr = &iwl_csr_v1
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K
 
 const struct iwl_cfg iwl6150_bgn_cfg = {
 	.name = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BGN",
@@ -361,7 +355,6 @@ const struct iwl_cfg iwl6000_3agn_cfg = {
 	.eeprom_params = &iwl6000_eeprom_params,
 	.ht_params = &iwl6000_ht_params,
 	.led_mode = IWL_LED_BLINK,
-	.trans.csr = &iwl_csr_v1,
 };
 
 MODULE_FIRMWARE(IWL6000_MODULE_FIRMWARE(IWL6000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index deb520aeb3f8..b72993e07fc2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -154,8 +154,7 @@ static const struct iwl_ht_params iwl7000_ht_params = {
 	.nvm_hw_section_num = 0,				\
 	.non_shared_ant = ANT_A,				\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,	\
-	.dccm_offset = IWL7000_DCCM_OFFSET,			\
-	.trans.csr = &iwl_csr_v1
+	.dccm_offset = IWL7000_DCCM_OFFSET
 
 #define IWL_DEVICE_7000						\
 	IWL_DEVICE_7000_COMMON,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index b3cc477140c0..280d84fa5cb1 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -151,8 +151,7 @@ static const struct iwl_tt_params iwl8000_tt_params = {
 	.apmg_not_supported = true,					\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
-	.min_umac_error_event_table = 0x800000,				\
-	.trans.csr = &iwl_csr_v1
+	.min_umac_error_event_table = 0x800000
 
 #define IWL_DEVICE_8000							\
 	IWL_DEVICE_8000_COMMON,						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index ac05c1a6ec6b..79390f880efb 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -145,7 +145,6 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x800000,				\
-	.trans.csr = &iwl_csr_v1,					\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 92 * 1024,				\
 	.ht_params = &iwl9000_ht_params,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 31a6f286f7f7..bb91c36c9d8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -284,52 +284,6 @@ struct iwl_pwr_tx_backoff {
 	u32 backoff;
 };
 
-/**
- * struct iwl_csr_params
- *
- * @flag_sw_reset: reset the device
- * @flag_mac_clock_ready:
- *	Indicates MAC (ucode processor, etc.) is powered up and can run.
- *	Internal resources are accessible.
- *	NOTE:  This does not indicate that the processor is actually running.
- *	NOTE:  This does not indicate that device has completed
- *	       init or post-power-down restore of internal SRAM memory.
- *	       Use CSR_UCODE_DRV_GP1_BIT_MAC_SLEEP as indication that
- *	       SRAM is restored and uCode is in normal operation mode.
- *	       This note is relevant only for pre 5xxx devices.
- *	NOTE:  After device reset, this bit remains "0" until host sets
- *	       INIT_DONE
- * @flag_init_done: Host sets this to put device into fully operational
- *	D0 power mode. Host resets this after SW_RESET to put device into
- *	low power mode.
- * @flag_mac_access_req: Host sets this to request and maintain MAC wakeup,
- *	to allow host access to device-internal resources. Host must wait for
- *	mac_clock_ready (and !GOING_TO_SLEEP) before accessing non-CSR device
- *	registers.
- * @flag_val_mac_access_en: mac access is enabled
- * @flag_master_dis: disable master
- * @flag_stop_master: stop master
- * @addr_sw_reset: address for resetting the device
- * @mac_addr0_otp: first part of MAC address from OTP
- * @mac_addr1_otp: second part of MAC address from OTP
- * @mac_addr0_strap: first part of MAC address from strap
- * @mac_addr1_strap: second part of MAC address from strap
- */
-struct iwl_csr_params {
-	u8 flag_sw_reset;
-	u8 flag_mac_clock_ready;
-	u8 flag_init_done;
-	u8 flag_mac_access_req;
-	u8 flag_val_mac_access_en;
-	u8 flag_master_dis;
-	u8 flag_stop_master;
-	u8 addr_sw_reset;
-	u32 mac_addr0_otp;
-	u32 mac_addr1_otp;
-	u32 mac_addr0_strap;
-	u32 mac_addr1_strap;
-};
-
 /**
  * struct iwl_cfg_trans - information needed to start the trans
  *
@@ -348,7 +302,6 @@ struct iwl_csr_params {
  */
 struct iwl_cfg_trans_params {
 	const struct iwl_base_params *base_params;
-	const struct iwl_csr_params *csr;
 	enum iwl_device_family device_family;
 	u32 umac_prph_offset;
 	u32 rf_id:1,
@@ -499,9 +452,6 @@ struct iwl_cfg {
 	const struct iwl_fw_mon_regs mon_smem_regs;
 };
 
-extern const struct iwl_csr_params iwl_csr_v1;
-extern const struct iwl_csr_params iwl_csr_v2;
-
 /*
  * This list declares the config structures for all devices.
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 92d9898ab7c2..2c150778d144 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -256,6 +256,7 @@
 /* RESET */
 #define CSR_RESET_REG_FLAG_NEVO_RESET                (0x00000001)
 #define CSR_RESET_REG_FLAG_FORCE_NMI                 (0x00000002)
+#define CSR_RESET_REG_FLAG_SW_RESET		     (0x00000080)
 #define CSR_RESET_REG_FLAG_MASTER_DISABLED           (0x00000100)
 #define CSR_RESET_REG_FLAG_STOP_MASTER               (0x00000200)
 #define CSR_RESET_LINK_PWR_MGMT_DISABLED             (0x80000000)
@@ -278,11 +279,35 @@
  *     4:  GOING_TO_SLEEP
  *         Indicates MAC is entering a power-saving sleep power-down.
  *         Not a good time to access device-internal resources.
+ *     3:  MAC_ACCESS_REQ
+ *         Host sets this to request and maintain MAC wakeup, to allow host
+ *         access to device-internal resources.  Host must wait for
+ *         MAC_CLOCK_READY (and !GOING_TO_SLEEP) before accessing non-CSR
+ *         device registers.
+ *     2:  INIT_DONE
+ *         Host sets this to put device into fully operational D0 power mode.
+ *         Host resets this after SW_RESET to put device into low power mode.
+ *     0:  MAC_CLOCK_READY
+ *         Indicates MAC (ucode processor, etc.) is powered up and can run.
+ *         Internal resources are accessible.
+ *         NOTE:  This does not indicate that the processor is actually running.
+ *         NOTE:  This does not indicate that device has completed
+ *                init or post-power-down restore of internal SRAM memory.
+ *                Use CSR_UCODE_DRV_GP1_BIT_MAC_SLEEP as indication that
+ *                SRAM is restored and uCode is in normal operation mode.
+ *                Later devices (5xxx/6xxx/1xxx) use non-volatile SRAM, and
+ *                do not need to save/restore it.
+ *         NOTE:  After device reset, this bit remains "0" until host sets
+ *                INIT_DONE
  */
+#define CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY	     (0x00000001)
 #define CSR_GP_CNTRL_REG_FLAG_INIT_DONE		     (0x00000004)
-#define CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP         (0x00000010)
+#define CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ	     (0x00000008)
+#define CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP	     (0x00000010)
 #define CSR_GP_CNTRL_REG_FLAG_XTAL_ON		     (0x00000400)
 
+#define CSR_GP_CNTRL_REG_VAL_MAC_ACCESS_EN	     (0x00000001)
+
 #define CSR_GP_CNTRL_REG_MSK_POWER_SAVE_TYPE         (0x07000000)
 #define CSR_GP_CNTRL_REG_FLAG_RFKILL_WAKE_L1A_EN     (0x04000000)
 #define CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW          (0x08000000)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 1b7414bf7bef..2139f0b8f2bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -70,36 +70,6 @@
 #include "iwl-prph.h"
 #include "iwl-fh.h"
 
-const struct iwl_csr_params iwl_csr_v1 = {
-	.flag_mac_clock_ready = 0,
-	.flag_val_mac_access_en = 0,
-	.flag_init_done = 2,
-	.flag_mac_access_req = 3,
-	.flag_sw_reset = 7,
-	.flag_master_dis = 8,
-	.flag_stop_master = 9,
-	.addr_sw_reset = CSR_BASE + 0x020,
-	.mac_addr0_otp = 0x380,
-	.mac_addr1_otp = 0x384,
-	.mac_addr0_strap = 0x388,
-	.mac_addr1_strap = 0x38C
-};
-
-const struct iwl_csr_params iwl_csr_v2 = {
-	.flag_init_done = 6,
-	.flag_mac_clock_ready = 20,
-	.flag_val_mac_access_en = 20,
-	.flag_mac_access_req = 21,
-	.flag_master_dis = 28,
-	.flag_stop_master = 29,
-	.flag_sw_reset = 31,
-	.addr_sw_reset = CSR_BASE + 0x024,
-	.mac_addr0_otp = 0x30,
-	.mac_addr1_otp = 0x34,
-	.mac_addr0_strap = 0x38,
-	.mac_addr1_strap = 0x3C
-};
-
 void iwl_write8(struct iwl_trans *trans, u32 ofs, u8 val)
 {
 	trace_iwlwifi_dev_iowrite8(trans->dev, ofs, val);
@@ -506,8 +476,7 @@ int iwl_finish_nic_init(struct iwl_trans *trans,
 	 * Set "initialization complete" bit to move adapter from
 	 * D0U* --> D0A* (powered-up active) state.
 	 */
-	iwl_set_bit(trans, CSR_GP_CNTRL,
-		    BIT(cfg_trans->csr->flag_init_done));
+	iwl_set_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 
 	if (cfg_trans->device_family == IWL_DEVICE_FAMILY_8000)
 		udelay(2);
@@ -518,8 +487,8 @@ int iwl_finish_nic_init(struct iwl_trans *trans,
 	 * and accesses to uCode SRAM.
 	 */
 	err = iwl_poll_bit(trans, CSR_GP_CNTRL,
-			   BIT(cfg_trans->csr->flag_mac_clock_ready),
-			   BIT(cfg_trans->csr->flag_mac_clock_ready),
+			   CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY,
+			   CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY,
 			   25000);
 	if (err < 0)
 		IWL_DEBUG_INFO(trans, "Failed to wake NIC\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 1e240a2a8329..4e706c684b1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -801,12 +801,8 @@ static void iwl_flip_hw_address(__le32 mac_addr0, __le32 mac_addr1, u8 *dest)
 static void iwl_set_hw_address_from_csr(struct iwl_trans *trans,
 					struct iwl_nvm_data *data)
 {
-	__le32 mac_addr0 =
-		cpu_to_le32(iwl_read32(trans,
-				       trans->trans_cfg->csr->mac_addr0_strap));
-	__le32 mac_addr1 =
-		cpu_to_le32(iwl_read32(trans,
-				       trans->trans_cfg->csr->mac_addr1_strap));
+	__le32 mac_addr0 = cpu_to_le32(iwl_read32(trans, CSR_MAC_ADDR0_STRAP));
+	__le32 mac_addr1 = cpu_to_le32(iwl_read32(trans, CSR_MAC_ADDR1_STRAP));
 
 	iwl_flip_hw_address(mac_addr0, mac_addr1, data->hw_addr);
 	/*
@@ -816,10 +812,8 @@ static void iwl_set_hw_address_from_csr(struct iwl_trans *trans,
 	if (is_valid_ether_addr(data->hw_addr))
 		return;
 
-	mac_addr0 = cpu_to_le32(iwl_read32(trans,
-					trans->trans_cfg->csr->mac_addr0_otp));
-	mac_addr1 = cpu_to_le32(iwl_read32(trans,
-					trans->trans_cfg->csr->mac_addr1_otp));
+	mac_addr0 = cpu_to_le32(iwl_read32(trans, CSR_MAC_ADDR0_OTP));
+	mac_addr1 = cpu_to_le32(iwl_read32(trans, CSR_MAC_ADDR1_OTP));
 
 	iwl_flip_hw_address(mac_addr0, mac_addr1, data->hw_addr);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index bac3d3fa0dec..79c24c696c8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1007,12 +1007,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* the trans_cfg should never change, so set it now */
 	iwl_trans->trans_cfg = &cfg->trans;
 
-	if (WARN_ONCE(!iwl_trans->trans_cfg->csr,
-		      "CSR addresses aren't configured\n")) {
-		ret = -EINVAL;
-		goto out_free_trans;
-	}
-
 #if IS_ENABLED(CONFIG_IWLMVM)
 	/*
 	 * special-case 7265D, it has the same PCI IDs.
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 498a14ebac47..12fec6d59eb9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -240,7 +240,7 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 			IWL_DEBUG_INFO(trans, "Rx queue requesting wakeup, GP1 = 0x%x\n",
 				       reg);
 			iwl_set_bit(trans, CSR_GP_CNTRL,
-				    BIT(trans->trans_cfg->csr->flag_mac_access_req));
+				    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 			rxq->need_update = true;
 			return;
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 0252716c0b24..c1bb7150489a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -157,8 +157,7 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	 * Clear "initialization complete" bit to move adapter from
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
-	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->trans_cfg->csr->flag_init_done));
+	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 }
 
 void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
@@ -200,7 +199,7 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 
 	/* Make sure (redundant) we've released our request to stay awake */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->trans_cfg->csr->flag_mac_access_req));
+		      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_gen2_apm_stop(trans, false);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index cb4915451792..3db1313f9270 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -183,8 +183,7 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 static void iwl_trans_pcie_sw_reset(struct iwl_trans *trans)
 {
 	/* Reset entire device - do controller reset (results in SHRD_HW_RST) */
-	iwl_set_bit(trans, trans->trans_cfg->csr->addr_sw_reset,
-		    BIT(trans->trans_cfg->csr->flag_sw_reset));
+	iwl_set_bit(trans, CSR_RESET, CSR_RESET_REG_FLAG_SW_RESET);
 	usleep_range(5000, 6000);
 }
 
@@ -487,8 +486,7 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 	 * Clear "initialization complete" bit to move adapter from
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
-	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->trans_cfg->csr->flag_init_done));
+	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 
 	/* Activates XTAL resources monitor */
 	__iwl_trans_pcie_set_bit(trans, CSR_MONITOR_CFG_REG,
@@ -510,12 +508,11 @@ void iwl_pcie_apm_stop_master(struct iwl_trans *trans)
 	int ret;
 
 	/* stop device's busmaster DMA activity */
-	iwl_set_bit(trans, trans->trans_cfg->csr->addr_sw_reset,
-		    BIT(trans->trans_cfg->csr->flag_stop_master));
+	iwl_set_bit(trans, CSR_RESET, CSR_RESET_REG_FLAG_STOP_MASTER);
 
-	ret = iwl_poll_bit(trans, trans->trans_cfg->csr->addr_sw_reset,
-			   BIT(trans->trans_cfg->csr->flag_master_dis),
-			   BIT(trans->trans_cfg->csr->flag_master_dis), 100);
+	ret = iwl_poll_bit(trans, CSR_RESET,
+			   CSR_RESET_REG_FLAG_MASTER_DISABLED,
+			   CSR_RESET_REG_FLAG_MASTER_DISABLED, 100);
 	if (ret < 0)
 		IWL_WARN(trans, "Master Disable Timed Out, 100 usec\n");
 
@@ -564,8 +561,7 @@ static void iwl_pcie_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	 * Clear "initialization complete" bit to move adapter from
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
-	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->trans_cfg->csr->flag_init_done));
+	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 }
 
 static int iwl_pcie_nic_init(struct iwl_trans *trans)
@@ -1270,7 +1266,7 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 
 	/* Make sure (redundant) we've released our request to stay awake */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->trans_cfg->csr->flag_mac_access_req));
+		      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_apm_stop(trans, false);
@@ -1494,9 +1490,8 @@ void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
 	iwl_pcie_synchronize_irqs(trans);
 
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->trans_cfg->csr->flag_mac_access_req));
-	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->trans_cfg->csr->flag_init_done));
+		      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 
 	if (reset) {
 		/*
@@ -1561,7 +1556,7 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 	}
 
 	iwl_set_bit(trans, CSR_GP_CNTRL,
-		    BIT(trans->trans_cfg->csr->flag_mac_access_req));
+		    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
 	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
 	if (ret)
@@ -1583,7 +1578,7 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 
 	if (!reset) {
 		iwl_clear_bit(trans, CSR_GP_CNTRL,
-			      BIT(trans->trans_cfg->csr->flag_mac_access_req));
+			      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 	} else {
 		iwl_trans_pcie_tx_reset(trans);
 
@@ -2029,7 +2024,7 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
 
 	/* this bit wakes up the NIC */
 	__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
-				 BIT(trans->trans_cfg->csr->flag_mac_access_req));
+				 CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 		udelay(2);
 
@@ -2054,8 +2049,8 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
 	 * and do not save/restore SRAM when power cycling.
 	 */
 	ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
-			   BIT(trans->trans_cfg->csr->flag_val_mac_access_en),
-			   (BIT(trans->trans_cfg->csr->flag_mac_clock_ready) |
+			   CSR_GP_CNTRL_REG_VAL_MAC_ACCESS_EN,
+			   (CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY |
 			    CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP), 15000);
 	if (unlikely(ret < 0)) {
 		u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);
@@ -2137,7 +2132,7 @@ static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans,
 		goto out;
 
 	__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-				   BIT(trans->trans_cfg->csr->flag_mac_access_req));
+				   CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 	/*
 	 * Above we read the CSR_GP_CNTRL register, which will flush
 	 * any previous writes, but we need the write that clears the
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index f21f16ab2a97..9ac03122653c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -306,7 +306,7 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 			IWL_DEBUG_INFO(trans, "Tx queue %d requesting wakeup, GP1 = 0x%x\n",
 				       txq_id, reg);
 			iwl_set_bit(trans, CSR_GP_CNTRL,
-				    BIT(trans->trans_cfg->csr->flag_mac_access_req));
+				    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 			txq->need_update = true;
 			return;
 		}
@@ -646,7 +646,7 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 
 	trans_pcie->cmd_hold_nic_awake = false;
 	__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-				   BIT(trans->trans_cfg->csr->flag_mac_access_req));
+				   CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 }
 
 /*
@@ -1255,16 +1255,16 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	if (trans->trans_cfg->base_params->apmg_wake_up_wa &&
 	    !trans_pcie->cmd_hold_nic_awake) {
 		__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
-					 BIT(trans->trans_cfg->csr->flag_mac_access_req));
+					 CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
 		ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
-				   BIT(trans->trans_cfg->csr->flag_val_mac_access_en),
-				   (BIT(trans->trans_cfg->csr->flag_mac_clock_ready) |
+				   CSR_GP_CNTRL_REG_VAL_MAC_ACCESS_EN,
+				   (CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY |
 				    CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP),
 				   15000);
 		if (ret < 0) {
 			__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-					BIT(trans->trans_cfg->csr->flag_mac_access_req));
+					CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 			IWL_ERR(trans, "Failed to wake NIC for hcmd\n");
 			return -EIO;
 		}
-- 
2.24.0

