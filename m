Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D259752
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF1JUo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:44 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54770 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbfF1JUo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:44 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3Q-0001ny-Cu; Fri, 28 Jun 2019 12:20:24 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 10/20] iwlwifi: pcie: increase the size of PCI dumps
Date:   Fri, 28 Jun 2019 12:19:58 +0300
Message-Id: <20190628092008.11049-11-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Currently we dump only the first 64 bytes of the PCI config space,
which leaves out some important things, such as the base address
registers.

Increase it to 352 for the PCI device and to 524 for the rootport to
make sure we include everything we need.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index ca486a7af602..6f5f7e9a894f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -90,8 +90,10 @@
 
 void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 {
-#define PCI_DUMP_SIZE	64
-#define PREFIX_LEN	32
+#define PCI_DUMP_SIZE		352
+#define PCI_MEM_DUMP_SIZE	64
+#define PCI_PARENT_DUMP_SIZE	524
+#define PREFIX_LEN		32
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct pci_dev *pdev = trans_pcie->pci_dev;
 	u32 i, pos, alloc_size, *ptr, *buf;
@@ -102,11 +104,15 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 
 	/* Should be a multiple of 4 */
 	BUILD_BUG_ON(PCI_DUMP_SIZE > 4096 || PCI_DUMP_SIZE & 0x3);
+	BUILD_BUG_ON(PCI_MEM_DUMP_SIZE > 4096 || PCI_MEM_DUMP_SIZE & 0x3);
+	BUILD_BUG_ON(PCI_PARENT_DUMP_SIZE > 4096 || PCI_PARENT_DUMP_SIZE & 0x3);
+
 	/* Alloc a max size buffer */
-	if (PCI_ERR_ROOT_ERR_SRC +  4 > PCI_DUMP_SIZE)
-		alloc_size = PCI_ERR_ROOT_ERR_SRC +  4 + PREFIX_LEN;
-	else
-		alloc_size = PCI_DUMP_SIZE + PREFIX_LEN;
+	alloc_size = PCI_ERR_ROOT_ERR_SRC +  4 + PREFIX_LEN;
+	alloc_size = max_t(u32, alloc_size, PCI_DUMP_SIZE + PREFIX_LEN);
+	alloc_size = max_t(u32, alloc_size, PCI_MEM_DUMP_SIZE + PREFIX_LEN);
+	alloc_size = max_t(u32, alloc_size, PCI_PARENT_DUMP_SIZE + PREFIX_LEN);
+
 	buf = kmalloc(alloc_size, GFP_ATOMIC);
 	if (!buf)
 		return;
@@ -123,7 +129,7 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
 
 	IWL_ERR(trans, "iwlwifi device memory mapped registers:\n");
-	for (i = 0, ptr = buf; i < PCI_DUMP_SIZE; i += 4, ptr++)
+	for (i = 0, ptr = buf; i < PCI_MEM_DUMP_SIZE; i += 4, ptr++)
 		*ptr = iwl_read32(trans, i);
 	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
 
@@ -146,7 +152,7 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 
 	IWL_ERR(trans, "iwlwifi parent port (%s) config registers:\n",
 		pci_name(pdev));
-	for (i = 0, ptr = buf; i < PCI_DUMP_SIZE; i += 4, ptr++)
+	for (i = 0, ptr = buf; i < PCI_PARENT_DUMP_SIZE; i += 4, ptr++)
 		if (pci_read_config_dword(pdev, i, ptr))
 			goto err_read;
 	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
-- 
2.20.1

