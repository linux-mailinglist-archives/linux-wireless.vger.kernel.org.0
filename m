Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3637B3A4E5F
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhFLLex (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 07:34:53 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47582 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231229AbhFLLew (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 07:34:52 -0400
Received: from [192.130.48.226] (helo=kveik.superpark.guest)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ls1sg-001V8i-BT; Sat, 12 Jun 2021 14:32:51 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 12 Jun 2021 14:32:39 +0300
Message-Id: <iwlwifi.20210612142637.9aa4f0e3574a.I458b283f203d5f927f00be1bfbd4b8ebf11c5ae4@changeid>
X-Mailer: git-send-email 2.32.0.rc2
In-Reply-To: <20210612113245.691117-1-luca@coelho.fi>
References: <20210612113245.691117-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 06/12] iwlwifi: pcie: handle pcim_iomap_table() failures better
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

pcim_iomap_table() might return NULL, so we shouldn't unconditionally
dereference the return value by taking the [0] entry.

Handle this better by checking for NULL first, and then separately
checking if the [0] entry is NULL.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 228baf362474..2152ee95b19e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3425,6 +3425,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	struct iwl_trans *trans;
 	int ret, addr_size;
 	const struct iwl_trans_ops *ops = &trans_ops_pcie_gen2;
+	void __iomem * const *table;
 
 	if (!cfg_trans->gen2)
 		ops = &trans_ops_pcie;
@@ -3497,9 +3498,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		goto out_no_pci;
 	}
 
-	trans_pcie->hw_base = pcim_iomap_table(pdev)[0];
-	if (!trans_pcie->hw_base) {
+	table = pcim_iomap_table(pdev);
+	if (!table) {
 		dev_err(&pdev->dev, "pcim_iomap_table failed\n");
+		ret = -ENOMEM;
+		goto out_no_pci;
+	}
+
+	trans_pcie->hw_base = table[0];
+	if (!trans_pcie->hw_base) {
+		dev_err(&pdev->dev, "couldn't find IO mem in first BAR\n");
 		ret = -ENODEV;
 		goto out_no_pci;
 	}
-- 
2.32.0.rc2

