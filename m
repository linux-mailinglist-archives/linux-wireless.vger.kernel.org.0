Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DDB7CBEC7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbjJQJRh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJQJRd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64824F1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534249; x=1729070249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7DE9Bcz9MgqCD0AIzbfHFr2IaJsGOLWj3xXveC7HiAg=;
  b=Xe24JmSImUM36iJ99rrSsScBBf6OCm0NT450aJmoPajgNqJBngyvc7t2
   06k/tSP9scMsJJMM2BFSmPFju3+zqcowLHr2asAsBXgvvJZ8bjXs9Xdeb
   cAps099hZTM9AjJZEF8p6XExbaKMJFujvJ0FA/DnHNox2wrY9IrtDUXRC
   EVym2P27Nikw6Hhe2oTE6ZauzH4fz2Eg4xEahQorKaJRT/uXmSRQ+lo97
   C5Dr6pZFD0Vl/FseqK9sDg3mHSLjcoLH0mTTheJKY43i470h7Vdb+ugdw
   3ZQBsZJlYvAWL8AprO4JlaDfDcalQV/FlCVWNre5LdCwpw12C6W1lhm+J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808562"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808562"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731960"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731960"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:27 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/14] wifi: iwlwifi: mvm: simplify the reorder buffer
Date:   Tue, 17 Oct 2023 12:16:47 +0300
Message-Id: <20231017115047.54cf4d3d5956.Ic06a08c9fb1e1ec315a4b49d632b78b8474dab79@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware / hardware of devices supporting RSS is able to report
duplicates and packets that time out inside the reoder buffer. We can
now remove all the complex logic that was implemented to keep all the Rx
queues more the less synchronized: we used to send a message to all the
queues through the firmware to teach the different queues about what is
the current SSN every 2048 packets.

