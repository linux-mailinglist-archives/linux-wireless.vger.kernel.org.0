Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A551AEABB
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDRIJq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56818 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbgDRIJp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:45 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXQ-000L3r-TV; Sat, 18 Apr 2020 11:09:21 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:55 +0300
Message-Id: <iwlwifi.20200418110539.d6df2bcee78f.Ie008b0c8f03340a466c1ef981bfd25359c9de90d@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/12] iwlwifi: pcie: add new structure for Qu devices with medium latency
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Some Qu devices require an intermediate amount of time to wake up and
for LTR notifications, so add a new structure with the correct values
for them and change the corresponding devices to use it.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 22 ++++++++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  7 +++---
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 1f30d8fdf35d..7db4472a1ec5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -234,6 +234,15 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 		},							\
 	}
 
+const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
+	.mq_rx_supported = true,
+	.use_tfh = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_22000,
+	.base_params = &iwl_22000_base_params,
+};
+
 const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
 	.mq_rx_supported = true,
 	.use_tfh = true,
@@ -246,7 +255,7 @@ const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_200US,
 };
 
-const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
+const struct iwl_cfg_trans_params iwl_qu_medium_latency_trans_cfg = {
 	.mq_rx_supported = true,
 	.use_tfh = true,
 	.rf_id = true,
@@ -254,18 +263,21 @@ const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
 	.integrated = true,
-	.xtal_latency = 12000,
-	.low_latency_xtal = true,
-	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
+	.xtal_latency = 1820,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_1820US,
 };
 
-const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
+const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
 	.mq_rx_supported = true,
 	.use_tfh = true,
 	.rf_id = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
+	.integrated = true,
+	.xtal_latency = 12000,
+	.low_latency_xtal = true,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 9b31fcc37ace..efb10a7f4d4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -513,9 +513,10 @@ struct iwl_dev_info {
 extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_qnj_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_qu_medium_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_qnj_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index bc2cdf40028e..2d78f8504bd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -524,9 +524,10 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 /* Qu devices */
 	{IWL_PCI_DEVICE(0x02F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
 	{IWL_PCI_DEVICE(0x06F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
-	{IWL_PCI_DEVICE(0x34F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
-	{IWL_PCI_DEVICE(0x3DF0, PCI_ANY_ID, iwl_qu_trans_cfg)},
-	{IWL_PCI_DEVICE(0x4DF0, PCI_ANY_ID, iwl_qu_trans_cfg)},
+
+	{IWL_PCI_DEVICE(0x34F0, PCI_ANY_ID, iwl_qu_medium_latency_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3DF0, PCI_ANY_ID, iwl_qu_medium_latency_trans_cfg)},
+	{IWL_PCI_DEVICE(0x4DF0, PCI_ANY_ID, iwl_qu_medium_latency_trans_cfg)},
 
 	{IWL_PCI_DEVICE(0x43F0, PCI_ANY_ID, iwl_qu_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA0F0, PCI_ANY_ID, iwl_qu_long_latency_trans_cfg)},
-- 
2.25.1

