Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB8DBEB6
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 09:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504688AbfJRHtL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 03:49:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50116 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2504670AbfJRHtL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 03:49:11 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLN0X-0001zy-4u; Fri, 18 Oct 2019 10:49:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 18 Oct 2019 10:49:01 +0300
Message-Id: <20191018104748.37249e76f17d.Id28ce460f03b8bac50e05d648e8ac15d32d6f14d@changeid>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v5.4] iwlwifi: pcie: fix merge damage on making QnJ exclusive
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Two patches were sent out of order: one removed some conditions from
an if and the other moved the code elsewhere.  When sending the patch
that moved the code, an older version of the original code was moved,
causing the "make QnJ exclusive" code to be essentially undone.

Fix that by removing the inclusive conditions from the check again.

Fixes: 809805a820c6 ("iwlwifi: pcie: move some cfg mangling from trans_pcie_alloc to probe")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---

Kalle, can you please apply this directly to wireless-drivers? This
fixes a regression in v5.4.  Thanks!


 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 6f4bb7ce71a5..9d41d783e59f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1067,11 +1067,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
 		   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
-		   ((cfg != &iwl_ax200_cfg_cc &&
-		     cfg != &killer1650x_2ax_cfg &&
-		     cfg != &killer1650w_2ax_cfg &&
-		     cfg != &iwl_ax201_cfg_quz_hr) ||
-		    iwl_trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0)) {
+		   iwl_trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0) {
 		u32 hw_status;
 
 		hw_status = iwl_read_prph(iwl_trans, UMAG_GEN_HW_STATUS);
-- 
2.23.0

