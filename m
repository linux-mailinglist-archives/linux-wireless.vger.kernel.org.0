Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9606EF16
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfGTK1f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:27:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59592 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727851AbfGTK1f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:27:35 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homZK-0000Hj-Of; Sat, 20 Jul 2019 13:26:24 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:42 +0300
Message-Id: <20190720102545.5952-14-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190720102545.5952-1-luca@coelho.fi>
References: <20190720102545.5952-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 13/16] iwlwifi: mvm: fix frame drop from the reordering buffer
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

An earlier patch made sure that the queues are not lagging
too far behind. This means that iwl_mvm_release_frames
should not be called with a head_sn too far behind NSSN.

Don't take the risk to change completely the entry
condition to iwl_mvm_release_frames, but don't update
the head_sn is the NSSN is more than 2048 packets ahead
of us. Since this just cannot be right. This means that
the scenario described here happened. We are queue 0.

	Q:0				Q:1
	head_sn: 0    -> 2047
					head_sn: 2048

	Lots of packets arrive:
	head_sn: 2047 -> 2150

					send NSSN_SYNC notification

	Handle notification
	from the firmware and
	do NOT move the head_sn
	back to 2048

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 44 ++++++++++++++-----
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 4f4fdaf49eef..854edd7d7103 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -518,12 +518,17 @@ static void iwl_mvm_sync_nssn(struct iwl_mvm *mvm, u8 baid, u16 nssn)
 
 #define RX_REORDER_BUF_TIMEOUT_MQ (HZ / 10)
 
+enum iwl_mvm_release_flags {
+	IWL_MVM_RELEASE_SEND_RSS_SYNC = BIT(0),
+	IWL_MVM_RELEASE_FROM_RSS_SYNC = BIT(1),
+};
+
 static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 				   struct ieee80211_sta *sta,
 				   struct napi_struct *napi,
 				   struct iwl_mvm_baid_data *baid_data,
 				   struct iwl_mvm_reorder_buffer *reorder_buf,
-				   u16 nssn, bool sync_rss)
+				   u16 nssn, u32 flags)
 {
 	struct iwl_mvm_reorder_buf_entry *entries =
 		&baid_data->entries[reorder_buf->queue *
@@ -532,6 +537,18 @@ static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&reorder_buf->lock);
 
+	/*
+	 * We keep the NSSN not too far behind, if we are sync'ing it and it
+	 * is more than 2048 ahead of us, it must be behind us. Discard it.
+	 * This can happen if the queue that hit the 0 / 2048 seqno was lagging
+	 * behind and this queue already processed packets. The next if
+	 * would have caught cases where this queue would have processed less
+	 * than 64 packets, but it may have processed more than 64 packets.
+	 */
+	if ((flags & IWL_MVM_RELEASE_FROM_RSS_SYNC) &&
+	    ieee80211_sn_less(nssn, ssn))
+		goto set_timer;
+
 	/* ignore nssn smaller than head sn - this can happen due to timeout */
 	if (iwl_mvm_is_sn_less(nssn, ssn, reorder_buf->buf_size))
 		goto set_timer;
@@ -542,7 +559,8 @@ static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 		struct sk_buff *skb;
 
 		ssn = ieee80211_sn_inc(ssn);
-		if (sync_rss && (ssn == 2048 || ssn == 0))
+		if ((flags & IWL_MVM_RELEASE_SEND_RSS_SYNC) &&
+		    (ssn == 2048 || ssn == 0))
 			iwl_mvm_sync_nssn(mvm, baid_data->baid, ssn);
 
 		/*
@@ -631,7 +649,7 @@ void iwl_mvm_reorder_timer_expired(struct timer_list *t)
 		iwl_mvm_event_frame_timeout_callback(buf->mvm, mvmsta->vif,
 						     sta, baid_data->tid);
 		iwl_mvm_release_frames(buf->mvm, sta, NULL, baid_data,
-				       buf, sn, true);
+				       buf, sn, IWL_MVM_RELEASE_SEND_RSS_SYNC);
 		rcu_read_unlock();
 	} else {
 		/*
@@ -674,7 +692,7 @@ static void iwl_mvm_del_ba(struct iwl_mvm *mvm, int queue,
 	iwl_mvm_release_frames(mvm, sta, NULL, ba_data, reorder_buf,
 			       ieee80211_sn_add(reorder_buf->head_sn,
 						reorder_buf->buf_size),
-			       false);
+			       0);
 	spin_unlock_bh(&reorder_buf->lock);
 	del_timer_sync(&reorder_buf->reorder_timer);
 
@@ -684,7 +702,8 @@ static void iwl_mvm_del_ba(struct iwl_mvm *mvm, int queue,
 
 static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 					      struct napi_struct *napi,
-					      u8 baid, u16 nssn, int queue)
+					      u8 baid, u16 nssn, int queue,
+					      u32 flags)
 {
 	struct ieee80211_sta *sta;
 	struct iwl_mvm_reorder_buffer *reorder_buf;
@@ -711,7 +730,7 @@ static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 
 	spin_lock_bh(&reorder_buf->lock);
 	iwl_mvm_release_frames(mvm, sta, napi, ba_data,
-			       reorder_buf, nssn, false);
+			       reorder_buf, nssn, flags);
 	spin_unlock_bh(&reorder_buf->lock);
 
 out:
@@ -723,7 +742,8 @@ static void iwl_mvm_nssn_sync(struct iwl_mvm *mvm,
 			      const struct iwl_mvm_nssn_sync_data *data)
 {
 	iwl_mvm_release_frames_from_notif(mvm, napi, data->baid,
-					  data->nssn, queue);
+					  data->nssn, queue,
+					  IWL_MVM_RELEASE_FROM_RSS_SYNC);
 }
 
 void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
@@ -851,7 +871,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 
 	if (ieee80211_is_back_req(hdr->frame_control)) {
 		iwl_mvm_release_frames(mvm, sta, napi, baid_data,
-				       buffer, nssn, false);
+				       buffer, nssn, 0);
 		goto drop;
 	}
 
@@ -871,7 +891,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 		u16 min_sn = ieee80211_sn_less(sn, nssn) ? sn : nssn;
 
 		iwl_mvm_release_frames(mvm, sta, napi, baid_data, buffer,
-				       min_sn, true);
+				       min_sn, IWL_MVM_RELEASE_SEND_RSS_SYNC);
 	}
 
 	/* drop any oudated packets */
@@ -963,7 +983,8 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	 */
 	if (!amsdu || last_subframe)
 		iwl_mvm_release_frames(mvm, sta, napi, baid_data,
-				       buffer, nssn, true);
+				       buffer, nssn,
+				       IWL_MVM_RELEASE_SEND_RSS_SYNC);
 
 	spin_unlock_bh(&buffer->lock);
 	return true;
@@ -1936,5 +1957,6 @@ void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct iwl_frame_release *release = (void *)pkt->data;
 
 	iwl_mvm_release_frames_from_notif(mvm, napi, release->baid,
-					  le16_to_cpu(release->nssn), queue);
+					  le16_to_cpu(release->nssn),
+					  queue, 0);
 }
-- 
2.20.1

