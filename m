Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA1D377F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 04:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfJKCYY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 22:24:24 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:57055 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfJKCYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 22:24:24 -0400
Received: by mail-pf1-f201.google.com with SMTP id b17so6260033pfo.23
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2019 19:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HmYY0PWVAFlMRzrk7cXJ/dfio3OkuBi+GUsExcPOorQ=;
        b=q9mkOC6KaQyawkvkfk73wglKZGlIhW5WYjPuGer7egMjUfhRbWxPIF8ijxYwRchm6P
         mnTNEz2EnFR+enjjqOcon4rzi8QO2I7DYTDBoGD22H7zs42+luWzM6OIVyxuKc3Kll+K
         /0f+BwxLPTk7AzrpCdLzoUjGdOdeRIKeJRWGDlt9JHL9c7xXvCkEEacoxdxlqbpMEwuh
         EUaKbNV+NGo8QjRzLxA+i0rv1a3OdhNI4H3IOIHfgkKXMy0DxfPlu3U3G6cUxIlK67dG
         sC3oPcNM75dtuRNQSD/WLSFXY7a9jkQYIUaxgk70q/J8cJ62Vh1k6E61CSu7Laoj/d31
         wo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HmYY0PWVAFlMRzrk7cXJ/dfio3OkuBi+GUsExcPOorQ=;
        b=pCTZ7S9/IoTRv70U/3xxwnKxklEDJiSp2mtfUaSXYP3Mcjg6T4NSisetHe5m/xgMej
         D5ZmIUrASZGcQVi8l7ztVscvzRkP3r8SdSgat3UAOYTwudTzz3n3WI64ioRLHjX1LIAg
         /wWH5VFKpWgyoEI5jvRUKjgIsNY35Nvdnq26LzSsZweRPwQkl3b9gVOgsjvZa9nXXqQ7
         OXQNZnIj1a6xqEu240cHtjSvt/bLsTn10bYZjDOIIaJyBn9YK8H9eyFNdfZ1N4iAPssq
         FBDRTHO65cdSGGLpeOwcJyzemSIfd1ylJiwhTORWzDEDZePmpXPeKDNClv2M40PIPjRI
         Pxwg==
X-Gm-Message-State: APjAAAXNJzV27vg3zMsAHNyQd6L80+LSd/Zz0f1NBltiWC8Pu3AG72sZ
        bkhKVQVVsbcrvumkIGo3sIYeS7QN
X-Google-Smtp-Source: APXvYqxY8BiQ3Fv8BLi6xeVwbFok1Wl07Ci7EYxc/1PlruwxjuKVB35a6bOxasQ7YDCHDQMs9iGlLjXI
X-Received: by 2002:a63:db15:: with SMTP id e21mr14361491pgg.21.1570760663156;
 Thu, 10 Oct 2019 19:24:23 -0700 (PDT)
Date:   Thu, 10 Oct 2019 19:24:13 -0700
In-Reply-To: <20191011022413.176208-1-kyan@google.com>
Message-Id: <20191011022413.176208-3-kyan@google.com>
Mime-Version: 1.0
References: <20191011022413.176208-1-kyan@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v4 2/2] ath10k: Enable Airtime-based Queue Limit (AQL)
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
 drivers/net/wireless/ath/ath10k/mac.c    |  6 ++++--
 drivers/net/wireless/ath/ath10k/txrx.c   | 11 ++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 83a7fb68fd24..12d63fa02e8e 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3053,6 +3053,7 @@ static void ath10k_htt_rx_tx_fetch_ind(struct ath10k *ar, struct sk_buff *skb)
 
 			num_msdus++;
 			num_bytes += ret;
+			may_tx = ieee80211_txq_airtime_check(hw, txq);
 		}
 		ieee80211_return_txq(hw, txq, false);
 		ieee80211_txq_schedule_end(hw, txq->ac);
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 0606416dc971..ed19a40c2c3a 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3983,6 +3983,9 @@ static bool ath10k_mac_tx_can_push(struct ieee80211_hw *hw,
 	struct ath10k_txq *artxq = (void *)txq->drv_priv;
 
 	/* No need to get locks */
+	if (!ieee80211_txq_airtime_check(hw, txq))
+		return false;
+
 	if (ar->htt.tx_q_state.mode == HTT_TX_MODE_SWITCH_PUSH)
 		return true;
 
@@ -4014,8 +4017,6 @@ static u16 ath10k_mac_update_airtime(struct ath10k *ar,
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
2.23.0.700.g56cf767bdb-goog

