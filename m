Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F22311CCB
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Feb 2021 12:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBFLCC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Feb 2021 06:02:02 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44034 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229507AbhBFLCB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Feb 2021 06:02:01 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l8LKy-0045Lv-PO; Sat, 06 Feb 2021 13:01:13 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat,  6 Feb 2021 13:01:10 +0200
Message-Id: <iwlwifi.20210206130110.6f0c1849f7dc.I647b4d22f9468c2f34b777a4bfa445912c6f04f0@changeid>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11] iwlwifi: add new cards for So and Qu family
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ihab Zhaika <ihab.zhaika@intel.com>

add few PCI ID'S for So with Hr and Qu with Hr in AX family.

Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 18 +++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 26 +++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 8280092066e7..503d0feb6bbc 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -635,6 +635,24 @@ const struct iwl_cfg iwl_cfg_snj_a0_mr_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_so_a0_hr_a0 = {
+	.fw_name_pre = IWL_SO_A_HR_B_FW_PRE,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_quz_a0_hr_b0 = {
+	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
+};
+
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 86e1d57df65e..c72d23d54d90 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -418,6 +418,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_QU		0x33
 #define IWL_CFG_MAC_TYPE_QUZ		0x35
 #define IWL_CFG_MAC_TYPE_QNJ		0x36
+#define IWL_CFG_MAC_TYPE_SO		0x37
 #define IWL_CFG_MAC_TYPE_SNJ		0x42
 #define IWL_CFG_MAC_TYPE_MA		0x44
 
@@ -604,6 +605,8 @@ extern const struct iwl_cfg iwlax201_cfg_snj_hr_b0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_snj_a0_mr_a0;
+extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
+extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index ed3f5b7aa71e..c55faa388948 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -934,6 +934,11 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_quz_a0_hr1_b0, iwl_ax101_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_ANY,
+		      iwl_cfg_quz_a0_hr_b0, iwl_ax203_name),
 
 /* Ma */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
@@ -952,6 +957,27 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_snj_a0_mr_a0, iwl_ma_name),
 
+/* So with Hr */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_ANY,
+		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_ANY,
+		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY,
+		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY,
+		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name)
 
 #endif /* CONFIG_IWLMVM */
 };
-- 
2.30.0

