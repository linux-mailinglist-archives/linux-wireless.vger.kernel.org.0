Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF121457D5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfFNItC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 04:49:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54480 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726552AbfFNItB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 04:49:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hbhtK-00081c-TZ; Fri, 14 Jun 2019 11:48:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Ihab Zhaika <ihab.zhaika@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 2/3] iwlwifi: add new cards for 22000 and change wrong structs
Date:   Fri, 14 Jun 2019 11:48:50 +0300
Message-Id: <20190614084852.386-3-luca@coelho.fi>
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

add few PCI ID'S for 22000 and chainge few cards structs names

Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  36 ++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   3 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 122 +++++++++---------
 3 files changed, 100 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 650ca46efc48..e40fa12212b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -265,6 +265,42 @@ const struct iwl_cfg iwl_ax101_cfg_quz_hr = {
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 };
 
+const struct iwl_cfg iwl_ax201_cfg_quz_hr = {
+		.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
+		.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+		IWL_DEVICE_22500,
+		/*
+         * This device doesn't support receiving BlockAck with a large bitmap
+         * so we need to restrict the size of transmitted aggregation to the
+         * HT size; mac80211 would otherwise pick the HE max (256) by default.
+         */
+		.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+};
+
+const struct iwl_cfg iwl_ax1650s_cfg_quz_hr = {
+		.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)",
+		.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+		IWL_DEVICE_22500,
+		/*
+         * This device doesn't support receiving BlockAck with a large bitmap
+         * so we need to restrict the size of transmitted aggregation to the
+         * HT size; mac80211 would otherwise pick the HE max (256) by default.
+         */
+		.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+};
+
+const struct iwl_cfg iwl_ax1650i_cfg_quz_hr = {
+		.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
+		.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+		IWL_DEVICE_22500,
+		/*
+         * This device doesn't support receiving BlockAck with a large bitmap
+         * so we need to restrict the size of transmitted aggregation to the
+         * HT size; mac80211 would otherwise pick the HE max (256) by default.
+         */
+		.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+};
+
 const struct iwl_cfg iwl_ax200_cfg_cc = {
 	.name = "Intel(R) Wi-Fi 6 AX200 160MHz",
 	.fw_name_pre = IWL_CC_A_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 29aaf649c13c..dbe6437249f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -563,6 +563,9 @@ extern const struct iwl_cfg iwl_ax101_cfg_quz_hr;
 extern const struct iwl_cfg iwl22000_2ax_cfg_hr;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
+extern const struct iwl_cfg iwl_ax201_cfg_quz_hr;
+extern const struct iwl_cfg iwl_ax1650i_cfg_quz_hr;
+extern const struct iwl_cfg iwl_ax1650s_cfg_quz_hr;
 extern const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0;
 extern const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0;
 extern const struct iwl_cfg killer1650x_2ax_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 2f3ee5769fdd..02af9073793a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -517,8 +517,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x02F0, 0x0034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x02F0, 0x0038, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x02F0, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0040, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0044, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x02F0, 0x0060, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x02F0, 0x0064, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x02F0, 0x00A0, iwl9462_2ac_cfg_soc)},
@@ -527,7 +525,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x02F0, 0x0234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x02F0, 0x0238, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x02F0, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0244, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x02F0, 0x0260, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x02F0, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x02F0, 0x02A0, iwl9462_2ac_cfg_soc)},
@@ -545,8 +542,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x06F0, 0x0034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x0038, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0040, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0044, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x06F0, 0x0060, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x0064, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x00A0, iwl9462_2ac_cfg_soc)},
@@ -555,7 +550,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x06F0, 0x0234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x0238, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0244, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x06F0, 0x0260, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x02A0, iwl9462_2ac_cfg_soc)},
@@ -621,7 +615,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x0034, iwl9560_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2720, 0x0038, iwl9560_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2720, 0x003C, iwl9560_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x0044, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0060, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x0064, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x00A0, iwl9462_2ac_cfg_soc)},
@@ -630,7 +623,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x0234, iwl9560_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2720, 0x0238, iwl9560_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2720, 0x023C, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x0244, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0260, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x02A0, iwl9462_2ac_cfg_soc)},
@@ -708,7 +700,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x34F0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0044, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
@@ -717,7 +708,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x34F0, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0244, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
@@ -764,7 +754,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x43F0, 0x0034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x0038, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0044, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x43F0, 0x0060, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x0064, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x00A0, iwl9462_2ac_cfg_soc)},
@@ -773,7 +762,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x43F0, 0x0234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x0238, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0244, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x43F0, 0x0260, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x02A0, iwl9462_2ac_cfg_soc)},
@@ -833,7 +821,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xA0F0, 0x0034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x0038, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0044, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x0060, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x0064, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x00A0, iwl9462_2ac_cfg_soc)},
@@ -842,7 +829,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xA0F0, 0x0234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x0238, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0244, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x0260, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x02A0, iwl9462_2ac_cfg_soc)},
@@ -890,69 +876,80 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x0030, iwl9560_2ac_cfg_qnj_jf_b0)},
 
 /* 22000 Series */
