Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47091AEABC
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgDRIJs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56822 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbgDRIJs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:48 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXR-000L3r-ML; Sat, 18 Apr 2020 11:09:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:56 +0300
Message-Id: <iwlwifi.20200418110539.daf515618f57.I80e60006b108e1586e3c56669635c670597fe08d@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/12] iwlwifi: pcie: add new structs for So devices with long latency
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Some So devices have a longer wake latency.  To support this properly,
add new cfg structs for them so the driver will inform the FW about
the need to use another xtal and use a higher wait value during state
transitions.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 20 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 10 +++++-----
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 7db4472a1ec5..2f741f5e3a7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -555,6 +555,16 @@ const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long = {
+	.name = "Intel(R) Wi-Fi 6 AX211 160MHz",
+	.fw_name_pre = IWL_22000_SO_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+	.trans.xtal_latency = 12000,
+	.trans.low_latency_xtal = true,
+};
+
 const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
 	.name = "Intel(R) Wi-Fi 6 AX210 160MHz",
 	.fw_name_pre = IWL_22000_TY_A_GF_A_FW_PRE,
@@ -571,6 +581,16 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
+	.name = "Intel(R) Wi-Fi 6 AX411 160MHz",
+	.fw_name_pre = IWL_22000_SO_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+	.trans.xtal_latency = 12000,
+	.trans.low_latency_xtal = true,
+};
+
 const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0 = {
 	.name = "Intel(R) Wi-Fi 6 AX411 160MHz",
 	.fw_name_pre = IWL_SNJ_A_GF4_A_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index efb10a7f4d4f..3a9a33851793 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -630,8 +630,10 @@ extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_a0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
+extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long;
 extern const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0;
+extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
 extern const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0;
 extern const struct iwl_cfg iwlax211_cfg_snj_gf_a0;
 #endif /* CPTCFG_IWLMVM || CPTCFG_IWLFMAC */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 2d78f8504bd5..2083eb4f2f15 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -545,11 +545,11 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2726, 0x0090, iwlax211_cfg_snj_gf_a0)},
 	{IWL_PCI_DEVICE(0x2726, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0)},
 	{IWL_PCI_DEVICE(0x2726, 0x0510, iwlax211_cfg_snj_gf_a0)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
-	{IWL_PCI_DEVICE(0x7A70, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0310, iwlax211_2ax_cfg_so_gf_a0)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0510, iwlax211_2ax_cfg_so_gf_a0)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0A10, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x7A70, 0x0090, iwlax211_2ax_cfg_so_gf_a0_long)},
+	{IWL_PCI_DEVICE(0x7A70, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0_long)},
+	{IWL_PCI_DEVICE(0x7A70, 0x0310, iwlax211_2ax_cfg_so_gf_a0_long)},
+	{IWL_PCI_DEVICE(0x7A70, 0x0510, iwlax211_2ax_cfg_so_gf_a0_long)},
+	{IWL_PCI_DEVICE(0x7A70, 0x0A10, iwlax211_2ax_cfg_so_gf_a0_long)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x0310, iwlax211_2ax_cfg_so_gf_a0)},
-- 
2.25.1