Now that we rely on the firmware / hardware to detect duplicates, we can
completely remove the code that did that in the driver and it has been
reported that this code was spuriously dropping legit packets.

Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 313 +-----------------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   7 -
 4 files changed, 24 insertions(+), 342 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 385bbeca4796..81f7b0a644f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -647,18 +647,9 @@ struct iwl_mvm_tcm {
  * @queue: queue of this reorder buffer
  * @last_amsdu: track last ASMDU SN for duplication detection
  * @last_sub_index: track ASMDU sub frame index for duplication detection
- * @reorder_timer: timer for frames are in the reorder buffer. For AMSDU
- *	it is the time of last received sub-frame
- * @removed: prevent timer re-arming
  * @valid: reordering is valid for this queue
  * @lock: protect reorder buffer internal state
  * @mvm: mvm pointer, needed for frame timer context
- * @consec_oldsn_drops: consecutive drops due to old SN
- * @consec_oldsn_ampdu_gp2: A-MPDU GP2 timestamp to track
- *	when to apply old SN consecutive drop workaround
- * @consec_oldsn_prev_drop: track whether or not an MPDU
- *	that was single/part of the previous A-MPDU was
- *	dropped due to old SN
  */
 struct iwl_mvm_reorder_buffer {
 	u16 head_sn;
@@ -667,33 +658,21 @@ struct iwl_mvm_reorder_buffer {
 	int queue;
 	u16 last_amsdu;
 	u8 last_sub_index;
-	struct timer_list reorder_timer;
-	bool removed;
 	bool valid;
 	spinlock_t lock;
 	struct iwl_mvm *mvm;
-	unsigned int consec_oldsn_drops;
-	u32 consec_oldsn_ampdu_gp2;
-	unsigned int consec_oldsn_prev_drop:1;
 } ____cacheline_aligned_in_smp;
 
 /**
- * struct _iwl_mvm_reorder_buf_entry - reorder buffer entry per-queue/per-seqno
+ * struct iwl_mvm_reorder_buf_entry - reorder buffer entry per-queue/per-seqno
  * @frames: list of skbs stored
- * @reorder_time: time the packet was stored in the reorder buffer
  */
-struct _iwl_mvm_reorder_buf_entry {
-	struct sk_buff_head frames;
-	unsigned long reorder_time;
-};
-
-/* make this indirection to get the aligned thing */
 struct iwl_mvm_reorder_buf_entry {
-	struct _iwl_mvm_reorder_buf_entry e;
+	struct sk_buff_head frames;
 }
 #ifndef __CHECKER__
 /* sparse doesn't like this construct: "bad integer constant expression" */
-__aligned(roundup_pow_of_two(sizeof(struct _iwl_mvm_reorder_buf_entry)))
+__aligned(roundup_pow_of_two(sizeof(struct sk_buff_head)))
 #endif
 ;
 
@@ -2335,7 +2314,6 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 				     enum iwl_mvm_rxq_notif_type type,
 				     bool sync,
 				     const void *data, u32 size);
-void iwl_mvm_reorder_timer_expired(struct timer_list *t);
 struct ieee80211_vif *iwl_mvm_get_bss_vif(struct iwl_mvm *mvm);
 struct ieee80211_vif *iwl_mvm_get_vif_by_macid(struct iwl_mvm *mvm, u32 macid);
 bool iwl_mvm_is_vif_assoc(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 17c3d00d4d27..886d00098528 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -550,44 +550,12 @@ static bool iwl_mvm_is_dup(struct ieee80211_sta *sta, int queue,
 	return false;
 }
 
-/*
- * Returns true if sn2 - buffer_size < sn1 < sn2.
- * To be used only in order to compare reorder buffer head with NSSN.
- * We fully trust NSSN unless it is behind us due to reorder timeout.
- * Reorder timeout can only bring us up to buffer_size SNs ahead of NSSN.
- */
-static bool iwl_mvm_is_sn_less(u16 sn1, u16 sn2, u16 buffer_size)
-{
-	return ieee80211_sn_less(sn1, sn2) &&
-	       !ieee80211_sn_less(sn1, sn2 - buffer_size);
-}
-
-static void iwl_mvm_sync_nssn(struct iwl_mvm *mvm, u8 baid, u16 nssn)
-{
-	if (IWL_MVM_USE_NSSN_SYNC) {
-		struct iwl_mvm_nssn_sync_data notif = {
-			.baid = baid,
-			.nssn = nssn,
-		};
-
-		iwl_mvm_sync_rx_queues_internal(mvm, IWL_MVM_RXQ_NSSN_SYNC, false,
-						&notif, sizeof(notif));
-	}
-}
-
-#define RX_REORDER_BUF_TIMEOUT_MQ (HZ / 10)
-
-enum iwl_mvm_release_flags {
-	IWL_MVM_RELEASE_SEND_RSS_SYNC = BIT(0),
-	IWL_MVM_RELEASE_FROM_RSS_SYNC = BIT(1),
-};
-
 static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 				   struct ieee80211_sta *sta,
 				   struct napi_struct *napi,
 				   struct iwl_mvm_baid_data *baid_data,
 				   struct iwl_mvm_reorder_buffer *reorder_buf,
-				   u16 nssn, u32 flags)
+				   u16 nssn)
 {
 	struct iwl_mvm_reorder_buf_entry *entries =
 		&baid_data->entries[reorder_buf->queue *
@@ -596,31 +564,12 @@ static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&reorder_buf->lock);
 
-	/*
-	 * We keep the NSSN not too far behind, if we are sync'ing it and it
-	 * is more than 2048 ahead of us, it must be behind us. Discard it.
-	 * This can happen if the queue that hit the 0 / 2048 seqno was lagging
-	 * behind and this queue already processed packets. The next if
-	 * would have caught cases where this queue would have processed less
-	 * than 64 packets, but it may have processed more than 64 packets.
-	 */
-	if ((flags & IWL_MVM_RELEASE_FROM_RSS_SYNC) &&
-	    ieee80211_sn_less(nssn, ssn))
-		goto set_timer;
-
-	/* ignore nssn smaller than head sn - this can happen due to timeout */
-	if (iwl_mvm_is_sn_less(nssn, ssn, reorder_buf->buf_size))
-		goto set_timer;
-
-	while (iwl_mvm_is_sn_less(ssn, nssn, reorder_buf->buf_size)) {
+	while (ieee80211_sn_less(ssn, nssn)) {
 		int index = ssn % reorder_buf->buf_size;
-		struct sk_buff_head *skb_list = &entries[index].e.frames;
+		struct sk_buff_head *skb_list = &entries[index].frames;
 		struct sk_buff *skb;
 
 		ssn = ieee80211_sn_inc(ssn);
-		if ((flags & IWL_MVM_RELEASE_SEND_RSS_SYNC) &&
-		    (ssn == 2048 || ssn == 0))
-			iwl_mvm_sync_nssn(mvm, baid_data->baid, ssn);
 
 		/*
 		 * Empty the list. Will have more than one frame for A-MSDU.
@@ -635,99 +584,6 @@ static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 		}
 	}
 	reorder_buf->head_sn = nssn;
-
-set_timer:
-	if (reorder_buf->num_stored && !reorder_buf->removed) {
-		u16 index = reorder_buf->head_sn % reorder_buf->buf_size;
-
-		while (skb_queue_empty(&entries[index].e.frames))
-			index = (index + 1) % reorder_buf->buf_size;
-		/* modify timer to match next frame's expiration time */
-		mod_timer(&reorder_buf->reorder_timer,
-			  entries[index].e.reorder_time + 1 +
-			  RX_REORDER_BUF_TIMEOUT_MQ);
-	} else {
-		del_timer(&reorder_buf->reorder_timer);
-	}
-}
-
-void iwl_mvm_reorder_timer_expired(struct timer_list *t)
-{
-	struct iwl_mvm_reorder_buffer *buf = from_timer(buf, t, reorder_timer);
-	struct iwl_mvm_baid_data *baid_data =
-		iwl_mvm_baid_data_from_reorder_buf(buf);
-	struct iwl_mvm_reorder_buf_entry *entries =
-		&baid_data->entries[buf->queue * baid_data->entries_per_queue];
-	int i;
-	u16 sn = 0, index = 0;
-	bool expired = false;
-	bool cont = false;
-
-	spin_lock(&buf->lock);
-
-	if (!buf->num_stored || buf->removed) {
-		spin_unlock(&buf->lock);
-		return;
-	}
-
-	for (i = 0; i < buf->buf_size ; i++) {
-		index = (buf->head_sn + i) % buf->buf_size;
-
-		if (skb_queue_empty(&entries[index].e.frames)) {
-			/*
-			 * If there is a hole and the next frame didn't expire
-			 * we want to break and not advance SN
-			 */
-			cont = false;
-			continue;
-		}
-		if (!cont &&
-		    !time_after(jiffies, entries[index].e.reorder_time +
-					 RX_REORDER_BUF_TIMEOUT_MQ))
-			break;
-
-		expired = true;
-		/* continue until next hole after this expired frames */
-		cont = true;
-		sn = ieee80211_sn_add(buf->head_sn, i + 1);
-	}
-
-	if (expired) {
-		struct ieee80211_sta *sta;
-		struct iwl_mvm_sta *mvmsta;
-		u8 sta_id = ffs(baid_data->sta_mask) - 1;
-
-		rcu_read_lock();
-		sta = rcu_dereference(buf->mvm->fw_id_to_mac_id[sta_id]);
-		if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta))) {
-			rcu_read_unlock();
-			goto out;
-		}
-
-		mvmsta = iwl_mvm_sta_from_mac80211(sta);
-
-		/* SN is set to the last expired frame + 1 */
-		IWL_DEBUG_HT(buf->mvm,
-			     "Releasing expired frames for sta %u, sn %d\n",
-			     sta_id, sn);
-		iwl_mvm_event_frame_timeout_callback(buf->mvm, mvmsta->vif,
-						     sta, baid_data->tid);
-		iwl_mvm_release_frames(buf->mvm, sta, NULL, baid_data,
-				       buf, sn, IWL_MVM_RELEASE_SEND_RSS_SYNC);
-		rcu_read_unlock();
-	} else {
-		/*
-		 * If no frame expired and there are stored frames, index is now
-		 * pointing to the first unexpired frame - modify timer
-		 * accordingly to this frame.
-		 */
-		mod_timer(&buf->reorder_timer,
-			  entries[index].e.reorder_time +
-			  1 + RX_REORDER_BUF_TIMEOUT_MQ);
-	}
-
-out:
-	spin_unlock(&buf->lock);
 }
 
 static void iwl_mvm_del_ba(struct iwl_mvm *mvm, int queue,
@@ -760,10 +616,8 @@ static void iwl_mvm_del_ba(struct iwl_mvm *mvm, int queue,
 	spin_lock_bh(&reorder_buf->lock);
 	iwl_mvm_release_frames(mvm, sta, NULL, ba_data, reorder_buf,
 			       ieee80211_sn_add(reorder_buf->head_sn,
-						reorder_buf->buf_size),
-			       0);
+						reorder_buf->buf_size));
 	spin_unlock_bh(&reorder_buf->lock);
