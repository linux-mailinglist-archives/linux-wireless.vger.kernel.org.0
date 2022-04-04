Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AC84F1A9B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379096AbiDDVSo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380647AbiDDUuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 16:50:09 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE113E9A;
        Mon,  4 Apr 2022 13:48:11 -0700 (PDT)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1649105290; bh=RiAyHNU78+NrUELRbly548BXFw5z7NQdyQvOAmmrXHA=;
        h=From:To:Cc:Subject:Date:From;
        b=ssUleUv1UhL+reEKU8Utjd1ZhfMl3vaYpLHe8AJY5EtGgylhTZfprZK50iWxSoMCC
         j4GxFzyfvHwpHgyiuSP7Oil962QouK91+CmEIubU/mSiua65qinAWReZtBnf40XwCH
         odM4aanlIaZ4micEf3DrdPPT7k2zOz+jEQQE8CQYH9S3YfRLcgB0lVE7FyDhayyqez
         f6cvfnJm1xYuJeFDg7XPpSyf+XiObB7pd1mZ034hSBcNcc05Gid2A8pVTCPduKG2+e
         e6p99f3yFYlTY4aNnYY5OQY+CWRfLf7PJ9eQTrgEw1pueQuABwHH7AgzDUYmM5U3WI
         Me8fh/mmSTOPQ==
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        stable@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH for-5.18 v3] ath9k: Fix usage of driver-private space in tx_info
Date:   Mon,  4 Apr 2022 22:48:00 +0200
Message-Id: <20220404204800.2681133-1-toke@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The ieee80211_tx_info_clear_status() helper also clears the rate counts and
the driver-private part of struct ieee80211_tx_info, so using it breaks
quite a few other things. So back out of using it, and instead define a
ath-internal helper that only clears the area between the
status_driver_data and the rates info. Combined with moving the
ath_frame_info struct to status_driver_data, this avoids clearing anything
we shouldn't be, and so we can keep the existing code for handling the rate
information.

While fixing this I also noticed that the setting of
tx_info->status.rates[tx_rateindex].count on hardware underrun errors was
always immediately overridden by the normal setting of the same fields, so
rearrange the code so that the underrun detection actually takes effect.

The new helper could be generalised to a 'memset_between()' helper, but
leave it as a driver-internal helper for now since this needs to go to
stable.

Cc: stable@vger.kernel.org
Reported-by: Peter Seiderer <ps.report@gmx.net>
Fixes: 037250f0a45c ("ath9k: Properly clear TX status area before reporting to mac80211")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/wireless/ath/ath9k/main.c |  2 +-
 drivers/net/wireless/ath/ath9k/xmit.c | 30 ++++++++++++++++++---------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 98090e40e1cf..e2791d45f5f5 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -839,7 +839,7 @@ static bool ath9k_txq_list_has_key(struct list_head *txq_list, u32 keyix)
 			continue;
 
 		txinfo = IEEE80211_SKB_CB(bf->bf_mpdu);
-		fi = (struct ath_frame_info *)&txinfo->rate_driver_data[0];
+		fi = (struct ath_frame_info *)&txinfo->status.status_driver_data[0];
 		if (fi->keyix == keyix)
 			return true;
 	}
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index cbcf96ac303e..db83cc4ba810 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -141,8 +141,8 @@ static struct ath_frame_info *get_frame_info(struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	BUILD_BUG_ON(sizeof(struct ath_frame_info) >
-		     sizeof(tx_info->rate_driver_data));
-	return (struct ath_frame_info *) &tx_info->rate_driver_data[0];
+		     sizeof(tx_info->status.status_driver_data));
+	return (struct ath_frame_info *) &tx_info->status.status_driver_data[0];
 }
 
 static void ath_send_bar(struct ath_atx_tid *tid, u16 seqno)
@@ -2542,6 +2542,16 @@ static void ath_tx_complete_buf(struct ath_softc *sc, struct ath_buf *bf,
 	spin_unlock_irqrestore(&sc->tx.txbuflock, flags);
 }
 
+static void ath_clear_tx_status(struct ieee80211_tx_info *tx_info)
+{
+	void *ptr = &tx_info->status;
+
+	memset(ptr + sizeof(tx_info->status.rates), 0,
+	       sizeof(tx_info->status) -
+	       sizeof(tx_info->status.rates) -
+	       sizeof(tx_info->status.status_driver_data));
+}
+
 static void ath_tx_rc_status(struct ath_softc *sc, struct ath_buf *bf,
 			     struct ath_tx_status *ts, int nframes, int nbad,
 			     int txok)
@@ -2553,7 +2563,7 @@ static void ath_tx_rc_status(struct ath_softc *sc, struct ath_buf *bf,
 	struct ath_hw *ah = sc->sc_ah;
 	u8 i, tx_rateindex;
 
-	ieee80211_tx_info_clear_status(tx_info);
+	ath_clear_tx_status(tx_info);
 
 	if (txok)
 		tx_info->status.ack_signal = ts->ts_rssi;
@@ -2569,6 +2579,13 @@ static void ath_tx_rc_status(struct ath_softc *sc, struct ath_buf *bf,
 	tx_info->status.ampdu_len = nframes;
 	tx_info->status.ampdu_ack_len = nframes - nbad;
 
+	tx_info->status.rates[tx_rateindex].count = ts->ts_longretry + 1;
+
+	for (i = tx_rateindex + 1; i < hw->max_rates; i++) {
+		tx_info->status.rates[i].count = 0;
+		tx_info->status.rates[i].idx = -1;
+	}
+
 	if ((ts->ts_status & ATH9K_TXERR_FILT) == 0 &&
 	    (tx_info->flags & IEEE80211_TX_CTL_NO_ACK) == 0) {
 		/*
@@ -2590,13 +2607,6 @@ static void ath_tx_rc_status(struct ath_softc *sc, struct ath_buf *bf,
 			tx_info->status.rates[tx_rateindex].count =
 				hw->max_rate_tries;
 	}
-
-	for (i = tx_rateindex + 1; i < hw->max_rates; i++) {
-		tx_info->status.rates[i].count = 0;
-		tx_info->status.rates[i].idx = -1;
-	}
-
-	tx_info->status.rates[tx_rateindex].count = ts->ts_longretry + 1;
 }
 
 static void ath_tx_processq(struct ath_softc *sc, struct ath_txq *txq)
-- 
2.35.1

