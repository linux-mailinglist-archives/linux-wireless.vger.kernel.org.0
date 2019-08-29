Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BB6A136F
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 10:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfH2INy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 04:13:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39172 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725990AbfH2INx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 04:13:53 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i3FZ1-0000ts-DP; Thu, 29 Aug 2019 11:13:52 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 29 Aug 2019 11:13:46 +0300
Message-Id: <20190829081346.13294-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v5.3] iwlwifi: assign directly to iwl_trans->cfg in QuZ detection
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We were erroneously assigning the new configuration to a local
variable cfg, but that was not being assigned to anything, so the
change was getting lost.  Assign directly to iwl_trans->cfg instead.

Fixes: 5a8c31aa6357 ("iwlwifi: pcie: fix recognition of QuZ devices")
Cc: stable@vger.kernel.org # 5.2
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d9ed53b7c768..3b12e7ad35e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1070,18 +1070,18 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* same thing for QuZ... */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QUZ) {
-		if (cfg == &iwl_ax101_cfg_qu_hr)
-			cfg = &iwl_ax101_cfg_quz_hr;
-		else if (cfg == &iwl_ax201_cfg_qu_hr)
-			cfg = &iwl_ax201_cfg_quz_hr;
-		else if (cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
-			cfg = &iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
-			cfg = &iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
-			cfg = &iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
-			cfg = &iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
+		if (iwl_trans->cfg == &iwl_ax101_cfg_qu_hr)
+			iwl_trans->cfg = &iwl_ax101_cfg_quz_hr;
+		else if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
+			iwl_trans->cfg = &iwl_ax201_cfg_quz_hr;
+		else if (iwl_trans->cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg = &iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
+		else if (iwl_trans->cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg = &iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
+		else if (iwl_trans->cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg = &iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
+		else if (iwl_trans->cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg = &iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
 	}
 
 #endif
-- 
2.23.0.rc1

