Return-Path: <linux-wireless+bounces-16076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0619E9AF7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51733188398C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CAC132C38;
	Mon,  9 Dec 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="aRAdhc3k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002F233139
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759798; cv=none; b=BQhhpjN/jBeeYnL29zgdATsZjIW/IIqdtjnBdxtAscJ5pTh+qISomcafeqRO3J3BuTsdAXotHCsYiwdlSk2jmYkuaIc9roGAJ13pheZJePSm5Q7JDH+8gVyp9pu9ElI+rDj0HUZ12SsZ/Qq447NzAGY3B+RCbw1BG25ArJwhPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759798; c=relaxed/simple;
	bh=jjycQAdQ6ZuSn6Tq7EJUzVvFu9vWk3cSZUlkapgJeN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVT0llWxh4qrSoUSymn7+hA5pkUBvot9FXOmo9BlrG0u2QyRvGdAHgXeJavJVtNn4WZwDQ01nBAmCxCwkveWmpirhm62K5+haVHqU176XeCDtsRVfZ6Hha00+jUeFtgSMDZbd8wC7tlb4pCKfIexpPRy7KhbGGoH3iOfvsOT/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=aRAdhc3k; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id 45AE263517
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:51:13 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:694a:0:640:6efd:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 8D044608F2;
	Mon,  9 Dec 2024 18:51:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3pnjm14OceA0-yQ5CFriM;
	Mon, 09 Dec 2024 18:51:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733759464; bh=j/8qOWgO+A4Uli7MnoLmn9fkCT3yThkYUI//C3ZllO4=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=aRAdhc3klyRkWG9co7EaIv1qDI/nOwldWCuLdHrFQZazmq17ZGmozu+o/XKmtg6SN
	 KYLuw9egZ6xMIOCXPkVusCIqy+2uiuw3Zsm9jTC6fzId2Dt86UK+lolpJZHK97qMyT
	 GxvTdZdY1t4wbTJpNJ2u8BiyQoBtDgSLeiWIlGyM=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/3] wifi: ath9k: cleanup a few (mostly) TX-related routines
Date: Mon,  9 Dec 2024 18:50:26 +0300
Message-ID: <20241209155027.636400-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209155027.636400-1-dmantipov@yandex.ru>
References: <20241209155027.636400-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused 'struct ath_softc *' argument of 'ath_pkt_duration()',
'ath_tx_update_baw()', 'ath_get_skb_tid()', 'ath_tx_addto_baw()' and
'ath_tx_count_frames()', adjust related users. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/ath9k.h |  4 +--
 drivers/net/wireless/ath/ath9k/recv.c  |  4 +--
 drivers/net/wireless/ath/ath9k/xmit.c  | 40 ++++++++++++--------------
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 29ca65a732a6..f68b96809ffa 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -592,8 +592,8 @@ void ath_txq_schedule_all(struct ath_softc *sc);
 int ath_tx_init(struct ath_softc *sc, int nbufs);
 int ath_txq_update(struct ath_softc *sc, int qnum,
 		   struct ath9k_tx_queue_info *q);
