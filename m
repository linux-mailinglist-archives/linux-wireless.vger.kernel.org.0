Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522582876DA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgJHPM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:12:56 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54560 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730874AbgJHPM4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:12:56 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbB-002QxQ-Jm; Thu, 08 Oct 2020 18:12:54 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:38 +0300
Message-Id: <iwlwifi.20201008181047.34392f98fdb1.I3d3db14f6d1a8ecc547ca6afce8488816bd26081@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/13] iwlwifi: pcie: fix xtal latency for 9560 devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We were using a very high latency for all 9560 devices so they all
would have time to stabilize.  But this causes the system to be
slighly slower, so we can use the best values for each device.

This requires a new trans cfg struct for devices with longer latency
and some adjustments to the other structs.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c   | 17 +++++++++++++----
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index f84b8e5d3f0b..be4acf4a0e32 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -20,7 +20,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -180,7 +180,16 @@ const struct iwl_cfg_trans_params iwl9560_trans_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
 	.integrated = true,
-	.xtal_latency = 5000,
+	.xtal_latency = 650,
+};
+
+const struct iwl_cfg_trans_params iwl9560_long_latency_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_9000,
+	.base_params = &iwl9000_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.integrated = true,
+	.xtal_latency = 2820,
 };
 
 const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg = {
@@ -189,7 +198,7 @@ const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
 	.integrated = true,
-	.xtal_latency = 5000,
+	.xtal_latency = 670,
 	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index d03f51bf7dfd..ca4967b81d01 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -519,6 +519,7 @@ struct iwl_dev_info {
  */
 extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl9560_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qnj_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_trans_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 83811fad8431..129021f26791 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -514,7 +514,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
 	{IWL_PCI_DEVICE(0x271B, PCI_ANY_ID, iwl9000_trans_cfg)},
 	{IWL_PCI_DEVICE(0x271C, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x30DC, PCI_ANY_ID, iwl9560_trans_cfg)},
+	{IWL_PCI_DEVICE(0x30DC, PCI_ANY_ID, iwl9560_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0x31DC, PCI_ANY_ID, iwl9560_shared_clk_trans_cfg)},
 	{IWL_PCI_DEVICE(0x9DF0, PCI_ANY_ID, iwl9560_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA370, PCI_ANY_ID, iwl9560_trans_cfg)},
-- 
2.28.0