-	del_timer_sync(&reorder_buf->reorder_timer);
 
 out:
 	rcu_read_unlock();
@@ -771,8 +625,7 @@ static void iwl_mvm_del_ba(struct iwl_mvm *mvm, int queue,
 
 static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 					      struct napi_struct *napi,
-					      u8 baid, u16 nssn, int queue,
-					      u32 flags)
+					      u8 baid, u16 nssn, int queue)
 {
 	struct ieee80211_sta *sta;
 	struct iwl_mvm_reorder_buffer *reorder_buf;
@@ -790,8 +643,7 @@ static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 
 	ba_data = rcu_dereference(mvm->baid_map[baid]);
 	if (!ba_data) {
-		WARN(!(flags & IWL_MVM_RELEASE_FROM_RSS_SYNC),
-		     "BAID %d not found in map\n", baid);
+		WARN(true, "BAID %d not found in map\n", baid);
 		goto out;
 	}
 
@@ -805,22 +657,13 @@ static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 
 	spin_lock_bh(&reorder_buf->lock);
 	iwl_mvm_release_frames(mvm, sta, napi, ba_data,
-			       reorder_buf, nssn, flags);
+			       reorder_buf, nssn);
 	spin_unlock_bh(&reorder_buf->lock);
 
 out:
 	rcu_read_unlock();
 }
 
