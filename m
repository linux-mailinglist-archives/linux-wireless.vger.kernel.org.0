Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6271B1AEAB9
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDRIJX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56776 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726012AbgDRIJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXO-000L3r-NS; Sat, 18 Apr 2020 11:09:19 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:52 +0300
Message-Id: <iwlwifi.20200418110539.5e5ce668ff8b.I20a9c8b3470aaabaa54361a5641637e5a14d8321@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/12] iwlwifi: pcie: add cfgs for SoCs with device ID 0x4FD0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

A new device ID needs to be added to the list to support new SoCs.
Add it and support all subsystem IDs that other Qu devices support.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index ab849aa4434e..bc2cdf40028e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -526,6 +526,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x06F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
 	{IWL_PCI_DEVICE(0x34F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
 	{IWL_PCI_DEVICE(0x3DF0, PCI_ANY_ID, iwl_qu_trans_cfg)},
+	{IWL_PCI_DEVICE(0x4DF0, PCI_ANY_ID, iwl_qu_trans_cfg)},
 
 	{IWL_PCI_DEVICE(0x43F0, PCI_ANY_ID, iwl_qu_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA0F0, PCI_ANY_ID, iwl_qu_long_latency_trans_cfg)},
@@ -662,6 +663,19 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x3DF0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
 
+	IWL_DEV_INFO(0x4DF0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x0244, iwl_ax101_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x0310, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x4DF0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
+
 	IWL_DEV_INFO(0x2720, 0x0000, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
 	IWL_DEV_INFO(0x2720, 0x0040, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
 	IWL_DEV_INFO(0x2720, 0x0044, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-- 
2.25.1

