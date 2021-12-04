Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CFD4682F3
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbhLDGja (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50272 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229784AbhLDGj2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:28 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOeM-0017AH-RV; Sat, 04 Dec 2021 08:36:02 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:44 +0200
Message-Id: <iwlwifi.20211204083237.44abbbc50f40.I5492600dfe513356555abe2d7df0e2835846e3d8@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi>
References: <20211204063555.769822-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/12] iwlwifi: mvm: fix delBA vs. NSSN queue sync race
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we happen to decide an NSSN queue sync (IWL_MVM_RXQ_NSSN_SYNC)
for some remaining packets that are still on the queue, but just
after we've decided to do a delBA (which causes its own queues
sync with IWL_MVM_RXQ_NOTIF_DEL_BA) we can end up with a sequence
of events like this:

 CPU 1                              CPU 2

remove BA session with baid N
send IWL_MVM_RXQ_NOTIF_DEL_BA
send IWL_MVM_RXQ_NSSN_SYNC
get IWL_MVM_RXQ_NOTIF_DEL_BA
                                    get IWL_MVM_RXQ_NOTIF_DEL_BA
get IWL_MVM_RXQ_NSSN_SYNC
complete IWL_MVM_RXQ_NOTIF_DEL_BA
remove N from baid_map[]
                                    get IWL_MVM_RXQ_NSSN_SYNC
                                    WARN_ON(!baid_map[N])

Thus, there's a race that leads in hitting the WARN_ON, but more
importantly, it's a race that potentially even results in a new
aggregation session getting assigned to baid N.

To fix this, remove the WARN_ON() in the NSSN_SYNC case, we can't
completely protect against hitting this case, so we shouldn't be
warning. However, guard ourselves against BAID reuse by doing yet
another round of queue synchronization after the entry is removed
from the baid_map, so that it cannot be reused with any in-flight
IWL_MVM_RXQ_NSSN_SYNC messages.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index e0601f802628..03e90087576c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -766,8 +766,11 @@ static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 	rcu_read_lock();
 
 	ba_data = rcu_dereference(mvm->baid_map[baid]);
-	if (WARN_ON_ONCE(!ba_data))
+	if (!ba_data) {
+		WARN(!(flags & IWL_MVM_RELEASE_FROM_RSS_SYNC),
+		     "BAID %d not found in map\n", baid);
 		goto out;
+	}
 
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[ba_data->sta_id]);
 	if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta)))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index a64874c05ced..feab0bfcd7a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2684,6 +2684,16 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		RCU_INIT_POINTER(mvm->baid_map[baid], NULL);
 		kfree_rcu(baid_data, rcu_head);
 		IWL_DEBUG_HT(mvm, "BAID %d is free\n", baid);
+
+		/*
+		 * After we've deleted it, do another queue sync
+		 * so if an IWL_MVM_RXQ_NSSN_SYNC was concurrently
+		 * running it won't find a new session in the old
+		 * BAID. It can find the NULL pointer for the BAID,
+		 * but we must not have it find a different session.
+		 */
+		iwl_mvm_sync_rx_queues_internal(mvm, IWL_MVM_RXQ_EMPTY,
+						true, NULL, 0);
 	}
 	return 0;
 
-- 
2.33.1

