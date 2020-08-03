Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDD823A127
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 10:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHCIjx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 04:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCIjx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 04:39:53 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7AFC06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 01:39:53 -0700 (PDT)
Received: from [134.101.163.132] (helo=bertha9.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k2W0a-0001dx-IV; Mon, 03 Aug 2020 10:39:48 +0200
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V5 1/2] ath11k: switch to using ieee80211_tx_status_ext()
Date:   Mon,  3 Aug 2020 10:39:41 +0200
Message-Id: <20200803083942.128767-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows us to pass HE rates down into the stack.

Signed-off-by: John Crispin <john@phrozen.org>
---
Changes in V5
* fix sparse warnings

 drivers/net/wireless/ath/ath11k/dp_tx.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 1af76775b1a8..a1f16f589b98 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -393,9 +393,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
 {
+	struct ieee80211_tx_status status = { };
 	struct ath11k_base *ab = ar->ab;
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
+	struct ath11k_peer *peer;
+	struct ath11k_sta *arsta;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -459,12 +462,23 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
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
2.25.1

