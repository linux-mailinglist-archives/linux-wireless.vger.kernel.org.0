Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F7300387
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 13:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbhAVMyo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 07:54:44 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:41666 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727470AbhAVMx7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 07:53:59 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l2vvl-003vnH-3k; Fri, 22 Jan 2021 14:52:49 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 Jan 2021 14:52:42 +0200
Message-Id: <iwlwifi.20210122144849.abe2dedcc3ac.Ia6b03f9eeb617fd819e56dd5376f4bb8edc7b98a@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122125242.107146-1-luca@coelho.fi>
References: <20210122125242.107146-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 7/7] iwlwifi: queue: bail out on invalid freeing
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we find an entry without an SKB, we currently continue, but
that will just result in an infinite loop since we won't increment
the read pointer, and will try the same thing over and over again.
Fix this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 27eea909e32d..794c6d0836ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -841,10 +841,8 @@ void iwl_txq_gen2_unmap(struct iwl_trans *trans, int txq_id)
 			int idx = iwl_txq_get_cmd_index(txq, txq->read_ptr);
 			struct sk_buff *skb = txq->entries[idx].skb;
 
-			if (WARN_ON_ONCE(!skb))
-				continue;
-
-			iwl_txq_free_tso_page(trans, skb);
+			if (!WARN_ON_ONCE(!skb))
+				iwl_txq_free_tso_page(trans, skb);
 		}
 		iwl_txq_gen2_free_tfd(trans, txq);
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
-- 
2.29.2