-static void iwl_mvm_nssn_sync(struct iwl_mvm *mvm,
-			      struct napi_struct *napi, int queue,
-			      const struct iwl_mvm_nssn_sync_data *data)
-{
-	iwl_mvm_release_frames_from_notif(mvm, napi, data->baid,
-					  data->nssn, queue,
-					  IWL_MVM_RELEASE_FROM_RSS_SYNC);
-}
-
 void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 			    struct iwl_rx_cmd_buffer *rxb, int queue)
 {
@@ -855,14 +698,6 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 			break;
 		iwl_mvm_del_ba(mvm, queue, (void *)internal_notif->data);
 		break;
-	case IWL_MVM_RXQ_NSSN_SYNC:
-		if (WARN_ONCE(len != sizeof(struct iwl_mvm_nssn_sync_data),
-			      "invalid nssn sync notification size %d (%d)",
-			      len, (int)sizeof(struct iwl_mvm_nssn_sync_data)))
-			break;
-		iwl_mvm_nssn_sync(mvm, napi, queue,
-				  (void *)internal_notif->data);
-		break;
 	default:
 		WARN_ONCE(1, "Invalid identifier %d", internal_notif->type);
 	}
@@ -876,55 +711,6 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 }
 
-static void iwl_mvm_oldsn_workaround(struct iwl_mvm *mvm,
-				     struct ieee80211_sta *sta, int tid,
-				     struct iwl_mvm_reorder_buffer *buffer,
-				     u32 reorder, u32 gp2, int queue)
-{
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-
-	if (gp2 != buffer->consec_oldsn_ampdu_gp2) {
-		/* we have a new (A-)MPDU ... */
-
-		/*
-		 * reset counter to 0 if we didn't have any oldsn in
-		 * the last A-MPDU (as detected by GP2 being identical)
-		 */
-		if (!buffer->consec_oldsn_prev_drop)
-			buffer->consec_oldsn_drops = 0;
-
-		/* either way, update our tracking state */
-		buffer->consec_oldsn_ampdu_gp2 = gp2;
-	} else if (buffer->consec_oldsn_prev_drop) {
-		/*
-		 * tracking state didn't change, and we had an old SN
-		 * indication before - do nothing in this case, we
-		 * already noted this one down and are waiting for the
-		 * next A-MPDU (by GP2)
-		 */
-		return;
-	}
-
-	/* return unless this MPDU has old SN */
-	if (!(reorder & IWL_RX_MPDU_REORDER_BA_OLD_SN))
-		return;
-
-	/* update state */
-	buffer->consec_oldsn_prev_drop = 1;
-	buffer->consec_oldsn_drops++;
-
-	/* if limit is reached, send del BA and reset state */
-	if (buffer->consec_oldsn_drops == IWL_MVM_AMPDU_CONSEC_DROPS_DELBA) {
-		IWL_WARN(mvm,
-			 "reached %d old SN frames from %pM on queue %d, stopping BA session on TID %d\n",
-			 IWL_MVM_AMPDU_CONSEC_DROPS_DELBA,
-			 sta->addr, queue, tid);
-		ieee80211_stop_rx_ba_session(mvmsta->vif, BIT(tid), sta->addr);
-		buffer->consec_oldsn_prev_drop = 0;
-		buffer->consec_oldsn_drops = 0;
-	}
-}
-
 /*
  * Returns true if the MPDU was buffered\dropped, false if it should be passed
  * to upper layer.
@@ -936,11 +722,9 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 			    struct sk_buff *skb,
 			    struct iwl_rx_mpdu_desc *desc)
 {
-	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb_mac_header(skb);
 	struct iwl_mvm_baid_data *baid_data;
 	struct iwl_mvm_reorder_buffer *buffer;
-	struct sk_buff *tail;
 	u32 reorder = le32_to_cpu(desc->reorder_data);
 	bool amsdu = desc->mac_flags2 & IWL_RX_MPDU_MFLG2_AMSDU;
 	bool last_subframe =
@@ -1021,59 +805,18 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 		buffer->valid = true;
 	}
 
-	if (ieee80211_is_back_req(hdr->frame_control)) {
-		iwl_mvm_release_frames(mvm, sta, napi, baid_data,
-				       buffer, nssn, 0);
+	/* drop any duplicated packets */
+	if (desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_DUPLICATE))
 		goto drop;
