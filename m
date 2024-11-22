Return-Path: <linux-wireless+bounces-15603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34289D628B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 17:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA01160E88
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4D11DED78;
	Fri, 22 Nov 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="0K0d+aqR";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="R59vyxUu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF95D477
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294188; cv=none; b=et4zUR58oE7+goAgMnlK0ulIOWVuH0Pk6hb/FJEtaDZsDYnGK8/0jM6aM/vcD5VvwRgbNxxqb9j660TpqwzfV0+AzEyXyIWwxzh2+eDeLCFXh8Naro9WnM/+NXsrtl7lX+YVaPX+NCV9zuMZW0QV96I/pCj7VUmQ8wLxJVpAFnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294188; c=relaxed/simple;
	bh=Zvcu5IVZTFMSBYHrm2FKiwsj+A2VsshdC2zeg1vCgzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3bMNrLNyptudBgVotzZN3LB6m/amWfkGArOmbgopfIAwvqqwp4YgTZxS9+zMktKupmyfNrcMDosDR2WjLc14Qc1o+ZNGpna4Z2Wx42SdeoJO+D/aaW9jsGni5f0AmpqksLYJT2ZSxtduHsvg9IxUU95Pqs8mHrfspbsstEgcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=0K0d+aqR reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=R59vyxUu; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732295085; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=VU7yyzm4vBwdip1dBLsGRd5MJn1hCw2dZHCEfwLlKhE=; b=0K0d+aqRbXspqlK0NkN1Kp9TK+
	MgK1ttzOrKwUfLEVZ2iI39R4ExTJpNyFW80PiCX1rV15+1qVO3EpgjgIsOOMJ/JL/G6EQqWiCIWF2
	kXpHzDbU58wz7vWwyMbgcgOaPTXXUtYWvVzmfbCTu5/00meAH87Yg+vzUilGMk2MkWK3C/l/B0Rv1
	LDOF1u01Mv2GkiUdQSKOkJiaH/eaU47deJniae+SaGqHIQKJrL366sJ02gcy+wU4czhfzysoM38vI
	mcmUiy2Lgb34S1qZ0dlPOL6JMreYqDlDQvS/krRR6gl30JYC2A+xMkICxQhsH+/eTrJTXx20kFsdz
	4oSNoOHw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732294185; h=from : subject
 : to : message-id : date;
 bh=VU7yyzm4vBwdip1dBLsGRd5MJn1hCw2dZHCEfwLlKhE=;
 b=R59vyxUud4gB9SqtJR6PetElXucLnbbd1zNG+AqAe/tMmE6V+PNpy5Idp8XUX/1yACrgl
 QYW2eGQey3Ns6NyJ9iSUUgkC41tKBXF/m5cbG/dQqDN/pcuVWPBiEWuM0Iwz2YZZPZgO1lv
 eEZtcKpo4Ktys0G89IabZ7BAKVTEqkvQU9v9JDOAkCkGN5/fI2uW4KGWN6xULt30YXMur7I
 UQhsy2SQB9JgDdxl1XHJJoSEIWUf0f88InqhfWXDuU6VXmtVCvdqbDGQ6RorCQ+OKEYYxQr
 vitHTZeR12K/NB1Vi70rPVmX28UpfqoiZsdwPcjV669QtdAgfDXF+/XrKr8Q==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEWqU-TRjyNW-1X; Fri, 22 Nov 2024 16:49:26 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEWqT-4o5NDgrgcgU-nS39; Fri, 22 Nov 2024 16:49:25 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RESEND PATCH v3 2/2] wifi: ath10k: Flush only requested txq in
 ath10k_flush()
Date: Fri, 22 Nov 2024 17:48:02 +0100
Message-Id: <01d859e8e574a1f5d0b916333fe0b5cda859af9b.1732293922.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1732293922.git.repk@triplefau.lt>
References: <cover.1732293922.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: bIL3tTx_h-hr.2eBdm3H1LOjg.4iaXGwzpAZS
Feedback-ID: 510616m:510616apGKSTK:510616sEnxp3C9dm
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

The ieee80211 flush callback can be called to flush only part of all hw
queues. The ath10k's flush callback implementation (i.e. ath10k_flush())
was waiting for all pending frames of all queues to be flushed ignoring
the queue parameter. Because only the queues to be flushed are stopped
by mac80211, skb can still be queued to other queues meanwhile. Thus
ath10k_flush() could fail (and wait 5sec holding ar->conf lock) even if
the requested queues are flushed correctly.

