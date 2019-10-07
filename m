Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E2ECDB1B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 06:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfJGEbc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 00:31:32 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:42145 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGEbb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 00:31:31 -0400
Received: by mail-pl1-f202.google.com with SMTP id d1so7828630plj.9
        for <linux-wireless@vger.kernel.org>; Sun, 06 Oct 2019 21:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MRJ0J4v3uVndCWKOzAexEna23pM90UBtQlxCvQvTxvU=;
        b=cS1C2yYFzjxuNn4fAF33qKl264RCoHygylKATrrvyD5ozjfo+/x40sNn2mL2+piiag
         2HX5pSIrNh5eN1Ilim7U4lNuQu4JCafPdUmHv1dWHIfupXilX6kkpvxccgZOBpv70Qu2
         0iBDPL6NwuXG+C5UUlx53GY6QJaAl4gLgZ5/f+Gsv3Rd7f7mlOJJuGUTR6i2+y67y/ua
         jcdQv8Xg0VuEb2Os9PonsZLXAgAzJt8NGLUxK1DbSCw5P+S2D+6m5sxRbgU8SUQrAODp
         85KIU4fDy6rH7tCHDkawIK96Wd5z6yQUwgaoLGWWfkdUS9dtWjoUKp3PUFcV99eVtpVR
         KbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MRJ0J4v3uVndCWKOzAexEna23pM90UBtQlxCvQvTxvU=;
        b=DbSYGMt3sWITpGiKTTeYFErQ57GcWqCvVEy2kchnum/Ibj6IDK9TozZnYt7504Fj+8
         5PWPENVVbMw285f+hyTcQn9HAMzFak6yp3TJEnHs4QmJwrGkTXd4I96iIX52HDF/bdk4
         4zCc3y89kXQhlDHMInLNA3vtEjNSx4B0SKJi+vrst0j/aV0blHBBwGNl8cNLkYZNLubd
         dG6aaAm8YjB1s9eoRIqwNxBpLakW7q1I1imdRhIow1Bqd/wVUl2dAo/7JdV9G92jnNZP
         gcZUGzulrT5VQeZqvSODJRewaKaJDyNexyTtyLqQ5LmBsYMpwU1AVC5rk7kj59q4QeIE
         UQRg==
X-Gm-Message-State: APjAAAWq3oNDb2Jib6rU6PgEBnDOFtgdh+y3+l1CPV9dnF3X27+riEaK
        8FgiY7/MA+V4j5yN8/s+n8Rwxocx
X-Google-Smtp-Source: APXvYqzGDV+9OPmpRE7O9bzDtuSPfptvA3RkODyicXarkytB86vPcCIwKUFSiDBxKxd8VWzlDtbjWMMf
X-Received: by 2002:a63:285:: with SMTP id 127mr15322825pgc.56.1570422690639;
 Sun, 06 Oct 2019 21:31:30 -0700 (PDT)
Date:   Sun,  6 Oct 2019 21:31:20 -0700
In-Reply-To: <20191007043120.67567-1-kyan@google.com>
Message-Id: <20191007043120.67567-3-kyan@google.com>
Mime-Version: 1.0
References: <20191007043120.67567-1-kyan@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v2 2/2] ath10k: Enable Airtime-based Queue Limit (AQL)
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, Kan Yan <kyan@google.com>
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
 drivers/net/wireless/ath/ath10k/txrx.c   | 13 ++++++++++---
 3 files changed, 16 insertions(+), 6 deletions(-)

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
index 0606416dc971..c22b822bd8f1 100644
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
 
+	ieee80211_sta_update_pending_airtime(txq->sta, txq->tid, airtime);
 	return airtime;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 4102df016931..03eb636c85ed 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -84,9 +84,16 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 		wake_up(&htt->empty_tx_wq);
 	spin_unlock_bh(&htt->tx_lock);
 
-	if (txq && txq->sta && skb_cb->airtime_est)
-		ieee80211_sta_register_airtime(txq->sta, txq->tid,
-					       skb_cb->airtime_est, 0);
+	if (txq && txq->sta && skb_cb->airtime_est) {
+		s32 airtime = -skb_cb->airtime_est;
+
+		if (!test_bit(WMI_SERVICE_REPORT_AIRTIME, ar->wmi.svc_map))
+			ieee80211_sta_register_airtime(txq->sta, txq->tid,
+						       skb_cb->airtime_est, 0);
+
+		ieee80211_sta_update_pending_airtime(txq->sta, txq->tid,
+						     airtime);
+	}
 
 	if (ar->bus_param.dev_type != ATH10K_DEV_TYPE_HL)
 		dma_unmap_single(dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-- 
2.23.0.581.g78d2f28ef7-goog

