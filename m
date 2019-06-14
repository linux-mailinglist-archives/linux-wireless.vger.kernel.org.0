Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9DB457D6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfFNItD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 04:49:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54494 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbfFNItC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 04:49:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hbhtL-00081c-Do; Fri, 14 Jun 2019 11:48:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Ihab Zhaika <ihab.zhaika@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 3/3] iwlwifi: change 0x02F0 fw from qu to quz
Date:   Fri, 14 Jun 2019 11:48:51 +0300
Message-Id: <20190614084852.386-4-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614084852.386-1-luca@coelho.fi>
References: <20190614084852.386-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ihab Zhaika <ihab.zhaika@intel.com>

change the fw of 0x02F0 platform from qu to quz

Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  88 +++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   6 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 100 +++++++++---------
 3 files changed, 144 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index e40fa12212b7..93526dfaf791 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -82,6 +82,7 @@
 #define IWL_22000_HR_A0_FW_PRE		"iwlwifi-QuQnj-a0-hr-a0-"
 #define IWL_QU_B_JF_B_FW_PRE		"iwlwifi-Qu-b0-jf-b0-"
 #define IWL_QUZ_A_HR_B_FW_PRE		"iwlwifi-QuZ-a0-hr-b0-"
+#define IWL_QUZ_A_JF_B_FW_PRE		"iwlwifi-QuZ-a0-jf-b0-"
 #define IWL_QNJ_B_JF_B_FW_PRE		"iwlwifi-QuQnj-b0-jf-b0-"
 #define IWL_CC_A_FW_PRE			"iwlwifi-cc-a0-"
 #define IWL_22000_SO_A_JF_B_FW_PRE	"iwlwifi-so-a0-jf-b0-"
@@ -106,6 +107,8 @@
 	IWL_22000_HR_A0_FW_PRE __stringify(api) ".ucode"
 #define IWL_QUZ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QUZ_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_QUZ_A_JF_B_MODULE_FIRMWARE(api) \
+	IWL_QUZ_A_JF_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_QU_B_JF_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_JF_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_QNJ_B_JF_B_MODULE_FIRMWARE(api)		\
@@ -381,6 +384,90 @@ const struct iwl_cfg iwl9560_2ac_cfg_qnj_jf_b0 = {
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 };
 
+const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc = {
+	.name = "Intel(R) Wireless-AC 9560 160MHz",
+	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.integrated = true,
+	.soc_latency = 5000,
+};
+
+const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc = {
+	.name = "Intel(R) Wireless-AC 9560 160MHz",
+	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.integrated = true,
+	.soc_latency = 5000,
+};
+
+const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc = {
+	.name = "Intel(R) Dual Band Wireless AC 9461",
+	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.integrated = true,
+	.soc_latency = 5000,
+};
+
+const struct iwl_cfg iwl9462_2ac_cfg_quz_a0_jf_b0_soc = {
+	.name = "Intel(R) Dual Band Wireless AC 9462",
+	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.integrated = true,
+	.soc_latency = 5000,
+};
+
+const struct iwl_cfg iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc = {
+	.name = "Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)",
+	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.integrated = true,
+	.soc_latency = 5000,
+};
+
+const struct iwl_cfg iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc = {
+	.name = "Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)",
+	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.integrated = true,
+	.soc_latency = 5000,
+};
+
 const struct iwl_cfg killer1550i_2ac_cfg_qu_b0_jf_b0 = {
 	.name = "Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)",
 	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
@@ -505,6 +592,7 @@ MODULE_FIRMWARE(IWL_22000_HR_B_QNJ_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_22000_HR_A0_QNJ_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_22000_SO_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index dbe6437249f0..bc267bd2c3b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -540,14 +540,20 @@ extern const struct iwl_cfg iwl9260_killer_2ac_cfg;
 extern const struct iwl_cfg iwl9270_2ac_cfg;
 extern const struct iwl_cfg iwl9460_2ac_cfg;
 extern const struct iwl_cfg iwl9560_2ac_cfg;
+extern const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_2ac_160_cfg;
+extern const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9460_2ac_cfg_soc;
 extern const struct iwl_cfg iwl9461_2ac_cfg_soc;
+extern const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9462_2ac_cfg_soc;
+extern const struct iwl_cfg iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
 extern const struct iwl_cfg iwl9560_2ac_160_cfg_soc;
 extern const struct iwl_cfg iwl9560_killer_2ac_cfg_soc;
 extern const struct iwl_cfg iwl9560_killer_s_2ac_cfg_soc;
+extern const struct iwl_cfg iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc;
+extern const struct iwl_cfg iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9460_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl9461_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl9462_2ac_cfg_shared_clk;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 02af9073793a..ccc83fd74649 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -513,56 +513,56 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8265_2ac_cfg)},
 
 /* 9000 Series */
-	{IWL_PCI_DEVICE(0x02F0, 0x0030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0034, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0038, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0060, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0064, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x00A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x00A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0230, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0238, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0260, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0264, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x02A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x2030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x2034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x40A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x42A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0034, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0038, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0060, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0064, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x00A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x00A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0230, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0238, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0260, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0264, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x02A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x2030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x2034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x4030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x4034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x40A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x4234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x42A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0034, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0038, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x003C, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0060, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0064, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x00A0, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x00A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0230, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0234, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0238, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x023C, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0260, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0264, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x02A0, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x02A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x1551, iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x1552, iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x2030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x2034, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4034, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x40A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4234, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x42A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0034, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0038, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x003C, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0060, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0064, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x00A0, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x00A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0230, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0234, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0238, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x023C, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0260, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0264, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x02A0, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x02A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x1551, iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x1552, iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x2030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x2034, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x4030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x4034, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x40A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x4234, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x42A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x0010, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0014, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0018, iwl9260_2ac_160_cfg)},
-- 
2.20.1