A way to reproduce the issue is to use two different APs because
each vdev has its own hw queue in ath10k. Connect STA0 to AP0 and STA1
to AP1. Then generate traffic from AP0 to STA0 and kill STA0 without
clean disassociation frame (e.g. unplug power cable, reboot -f, ...).
Now if we were to flush AP1's queue, ath10k_flush() would fail (and
effectively block 5 seconds with ar->conf or even wiphy's lock held)
with the following warning:

 ath10k_pci 0000:01:00.0: failed to flush transmit queue (skip 0 ar-state 2): 0

Wait only for pending frames of the requested queues to be flushed in
ath10k_flush() to avoid that long blocking.

Reported-by: Cedric Veilleux <veilleux.cedric@gmail.com>
Closes: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 drivers/net/wireless/ath/ath10k/htt.h    |  7 +++--
 drivers/net/wireless/ath/ath10k/htt_tx.c | 18 ++++++++++--
 drivers/net/wireless/ath/ath10k/mac.c    | 35 ++++++++++++++++--------
 drivers/net/wireless/ath/ath10k/txrx.c   |  2 +-
 4 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index d150f9330941..ca8bf3b6766d 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -1870,6 +1870,7 @@ struct ath10k_htt {
 	spinlock_t tx_lock;
 	int max_num_pending_tx;
 	int num_pending_tx;
+	int num_pending_per_queue[IEEE80211_MAX_QUEUES];
 	int num_pending_mgmt_tx;
 	struct idr pending_tx;
 	wait_queue_head_t empty_tx_wq;
@@ -2447,8 +2448,10 @@ void ath10k_htt_tx_txq_update(struct ieee80211_hw *hw,
 void ath10k_htt_tx_txq_recalc(struct ieee80211_hw *hw,
 			      struct ieee80211_txq *txq);
 void ath10k_htt_tx_txq_sync(struct ath10k *ar);
-void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt);
-int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt);
+void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt,
+			       struct ieee80211_txq *txq);
+int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt,
+			      struct ieee80211_txq *txq);
 void ath10k_htt_tx_mgmt_dec_pending(struct ath10k_htt *htt);
 int ath10k_htt_tx_mgmt_inc_pending(struct ath10k_htt *htt, bool is_mgmt,
 				   bool is_presp);
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 211752bd0f65..ef5a992e8cce 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -140,19 +140,26 @@ void ath10k_htt_tx_txq_update(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->htt.tx_lock);
 }
 
-void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
+void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt,
+			       struct ieee80211_txq *txq)
 {
+	int qnr = -1;
+
 	lockdep_assert_held(&htt->tx_lock);
 
 	htt->num_pending_tx--;
 	if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
 		ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
 
-	if (htt->num_pending_tx == 0)
+	if (txq)
+		qnr = --htt->num_pending_per_queue[txq->vif->hw_queue[txq->ac]];
+
+	if (htt->num_pending_tx == 0 || qnr == 0)
 		wake_up(&htt->empty_tx_wq);
 }
 
-int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
+int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt,
+			      struct ieee80211_txq *txq)
 {
 	lockdep_assert_held(&htt->tx_lock);
 
@@ -163,6 +170,11 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
 	if (htt->num_pending_tx == htt->max_num_pending_tx)
 		ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
 
+	if (!txq)
+		return 0;
+
+	htt->num_pending_per_queue[txq->vif->hw_queue[txq->ac]]++;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 8b8d4f24e5fb..7c5f95f2858f 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4385,7 +4385,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 	u16 airtime;
 
 	spin_lock_bh(&ar->htt.tx_lock);
-	ret = ath10k_htt_tx_inc_pending(htt);
+	ret = ath10k_htt_tx_inc_pending(htt, txq);
 	spin_unlock_bh(&ar->htt.tx_lock);
 
 	if (ret)
@@ -4394,7 +4394,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 	skb = ieee80211_tx_dequeue_ni(hw, txq);
 	if (!skb) {
 		spin_lock_bh(&ar->htt.tx_lock);
-		ath10k_htt_tx_dec_pending(htt);
+		ath10k_htt_tx_dec_pending(htt, txq);
 		spin_unlock_bh(&ar->htt.tx_lock);
 
 		return -ENOENT;
@@ -4416,7 +4416,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 		ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_mgmt, is_presp);
 
 		if (ret) {
-			ath10k_htt_tx_dec_pending(htt);
+			ath10k_htt_tx_dec_pending(htt, txq);
 			spin_unlock_bh(&ar->htt.tx_lock);
 			return ret;
 		}
@@ -4430,7 +4430,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 		ath10k_warn(ar, "failed to push frame: %d\n", ret);
 
 		spin_lock_bh(&ar->htt.tx_lock);
-		ath10k_htt_tx_dec_pending(htt);
+		ath10k_htt_tx_dec_pending(htt, txq);
 		if (is_mgmt)
 			ath10k_htt_tx_mgmt_dec_pending(htt);
 		spin_unlock_bh(&ar->htt.tx_lock);
@@ -4693,7 +4693,7 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 			is_presp = ieee80211_is_probe_resp(hdr->frame_control);
 		}
 
