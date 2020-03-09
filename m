Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4831E17D9A4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCIHQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33028 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgCIHQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:33 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeM-0007CP-MM; Mon, 09 Mar 2020 09:16:31 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:07 +0200
Message-Id: <iwlwifi.20200309091348.a7998f8d7507.I4be8776edb8c30416efc184c66f11add5eed06de@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309071619.670108-1-luca@coelho.fi>
References: <20200309071619.670108-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 01/13] iwlwifi: move the remaining 0x2526 configs to the new table
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Now that we have the strings separate from the rest, we can move the
remaining 0x2526 devices to the new table in preparation to reuse the
configs.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 15 +++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  8 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 71 ++++++++++---------
 3 files changed, 58 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 379ea788e424..478c432ae273 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -190,22 +190,32 @@ const struct iwl_cfg iwl9260_2ac_cfg = {
 	IWL_DEVICE_9000,
 };
 
+const char iwl9260_name[] = "Intel(R) Wireless-AC 9260";
+const char iwl9270_name[] = "Intel(R) Wireless-AC 9270";
+const char iwl9461_name[] = "Intel(R) Wireless-AC 9461";
+const char iwl9462_name[] = "Intel(R) Wireless-AC 9462";
+const char iwl9560_name[] = "Intel(R) Wireless-AC 9560";
 const char iwl9260_160_name[] = "Intel(R) Wireless-AC 9260 160MHz";
 const char iwl9560_160_name[] = "Intel(R) Wireless-AC 9560 160MHz";
 
+const char iwl9260_killer_1550_name[] =
+	"Killer (R) Wireless-AC 1550 Wireless Network Adapter (9260NGW)";
+const char iwl9560_killer_1550i_name[] =
+	"Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)";
+const char iwl9560_killer_1550s_name[] =
+	"Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)";
+
 const struct iwl_cfg iwl9260_2ac_160_cfg = {
 	.fw_name_pre = IWL9260_FW_PRE,
 	IWL_DEVICE_9000,
 };
 
 const struct iwl_cfg iwl9260_killer_2ac_cfg = {
-	.name = "Killer (R) Wireless-AC 1550 Wireless Network Adapter (9260NGW)",
 	.fw_name_pre = IWL9260_FW_PRE,
 	IWL_DEVICE_9000,
 };
 
 const struct iwl_cfg iwl9270_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 9270",
 	.fw_name_pre = IWL9260_FW_PRE,
 	IWL_DEVICE_9000,
 };
@@ -247,7 +257,6 @@ const struct iwl_cfg iwl9560_2ac_cfg = {
 };
 
 const struct iwl_cfg iwl9560_2ac_160_cfg = {
-	.name = "Intel(R) Wireless-AC 9560 160MHz",
 	.fw_name_pre = IWL9260_FW_PRE,
 	IWL_DEVICE_9000,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index be6a2bf9ce74..d95b1b513768 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -465,8 +465,16 @@ struct iwl_dev_info {
  * This list declares the config structures for all devices.
  */
 extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
+extern const char iwl9260_name[];
+extern const char iwl9270_name[];
+extern const char iwl9461_name[];
+extern const char iwl9462_name[];
+extern const char iwl9560_name[];
 extern const char iwl9260_160_name[];
 extern const char iwl9560_160_name[];
+extern const char iwl9260_killer_1550_name[];
+extern const char iwl9560_killer_1550i_name[];
+extern const char iwl9560_killer_1550s_name[];
 
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 97f227f3cbc3..d7db2c434517 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -566,36 +566,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x06F0, 0x4234, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x42A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
 
-	{IWL_PCI_DEVICE(0x2526, 0x0034, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0060, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x0064, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x00A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x00A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x0210, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0214, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0230, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0234, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0238, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x023C, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0260, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x0264, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x02A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x1010, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x1030, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x1210, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x1410, iwl9270_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x1420, iwl9460_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x1550, iwl9260_killer_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x1552, iwl9560_killer_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x1610, iwl9270_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x2030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x2034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x4034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x40A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x4234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x42A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
 
 	{IWL_PCI_DEVICE(0x271B, 0x0010, iwl9160_2ac_cfg)},
@@ -663,7 +633,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x31DC, 0x0034, iwl9560_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x0038, iwl9560_2ac_160_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x003C, iwl9560_2ac_160_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0060, iwl9460_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0060, iwl9461_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x0064, iwl9461_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x00A0, iwl9462_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x00A4, iwl9462_2ac_cfg_shared_clk)},
@@ -774,7 +744,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x9DF0, 0x0034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0038, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x9DF0, 0x0060, iwl9460_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x9DF0, 0x0060, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0064, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x00A0, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x00A4, iwl9462_2ac_cfg_soc)},
@@ -839,7 +809,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xA370, 0x0034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x0038, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA370, 0x0060, iwl9460_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA370, 0x0060, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x0064, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x00A0, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x00A4, iwl9462_2ac_cfg_soc)},
@@ -989,10 +959,45 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2526, 0xE010, iwl9260_2ac_160_cfg, iwl9260_160_name),
 	IWL_DEV_INFO(0x2526, 0xE014, iwl9260_2ac_160_cfg, iwl9260_160_name),
 
