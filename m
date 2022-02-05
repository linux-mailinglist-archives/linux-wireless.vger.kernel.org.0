Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C94AA7DD
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346138AbiBEJVt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37990 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244133AbiBEJVs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:48 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGM-0006b7-A3;
        Sat, 05 Feb 2022 11:21:47 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:32 +0200
Message-Id: <iwlwifi.20220205112029.a79e733a12f7.I8189344294222be0589fa43cc70fdf38e3057045@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205092140.751171-1-luca@coelho.fi>
References: <20220205092140.751171-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/12] iwlwifi: don't dump_stack() when we get an unexpected interrupt
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

It is yet unclear if the WARNING really points to a real problem,
but for sure the stack dump doesn't help fixing it.
Just use a regular error print instead.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 71db571a42e0..516b2e573730 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1627,10 +1627,13 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 	if (WARN_ON(entry->entry >= trans->num_rx_queues))
 		return IRQ_NONE;
 
-	if (WARN_ONCE(!rxq,
-		      "[%d] Got MSI-X interrupt before we have Rx queues",
-		      entry->entry))
+	if (!rxq) {
+		if (net_ratelimit())
+			IWL_ERR(trans,
+				"[%d] Got MSI-X interrupt before we have Rx queues\n",
+				entry->entry);
 		return IRQ_NONE;
+	}
 
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
 	IWL_DEBUG_ISR(trans, "[%d] Got interrupt\n", entry->entry);
-- 
2.34.1

