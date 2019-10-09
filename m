Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1CD0BC8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfJIJvB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 05:51:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47812 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727657AbfJIJvB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 05:51:01 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iI8cT-0003o4-KX; Wed, 09 Oct 2019 12:50:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Oct 2019 12:48:54 +0300
Message-Id: <1570614256-@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <1570614256-@changeid>
References: <1570614256-@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 2/2] iwlwifi: pcie: change qu with jf devices to use qu configuration
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

There were a bunch of devices with qu and jf that were loading the
configuration with pu and jf, which is wrong.  Fix them all
accordingly.  Additionally, remove 0x1010 and 0x1210 subsytem IDs from
the list, since they are obviously wrong, and 0x0044 and 0x0244, which
were duplicate.

Cc: stable@vger.kernel.org # 5.1+
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 274 +++++++++---------
 1 file changed, 137 insertions(+), 137 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e29c47744ef5..6f4bb7ce71a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -513,31 +513,33 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8265_2ac_cfg)},
 
 /* 9000 Series */
-	{IWL_PCI_DEVICE(0x02F0, 0x0030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0034, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0038, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x003C, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0060, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0064, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x00A0, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x00A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0230, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0234, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0238, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x023C, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0260, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x0264, iwl9461_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x02A0, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x02A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1551, iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x1552, iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x2030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x2034, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4034, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x40A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x4234, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x02F0, 0x42A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+
 	{IWL_PCI_DEVICE(0x06F0, 0x0030, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x0034, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x0038, iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc)},
@@ -643,34 +645,34 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x40A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x4234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x42A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0034, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0038, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0060, iwl9460_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0064, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x00A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x00A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0230, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0238, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0260, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0264, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x02A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x1010, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x30DC, 0x1030, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x1210, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x30DC, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x1552, iwl9560_killer_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x2030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x2034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x4030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x4034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x40A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x4234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x30DC, 0x42A4, iwl9462_2ac_cfg_soc)},
+
+	{IWL_PCI_DEVICE(0x30DC, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x30DC, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+
 	{IWL_PCI_DEVICE(0x31DC, 0x0030, iwl9560_2ac_160_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x0034, iwl9560_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x0038, iwl9560_2ac_160_cfg_shared_clk)},
@@ -726,62 +728,60 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x34F0, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
 
-	{IWL_PCI_DEVICE(0x3DF0, 0x0030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0034, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0038, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0060, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0064, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x00A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x00A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0230, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0238, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0260, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x0264, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x02A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x1010, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x1030, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x1210, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x2030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x2034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x4030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x4034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x40A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x4234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x3DF0, 0x42A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0034, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0038, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0060, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0064, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x00A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x00A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0230, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0238, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0260, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x0264, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x02A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x1010, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x43F0, 0x1030, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x1210, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x43F0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x2030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x2034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x4030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x4034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x40A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x4234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x43F0, 0x42A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+
+	{IWL_PCI_DEVICE(0x43F0, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+
 	{IWL_PCI_DEVICE(0x9DF0, 0x0000, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0010, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x0030, iwl9560_2ac_160_cfg_soc)},
@@ -821,34 +821,34 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x9DF0, 0x40A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x4234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x42A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0034, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0038, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0060, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0064, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x00A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x00A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0230, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0238, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0260, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x0264, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x02A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x1010, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x1030, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x1210, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x2030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x2034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x4030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x4034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x40A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x4234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0xA0F0, 0x42A4, iwl9462_2ac_cfg_soc)},
+
+	{IWL_PCI_DEVICE(0xA0F0, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+
 	{IWL_PCI_DEVICE(0xA370, 0x0030, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x0034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x0038, iwl9560_2ac_160_cfg_soc)},
-- 
2.23.0