-	{IWL_PCI_DEVICE(0x02F0, 0x0070, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0074, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0078, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x007C, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0310, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0x02F0, 0x2074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4070, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0070, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0074, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0078, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x007C, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x0310, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0x06F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0x06F0, 0x2074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x06F0, 0x4070, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0070, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0074, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0078, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x007C, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0244, iwl_ax101_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0310, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x1651, iwl_ax1650s_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x1652, iwl_ax1650i_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x2074, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4070, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4244, iwl_ax101_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0070, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0074, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0078, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x007C, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0244, iwl_ax101_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0310, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x1651, iwl_ax1650s_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x1652, iwl_ax1650i_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x2074, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x4070, iwl_ax201_cfg_quz_hr)},
+	{IWL_PCI_DEVICE(0x06F0, 0x4244, iwl_ax101_cfg_quz_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0000, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0040, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0070, iwl22000_2ac_cfg_hr_cdb)},
-	{IWL_PCI_DEVICE(0x2720, 0x0074, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0078, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x007C, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x2720, 0x0044, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x2720, 0x0070, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x2720, 0x0074, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x2720, 0x0078, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x2720, 0x007C, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0090, iwl22000_2ac_cfg_hr_cdb)},
-	{IWL_PCI_DEVICE(0x2720, 0x0310, iwl22000_2ac_cfg_hr_cdb)},
-	{IWL_PCI_DEVICE(0x2720, 0x0A10, iwl22000_2ac_cfg_hr_cdb)},
+	{IWL_PCI_DEVICE(0x2720, 0x0244, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x2720, 0x0310, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x2720, 0x0A10, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x1080, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x2720, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x2720, 0x2074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x4070, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0040, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0070, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0074, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0078, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x007C, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x0310, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x2720, 0x4070, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x2720, 0x4244, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0044, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0070, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0074, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0078, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x34F0, 0x007C, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0244, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x34F0, 0x0310, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x34F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x2074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x34F0, 0x4070, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0040, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0070, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0074, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0078, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x007C, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x34F0, 0x4070, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x34F0, 0x4244, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0044, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0070, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0074, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0078, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x43F0, 0x007C, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0244, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x43F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x43F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x43F0, 0x2074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x43F0, 0x4070, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0000, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0040, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0070, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0074, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0078, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x007C, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x00B0, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0A10, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x43F0, 0x4070, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0x43F0, 0x4244, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0044, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0070, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0074, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0078, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x007C, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0244, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0A10, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x2074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x4070, iwl_ax101_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x4070, iwl_ax201_cfg_qu_hr)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x4244, iwl_ax101_cfg_qu_hr)},
 
 	{IWL_PCI_DEVICE(0x2723, 0x0080, iwl_ax200_cfg_cc)},
 	{IWL_PCI_DEVICE(0x2723, 0x0084, iwl_ax200_cfg_cc)},
@@ -974,6 +971,9 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x7A70, 0x0310, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7A70, 0x0510, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7A70, 0x0A10, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x7AF0, 0x0310, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x7AF0, 0x0510, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x7AF0, 0x0A10, iwlax211_2ax_cfg_so_gf_a0)},
 
 #endif /* CONFIG_IWLMVM */
 
-- 
2.20.1

