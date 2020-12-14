Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258422D9D9B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 18:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440350AbgLNR0I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 12:26:08 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:49782 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440349AbgLNRZ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 12:25:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607966739; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=EjjzktZtQO0t7JRvksu5vkb4uWr016uKiDNH7HSVzVo=; b=VR7UlcqKej0f/dztkRzEYWbpCM3RY7IzJvoin5o9iKXOnUtYzXbUEImqyA/9al7Pst96Xd8e
 hmi3y0FMhFBUjdFK3tqoSbj/ixWRHeFbu4+9rRAHzeEAwl8WtyTJPz05TjwsGSw8/WFKxrDA
 /wpRejLV5qBv6U4k01CVK8rfrFM=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fd7a0049499561cc1523b55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Dec 2020 17:25:24
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF64DC43461; Mon, 14 Dec 2020 17:25:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-35-200-nat.elisa-mobile.fi [85.76.35.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2ED65C433CA;
        Mon, 14 Dec 2020 17:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2ED65C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     ath9k-devel@qca.qualcomm.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 5/5] ath9k: Postpone key cache entry deletion for TXQ frames reference it
Date:   Mon, 14 Dec 2020 19:21:18 +0200
Message-Id: <20201214172118.18100-6-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214172118.18100-1-jouni@codeaurora.org>
References: <20201214172118.18100-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not delete a key cache entry that is still being referenced by
pending frames in TXQs. This avoids reuse of the key cache entry while a
frame might still be transmitted using it.

To avoid having to do any additional operations during the main TX path
operations, track pending key cache entries in a new bitmap and check
whether any pending entries can be deleted before every new key
add/remove operation. Also clear any remaining entries when stopping the
interface.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath9k/hw.h   |  1 +
 drivers/net/wireless/ath/ath9k/main.c | 87 ++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 023599e10dd5..b7b65b1c90e8 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -820,6 +820,7 @@ struct ath_hw {
 	struct ath9k_pacal_info pacal_info;
 	struct ar5416Stats stats;
 	struct ath9k_tx_queue_info txq[ATH9K_NUM_TX_QUEUES];
+	DECLARE_BITMAP(pending_del_keymap, ATH_KEYMAX);
 
 	enum ath9k_int imask;
 	u32 imrs2_reg;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index bcdf150060f2..45f6402478b5 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -821,12 +821,80 @@ static void ath9k_tx(struct ieee80211_hw *hw,
 	ieee80211_free_txskb(hw, skb);
 }
 
+static bool ath9k_txq_list_has_key(struct list_head *txq_list, u32 keyix)
+{
+	struct ath_buf *bf;
+	struct ieee80211_tx_info *txinfo;
+	struct ath_frame_info *fi;
+
+	list_for_each_entry(bf, txq_list, list) {
+		if (bf->bf_state.stale || !bf->bf_mpdu)
+			continue;
+
+		txinfo = IEEE80211_SKB_CB(bf->bf_mpdu);
+		fi = (struct ath_frame_info *)&txinfo->rate_driver_data[0];
+		if (fi->keyix == keyix)
+			return true;
+	}
+
+	return false;
+}
+
+static bool ath9k_txq_has_key(struct ath_softc *sc, u32 keyix)
+{
+	struct ath_hw *ah = sc->sc_ah;
+	int i;
+	struct ath_txq *txq;
+	bool key_in_use = false;
+
+	for (i = 0; !key_in_use && i < ATH9K_NUM_TX_QUEUES; i++) {
+		if (!ATH_TXQ_SETUP(sc, i))
+			continue;
+		txq = &sc->tx.txq[i];
+		if (!txq->axq_depth)
+			continue;
+		if (!ath9k_hw_numtxpending(ah, txq->axq_qnum))
+			continue;
+
+		ath_txq_lock(sc, txq);
+		key_in_use = ath9k_txq_list_has_key(&txq->axq_q, keyix);
+		if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA) {
+			int idx = txq->txq_tailidx;
+
+			while (!key_in_use &&
+			       !list_empty(&txq->txq_fifo[idx])) {
+				key_in_use = ath9k_txq_list_has_key(
+					&txq->txq_fifo[idx], keyix);
+				INCR(idx, ATH_TXFIFO_DEPTH);
+			}
+		}
+		ath_txq_unlock(sc, txq);
+	}
+
+	return key_in_use;
+}
+
+static void ath9k_pending_key_del(struct ath_softc *sc, u8 keyix)
+{
+	struct ath_hw *ah = sc->sc_ah;
+	struct ath_common *common = ath9k_hw_common(ah);
+
+	if (!test_bit(keyix, ah->pending_del_keymap) ||
+	    ath9k_txq_has_key(sc, keyix))
+		return;
+
+	/* No more TXQ frames point to this key cache entry, so delete it. */
+	clear_bit(keyix, ah->pending_del_keymap);
+	ath_key_delete(common, keyix);
+}
+
 static void ath9k_stop(struct ieee80211_hw *hw)
 {
 	struct ath_softc *sc = hw->priv;
 	struct ath_hw *ah = sc->sc_ah;
 	struct ath_common *common = ath9k_hw_common(ah);
 	bool prev_idle;
+	int i;
 
 	ath9k_deinit_channel_context(sc);
 
@@ -894,6 +962,9 @@ static void ath9k_stop(struct ieee80211_hw *hw)
 
 	spin_unlock_bh(&sc->sc_pcu_lock);
 
+	for (i = 0; i < ATH_KEYMAX; i++)
+		ath9k_pending_key_del(sc, i);
+
 	/* Clear key cache entries explicitly to get rid of any potentially
 	 * remaining keys.
 	 */
@@ -1718,6 +1789,12 @@ static int ath9k_set_key(struct ieee80211_hw *hw,
 	if (sta)
 		an = (struct ath_node *)sta->drv_priv;
 
+	/* Delete pending key cache entries if no more frames are pointing to
+	 * them in TXQs.
+	 */
+	for (i = 0; i < ATH_KEYMAX; i++)
+		ath9k_pending_key_del(sc, i);
+
 	switch (cmd) {
 	case SET_KEY:
 		if (sta)
@@ -1747,7 +1824,15 @@ static int ath9k_set_key(struct ieee80211_hw *hw,
 		}
 		break;
 	case DISABLE_KEY:
-		ath_key_delete(common, key->hw_key_idx);
+		if (ath9k_txq_has_key(sc, key->hw_key_idx)) {
+			/* Delay key cache entry deletion until there are no
+			 * remaining TXQ frames pointing to this entry.
+			 */
+			set_bit(key->hw_key_idx, sc->sc_ah->pending_del_keymap);
+			ath_hw_keysetmac(common, key->hw_key_idx, NULL);
+		} else {
+			ath_key_delete(common, key->hw_key_idx);
+		}
 		if (an) {
 			for (i = 0; i < ARRAY_SIZE(an->key_idx); i++) {
 				if (an->key_idx[i] != key->hw_key_idx)
-- 
2.20.1

