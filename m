Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AA718F590
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgCWNTj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:19:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43394 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728378AbgCWNTi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:19:38 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzQ-00023f-B9; Mon, 23 Mar 2020 15:19:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:14 +0200
Message-Id: <iwlwifi.20200323151304.18627088be69.Ib2d254a38a4bfb95dcc3d04eec91781827a0c623@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323131925.208376-1-luca@coelho.fi>
References: <20200323131925.208376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/14] iwlwifi: pcie: implement read_config32
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add the read_config32 op to allow dumping the config space when
needed.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 38d8fe21690a..46832bbfcae7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2206,6 +2206,13 @@ static int iwl_trans_pcie_write_mem(struct iwl_trans *trans, u32 addr,
 	return ret;
 }
 
+static int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
+					u32 *val)
+{
+	return pci_read_config_dword(IWL_TRANS_GET_PCIE_TRANS(trans)->pci_dev,
+				     ofs, val);
+}
+
 static void iwl_trans_pcie_freeze_txq_timer(struct iwl_trans *trans,
 					    unsigned long txqs,
 					    bool freeze)
@@ -3380,6 +3387,7 @@ static void iwl_trans_pcie_resume(struct iwl_trans *trans)
 	.write_prph = iwl_trans_pcie_write_prph,			\
 	.read_mem = iwl_trans_pcie_read_mem,				\
 	.write_mem = iwl_trans_pcie_write_mem,				\
+	.read_config32 = iwl_trans_pcie_read_config32,			\
 	.configure = iwl_trans_pcie_configure,				\
 	.set_pmi = iwl_trans_pcie_set_pmi,				\
 	.sw_reset = iwl_trans_pcie_sw_reset,				\
-- 
2.25.1