-	}
-
-	/*
-	 * If there was a significant jump in the nssn - adjust.
-	 * If the SN is smaller than the NSSN it might need to first go into
-	 * the reorder buffer, in which case we just release up to it and the
-	 * rest of the function will take care of storing it and releasing up to
-	 * the nssn.
-	 * This should not happen. This queue has been lagging and it should
-	 * have been updated by a IWL_MVM_RXQ_NSSN_SYNC notification. Be nice
-	 * and update the other queues.
-	 */
-	if (!iwl_mvm_is_sn_less(nssn, buffer->head_sn + buffer->buf_size,
-				buffer->buf_size) ||
-	    !ieee80211_sn_less(sn, buffer->head_sn + buffer->buf_size)) {
-		u16 min_sn = ieee80211_sn_less(sn, nssn) ? sn : nssn;
-
-		iwl_mvm_release_frames(mvm, sta, napi, baid_data, buffer,
-				       min_sn, IWL_MVM_RELEASE_SEND_RSS_SYNC);
-	}
-
-	iwl_mvm_oldsn_workaround(mvm, sta, tid, buffer, reorder,
-				 rx_status->device_timestamp, queue);
 
 	/* drop any oudated packets */
-	if (ieee80211_sn_less(sn, buffer->head_sn))
+	if (reorder & IWL_RX_MPDU_REORDER_BA_OLD_SN)
 		goto drop;
 
 	/* release immediately if allowed by nssn and no stored frames */
 	if (!buffer->num_stored && ieee80211_sn_less(sn, nssn)) {
-		if (iwl_mvm_is_sn_less(buffer->head_sn, nssn,
-				       buffer->buf_size) &&
-		   (!amsdu || last_subframe)) {
-			/*
-			 * If we crossed the 2048 or 0 SN, notify all the
-			 * queues. This is done in order to avoid having a
-			 * head_sn that lags behind for too long. When that
-			 * happens, we can get to a situation where the head_sn
-			 * is within the interval [nssn - buf_size : nssn]
-			 * which will make us think that the nssn is a packet
-			 * that we already freed because of the reordering
-			 * buffer and we will ignore it. So maintain the
-			 * head_sn somewhat updated across all the queues:
-			 * when it crosses 0 and 2048.
-			 */
-			if (sn == 2048 || sn == 0)
-				iwl_mvm_sync_nssn(mvm, baid, sn);
+		if (!amsdu || last_subframe)
 			buffer->head_sn = nssn;
-		}
 		/* No need to update AMSDU last SN - we are moving the head */
 		spin_unlock_bh(&buffer->lock);
 		return false;
@@ -1088,37 +831,18 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	 * while technically there is no hole and we can move forward.
 	 */
 	if (!buffer->num_stored && sn == buffer->head_sn) {
-		if (!amsdu || last_subframe) {
-			if (sn == 2048 || sn == 0)
-				iwl_mvm_sync_nssn(mvm, baid, sn);
+		if (!amsdu || last_subframe)
 			buffer->head_sn = ieee80211_sn_inc(buffer->head_sn);
-		}
+
 		/* No need to update AMSDU last SN - we are moving the head */
 		spin_unlock_bh(&buffer->lock);
 		return false;
 	}
 
-	index = sn % buffer->buf_size;
-
-	/*
-	 * Check if we already stored this frame
-	 * As AMSDU is either received or not as whole, logic is simple:
-	 * If we have frames in that position in the buffer and the last frame
-	 * originated from AMSDU had a different SN then it is a retransmission.
-	 * If it is the same SN then if the subframe index is incrementing it
-	 * is the same AMSDU - otherwise it is a retransmission.
-	 */
-	tail = skb_peek_tail(&entries[index].e.frames);
-	if (tail && !amsdu)
-		goto drop;
-	else if (tail && (sn != buffer->last_amsdu ||
-			  buffer->last_sub_index >= sub_frame_idx))
-		goto drop;
-
 	/* put in reorder buffer */
-	__skb_queue_tail(&entries[index].e.frames, skb);
+	index = sn % buffer->buf_size;
+	__skb_queue_tail(&entries[index].frames, skb);
 	buffer->num_stored++;
-	entries[index].e.reorder_time = jiffies;
 
 	if (amsdu) {
 		buffer->last_amsdu = sn;
@@ -1138,8 +862,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	 */
 	if (!amsdu || last_subframe)
 		iwl_mvm_release_frames(mvm, sta, napi, baid_data,
-				       buffer, nssn,
-				       IWL_MVM_RELEASE_SEND_RSS_SYNC);
+				       buffer, nssn);
 
 	spin_unlock_bh(&buffer->lock);
 	return true;
@@ -2771,7 +2494,7 @@ void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	iwl_mvm_release_frames_from_notif(mvm, napi, release->baid,
 					  le16_to_cpu(release->nssn),
-					  queue, 0);
+					  queue);
 }
 
 void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
