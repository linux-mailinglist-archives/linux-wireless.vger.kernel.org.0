Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133A412371C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 21:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfLQUTS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 15:19:18 -0500
Received: from nbd.name ([46.4.11.11]:37058 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfLQUTS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 15:19:18 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihJJL-0000ls-Sk; Tue, 17 Dec 2019 21:19:16 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [RESEND 3/3] ath11k: switch to using ieee80211_tx_status_ext()
Date:   Tue, 17 Dec 2019 21:19:09 +0100
Message-Id: <20191217201909.27420-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217201909.27420-1-john@phrozen.org>
References: <20191217201909.27420-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows us to pass HE rates down into the stack.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 0c93b291305c..d4be307f2eba 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -361,9 +361,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
 {
+	struct ieee80211_tx_status status = { 0 };
 	struct ath11k_base *ab = ar->ab;
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
+	struct ath11k_peer *peer;
+	struct ath11k_sta *arsta;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -427,12 +430,23 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 		ath11k_dp_tx_cache_peer_stats(ar, msdu, ts);
 	}
 
-	/* NOTE: Tx rate status reporting. Tx completion status does not have
-	 * necessary information (for example nss) to build the tx rate.
-	 * Might end up reporting it out-of-band from HTT stats.
-	 */
 
-	ieee80211_tx_status(ar->hw, msdu);
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
+	if (peer) {
+		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
+		status.sta = peer->sta;
+		status.skb = msdu;
+		status.info = info;
+		status.rate = &arsta->last_txrate;
+	}
+	rcu_read_unlock();
+	if (peer)
+		ieee80211_tx_status_ext(ar->hw, &status);
+	else
+		dev_kfree_skb_any(msdu);
+	spin_unlock_bh(&ab->base_lock);
+	return;
 
 exit:
 	rcu_read_unlock();
-- 
2.20.1

