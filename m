Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF17129BDC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 00:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLWXrf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 18:47:35 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54696 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726512AbfLWXre (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 18:47:34 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ijXQB-00010j-1k; Tue, 24 Dec 2019 01:47:33 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 24 Dec 2019 01:47:15 +0200
Message-Id: <20191223234721.1513938-2-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223234721.1513938-1-luca@coelho.fi>
References: <20191223234721.1513938-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 1/7] iwlwifi: mvm: fix SKB leak on invalid queue
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It used to be the case that if we got here, we wouldn't warn
but instead allocate the queue (DQA). With using the mac80211
TXQs model this changed, and we really have nothing to do with
the frame here anymore, hence the warning now.

However, clearly we missed in coding & review that this is now
a pure error path and leaks the SKB if we return 0 instead of
an indication that the SKB needs to be freed. Fix this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: cfbc6c4c5b91 ("iwlwifi: mvm: support mac80211 TXQs model")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 80052ad1fa6d..eaeb8501c9b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1149,7 +1149,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (WARN_ONCE(txq_id == IWL_MVM_INVALID_QUEUE, "Invalid TXQ id")) {
 		iwl_trans_free_tx_cmd(mvm->trans, dev_cmd);
 		spin_unlock(&mvmsta->lock);
-		return 0;
+		return -1;
 	}
 
 	if (!iwl_mvm_has_new_tx_api(mvm)) {
-- 
2.24.0

