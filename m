Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E66EF13
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfGTK1Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:27:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59568 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727851AbfGTK1Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:27:24 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homZR-0000Hj-8t; Sat, 20 Jul 2019 13:26:30 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Ihab Zhaika <ihab.zhaika@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:44 +0300
Message-Id: <20190720102545.5952-16-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190720102545.5952-1-luca@coelho.fi>
References: <20190720102545.5952-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 15/16] iwlwifi: add 3 new IDs for the 9000 series (iwl9260_2ac_160_cfg)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ihab Zhaika <ihab.zhaika@intel.com>

Add a few PCI ID'S for 9000 series.

Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index ea2a03d4bf55..de711c1160d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -604,10 +604,13 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2526, 0x40A4, iwl9460_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x4234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x42A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2526, 0x6010, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x6014, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x8014, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x8010, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0xA014, iwl9260_2ac_160_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0xE010, iwl9260_2ac_160_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0xE014, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0010, iwl9160_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0014, iwl9160_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0210, iwl9160_2ac_cfg)},
-- 
2.20.1