-		ret = ath10k_htt_tx_inc_pending(htt);
+		ret = ath10k_htt_tx_inc_pending(htt, txq);
 		if (ret) {
 			ath10k_warn(ar, "failed to increase tx pending count: %d, dropping\n",
 				    ret);
@@ -4706,7 +4706,7 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 		if (ret) {
 			ath10k_dbg(ar, ATH10K_DBG_MAC, "failed to increase tx mgmt pending count: %d, dropping\n",
 				   ret);
-			ath10k_htt_tx_dec_pending(htt);
+			ath10k_htt_tx_dec_pending(htt, txq);
 			spin_unlock_bh(&ar->htt.tx_lock);
 			ieee80211_free_txskb(ar->hw, skb);
 			return;
@@ -4719,7 +4719,7 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 		ath10k_warn(ar, "failed to transmit frame: %d\n", ret);
 		if (is_htt) {
 			spin_lock_bh(&ar->htt.tx_lock);
-			ath10k_htt_tx_dec_pending(htt);
+			ath10k_htt_tx_dec_pending(htt, txq);
 			if (is_mgmt)
 				ath10k_htt_tx_mgmt_dec_pending(htt);
 			spin_unlock_bh(&ar->htt.tx_lock);
@@ -8059,10 +8059,12 @@ static int ath10k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 	return -EOPNOTSUPP;
 }
 
-void ath10k_mac_wait_tx_complete(struct ath10k *ar)
+static void _ath10k_mac_wait_tx_complete(struct ath10k *ar,
+					 unsigned long queues)
 {
 	bool skip;
 	long time_left;
+	unsigned int q;
 
 	/* mac80211 doesn't care if we really xmit queued frames or not
 	 * we'll collect those frames either way if we stop/delete vdevs
@@ -8072,10 +8074,14 @@ void ath10k_mac_wait_tx_complete(struct ath10k *ar)
 		return;
 
 	time_left = wait_event_timeout(ar->htt.empty_tx_wq, ({
-			bool empty;
+			bool empty = true;
 
 			spin_lock_bh(&ar->htt.tx_lock);
-			empty = (ar->htt.num_pending_tx == 0);
+			for_each_set_bit(q, &queues, ar->hw->queues) {
+				empty = (ar->htt.num_pending_per_queue[q] == 0);
+				if (!empty)
+					break;
+			}
 			spin_unlock_bh(&ar->htt.tx_lock);
 
 			skip = (ar->state == ATH10K_STATE_WEDGED) ||
@@ -8090,6 +8096,13 @@ void ath10k_mac_wait_tx_complete(struct ath10k *ar)
 			    skip, ar->state, time_left);
 }
 
+void ath10k_mac_wait_tx_complete(struct ath10k *ar)
+{
+	unsigned int queues = GENMASK(ar->hw->queues - 1, 0);
+
+	_ath10k_mac_wait_tx_complete(ar, queues);
+}
+
 static void ath10k_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 u32 queues, bool drop)
 {
@@ -8111,7 +8124,7 @@ static void ath10k_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	mutex_lock(&ar->conf_mutex);
-	ath10k_mac_wait_tx_complete(ar);
+	_ath10k_mac_wait_tx_complete(ar, queues);
 	mutex_unlock(&ar->conf_mutex);
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 5b6750ef7d19..b848962fc8fb 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -82,7 +82,7 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 
 	flags = skb_cb->flags;
 	ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
-	ath10k_htt_tx_dec_pending(htt);
+	ath10k_htt_tx_dec_pending(htt, txq);
 	spin_unlock_bh(&htt->tx_lock);
 
 	rcu_read_lock();
-- 
2.40.0


