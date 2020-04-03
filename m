Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0AAA19D234
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390405AbgDCIaH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 04:30:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:45438 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727803AbgDCIaG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 04:30:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jKHiG-0008yu-Aq; Fri, 03 Apr 2020 11:30:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  3 Apr 2020 11:29:48 +0300
Message-Id: <iwlwifi.20200403112332.165b961b6ff6.Id5feebc9b4318041913a9c89fc1378bb5454292c@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200403082955.1126339-1-luca@coelho.fi>
References: <20200403082955.1126339-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v5.7 1/8] iwlwifi: pcie: actually release queue memory in TVQM
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The iwl_trans_pcie_dyn_txq_free() function only releases the frames
that may be left on the queue by calling iwl_pcie_gen2_txq_unmap(),
but doesn't actually free the DMA ring or byte-count tables for the
queue. This leads to pretty large memory leaks (at least before my
queue size improvements), in particular in monitor/sniffer mode on
channel hopping since this happens on every channel change.

This was also now more evident after the move to a DMA pool for the
byte count tables, showing messages such as

  BUG iwlwifi:bc (...): Objects remaining in iwlwifi:bc on __kmem_cache_shutdown()

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=206811.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 6b35ff91572f ("iwlwifi: pcie: introduce a000 TX queues management")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 86fc00167817..9664dbc70ef1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1418,6 +1418,9 @@ void iwl_trans_pcie_dyn_txq_free(struct iwl_trans *trans, int queue)
 
 	iwl_pcie_gen2_txq_unmap(trans, queue);
 
+	iwl_pcie_gen2_txq_free_memory(trans, trans_pcie->txq[queue]);
+	trans_pcie->txq[queue] = NULL;
+
 	IWL_DEBUG_TX_QUEUES(trans, "Deactivate queue %d\n", queue);
 }
 
-- 
2.25.1

