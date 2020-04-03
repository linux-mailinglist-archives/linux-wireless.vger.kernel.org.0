Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4319D23B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 10:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbgDCIaN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 04:30:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:45484 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390431AbgDCIaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 04:30:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jKHiL-0008yu-DB; Fri, 03 Apr 2020 11:30:10 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  3 Apr 2020 11:29:55 +0300
Message-Id: <iwlwifi.20200403112332.0f49448c133d.I17fd308bc4a9491859c9b112f4eb5d2c3fc18d7d@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200403082955.1126339-1-luca@coelho.fi>
References: <20200403082955.1126339-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v5.7 8/8] iwlwifi: mvm: don't call iwl_mvm_free_inactive_queue() under RCU
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

iwl_mvm_free_inactive_queue() will sleep in synchronize_net() under
some circumstances, so don't call it under RCU. There doesn't appear
to be a need for RCU protection around this particular call.

Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 56ae72debb96..9ca433fdf634 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1184,17 +1184,15 @@ static int iwl_mvm_inactivity_check(struct iwl_mvm *mvm, u8 alloc_for_sta)
 	for_each_set_bit(i, &changetid_queues, IWL_MAX_HW_QUEUES)
 		iwl_mvm_change_queue_tid(mvm, i);
 
+	rcu_read_unlock();
+
 	if (free_queue >= 0 && alloc_for_sta != IWL_MVM_INVALID_STA) {
 		ret = iwl_mvm_free_inactive_queue(mvm, free_queue, queue_owner,
 						  alloc_for_sta);
-		if (ret) {
-			rcu_read_unlock();
+		if (ret)
 			return ret;
-		}
 	}
 
-	rcu_read_unlock();
-
 	return free_queue;
 }
 
-- 
2.25.1

