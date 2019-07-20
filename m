Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24916EF0B
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfGTK0J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:26:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59468 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbfGTK0J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:26:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homZ3-0000Hj-I6; Sat, 20 Jul 2019 13:26:07 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:34 +0300
Message-Id: <20190720102545.5952-6-luca@coelho.fi>
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
Subject: [PATCH 05/16] iwlwifi: mvm: add a loose synchronization of the NSSN across Rx queues
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

In order to support MSI-X efficiently, we want to avoid
communication across Rx queues. Each Rx queue should have
all the data it needs to process a packet.

The reordering buffer is a challenge in the MSI-X world
since we can have a single BA session whose packets are
directed to different queues. This is why each queue has
its own reordering buffer. The hardware is able to hint
the driver whether we have a hole or not, which allows
the driver to know whether it can release a packet or not.
This indication is called NSSN. Roughly, if the packet's
SN is lower than the NSSN, we can release the packet to
the stack. The NSSN is the SN of the newest packet received
without any holes + 1.

This is working as long as we don't have packets that we
release because of a timeout. When that happens, we could
have taken the decision to release a packet after we have
been waiting for its predecessor for too long. If this
predecessor comes later, we have to drop it because we
can't release packets out of order. In that case, the
hardware will give us an indication that we can we release
the packet (SN < NSSN), but the packet still needs to be
dropped.
This is why we sometimes need to ignore the NSSN and we
track the head_sn in software.
Here is a specific example of this:

1) Rx queue 1 got packets: 480, 482, 483
2) We release 480 to to the stack and wait for 481
3) NSSN is now 481
4) The timeout expires
5) We release 482 and 483, NSSN is still 480
6) 481 arrives its NSSN is 484.

We need to drop 481 even if 481 < 484. This is why we'll
update the head_sn to 484 at step 2. The flow now is:

1) Rx queue 1 got packets: 480, 482, 483
2) We release 480 to to the stack and wait for 481
3) NSSN is now 481 / head_sn is 481
4) The timeout expires
5) We release 482 and 483, NSSN is still 480 but head_sn is 484.
6) 481 arrives its NSSN is 484, but head_sn is 484 and we drop it.

This code introduces another problem in case all the traffic
goes well (no hole, no timeout):

Rx queue 1: 0   -> 483   (head_sn = 484)
Rx queue 2: 501 -> 4095  (head_sn = 0)
Rx queue 2: 0   -> 480   (head_sn = 481)
Rx queue 1: 481 but head_sn = 484 and we drop it.

At this point, the SN of queue 1 is far behind: more than
4040 packets behind. Queue 1 will consider 481 "old"
because 481 is in [501-64:501] whereas it is a very new
packet.

In order to fix that, send an Rx notification from time to
time (twice across the full set of 4096 packets) to make
sure no Rx queue is lagging too far behind.

What will happen then is:

Rx queue 1: 0    -> 483       (head_sn = 484)
Rx queue 2: 501  -> 2047      (head_sn = 2048)
Rx queue 1: Sync nofication   (head_sn = 2048)
Rx queue 2: 2048 -> 4095      (head_sn = 0)
Rx queue 1: Sync notification (head_sn = 0)
Rx queue 2: 1    -> 481       (head_sn = 482)
Rx queue 1: 481 and head_sn = 0.

In queue 1's data, head_sn is now 0, the packet coming in
is 481, it'll understand that the new packet is new and it
won't be dropped.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 64 +++++++++++++++----
 3 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 99fa440bc639..982682ec74fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5053,7 +5053,6 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 	u32 qmask = BIT(mvm->trans->num_rx_queues) - 1;
 	int ret;
 
-	lockdep_assert_held(&mvm->mutex);
 
 	if (!iwl_mvm_has_new_rx_api(mvm))
 		return;
@@ -5064,13 +5063,15 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 		atomic_set(&mvm->queue_sync_counter,
 			   mvm->trans->num_rx_queues);
 