-u32 ath_pkt_duration(struct ath_softc *sc, u8 rix, int pktlen,
-		     int width, int half_gi, bool shortPreamble);
+u32 ath_pkt_duration(u8 rix, int pktlen, int width,
+		     int half_gi, bool shortPreamble);
 void ath_update_max_aggr_framelen(struct ath_softc *sc, int queue, int txop);
 void ath_assign_seq(struct ath_common *common, struct sk_buff *skb);
 int ath_tx_start(struct ieee80211_hw *hw, struct sk_buff *skb,
diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
index 0c0624a3b40d..34c74ed99b7b 100644
--- a/drivers/net/wireless/ath/ath9k/recv.c
+++ b/drivers/net/wireless/ath/ath9k/recv.c
@@ -1042,8 +1042,8 @@ static void ath_rx_count_airtime(struct ath_softc *sc,
 	if (!!(rxs->encoding == RX_ENC_HT)) {
 		/* MCS rates */
 
-		airtime += ath_pkt_duration(sc, rxs->rate_idx, len,
-					is_40, is_sgi, is_sp);
+		airtime += ath_pkt_duration(rxs->rate_idx, len,
+					    is_40, is_sgi, is_sp);
 	} else {
 
 		phy = IS_CCK_RATE(rs->rs_rate) ? WLAN_RC_PHY_CCK : WLAN_RC_PHY_OFDM;
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index fae96e3d66dd..8242139051ef 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -67,8 +67,7 @@ static void ath_tx_txqaddbuf(struct ath_softc *sc, struct ath_txq *txq,
 static void ath_tx_rc_status(struct ath_softc *sc, struct ath_buf *bf,
 			     struct ath_tx_status *ts, int nframes, int nbad,
 			     int txok);
-static void ath_tx_update_baw(struct ath_softc *sc, struct ath_atx_tid *tid,
-			      struct ath_buf *bf);
+static void ath_tx_update_baw(struct ath_atx_tid *tid, struct ath_buf *bf);
 static struct ath_buf *ath_tx_setup_buffer(struct ath_softc *sc,
 					   struct ath_txq *txq,
 					   struct ath_atx_tid *tid,
@@ -224,7 +223,7 @@ static void ath_txq_skb_done(struct ath_softc *sc, struct sk_buff *skb)
 }
 
 static struct ath_atx_tid *
-ath_get_skb_tid(struct ath_softc *sc, struct ath_node *an, struct sk_buff *skb)
+ath_get_skb_tid(struct ath_node *an, struct sk_buff *skb)
 {
 	u8 tidno = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 	return ATH_AN_2_TID(an, tidno);
@@ -300,7 +299,7 @@ static void ath_tx_flush_tid(struct ath_softc *sc, struct ath_atx_tid *tid)
 		}
 
 		if (fi->baw_tracked) {
-			ath_tx_update_baw(sc, tid, bf);
+			ath_tx_update_baw(tid, bf);
 			sendbar = true;
 		}
 
@@ -315,8 +314,7 @@ static void ath_tx_flush_tid(struct ath_softc *sc, struct ath_atx_tid *tid)
 	}
 }
 
-static void ath_tx_update_baw(struct ath_softc *sc, struct ath_atx_tid *tid,
-			      struct ath_buf *bf)
+static void ath_tx_update_baw(struct ath_atx_tid *tid, struct ath_buf *bf)
 {
 	struct ath_frame_info *fi = get_frame_info(bf->bf_mpdu);
 	u16 seqno = bf->bf_state.seqno;
@@ -338,8 +336,7 @@ static void ath_tx_update_baw(struct ath_softc *sc, struct ath_atx_tid *tid,
 	}
 }
 
-static void ath_tx_addto_baw(struct ath_softc *sc, struct ath_atx_tid *tid,
-			     struct ath_buf *bf)
+static void ath_tx_addto_baw(struct ath_atx_tid *tid, struct ath_buf *bf)
 {
 	struct ath_frame_info *fi = get_frame_info(bf->bf_mpdu);
 	u16 seqno = bf->bf_state.seqno;
@@ -452,9 +449,8 @@ static struct ath_buf* ath_clone_txbuf(struct ath_softc *sc, struct ath_buf *bf)
 	return tbf;
 }
 
-static void ath_tx_count_frames(struct ath_softc *sc, struct ath_buf *bf,
-			        struct ath_tx_status *ts, int txok,
-			        int *nframes, int *nbad)
+static void ath_tx_count_frames(struct ath_buf *bf, struct ath_tx_status *ts,
+				int txok, int *nframes, int *nbad)
 {
 	u16 seq_st = 0;
 	u32 ba[WME_BA_BMP_SIZE >> 5];
@@ -568,7 +564,7 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 
 	__skb_queue_head_init(&bf_pending);
 
-	ath_tx_count_frames(sc, bf, ts, txok, &nframes, &nbad);
+	ath_tx_count_frames(bf, ts, txok, &nframes, &nbad);
 	while (bf) {
 		u16 seqno = bf->bf_state.seqno;
 
@@ -621,7 +617,7 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 			 * complete the acked-ones/xretried ones; update
 			 * block-ack window
 			 */
-			ath_tx_update_baw(sc, tid, bf);
+			ath_tx_update_baw(tid, bf);
 
 			if (rc_update && (acked_cnt == 1 || txfail_cnt == 1)) {
 				memcpy(tx_info->control.rates, rates, sizeof(rates));
@@ -651,7 +647,7 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 				 * run out of tx buf.
 				 */
 				if (!tbf) {
-					ath_tx_update_baw(sc, tid, bf);
+					ath_tx_update_baw(tid, bf);
 
 					ath_tx_complete_buf(sc, bf, txq,
 							    &bf_head, NULL, ts,
@@ -752,7 +748,7 @@ static void ath_tx_process_buffer(struct ath_softc *sc, struct ath_txq *txq,
 	sta = ieee80211_find_sta_by_ifaddr(hw, hdr->addr1, hdr->addr2);
 	if (sta) {
 		struct ath_node *an = (struct ath_node *)sta->drv_priv;
-		tid = ath_get_skb_tid(sc, an, bf->bf_mpdu);
+		tid = ath_get_skb_tid(an, bf->bf_mpdu);
 		ath_tx_count_airtime(sc, sta, bf, ts, tid->tidno);
 		if (ts->ts_status & (ATH9K_TXERR_FILT | ATH9K_TXERR_XRETRY))
 			tid->clear_ps_filter = true;
@@ -1012,13 +1008,13 @@ ath_tx_get_tid_subframe(struct ath_softc *sc, struct ath_txq *txq,
 
 			INIT_LIST_HEAD(&bf_head);
 			list_add(&bf->list, &bf_head);
-			ath_tx_update_baw(sc, tid, bf);
+			ath_tx_update_baw(tid, bf);
 			ath_tx_complete_buf(sc, bf, txq, &bf_head, NULL, &ts, 0);
 			continue;
 		}
 
 		if (bf_isampdu(bf))
-			ath_tx_addto_baw(sc, tid, bf);
+			ath_tx_addto_baw(tid, bf);
 
 		break;
 	}
@@ -1114,8 +1110,8 @@ ath_tx_form_aggr(struct ath_softc *sc, struct ath_txq *txq,
  * width  - 0 for 20 MHz, 1 for 40 MHz
  * half_gi - to use 4us v/s 3.6 us for symbol time
  */
-u32 ath_pkt_duration(struct ath_softc *sc, u8 rix, int pktlen,
-		     int width, int half_gi, bool shortPreamble)
+u32 ath_pkt_duration(u8 rix, int pktlen, int width,
+		     int half_gi, bool shortPreamble)
 {
 	u32 nbits, nsymbits, duration, nsymbols;
 	int streams;
@@ -1327,7 +1323,7 @@ static void ath_buf_set_rate(struct ath_softc *sc, struct ath_buf *bf,
 			info->rates[i].Rate = rix | 0x80;
 			info->rates[i].ChSel = ath_txchainmask_reduction(sc,
 					ah->txchainmask, info->rates[i].Rate);
-			info->rates[i].PktDuration = ath_pkt_duration(sc, rix, len,
+			info->rates[i].PktDuration = ath_pkt_duration(rix, len,
 				 is_40, is_sgi, is_sp);
 			if (rix < 8 && (tx_info->flags & IEEE80211_TX_CTL_STBC))
 				info->rates[i].RateFlags |= ATH9K_RATESERIES_STBC;
@@ -2122,7 +2118,7 @@ static void ath_tx_send_normal(struct ath_softc *sc, struct ath_txq *txq,
 	bf->bf_state.bf_type = 0;
 	if (tid && (tx_info->flags & IEEE80211_TX_CTL_AMPDU)) {
 		bf->bf_state.bf_type = BUF_AMPDU;
-		ath_tx_addto_baw(sc, tid, bf);
+		ath_tx_addto_baw(tid, bf);
 	}
 
 	bf->bf_next = NULL;
@@ -2368,7 +2364,7 @@ int ath_tx_start(struct ieee80211_hw *hw, struct sk_buff *skb,
 
 	if (txctl->sta) {
 		an = (struct ath_node *) sta->drv_priv;
-		tid = ath_get_skb_tid(sc, an, skb);
+		tid = ath_get_skb_tid(an, skb);
 	}
 
 	ath_txq_lock(sc, txq);
-- 
2.47.1


