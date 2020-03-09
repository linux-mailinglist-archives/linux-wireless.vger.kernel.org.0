Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554C317D9A8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCIHQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:37 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33062 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgCIHQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeQ-0007CP-U3; Mon, 09 Mar 2020 09:16:35 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:12 +0200
Message-Id: <iwlwifi.20200309091348.345de1efb3ec.Ib9221027a955188ea7c1ffca8a45bccd6c1e6a13@changeid>
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
Subject: [PATCH 06/13] iwlwifi: map 9461 and 9462 using RF type and RF ID
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

These devices can be differentiated depending on the RF type and RF
ID.  Change them to use these instead of relying on the subsystem
device IDs.

This also fixes some names that were not including 160MHz (as they
should).

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  2 ++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 30 +++++++++++--------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index af4911876a40..97644a5be253 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -197,6 +197,8 @@ const char iwl9462_name[] = "Intel(R) Wireless-AC 9462";
 const char iwl9560_name[] = "Intel(R) Wireless-AC 9560";
 const char iwl9260_160_name[] = "Intel(R) Wireless-AC 9260 160MHz";
 const char iwl9270_160_name[] = "Intel(R) Wireless-AC 9270 160MHz";
+const char iwl9461_160_name[] = "Intel(R) Wireless-AC 9461 160MHz";
+const char iwl9462_160_name[] = "Intel(R) Wireless-AC 9462 160MHz";
 const char iwl9560_160_name[] = "Intel(R) Wireless-AC 9560 160MHz";
 
 const char iwl9260_killer_1550_name[] =
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 7a985b317807..72b84f0e72c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -467,6 +467,7 @@ struct iwl_cfg {
 #define IWL_CFG_RF_ID_TH1		0x1
 #define IWL_CFG_RF_ID_JF		0x3
 #define IWL_CFG_RF_ID_JF1		0x6
+#define IWL_CFG_RF_ID_JF1_DIV		0xA
 
 #define IWL_CFG_NO_160			0x0
 #define IWL_CFG_160			0x1
@@ -501,6 +502,8 @@ extern const char iwl9462_name[];
 extern const char iwl9560_name[];
 extern const char iwl9260_160_name[];
 extern const char iwl9270_160_name[];
+extern const char iwl9461_160_name[];
+extern const char iwl9462_160_name[];
 extern const char iwl9560_160_name[];
 extern const char iwl9260_killer_1550_name[];
 extern const char iwl9560_killer_1550i_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 492aa4469608..b56b1c31c2f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -954,22 +954,26 @@ MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 static const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
 	IWL_DEV_INFO(0x2526, 0x1550, iwl9260_2ac_cfg, iwl9260_killer_1550_name),
-
-	IWL_DEV_INFO(0x2526, 0x0060, iwl9560_2ac_cfg_soc, iwl9461_name),
-	IWL_DEV_INFO(0x2526, 0x0064, iwl9560_2ac_cfg_soc, iwl9461_name),
-	IWL_DEV_INFO(0x2526, 0x0260, iwl9560_2ac_cfg_soc, iwl9461_name),
-	IWL_DEV_INFO(0x2526, 0x0264, iwl9560_2ac_cfg_soc, iwl9461_name),
-
-	IWL_DEV_INFO(0x2526, 0x00A0, iwl9560_2ac_cfg_soc, iwl9462_name),
-	IWL_DEV_INFO(0x2526, 0x00A4, iwl9560_2ac_cfg_soc, iwl9462_name),
-	IWL_DEV_INFO(0x2526, 0x02A0, iwl9560_2ac_cfg_soc, iwl9462_name),
-	IWL_DEV_INFO(0x2526, 0x02A4, iwl9560_2ac_cfg_soc, iwl9462_name),
-	IWL_DEV_INFO(0x2526, 0x40A4, iwl9560_2ac_cfg_soc, iwl9462_name),
-	IWL_DEV_INFO(0x2526, 0x42A4, iwl9560_2ac_cfg_soc, iwl9462_name),
-
 	IWL_DEV_INFO(0x2526, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
 	IWL_DEV_INFO(0x2526, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 
+	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg, iwl9461_160_name),
+	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg, iwl9461_name),
+	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg, iwl9462_160_name),
+	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg, iwl9462_name),
+
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
 		      IWL_CFG_160, IWL_CFG_CORES_BT,
-- 
2.25.1

