Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6D2193F4E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgCZMzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:55:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44204 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728065AbgCZMzX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:55:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHS2a-00040Z-N2; Thu, 26 Mar 2020 14:55:21 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:55:01 +0200
Message-Id: <iwlwifi.20200326145047.abe5b5ef260a.I8a14c6af45ea14d8e7f1ef38a589158f38d0c0ea@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326125510.621842-1-luca@coelho.fi>
References: <20200326125510.621842-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/12] iwlwifi: add trans_cfg for devices with long latency
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

A couple of SoCs, which can be recognized by PCI device IDs 0xA0F0 and
0x43F0, need a longer wait for the xtal to stabilize.  To handle this,
add a new trans_cfg structure for Qu devices with a larger
xtal_latency value and apply them to the devices recognized by these
IDs.  Also add a flag that allows us to inform the FW that the low
latency xtal should be used.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 12 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |  5 +++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 66f5df74a321..7b67c1ebbedf 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -246,6 +246,18 @@ const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
 	.xtal_latency = 5000,
 };
 
+const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
+	.mq_rx_supported = true,
+	.use_tfh = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_22000,
+	.base_params = &iwl_22000_base_params,
+	.integrated = true,
+	.xtal_latency = 12000,
+	.low_latency_xtal = true,
+};
+
 const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
 	.mq_rx_supported = true,
 	.use_tfh = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 3069a322ca75..ec715ee17156 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -507,6 +507,7 @@ extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qnj_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
 extern const char iwl9162_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index ba4773e07bf2..d6735453849d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -526,8 +526,9 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x06F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
 	{IWL_PCI_DEVICE(0x34F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
 	{IWL_PCI_DEVICE(0x3DF0, PCI_ANY_ID, iwl_qu_trans_cfg)},
-	{IWL_PCI_DEVICE(0x43F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA0F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
+
+	{IWL_PCI_DEVICE(0x43F0, PCI_ANY_ID, iwl_qu_long_latency_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA0F0, PCI_ANY_ID, iwl_qu_long_latency_trans_cfg)},
 
 	{IWL_PCI_DEVICE(0x2720, PCI_ANY_ID, iwl_qnj_trans_cfg)},
 
-- 
2.25.1

