Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C191718F59B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgCWNUc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:20:32 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43486 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728453AbgCWNUc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:20:32 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzX-00023f-6T; Mon, 23 Mar 2020 15:19:44 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:23 +0200
Message-Id: <iwlwifi.20200323151304.ec4f463bde60.I14e9146a99621ff11ce50bc746a4b88af508fee0@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323131925.208376-1-luca@coelho.fi>
References: <20200323131925.208376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/14] iwlwifi: convert all Qu with Jf devices to the new config table
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add new generic iwl_trans structures for these devices and apply the
correct cfg depending on the device characteristics.

Since we have to match Qu with IWL_CONFIG_ANY, we also need to move
the Hr devices to the new table, but for now we keep matching on PCI
device and subsystem device IDs.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  35 ++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   5 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 493 +++++++++---------
 3 files changed, 283 insertions(+), 250 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index bfabe0ed4ee8..d86752ad96b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -235,6 +235,17 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 		},							\
 	}
 
+const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
+	.mq_rx_supported = true,
+	.use_tfh = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_22000,
+	.base_params = &iwl_22000_base_params,
+	.integrated = true,
+	.xtal_latency = 5000,
+};
+
 /*
  * If the device doesn't support HE, no need to have that many buffers.
  * 22000 devices can split multiple frames into a single RB, so fewer are
@@ -246,6 +257,30 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 #define IWL_NUM_RBDS_22000_HE		2048
 #define IWL_NUM_RBDS_AX210_HE		4096
 
+const struct iwl_cfg iwl9560_qu_b0_jf_b0_cfg = {
+	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
+};
+
+const struct iwl_cfg iwl9560_qu_c0_jf_b0_cfg = {
+	.fw_name_pre = IWL_QU_C_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
+};
+
+const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg = {
+	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
+};
+
 const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 13f38c21cbd7..af7b6a67dfb1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -461,6 +461,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_PNJ		0x32
 #define IWL_CFG_MAC_TYPE_TH		0x32
 #define IWL_CFG_MAC_TYPE_QU		0x33
+#define IWL_CFG_MAC_TYPE_QUZ		0x35
 
 #define IWL_CFG_RF_TYPE_TH		0x105
 #define IWL_CFG_RF_TYPE_TH1		0x108
@@ -502,6 +503,7 @@ struct iwl_dev_info {
 extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_qu_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
@@ -589,6 +591,9 @@ extern const struct iwl_cfg iwl8265_2ac_cfg;
 extern const struct iwl_cfg iwl8275_2ac_cfg;
 extern const struct iwl_cfg iwl4165_2ac_cfg;
 extern const struct iwl_cfg iwl9260_2ac_cfg;
+extern const struct iwl_cfg iwl9560_qu_b0_jf_b0_cfg;
+extern const struct iwl_cfg iwl9560_qu_c0_jf_b0_cfg;
+extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index ee692e45bdb3..609c4c5bd32c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -513,67 +513,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8265_2ac_cfg)},
 
 /* 9000 Series */
