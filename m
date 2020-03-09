Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9E17D9A5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCIHQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33034 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725796AbgCIHQe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeN-0007CP-Nz; Mon, 09 Mar 2020 09:16:32 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:08 +0200
Message-Id: <iwlwifi.20200309091348.88e3d47c42a8.I1bd37ae0d0f9f79732f03badf84d7d063993b73e@changeid>
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
Subject: [PATCH 02/13] iwlwifi: combine 9260 cfgs that only change names
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

All the 0x2526 devices are now in the new table, so we can start
reusing configurations and adding the strings independently to all of
them, reusing them when possible.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 10 ---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 69 ++++++++++---------
 2 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 478c432ae273..3693adf3d510 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -205,21 +205,11 @@ const char iwl9560_killer_1550i_name[] =
 const char iwl9560_killer_1550s_name[] =
 	"Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)";
 
-const struct iwl_cfg iwl9260_2ac_160_cfg = {
-	.fw_name_pre = IWL9260_FW_PRE,
-	IWL_DEVICE_9000,
-};
-
 const struct iwl_cfg iwl9260_killer_2ac_cfg = {
 	.fw_name_pre = IWL9260_FW_PRE,
 	IWL_DEVICE_9000,
 };
 
-const struct iwl_cfg iwl9270_2ac_cfg = {
-	.fw_name_pre = IWL9260_FW_PRE,
-	IWL_DEVICE_9000,
-};
-
 const struct iwl_cfg iwl9460_2ac_cfg = {
 	.name = "Intel(R) Dual Band Wireless AC 9460",
 	.fw_name_pre = IWL9260_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d7db2c434517..51f4f4e9aa30 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -947,30 +947,35 @@ MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 
 static const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
-	IWL_DEV_INFO(0x2526, 0x0010, iwl9260_2ac_160_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x0014, iwl9260_2ac_160_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x0018, iwl9260_2ac_160_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x001C, iwl9260_2ac_160_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x6010, iwl9260_2ac_160_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x6014, iwl9260_2ac_160_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x8014, iwl9260_2ac_160_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x8010, iwl9260_2ac_160_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0xA014, iwl9260_2ac_160_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0xE010, iwl9260_2ac_160_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0xE014, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x0010, iwl9260_2ac_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x0014, iwl9260_2ac_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x0018, iwl9260_2ac_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x001C, iwl9260_2ac_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x6010, iwl9260_2ac_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x6014, iwl9260_2ac_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x8014, iwl9260_2ac_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x8010, iwl9260_2ac_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0xA014, iwl9260_2ac_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0xE010, iwl9260_2ac_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0xE014, iwl9260_2ac_cfg, iwl9260_160_name),
 
 	IWL_DEV_INFO(0x2526, 0x0210, iwl9260_2ac_cfg, iwl9260_name),
 	IWL_DEV_INFO(0x2526, 0x0214, iwl9260_2ac_cfg, iwl9260_name),
 	IWL_DEV_INFO(0x2526, 0x1010, iwl9260_2ac_cfg, iwl9260_name),
 	IWL_DEV_INFO(0x2526, 0x1210, iwl9260_2ac_cfg, iwl9260_name),
 
-	IWL_DEV_INFO(0x2526, 0x0030, iwl9560_2ac_160_cfg, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x0038, iwl9560_2ac_160_cfg, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x003C, iwl9560_2ac_160_cfg, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x4030, iwl9560_2ac_160_cfg, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x2030, iwl9560_2ac_160_cfg_soc, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x2034, iwl9560_2ac_160_cfg_soc, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x4034, iwl9560_2ac_160_cfg_soc, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x1410, iwl9260_2ac_cfg, iwl9270_name),
+	IWL_DEV_INFO(0x2526, 0x1610, iwl9260_2ac_cfg, iwl9270_name),
+
+	IWL_DEV_INFO(0x2526, 0x1550, iwl9260_2ac_cfg, iwl9260_killer_1550_name),
+
+	IWL_DEV_INFO(0x2526, 0x0030, iwl9560_2ac_cfg, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x0038, iwl9560_2ac_cfg, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x003C, iwl9560_2ac_cfg, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x4030, iwl9560_2ac_cfg, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x2030, iwl9560_2ac_cfg_soc, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x2034, iwl9560_2ac_cfg_soc, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x4034, iwl9560_2ac_cfg_soc, iwl9560_160_name),
 
 	IWL_DEV_INFO(0x2526, 0x0034, iwl9560_2ac_cfg, iwl9560_name),
 	IWL_DEV_INFO(0x2526, 0x0230, iwl9560_2ac_cfg, iwl9560_name),
@@ -980,24 +985,20 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2526, 0x1030, iwl9560_2ac_cfg, iwl9560_name),
 	IWL_DEV_INFO(0x2526, 0x4234, iwl9560_2ac_cfg_soc, iwl9560_name),
 
