Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26EACB9E
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 10:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfIHIjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 04:39:16 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:7970 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbfIHIjP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 04:39:15 -0400
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 08 Sep 2019 10:33:04 +0200
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg03-ams.qualcomm.com with ESMTP; 08 Sep 2019 10:32:59 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Dedy Lansky <dlansky@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 01/11] wil6210: add wil_netif_rx() helper function
Date:   Sun,  8 Sep 2019 11:32:45 +0300
Message-Id: <1567931575-27984-2-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
References: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dedy Lansky <dlansky@codeaurora.org>

Move common part of wil_netif_rx_any into new helper function and add
support for non-gro receive using netif_rx_ni.

Signed-off-by: Dedy Lansky <dlansky@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/txrx.c | 60 ++++++++++++++++++++-------------
 drivers/net/wireless/ath/wil6210/txrx.h |  2 ++
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index 8b01ef8..b6253fc 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -728,21 +728,19 @@ static void wil_get_netif_rx_params(struct sk_buff *skb, int *cid,
  * Pass Rx packet to the netif. Update statistics.
  * Called in softirq context (NAPI poll).
  */
-void wil_netif_rx_any(struct sk_buff *skb, struct net_device *ndev)
+void wil_netif_rx(struct sk_buff *skb, struct net_device *ndev, int cid,
+		  struct wil_net_stats *stats, bool gro)
 {
 	gro_result_t rc = GRO_NORMAL;
 	struct wil6210_vif *vif = ndev_to_vif(ndev);
 	struct wil6210_priv *wil = ndev_to_wil(ndev);
 	struct wireless_dev *wdev = vif_to_wdev(vif);
 	unsigned int len = skb->len;
-	int cid;
-	int security;
 	u8 *sa, *da = wil_skb_get_da(skb);
 	/* here looking for DA, not A1, thus Rxdesc's 'mcast' indication
 	 * is not suitable, need to look at data
 	 */
 	int mcast = is_multicast_ether_addr(da);
-	struct wil_net_stats *stats;
 	struct sk_buff *xmit_skb = NULL;
 	static const char * const gro_res_str[] = {
 		[GRO_MERGED]		= "GRO_MERGED",
@@ -753,25 +751,6 @@ void wil_netif_rx_any(struct sk_buff *skb, struct net_device *ndev)
 		[GRO_CONSUMED]		= "GRO_CONSUMED",
 	};
 
-	wil->txrx_ops.get_netif_rx_params(skb, &cid, &security);
-
-	stats = &wil->sta[cid].stats;
-
-	skb_orphan(skb);
-
-	if (security && (wil->txrx_ops.rx_crypto_check(wil, skb) != 0)) {
-		rc = GRO_DROP;
-		dev_kfree_skb(skb);
-		stats->rx_replay++;
-		goto stats;
-	}
-
-	/* check errors reported by HW and update statistics */
-	if (unlikely(wil->txrx_ops.rx_error_check(wil, skb, stats))) {
-		dev_kfree_skb(skb);
-		return;
-	}
-
 	if (wdev->iftype == NL80211_IFTYPE_STATION) {
 		sa = wil_skb_get_sa(skb);
 		if (mcast && ether_addr_equal(sa, ndev->dev_addr)) {
@@ -817,7 +796,10 @@ void wil_netif_rx_any(struct sk_buff *skb, struct net_device *ndev)
 	if (skb) { /* deliver to local stack */
 		skb->protocol = eth_type_trans(skb, ndev);
 		skb->dev = ndev;
-		rc = napi_gro_receive(&wil->napi_rx, skb);
+		if (gro)
+			rc = napi_gro_receive(&wil->napi_rx, skb);
+		else
+			netif_rx_ni(skb);
 		wil_dbg_txrx(wil, "Rx complete %d bytes => %s\n",
 			     len, gro_res_str[rc]);
 	}
@@ -837,6 +819,36 @@ void wil_netif_rx_any(struct sk_buff *skb, struct net_device *ndev)
 	}
 }
 
+void wil_netif_rx_any(struct sk_buff *skb, struct net_device *ndev)
+{
+	int cid, security;
+	struct wil6210_priv *wil = ndev_to_wil(ndev);
+	struct wil_net_stats *stats;
+
+	wil->txrx_ops.get_netif_rx_params(skb, &cid, &security);
+
+	stats = &wil->sta[cid].stats;
+
+	skb_orphan(skb);
+
+	if (security && (wil->txrx_ops.rx_crypto_check(wil, skb) != 0)) {
+		dev_kfree_skb(skb);
+		ndev->stats.rx_dropped++;
+		stats->rx_replay++;
+		stats->rx_dropped++;
+		wil_dbg_txrx(wil, "Rx drop %d bytes\n", skb->len);
+		return;
+	}
+
+	/* check errors reported by HW and update statistics */
+	if (unlikely(wil->txrx_ops.rx_error_check(wil, skb, stats))) {
+		dev_kfree_skb(skb);
+		return;
+	}
+
+	wil_netif_rx(skb, ndev, cid, stats, true);
+}
+
 /**
  * Proceed all completed skb's from Rx VRING
  *
diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wireless/ath/wil6210/txrx.h
index c0da134..fceb251 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.h
+++ b/drivers/net/wireless/ath/wil6210/txrx.h
@@ -646,6 +646,8 @@ static inline void wil_skb_set_cid(struct sk_buff *skb, u8 cid)
 }
 
 void wil_netif_rx_any(struct sk_buff *skb, struct net_device *ndev);
+void wil_netif_rx(struct sk_buff *skb, struct net_device *ndev, int cid,
+		  struct wil_net_stats *stats, bool gro);
 void wil_rx_reorder(struct wil6210_priv *wil, struct sk_buff *skb);
 void wil_rx_bar(struct wil6210_priv *wil, struct wil6210_vif *vif,
 		u8 cid, u8 tid, u16 seq);
-- 
1.9.1

