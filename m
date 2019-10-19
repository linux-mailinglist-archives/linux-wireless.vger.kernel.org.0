Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76819DD7E0
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 12:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfJSKDj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 06:03:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50512 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbfJSKDj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 06:03:39 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlaD-0002jL-Mm; Sat, 19 Oct 2019 13:03:38 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 13:03:28 +0300
Message-Id: <20191019100331.21322-3-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019100331.21322-1-luca@coelho.fi>
References: <20191019100331.21322-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 2/5] iwlwifi: pcie: fix all 9460 entries for qnj
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

A bunch of the entries for qnj were wrong.  The 9460 device doesn't
exist, so update them to 9461 and 9462.  There are still a bunch of
other occurrences of 9460, but that will be fixed separately.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b7c3737c5c2f..03568f18a171 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -573,20 +573,20 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2526, 0x0034, iwl9560_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0038, iwl9560_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x003C, iwl9560_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0060, iwl9460_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0064, iwl9460_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x00A0, iwl9460_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x00A4, iwl9460_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0x0060, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2526, 0x0064, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2526, 0x00A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2526, 0x00A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x0210, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0214, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0230, iwl9560_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0234, iwl9560_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0238, iwl9560_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x023C, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0260, iwl9460_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0x0260, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x0264, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x02A0, iwl9460_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x02A4, iwl9460_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0x02A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2526, 0x02A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x1030, iwl9560_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x1210, iwl9260_2ac_cfg)},
@@ -603,7 +603,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2526, 0x401C, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x4030, iwl9560_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x4034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x40A4, iwl9460_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0x40A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x4234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x42A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x6010, iwl9260_2ac_160_cfg)},
-- 
2.23.0