+	IWL_DEV_INFO(0x2526, 0x0210, iwl9260_2ac_cfg, iwl9260_name),
+	IWL_DEV_INFO(0x2526, 0x0214, iwl9260_2ac_cfg, iwl9260_name),
+	IWL_DEV_INFO(0x2526, 0x1010, iwl9260_2ac_cfg, iwl9260_name),
+	IWL_DEV_INFO(0x2526, 0x1210, iwl9260_2ac_cfg, iwl9260_name),
+
 	IWL_DEV_INFO(0x2526, 0x0030, iwl9560_2ac_160_cfg, iwl9560_160_name),
 	IWL_DEV_INFO(0x2526, 0x0038, iwl9560_2ac_160_cfg, iwl9560_160_name),
 	IWL_DEV_INFO(0x2526, 0x003C, iwl9560_2ac_160_cfg, iwl9560_160_name),
 	IWL_DEV_INFO(0x2526, 0x4030, iwl9560_2ac_160_cfg, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x2030, iwl9560_2ac_160_cfg_soc, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x2034, iwl9560_2ac_160_cfg_soc, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x4034, iwl9560_2ac_160_cfg_soc, iwl9560_160_name),
+
+	IWL_DEV_INFO(0x2526, 0x0034, iwl9560_2ac_cfg, iwl9560_name),
+	IWL_DEV_INFO(0x2526, 0x0230, iwl9560_2ac_cfg, iwl9560_name),
+	IWL_DEV_INFO(0x2526, 0x0234, iwl9560_2ac_cfg, iwl9560_name),
+	IWL_DEV_INFO(0x2526, 0x0238, iwl9560_2ac_cfg, iwl9560_name),
+	IWL_DEV_INFO(0x2526, 0x023C, iwl9560_2ac_cfg, iwl9560_name),
+	IWL_DEV_INFO(0x2526, 0x1030, iwl9560_2ac_cfg, iwl9560_name),
+	IWL_DEV_INFO(0x2526, 0x4234, iwl9560_2ac_cfg_soc, iwl9560_name),
+
+	IWL_DEV_INFO(0x2526, 0x0060, iwl9461_2ac_cfg_soc, iwl9461_name),
+	IWL_DEV_INFO(0x2526, 0x0064, iwl9461_2ac_cfg_soc, iwl9461_name),
+	IWL_DEV_INFO(0x2526, 0x0260, iwl9461_2ac_cfg_soc, iwl9461_name),
+	IWL_DEV_INFO(0x2526, 0x0264, iwl9461_2ac_cfg_soc, iwl9461_name),
+
+	IWL_DEV_INFO(0x2526, 0x00A0, iwl9462_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x00A4, iwl9462_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x02A0, iwl9462_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x02A4, iwl9462_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x40A4, iwl9462_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x42A4, iwl9462_2ac_cfg_soc, iwl9462_name),
+
+	IWL_DEV_INFO(0x2526, 0x1550, iwl9260_killer_2ac_cfg, iwl9260_killer_1550_name),
+	IWL_DEV_INFO(0x2526, 0x1551, iwl9560_killer_s_2ac_cfg_soc, iwl9560_killer_1550s_name),
+	IWL_DEV_INFO(0x2526, 0x1552, iwl9560_killer_2ac_cfg_soc, iwl9560_killer_1550i_name),
+
+	IWL_DEV_INFO(0x2526, 0x1410, iwl9270_2ac_cfg, iwl9270_name),
+	IWL_DEV_INFO(0x2526, 0x1610, iwl9270_2ac_cfg, iwl9270_name),
 #endif /* CONFIG_IWLMVM */
 };
 
-- 
2.25.1

