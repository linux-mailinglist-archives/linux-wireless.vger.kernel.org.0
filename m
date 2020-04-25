Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA33A1B8584
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDYKFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:05:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58256 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbgDYKFR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:05:17 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jSHgR-000P3t-1T; Sat, 25 Apr 2020 13:05:15 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 25 Apr 2020 13:04:56 +0300
Message-Id: <iwlwifi.20200425130140.dcf1801f25ef.I6d71e13ea042765800f2ee41401b8eb282527c34@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200425100459.2778317-1-luca@coelho.fi>
References: <20200425100459.2778317-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/11] iwlwifi: mvm: don't transmit on unallocated queue
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We can currently end up transmitting on an unallocated queue, if
the allocation fails. Stop doing that, by simply not transmitting.
We don't have any better strategy here, unfortunately, but the
previous commits make that much less likely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 3e16bd4190ff..bff520087ed7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1395,7 +1395,17 @@ void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk)
 		if (tid == IEEE80211_NUM_TIDS)
 			tid = IWL_MAX_TID_COUNT;
 
-		iwl_mvm_sta_alloc_queue(mvm, txq->sta, txq->ac, tid);
+		/*
+		 * We can't really do much here, but if this fails we can't
+		 * transmit anyway - so just don't transmit the frame etc.
+		 * and let them back up ... we've tried our best to allocate
+		 * a queue in the function itself.
+		 */
+		if (iwl_mvm_sta_alloc_queue(mvm, txq->sta, txq->ac, tid)) {
+			list_del_init(&mvmtxq->list);
+			continue;
+		}
+
 		list_del_init(&mvmtxq->list);
 		local_bh_disable();
 		iwl_mvm_mac_itxq_xmit(mvm->hw, txq);
-- 
2.26.2

