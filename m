Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931AFA62B6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 09:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfICHhz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 03:37:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40328 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725888AbfICHhz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 03:37:55 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i53Ne-0004Cd-B6; Tue, 03 Sep 2019 10:37:35 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  3 Sep 2019 10:37:05 +0300
Message-Id: <20190903073714.32278-13-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903073714.32278-1-luca@coelho.fi>
References: <20190903073714.32278-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 12/21] iwlwifi: mvm: drop BA sessions on too many old-SN frames
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Certain APs (I think a certain Broadcom model) interact badly with our
full state BA bitmap handling, and if triggered badly with many powersave
transitions they keep sending frames from before the window, which our
hardware then doesn't appear to ACK (to them) since it has moved on and
is sending ACKs for higher SNs now.

Try to detect this situation and if this keeps happening, disable the
aggregation session.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/constants.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  9 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 53 +++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 915b172da57a..60aff2ecec12 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -153,5 +153,6 @@
 #define IWL_MVM_FTM_INITIATOR_DYNACK		true
 #define IWL_MVM_D3_DEBUG			false
 #define IWL_MVM_USE_TWT				false
+#define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	10
 
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2540d7ffbbc1..b8a8369457b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -661,6 +661,12 @@ struct iwl_mvm_tcm {
  * @valid: reordering is valid for this queue
  * @lock: protect reorder buffer internal state
  * @mvm: mvm pointer, needed for frame timer context
+ * @consec_oldsn_drops: consecutive drops due to old SN
+ * @consec_oldsn_ampdu_gp2: A-MPDU GP2 timestamp to track
+ *	when to apply old SN consecutive drop workaround
+ * @consec_oldsn_prev_drop: track whether or not an MPDU
+ *	that was single/part of the previous A-MPDU was
+ *	dropped due to old SN
  */
 struct iwl_mvm_reorder_buffer {
 	u16 head_sn;
@@ -674,6 +680,9 @@ struct iwl_mvm_reorder_buffer {
 	bool valid;
 	spinlock_t lock;
 	struct iwl_mvm *mvm;
+	unsigned int consec_oldsn_drops;
+	u32 consec_oldsn_ampdu_gp2;
+	unsigned int consec_oldsn_prev_drop:1;
 } ____cacheline_aligned_in_smp;
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 25d038092eec..f3f9e641ae70 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -781,6 +781,55 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 		wake_up(&mvm->rx_sync_waitq);
 }
 
+static void iwl_mvm_oldsn_workaround(struct iwl_mvm *mvm,
+				     struct ieee80211_sta *sta, int tid,
+				     struct iwl_mvm_reorder_buffer *buffer,
+				     u32 reorder, u32 gp2, int queue)
+{
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
+	if (gp2 != buffer->consec_oldsn_ampdu_gp2) {
+		/* we have a new (A-)MPDU ... */
+
+		/*
+		 * reset counter to 0 if we didn't have any oldsn in
+		 * the last A-MPDU (as detected by GP2 being identical)
+		 */
+		if (!buffer->consec_oldsn_prev_drop)
+			buffer->consec_oldsn_drops = 0;
+
+		/* either way, update our tracking state */
+		buffer->consec_oldsn_ampdu_gp2 = gp2;
+	} else if (buffer->consec_oldsn_prev_drop) {
+		/*
+		 * tracking state didn't change, and we had an old SN
+		 * indication before - do nothing in this case, we
+		 * already noted this one down and are waiting for the
+		 * next A-MPDU (by GP2)
+		 */
+		return;
+	}
+
+	/* return unless this MPDU has old SN */
+	if (!(reorder & IWL_RX_MPDU_REORDER_BA_OLD_SN))
+		return;
+
+	/* update state */
+	buffer->consec_oldsn_prev_drop = 1;
+	buffer->consec_oldsn_drops++;
+
+	/* if limit is reached, send del BA and reset state */
+	if (buffer->consec_oldsn_drops == IWL_MVM_AMPDU_CONSEC_DROPS_DELBA) {
+		IWL_WARN(mvm,
+			 "reached %d old SN frames from %pM on queue %d, stopping BA session on TID %d\n",
+			 IWL_MVM_AMPDU_CONSEC_DROPS_DELBA,
+			 sta->addr, queue, tid);
+		ieee80211_stop_rx_ba_session(mvmsta->vif, BIT(tid), sta->addr);
+		buffer->consec_oldsn_prev_drop = 0;
+		buffer->consec_oldsn_drops = 0;
+	}
+}
+
 /*
  * Returns true if the MPDU was buffered\dropped, false if it should be passed
  * to upper layer.
@@ -792,6 +841,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 			    struct sk_buff *skb,
 			    struct iwl_rx_mpdu_desc *desc)
 {
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = iwl_mvm_skb_get_hdr(skb);
 	struct iwl_mvm_sta *mvm_sta;
 	struct iwl_mvm_baid_data *baid_data;
@@ -894,6 +944,9 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 				       min_sn, IWL_MVM_RELEASE_SEND_RSS_SYNC);
 	}
 
+	iwl_mvm_oldsn_workaround(mvm, sta, tid, buffer, reorder,
+				 rx_status->device_timestamp, queue);
+
 	/* drop any oudated packets */
 	if (ieee80211_sn_less(sn, buffer->head_sn))
 		goto drop;
-- 
2.23.0.rc1

