Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64C17D9AC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCIHQk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:40 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33082 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgCIHQj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:39 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeT-0007CP-4t; Mon, 09 Mar 2020 09:16:37 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:15 +0200
Message-Id: <iwlwifi.20200309091348.fef62aa45887.I302e32b7cfff7da0d920547fae60ad9f2296e052@changeid>
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
Subject: [PATCH 09/13] iwlwifi: remove 9260 devices with 0x1010 and 0x1210 subsytem IDs
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

These devices don't exist anymore, so remove them from the tables.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index c4ed9fa28d46..b4e53251021e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -179,7 +179,6 @@ const struct iwl_cfg_trans_params iwl9000_trans_cfg = {
 };
 
 const struct iwl_cfg iwl9260_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 9260",
 	.fw_name_pre = IWL9260_FW_PRE,
 	IWL_DEVICE_9000,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 6ecb00cc7406..e7840e20b645 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -612,9 +612,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x30DC, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x02A0, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x30DC, 0x1030, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x1210, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x30DC, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x2030, iwl9560_2ac_160_cfg_soc)},
@@ -641,9 +639,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x31DC, 0x0264, iwl9461_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x02A0, iwl9462_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x02A4, iwl9462_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x31DC, 0x1030, iwl9560_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x1210, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x31DC, 0x1551, iwl9560_killer_s_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x1552, iwl9560_killer_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x2030, iwl9560_2ac_160_cfg_shared_clk)},
@@ -759,9 +755,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x9DF0, 0x0610, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0710, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0A10, iwl9460_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x9DF0, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x1030, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x9DF0, 0x1210, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x2010, iwl9460_2ac_cfg_soc)},
@@ -817,9 +811,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xA370, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x02A0, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA370, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0xA370, 0x1030, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA370, 0x1210, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0xA370, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x2030, iwl9560_2ac_160_cfg_soc)},
-- 
2.25.1

