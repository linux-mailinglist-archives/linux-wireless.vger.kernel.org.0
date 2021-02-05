Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B34310760
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 10:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBEJKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 04:10:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43758 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230122AbhBEJHw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 04:07:52 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7x4j-0044i1-Cx; Fri, 05 Feb 2021 11:06:50 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  5 Feb 2021 11:06:35 +0200
Message-Id: <iwlwifi.20210205110447.7e11dcb7b04e.I6f65126175d54b73834c2896013d00ce114ff601@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205090642.1553849-1-luca@coelho.fi>
References: <20210205090642.1553849-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [RESEND PATCH 05/12] iwlwifi: move SnJ and So rules to the new tables
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We were hardcoding the SnJ and So IDs already at the trans_cfg
selection, instead of doing it in a more generic way.  Use the generic
trans_cfg selection for these devices and move the hardcoded IDs to
the new table.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 38 +++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 83 ++++++++++---------
 3 files changed, 85 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index d6c88c813880..4ffe28c248d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -238,6 +238,44 @@ const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
+const struct iwl_cfg_trans_params iwl_snj_trans_cfg = {
+	.mq_rx_supported = true,
+	.use_tfh = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base_params = &iwl_ax210_base_params,
+	.umac_prph_offset = 0x300000,
+};
+
+const struct iwl_cfg_trans_params iwl_so_trans_cfg = {
+	.mq_rx_supported = true,
+	.use_tfh = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base_params = &iwl_ax210_base_params,
+	.umac_prph_offset = 0x300000,
+	.integrated = true,
+	/* TODO: the following values need to be checked */
+	.xtal_latency = 500,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_200US,
+};
+
+const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg = {
+	.mq_rx_supported = true,
+	.use_tfh = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base_params = &iwl_ax210_base_params,
+	.umac_prph_offset = 0x300000,
+	.integrated = true,
+	/* TODO: the following values need to be checked */
+	.xtal_latency = 12000,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
+};
+
 /*
  * If the device doesn't support HE, no need to have that many buffers.
  * 22000 devices can split multiple frames into a single RB, so fewer are
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 27cb0406ba9a..56ca35b345cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -418,6 +418,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_QU		0x33
 #define IWL_CFG_MAC_TYPE_QUZ		0x35
 #define IWL_CFG_MAC_TYPE_QNJ		0x36
+#define IWL_CFG_MAC_TYPE_SO		0x37
 #define IWL_CFG_MAC_TYPE_SNJ		0x42
 #define IWL_CFG_MAC_TYPE_MA		0x44
 
@@ -473,6 +474,9 @@ extern const struct iwl_cfg_trans_params iwl_qu_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_medium_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_snj_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_so_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ma_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 965982612e74..852c6b8b7568 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -478,40 +478,13 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 	{IWL_PCI_DEVICE(0x2723, PCI_ANY_ID, iwl_ax200_trans_cfg)},
 
-	{IWL_PCI_DEVICE(0x2725, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x0024, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x0510, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x0A10, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0xE020, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0xE024, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x4020, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x6020, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x6024, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0)},
-	{IWL_PCI_DEVICE(0x2726, 0x0070, iwlax201_cfg_snj_hr_b0)},
-	{IWL_PCI_DEVICE(0x2726, 0x0074, iwlax201_cfg_snj_hr_b0)},
-	{IWL_PCI_DEVICE(0x2726, 0x0078, iwlax201_cfg_snj_hr_b0)},
-	{IWL_PCI_DEVICE(0x2726, 0x007C, iwlax201_cfg_snj_hr_b0)},
-	{IWL_PCI_DEVICE(0x2726, 0x0090, iwlax211_cfg_snj_gf_a0)},
-	{IWL_PCI_DEVICE(0x2726, 0x0098, iwlax211_cfg_snj_gf_a0)},
-	{IWL_PCI_DEVICE(0x2726, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0)},
-	{IWL_PCI_DEVICE(0x2726, 0x0510, iwlax211_cfg_snj_gf_a0)},
-	{IWL_PCI_DEVICE(0x2726, 0x2074, iwlax201_cfg_snj_hr_b0)},
-	{IWL_PCI_DEVICE(0x2726, 0x4070, iwlax201_cfg_snj_hr_b0)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0090, iwlax211_2ax_cfg_so_gf_a0_long)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0098, iwlax211_2ax_cfg_so_gf_a0_long)},
-	{IWL_PCI_DEVICE(0x7A70, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0_long)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0310, iwlax211_2ax_cfg_so_gf_a0_long)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0510, iwlax211_2ax_cfg_so_gf_a0_long)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0A10, iwlax211_2ax_cfg_so_gf_a0_long)},
-	{IWL_PCI_DEVICE(0x7AF0, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
-	{IWL_PCI_DEVICE(0x7AF0, 0x0098, iwlax211_2ax_cfg_so_gf_a0)},
-	{IWL_PCI_DEVICE(0x7AF0, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0)},
-	{IWL_PCI_DEVICE(0x7AF0, 0x0310, iwlax211_2ax_cfg_so_gf_a0)},
-	{IWL_PCI_DEVICE(0x7AF0, 0x0510, iwlax211_2ax_cfg_so_gf_a0)},
-	{IWL_PCI_DEVICE(0x7AF0, 0x0A10, iwlax211_2ax_cfg_so_gf_a0)},
+/* So devices */
+	{IWL_PCI_DEVICE(0x2725, PCI_ANY_ID, iwl_so_trans_cfg)},
+	{IWL_PCI_DEVICE(0x2726, PCI_ANY_ID, iwl_snj_trans_cfg)},
+	{IWL_PCI_DEVICE(0x7A70, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
+	{IWL_PCI_DEVICE(0x7AF0, PCI_ANY_ID, iwl_so_trans_cfg)},
+	{IWL_PCI_DEVICE(0x51F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
+	{IWL_PCI_DEVICE(0x54F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
 
 /* Ma devices */
 	{IWL_PCI_DEVICE(0x2729, PCI_ANY_ID, iwl_ma_trans_cfg)},
@@ -558,12 +531,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	/* QnJ with Hr */
 	IWL_DEV_INFO(0x2720, IWL_CFG_ANY, iwl_qnj_b0_hr_b0_cfg, iwl_ax201_name),
 
-	/* SnJ with HR*/
-	IWL_DEV_INFO(0x2726, 0x0244, iwlax201_cfg_snj_hr_b0, iwl_ax101_name),
-	IWL_DEV_INFO(0x2726, 0x1651, iwlax201_cfg_snj_hr_b0, iwl_ax201_killer_1650s_name),
-	IWL_DEV_INFO(0x2726, 0x1652, iwlax201_cfg_snj_hr_b0, iwl_ax201_killer_1650i_name),
-	IWL_DEV_INFO(0x2726, 0x4244, iwlax201_cfg_snj_hr_b0, iwl_ax101_name),
-
 	/* Qu with Hr */
 	IWL_DEV_INFO(0x43F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
@@ -629,6 +596,42 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x4DF0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
 
+	/* So with HR */
+	IWL_DEV_INFO(0x2725, 0x0090, iwlax211_2ax_cfg_so_gf_a0, NULL),
+	IWL_DEV_INFO(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0, NULL),
+	IWL_DEV_INFO(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0, NULL),
+	IWL_DEV_INFO(0x2725, 0x0510, iwlax210_2ax_cfg_ty_gf_a0, NULL),
+	IWL_DEV_INFO(0x2725, 0x0A10, iwlax210_2ax_cfg_ty_gf_a0, NULL),
+	IWL_DEV_INFO(0x7A70, 0x0090, iwlax211_2ax_cfg_so_gf_a0_long, NULL),
+	IWL_DEV_INFO(0x7A70, 0x0098, iwlax211_2ax_cfg_so_gf_a0_long, NULL),
+	IWL_DEV_INFO(0x7A70, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0_long, NULL),
+	IWL_DEV_INFO(0x7A70, 0x0310, iwlax211_2ax_cfg_so_gf_a0_long, NULL),
+	IWL_DEV_INFO(0x7A70, 0x0510, iwlax211_2ax_cfg_so_gf_a0_long, NULL),
+	IWL_DEV_INFO(0x7A70, 0x0A10, iwlax211_2ax_cfg_so_gf_a0_long, NULL),
+	IWL_DEV_INFO(0x7AF0, 0x0090, iwlax211_2ax_cfg_so_gf_a0, NULL),
+	IWL_DEV_INFO(0x7AF0, 0x0098, iwlax211_2ax_cfg_so_gf_a0, NULL),
+	IWL_DEV_INFO(0x7AF0, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0, NULL),
+	IWL_DEV_INFO(0x7AF0, 0x0310, iwlax211_2ax_cfg_so_gf_a0, NULL),
+	IWL_DEV_INFO(0x7AF0, 0x0510, iwlax211_2ax_cfg_so_gf_a0, NULL),
+	IWL_DEV_INFO(0x7AF0, 0x0A10, iwlax211_2ax_cfg_so_gf_a0, NULL),
+
+	/* SnJ with HR */
+	IWL_DEV_INFO(0x2725, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0, NULL),
+	IWL_DEV_INFO(0x2726, 0x0070, iwlax201_cfg_snj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2726, 0x0074, iwlax201_cfg_snj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2726, 0x0078, iwlax201_cfg_snj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2726, 0x007C, iwlax201_cfg_snj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2726, 0x0090, iwlax211_cfg_snj_gf_a0, NULL),
+	IWL_DEV_INFO(0x2726, 0x0098, iwlax211_cfg_snj_gf_a0, NULL),
+	IWL_DEV_INFO(0x2726, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0, NULL),
+	IWL_DEV_INFO(0x2726, 0x0510, iwlax211_cfg_snj_gf_a0, NULL),
+	IWL_DEV_INFO(0x2726, 0x2074, iwlax201_cfg_snj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2726, 0x4070, iwlax201_cfg_snj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2726, 0x0244, iwlax201_cfg_snj_hr_b0, iwl_ax101_name),
+	IWL_DEV_INFO(0x2726, 0x1651, iwlax201_cfg_snj_hr_b0, iwl_ax201_killer_1650s_name),
+	IWL_DEV_INFO(0x2726, 0x1652, iwlax201_cfg_snj_hr_b0, iwl_ax201_killer_1650i_name),
+	IWL_DEV_INFO(0x2726, 0x4244, iwlax201_cfg_snj_hr_b0, iwl_ax101_name),
+
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-- 
2.30.0