-	ret = iwl_mvm_notify_rx_queue(mvm, qmask, (u8 *)notif, size);
+	ret = iwl_mvm_notify_rx_queue(mvm, qmask, (u8 *)notif,
+				      size, !notif->sync);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to trigger RX queues sync (%d)\n", ret);
 		goto out;
 	}
 
 	if (notif->sync) {
+		lockdep_assert_held(&mvm->mutex);
 		ret = wait_event_timeout(mvm->rx_sync_waitq,
 					 atomic_read(&mvm->queue_sync_counter) == 0 ||
 					 iwl_mvm_is_radio_killed(mvm),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index c1e8b4766b0c..fd1764df592f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1664,7 +1664,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 			      struct iwl_rx_cmd_buffer *rxb, int queue);
 int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
-			    const u8 *data, u32 count);
+			    const u8 *data, u32 count, bool async);
 void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 			    struct iwl_rx_cmd_buffer *rxb, int queue);
 void iwl_mvm_rx_tx_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 16078aa7c95f..4f4fdaf49eef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -463,7 +463,7 @@ static bool iwl_mvm_is_dup(struct ieee80211_sta *sta, int queue,
 }
 
 int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
-			    const u8 *data, u32 count)
+			    const u8 *data, u32 count, bool async)
 {
 	u8 buf[sizeof(struct iwl_rxq_sync_cmd) +
 	       sizeof(struct iwl_mvm_rss_sync_notif)];
@@ -487,7 +487,7 @@ int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
 	ret = iwl_mvm_send_cmd_pdu(mvm,
 				   WIDE_ID(DATA_PATH_GROUP,
 					   TRIGGER_RX_QUEUES_NOTIF_CMD),
-				   0, data_size, cmd);
+				   async ? CMD_ASYNC : 0, data_size, cmd);
 
 	return ret;
 }
@@ -504,6 +504,18 @@ static bool iwl_mvm_is_sn_less(u16 sn1, u16 sn2, u16 buffer_size)
 	       !ieee80211_sn_less(sn1, sn2 - buffer_size);
 }
 
+static void iwl_mvm_sync_nssn(struct iwl_mvm *mvm, u8 baid, u16 nssn)
+{
+	struct iwl_mvm_rss_sync_notif notif = {
+		.metadata.type = IWL_MVM_RXQ_NSSN_SYNC,
+		.metadata.sync = 0,
+		.nssn_sync.baid = baid,
+		.nssn_sync.nssn = nssn,
+	};
+
+	iwl_mvm_sync_rx_queues_internal(mvm, (void *)&notif, sizeof(notif));
+}
+
 #define RX_REORDER_BUF_TIMEOUT_MQ (HZ / 10)
 
 static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
@@ -511,7 +523,7 @@ static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 				   struct napi_struct *napi,
 				   struct iwl_mvm_baid_data *baid_data,
 				   struct iwl_mvm_reorder_buffer *reorder_buf,
