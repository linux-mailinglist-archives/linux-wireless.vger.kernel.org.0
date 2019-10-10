Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7479BD1E66
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 04:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbfJJCZX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 22:25:23 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39345 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfJJCZX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 22:25:23 -0400
Received: by mail-pl1-f201.google.com with SMTP id w11so2886457ply.6
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2019 19:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kGk/7KejGkDZxzehqIVr9iG/CJHtXnwr5jx9nytWH0I=;
        b=kbC/KmHukXc1r/7vG59UBTp6xFJZnPdTQp+YRg2PvaBXk2vz9kJKMFbHpTNrh7n5/L
         ArdMvvvU4Zk8+WKvTeLAD6UTrvbMGUjtF7a4/myn7sulc0Zv0YcnSa2autoqg+ttdXcI
         cfAov0OnR/1oUP7r1ZUK6f8DmmSONBeMvPLvNLaF1ujghOUank/z8OCr5ZMbYlqext6w
         911RRavOiIAi4XyOpoWJSQaRuqU5GTKle52Sv6VnQysbbkmcN1qu+k+MNfFjaFXLHp7J
         TWDTmczO/l/6hjXDMh16XIlFox+UgLEXgvqoazZIU3Jb/Q730tkYpRp/n0DMl4cq+vfy
         C2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kGk/7KejGkDZxzehqIVr9iG/CJHtXnwr5jx9nytWH0I=;
        b=dizWNAsTrkwL/N8VQaTeaZOyQRwoRxjOsLrk2xEjQBXVPNph0usES/lF5o8pgrUa9V
         lf5qLeIo3NxKi2VXXSVwUROLT68ME6UbY4gkZqEOf4tVyiu8cRyLs2AxJyo0fIPkS9un
         8zHOBt9bsiBaqhgDmR7GcoH8mD1K8IzKzcO/0u+IOXLoDX/DXdh/Tf2++JAs2y0Btzy2
         ydm0UwNVl3mWnK9D776QU9LqFnMxK1OddcNh1F4J13nVo6Qe0SkI1Dnpeky6RJ8EM1I/
         bxl8+9gAqPPDsyRb+7irnBOOZ+Iro0vKRUDyAMR5r55GgZAyi9Q03F0MrNLqrUMRgnxs
         LKFg==
X-Gm-Message-State: APjAAAXlNTnt5WavcVsQhjD6SInjw2V97fvQTT40LyzyImqgmK6gCnYp
        mxqpNUS3Gn/vBi/MVPK9AXUC8TQW
X-Google-Smtp-Source: APXvYqygGfbjespKmHgXgHBuOcQEh8edbha1EHCUFKHMydLFWheu7apHsV0cCqj3DbH/NLYOFV1n1q0Q
X-Received: by 2002:a63:c045:: with SMTP id z5mr7831822pgi.69.1570674321965;
 Wed, 09 Oct 2019 19:25:21 -0700 (PDT)
Date:   Wed,  9 Oct 2019 19:25:02 -0700
In-Reply-To: <20191010022502.141862-1-kyan@google.com>
Message-Id: <20191010022502.141862-3-kyan@google.com>
Mime-Version: 1.0
References: <20191010022502.141862-1-kyan@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v3 2/2] ath10k: Enable Airtime-based Queue Limit (AQL)
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, ath10k@lists.infradead.org, yiboz@codeaurora.org,
        Kan Yan <kyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Calculate the estimated airtime pending in the txqs and apply AQL to
prevent excessive amounts of packets being queued in the firmware queue.

Signed-off-by: Kan Yan <kyan@google.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c |  1 +
 drivers/net/wireless/ath/ath10k/mac.c    |  8 +++++---
 drivers/net/wireless/ath/ath10k/txrx.c   | 11 ++++++++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 83a7fb68fd24..f2115b940964 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3053,6 +3053,7 @@ static void ath10k_htt_rx_tx_fetch_ind(struct ath10k *ar, struct sk_buff *skb)
 
 			num_msdus++;
 			num_bytes += ret;
+			may_tx = ieee80211_txq_aql_check(hw, txq);
 		}
 		ieee80211_return_txq(hw, txq, false);
 		ieee80211_txq_schedule_end(hw, txq->ac);
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 0606416dc971..b300a3c506b2 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3983,6 +3983,9 @@ static bool ath10k_mac_tx_can_push(struct ieee80211_hw *hw,
 	struct ath10k_txq *artxq = (void *)txq->drv_priv;
 
 	/* No need to get locks */
+	if (!ieee80211_txq_aql_check(hw, txq))
+		return false;
+
 	if (ar->htt.tx_q_state.mode == HTT_TX_MODE_SWITCH_PUSH)
 		return true;
 
@@ -4009,13 +4012,11 @@ static u16 ath10k_mac_update_airtime(struct ath10k *ar,
 {
 	struct ath10k_sta *arsta;
 	u32 pktlen;
-	u16 airtime = 0;
+	s32 airtime = 0;
 
 	if (!txq || !txq->sta)
 		return airtime;
 
-	if (test_bit(WMI_SERVICE_REPORT_AIRTIME, ar->wmi.svc_map))
-		return airtime;
 
 	spin_lock_bh(&ar->data_lock);
 	arsta = (struct ath10k_sta *)txq->sta->drv_priv;
@@ -4038,6 +4039,7 @@ static u16 ath10k_mac_update_airtime(struct ath10k *ar,
 	}
 	spin_unlock_bh(&ar->data_lock);
 
+	ieee80211_sta_register_pending_airtime(txq->sta, txq->tid, airtime);
 	return airtime;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 4102df016931..739046b34d4b 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -84,9 +84,14 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 		wake_up(&htt->empty_tx_wq);
 	spin_unlock_bh(&htt->tx_lock);
 
-	if (txq && txq->sta && skb_cb->airtime_est)
-		ieee80211_sta_register_airtime(txq->sta, txq->tid,
-					       skb_cb->airtime_est, 0);
+	if (txq && txq->sta && skb_cb->airtime_est) {
+		if (!test_bit(WMI_SERVICE_REPORT_AIRTIME, ar->wmi.svc_map))
+			ieee80211_sta_register_airtime(txq->sta, txq->tid,
+						       skb_cb->airtime_est, 0);
+
+		ieee80211_sta_release_pending_airtime(txq->sta, txq->tid,
+						      skb_cb->airtime_est);
+	}
 
 	if (ar->bus_param.dev_type != ATH10K_DEV_TYPE_HL)
 		dma_unmap_single(dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-- 
2.23.0.581.g78d2f28ef7-goog