-	IWL_DEV_INFO(0x2526, 0x0060, iwl9461_2ac_cfg_soc, iwl9461_name),
-	IWL_DEV_INFO(0x2526, 0x0064, iwl9461_2ac_cfg_soc, iwl9461_name),
-	IWL_DEV_INFO(0x2526, 0x0260, iwl9461_2ac_cfg_soc, iwl9461_name),
-	IWL_DEV_INFO(0x2526, 0x0264, iwl9461_2ac_cfg_soc, iwl9461_name),
-
-	IWL_DEV_INFO(0x2526, 0x00A0, iwl9462_2ac_cfg_soc, iwl9462_name),
-	IWL_DEV_INFO(0x2526, 0x00A4, iwl9462_2ac_cfg_soc, iwl9462_name),
-	IWL_DEV_INFO(0x2526, 0x02A0, iwl9462_2ac_cfg_soc, iwl9462_name),
-	IWL_DEV_INFO(0x2526, 0x02A4, iwl9462_2ac_cfg_soc, iwl9462_name),
-	IWL_DEV_INFO(0x2526, 0x40A4, iwl9462_2ac_cfg_soc, iwl9462_name),
-	IWL_DEV_INFO(0x2526, 0x42A4, iwl9462_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x0060, iwl9560_2ac_cfg_soc, iwl9461_name),
+	IWL_DEV_INFO(0x2526, 0x0064, iwl9560_2ac_cfg_soc, iwl9461_name),
+	IWL_DEV_INFO(0x2526, 0x0260, iwl9560_2ac_cfg_soc, iwl9461_name),
+	IWL_DEV_INFO(0x2526, 0x0264, iwl9560_2ac_cfg_soc, iwl9461_name),
 
-	IWL_DEV_INFO(0x2526, 0x1550, iwl9260_killer_2ac_cfg, iwl9260_killer_1550_name),
-	IWL_DEV_INFO(0x2526, 0x1551, iwl9560_killer_s_2ac_cfg_soc, iwl9560_killer_1550s_name),
-	IWL_DEV_INFO(0x2526, 0x1552, iwl9560_killer_2ac_cfg_soc, iwl9560_killer_1550i_name),
+	IWL_DEV_INFO(0x2526, 0x00A0, iwl9560_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x00A4, iwl9560_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x02A0, iwl9560_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x02A4, iwl9560_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x40A4, iwl9560_2ac_cfg_soc, iwl9462_name),
+	IWL_DEV_INFO(0x2526, 0x42A4, iwl9560_2ac_cfg_soc, iwl9462_name),
 
-	IWL_DEV_INFO(0x2526, 0x1410, iwl9270_2ac_cfg, iwl9270_name),
-	IWL_DEV_INFO(0x2526, 0x1610, iwl9270_2ac_cfg, iwl9270_name),
+	IWL_DEV_INFO(0x2526, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
+	IWL_DEV_INFO(0x2526, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 #endif /* CONFIG_IWLMVM */
 };
 
-- 
2.25.1