-				   u16 nssn)
+				   u16 nssn, bool sync_rss)
 {
 	struct iwl_mvm_reorder_buf_entry *entries =
 		&baid_data->entries[reorder_buf->queue *
@@ -530,6 +542,8 @@ static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 		struct sk_buff *skb;
 
 		ssn = ieee80211_sn_inc(ssn);
+		if (sync_rss && (ssn == 2048 || ssn == 0))
+			iwl_mvm_sync_nssn(mvm, baid_data->baid, ssn);
 
 		/*
 		 * Empty the list. Will have more than one frame for A-MSDU.
@@ -616,7 +630,8 @@ void iwl_mvm_reorder_timer_expired(struct timer_list *t)
 			     sta_id, sn);
 		iwl_mvm_event_frame_timeout_callback(buf->mvm, mvmsta->vif,
 						     sta, baid_data->tid);
-		iwl_mvm_release_frames(buf->mvm, sta, NULL, baid_data, buf, sn);
+		iwl_mvm_release_frames(buf->mvm, sta, NULL, baid_data,
+				       buf, sn, true);
 		rcu_read_unlock();
 	} else {
 		/*
@@ -658,7 +673,8 @@ static void iwl_mvm_del_ba(struct iwl_mvm *mvm, int queue,
 	spin_lock_bh(&reorder_buf->lock);
 	iwl_mvm_release_frames(mvm, sta, NULL, ba_data, reorder_buf,
 			       ieee80211_sn_add(reorder_buf->head_sn,
-						reorder_buf->buf_size));
+						reorder_buf->buf_size),
+			       false);
 	spin_unlock_bh(&reorder_buf->lock);
 	del_timer_sync(&reorder_buf->reorder_timer);
 
@@ -694,7 +710,8 @@ static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 	reorder_buf = &ba_data->reorder_buf[queue];
 
 	spin_lock_bh(&reorder_buf->lock);
-	iwl_mvm_release_frames(mvm, sta, napi, ba_data, reorder_buf, nssn);
+	iwl_mvm_release_frames(mvm, sta, napi, ba_data,
+			       reorder_buf, nssn, false);
 	spin_unlock_bh(&reorder_buf->lock);
 
 out:
@@ -833,7 +850,8 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	}
 
 	if (ieee80211_is_back_req(hdr->frame_control)) {
-		iwl_mvm_release_frames(mvm, sta, napi, baid_data, buffer, nssn);
+		iwl_mvm_release_frames(mvm, sta, napi, baid_data,
+				       buffer, nssn, false);
 		goto drop;
 	}
 
@@ -842,7 +860,10 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	 * If the SN is smaller than the NSSN it might need to first go into
 	 * the reorder buffer, in which case we just release up to it and the
 	 * rest of the function will take care of storing it and releasing up to
-	 * the nssn
+	 * the nssn.
+	 * This should not happen. This queue has been lagging and it should
+	 * have been updated by a IWL_MVM_RXQ_NSSN_SYNC notification. Be nice
+	 * and update the other queues.
 	 */
 	if (!iwl_mvm_is_sn_less(nssn, buffer->head_sn + buffer->buf_size,
 				buffer->buf_size) ||
@@ -850,7 +871,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 		u16 min_sn = ieee80211_sn_less(sn, nssn) ? sn : nssn;
 
 		iwl_mvm_release_frames(mvm, sta, napi, baid_data, buffer,
-				       min_sn);
+				       min_sn, true);
 	}
 
 	/* drop any oudated packets */
@@ -861,8 +882,23 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	if (!buffer->num_stored && ieee80211_sn_less(sn, nssn)) {
 		if (iwl_mvm_is_sn_less(buffer->head_sn, nssn,
 				       buffer->buf_size) &&
-		   (!amsdu || last_subframe))
+		   (!amsdu || last_subframe)) {
+			/*
+			 * If we crossed the 2048 or 0 SN, notify all the
+			 * queues. This is done in order to avoid having a
+			 * head_sn that lags behind for too long. When that
+			 * happens, we can get to a situation where the head_sn
+			 * is within the interval [nssn - buf_size : nssn]
+			 * which will make us think that the nssn is a packet
+			 * that we already freed because of the reordering
+			 * buffer and we will ignore it. So maintain the
+			 * head_sn somewhat updated across all the queues:
+			 * when it crosses 0 and 2048.
+			 */
+			if (sn == 2048 || sn == 0)
+				iwl_mvm_sync_nssn(mvm, baid, sn);
 			buffer->head_sn = nssn;
+		}
 		/* No need to update AMSDU last SN - we are moving the head */
 		spin_unlock_bh(&buffer->lock);
 		return false;
@@ -877,8 +913,11 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	 * while technically there is no hole and we can move forward.
 	 */
 	if (!buffer->num_stored && sn == buffer->head_sn) {
-		if (!amsdu || last_subframe)
+		if (!amsdu || last_subframe) {
+			if (sn == 2048 || sn == 0)
+				iwl_mvm_sync_nssn(mvm, baid, sn);
 			buffer->head_sn = ieee80211_sn_inc(buffer->head_sn);
+		}
 		/* No need to update AMSDU last SN - we are moving the head */
 		spin_unlock_bh(&buffer->lock);
 		return false;
@@ -923,7 +962,8 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	 * release notification with up to date NSSN.
 	 */
 	if (!amsdu || last_subframe)
-		iwl_mvm_release_frames(mvm, sta, napi, baid_data, buffer, nssn);
+		iwl_mvm_release_frames(mvm, sta, napi, baid_data,
+				       buffer, nssn, true);
 
 	spin_unlock_bh(&buffer->lock);
 	return true;
-- 
2.20.1