-	{IWL_PCI_DEVICE(0x02F0, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-
-	{IWL_PCI_DEVICE(0x06F0, 0x0030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0034, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0038, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x003C, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0060, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0064, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x00A0, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x00A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0230, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0234, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0238, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x023C, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0260, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0264, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x02A0, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x02A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x1551, iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x1552, iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x2030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x2034, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x4030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x4034, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x40A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x4234, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x42A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-
-	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x271B, PCI_ANY_ID, iwl9560_trans_cfg)},
-	{IWL_PCI_DEVICE(0x271C, PCI_ANY_ID, iwl9560_trans_cfg)},
-	{IWL_PCI_DEVICE(0x30DC, PCI_ANY_ID, iwl9560_trans_cfg)},
-	{IWL_PCI_DEVICE(0x31DC, PCI_ANY_ID, iwl9560_shared_clk_trans_cfg)},
-	{IWL_PCI_DEVICE(0x9DF0, PCI_ANY_ID, iwl9560_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA370, PCI_ANY_ID, iwl9560_trans_cfg)},
-
 	{IWL_PCI_DEVICE(0x2720, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x2720, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x2720, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
@@ -600,140 +539,27 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x2720, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
 
-	{IWL_PCI_DEVICE(0x34F0, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-
-	{IWL_PCI_DEVICE(0x3DF0, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-
-	{IWL_PCI_DEVICE(0x43F0, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-
-	{IWL_PCI_DEVICE(0xA0F0, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x271B, PCI_ANY_ID, iwl9560_trans_cfg)},
+	{IWL_PCI_DEVICE(0x271C, PCI_ANY_ID, iwl9560_trans_cfg)},
+	{IWL_PCI_DEVICE(0x30DC, PCI_ANY_ID, iwl9560_trans_cfg)},
+	{IWL_PCI_DEVICE(0x31DC, PCI_ANY_ID, iwl9560_shared_clk_trans_cfg)},
+	{IWL_PCI_DEVICE(0x9DF0, PCI_ANY_ID, iwl9560_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA370, PCI_ANY_ID, iwl9560_trans_cfg)},
+
+/* Qu devices */
+	{IWL_PCI_DEVICE(0x02F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
+	{IWL_PCI_DEVICE(0x06F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
+	{IWL_PCI_DEVICE(0x34F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3DF0, PCI_ANY_ID, iwl_qu_trans_cfg)},
+	{IWL_PCI_DEVICE(0x43F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA0F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
 
 	{IWL_PCI_DEVICE(0x2720, 0x0030, iwl9560_2ac_cfg_qnj_jf_b0)},
 
 /* 22000 Series */
 	{IWL_PCI_DEVICE(0x2723, PCI_ANY_ID, iwl_ax200_trans_cfg)},
 
-	{IWL_PCI_DEVICE(0x02F0, 0x0070, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0074, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0078, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x007C, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0244, iwl_ax101_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0310, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1651, iwl_ax1650s_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1652, iwl_ax1650i_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x2074, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4070, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4244, iwl_ax101_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0070, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0074, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0078, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x007C, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0244, iwl_ax101_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0310, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x1651, iwl_ax1650s_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x1652, iwl_ax1650i_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x2074, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x4070, iwl_ax201_cfg_quz_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x4244, iwl_ax101_cfg_quz_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0000, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0040, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0044, iwl_ax101_cfg_qu_hr)},
@@ -750,41 +576,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x2074, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x4070, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x4244, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0044, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0070, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0078, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x007C, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0244, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0310, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x2074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x4070, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x4244, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0044, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0070, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0078, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x007C, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0244, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0x43F0, 0x2074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x4070, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x4244, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0044, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0070, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0078, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x007C, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0244, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0A10, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x2074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x4070, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x4244, iwl_ax101_cfg_qu_hr)},
 
 	{IWL_PCI_DEVICE(0x2725, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0)},
@@ -832,6 +623,83 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 
+/* AX200 */
+	IWL_DEV_INFO(0x2723, 0x1653, iwl_ax200_cfg_cc, iwl_ax200_killer_1650w_name),
+	IWL_DEV_INFO(0x2723, 0x1654, iwl_ax200_cfg_cc, iwl_ax200_killer_1650x_name),
+	IWL_DEV_INFO(0x2723, IWL_CFG_ANY, iwl_ax200_cfg_cc, iwl_ax200_name),
+
+/* Qu with Hr */
+	IWL_DEV_INFO(0x43F0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x0244, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0x43F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0x43F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x0244, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x0A10, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x0070, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x0074, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x0078, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x007C, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x0244, iwl_ax101_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x0310, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x1651, iwl_ax1650s_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x1652, iwl_ax1650i_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x2074, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x4070, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x02F0, 0x4244, iwl_ax101_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x0070, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x0074, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x0078, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x007C, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x0244, iwl_ax101_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x0310, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x1651, iwl_ax1650s_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x1652, iwl_ax1650i_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x2074, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x4070, iwl_ax201_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x06F0, 0x4244, iwl_ax101_cfg_quz_hr, NULL),
+	IWL_DEV_INFO(0x34F0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x34F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x34F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x34F0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x34F0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x34F0, 0x0244, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x34F0, 0x0310, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x34F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0x34F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0x34F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x34F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x34F0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
+
+	IWL_DEV_INFO(0x3DF0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x0244, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x0310, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x3DF0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
+
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
@@ -929,11 +797,138 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
 		      iwl9260_2ac_cfg, iwl9260_name),
 
-/* AX200 */
-	IWL_DEV_INFO(0x2723, 0x1653, iwl_ax200_cfg_cc, iwl_ax200_killer_1650w_name),
-	IWL_DEV_INFO(0x2723, 0x1654, iwl_ax200_cfg_cc, iwl_ax200_killer_1650x_name),
-	IWL_DEV_INFO(0x2723, IWL_CFG_ANY, iwl_ax200_cfg_cc, iwl_ax200_name),
+	/* Qu with Jf */
+	/* Qu B step */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_b0_jf_b0_cfg, iwl9461_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_b0_jf_b0_cfg, iwl9461_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_b0_jf_b0_cfg, iwl9462_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_b0_jf_b0_cfg, iwl9462_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550s_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
+	/* Qu C step */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_c0_jf_b0_cfg, iwl9461_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_c0_jf_b0_cfg, iwl9461_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_c0_jf_b0_cfg, iwl9462_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_c0_jf_b0_cfg, iwl9462_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550s_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550i_name),
+
+	/* QuZ */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_quz_a0_jf_b0_cfg, iwl9461_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_quz_a0_jf_b0_cfg, iwl9461_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_quz_a0_jf_b0_cfg, iwl9462_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_quz_a0_jf_b0_cfg, iwl9462_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
+		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550s_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
+		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550i_name),
 #endif /* CONFIG_IWLMVM */
 };
 
@@ -997,7 +992,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		     IWL_SUBDEVICE_CORES(pdev->subsystem_device))) {
 			iwl_trans->cfg = dev_info->cfg;
 			iwl_trans->name = dev_info->name;
-			goto found;
 		}
 	}
 
@@ -1079,38 +1073,38 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * thing to do to support Qu C-step.
 	 */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QU_C0) {
-		if (cfg == &iwl_ax101_cfg_qu_hr)
+		if (iwl_trans->cfg == &iwl_ax101_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax101_cfg_qu_c0_hr_b0;
-		else if (cfg == &iwl_ax201_cfg_qu_hr)
+		else if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax201_cfg_qu_c0_hr_b0;
-		else if (cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
+		else if (iwl_trans->cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
 			iwl_trans->cfg = &iwl9461_2ac_cfg_qu_c0_jf_b0;
-		else if (cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
+		else if (iwl_trans->cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
 			iwl_trans->cfg = &iwl9462_2ac_cfg_qu_c0_jf_b0;
-		else if (cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
+		else if (iwl_trans->cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
 			iwl_trans->cfg = &iwl9560_2ac_cfg_qu_c0_jf_b0;
-		else if (cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
+		else if (iwl_trans->cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
 			iwl_trans->cfg = &iwl9560_2ac_160_cfg_qu_c0_jf_b0;
-		else if (cfg == &killer1650s_2ax_cfg_qu_b0_hr_b0)
+		else if (iwl_trans->cfg == &killer1650s_2ax_cfg_qu_b0_hr_b0)
 			iwl_trans->cfg = &killer1650s_2ax_cfg_qu_c0_hr_b0;
-		else if (cfg == &killer1650i_2ax_cfg_qu_b0_hr_b0)
+		else if (iwl_trans->cfg == &killer1650i_2ax_cfg_qu_b0_hr_b0)
 			iwl_trans->cfg = &killer1650i_2ax_cfg_qu_c0_hr_b0;
 	}
 
 	/* same thing for QuZ... */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QUZ) {
-		if (cfg == &iwl_ax101_cfg_qu_hr)
-			cfg = &iwl_ax101_cfg_quz_hr;
-		else if (cfg == &iwl_ax201_cfg_qu_hr)
-			cfg = &iwl_ax201_cfg_quz_hr;
-		else if (cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
-			cfg = &iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
-			cfg = &iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
-			cfg = &iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
-			cfg = &iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
+		if (iwl_trans->cfg == &iwl_ax101_cfg_qu_hr)
+			iwl_trans->cfg = &iwl_ax101_cfg_quz_hr;
+		else if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
+			iwl_trans->cfg = &iwl_ax201_cfg_quz_hr;
+		else if (iwl_trans->cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg = &iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
+		else if (iwl_trans->cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg = &iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
+		else if (iwl_trans->cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg = &iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
+		else if (iwl_trans->cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg = &iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
 	}
 
 #endif
@@ -1121,7 +1115,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!iwl_trans->cfg)
 		iwl_trans->cfg = cfg;
 
-found:
 	/* if we don't have a name yet, copy name from the old cfg */
 	if (!iwl_trans->name)
 		iwl_trans->name = iwl_trans->cfg->name;
-- 
2.25.1