@@ -2815,7 +2538,7 @@ void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 	IWL_DEBUG_DROP(mvm, "Received a BAR, expect packet loss: nssn %d\n",
 		       nssn);
 
-	iwl_mvm_release_frames_from_notif(mvm, napi, baid, nssn, queue, 0);
+	iwl_mvm_release_frames_from_notif(mvm, napi, baid, nssn, queue);
 out:
 	rcu_read_unlock();
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 9c5ce4c52a05..bba96a968890 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2719,18 +2719,9 @@ static void iwl_mvm_free_reorder(struct iwl_mvm *mvm,
 		WARN_ON(1);
 
 		for (j = 0; j < reorder_buf->buf_size; j++)
-			__skb_queue_purge(&entries[j].e.frames);
-		/*
-		 * Prevent timer re-arm. This prevents a very far fetched case
-		 * where we timed out on the notification. There may be prior
-		 * RX frames pending in the RX queue before the notification
-		 * that might get processed between now and the actual deletion
-		 * and we would re-arm the timer although we are deleting the
-		 * reorder buffer.
-		 */
-		reorder_buf->removed = true;
+			__skb_queue_purge(&entries[j].frames);
+
 		spin_unlock_bh(&reorder_buf->lock);
-		del_timer_sync(&reorder_buf->reorder_timer);
 	}
 }
 
@@ -2750,15 +2741,12 @@ static void iwl_mvm_init_reorder_buffer(struct iwl_mvm *mvm,
 		reorder_buf->num_stored = 0;
 		reorder_buf->head_sn = ssn;
 		reorder_buf->buf_size = buf_size;
-		/* rx reorder timer */
-		timer_setup(&reorder_buf->reorder_timer,
-			    iwl_mvm_reorder_timer_expired, 0);
 		spin_lock_init(&reorder_buf->lock);
 		reorder_buf->mvm = mvm;
 		reorder_buf->queue = i;
 		reorder_buf->valid = false;
 		for (j = 0; j < reorder_buf->buf_size; j++)
-			__skb_queue_head_init(&entries[j].e.frames);
+			__skb_queue_head_init(&entries[j].frames);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 7738fdf1d336..b33a0ce096d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -286,12 +286,10 @@ struct iwl_mvm_key_pn {
  *
  * @IWL_MVM_RXQ_EMPTY: empty sync notification
  * @IWL_MVM_RXQ_NOTIF_DEL_BA: notify RSS queues of delBA
- * @IWL_MVM_RXQ_NSSN_SYNC: notify all the RSS queues with the new NSSN
  */
 enum iwl_mvm_rxq_notif_type {
 	IWL_MVM_RXQ_EMPTY,
 	IWL_MVM_RXQ_NOTIF_DEL_BA,
-	IWL_MVM_RXQ_NSSN_SYNC,
 };
 
 /**
@@ -315,11 +313,6 @@ struct iwl_mvm_delba_data {
 	u32 baid;
 } __packed;
 
-struct iwl_mvm_nssn_sync_data {
-	u32 baid;
-	u32 nssn;
-} __packed;
-
 /**
  * struct iwl_mvm_rxq_dup_data - per station per rx queue data
  * @last_seq: last sequence per tid for duplicate packet detection
-- 
2.38.1

