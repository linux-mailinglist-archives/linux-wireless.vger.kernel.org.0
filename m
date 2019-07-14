Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1272D67FEF
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2019 17:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfGNPok (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jul 2019 11:44:40 -0400
Received: from nbd.name ([46.4.11.11]:59444 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfGNPoj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jul 2019 11:44:39 -0400
Received: from p5dcfb359.dip0.t-ipconnect.de ([93.207.179.89] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hmgg0-0007cJ-Tn; Sun, 14 Jul 2019 17:44:37 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 6/6] ath11k: switch to using ieee80211_tx_status_ext()
Date:   Sun, 14 Jul 2019 17:44:19 +0200
Message-Id: <20190714154419.11854-7-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190714154419.11854-1-john@phrozen.org>
References: <20190714154419.11854-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows us to pass HE rates down into the stack.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 33404483ec0a..7fe6ca18fc27 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -365,9 +365,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
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
@@ -431,12 +434,18 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 		ath11k_dp_tx_cache_peer_stats(ar, msdu, ts);
 	}
 
-	/* NOTE: Tx rate status reporting. Tx completion status does not have
-	 * necessary information (for example nss) to build the tx rate.
-	 * Might end up reporting it out-of-band from HTT stats.
-	 */
 
-	ieee80211_tx_status(ar->hw, msdu);
+	spin_lock_bh(&ab->data_lock);
+	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
+	arsta = (struct ath11k_sta *)peer->sta->drv_priv;
+	status.sta = peer->sta;
+	status.skb = msdu;
+	status.info = info;
+	status.rate = &arsta->last_txrate;
+	rcu_read_unlock();
+	ieee80211_tx_status_ext(ar->hw, &status);
+	spin_unlock_bh(&ab->data_lock);
+	return;
 
 exit:
 	rcu_read_unlock();
-- 
2.20.1

