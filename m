Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFE12036E6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 14:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgFVMfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 08:35:46 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:57732 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgFVMfp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 08:35:45 -0400
Received: from legolas.fritz.box (unknown [79.211.69.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id E7A04580060;
        Mon, 22 Jun 2020 14:35:43 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, j@w1.fi,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v3] mac80211: fix control port tx status check
Date:   Mon, 22 Jun 2020 14:35:42 +0200
Message-Id: <20200622123542.173695-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The initial control port tx status patch assumed, that
we have IEEE 802.11 frames, but actually ethernet frames
are stored in the ack skb. Fix this by checking for the
correct ethertype and skb protocol 802.3.

Also allow tx status reports for ETH_P_PREAUTH, as preauth
frames can also be send over the nl80211 control port.

Fixes: a7528198add8 ("mac80211: support control port TX status reporting")
Reported-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
v3: also check for ETH_P_PREAUTH
v2: use __be16, as suggested by Johannes Berg
 net/mac80211/status.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 7b1bacac39c6..7d1bc3ca389a 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -639,11 +639,23 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 		u64 cookie = IEEE80211_SKB_CB(skb)->ack.cookie;
 		struct ieee80211_sub_if_data *sdata;
 		struct ieee80211_hdr *hdr = (void *)skb->data;
+		__be16 ethertype = 0xffff;
+
+		if (skb->len >= ETH_HLEN && skb->protocol == cpu_to_be16(ETH_P_802_3))
+			skb_copy_bits(skb, 2 * ETH_ALEN, &ethertype, ETH_TLEN);

 		rcu_read_lock();
 		sdata = ieee80211_sdata_from_skb(local, skb);
 		if (sdata) {
-			if (ieee80211_is_any_nullfunc(hdr->frame_control))
+			if (ethertype == sdata->control_port_protocol ||
+			    ethertype == cpu_to_be16(ETH_P_PREAUTH))
+				cfg80211_control_port_tx_status(&sdata->wdev,
+								cookie,
+								skb->data,
+								skb->len,
+								acked,
+								GFP_ATOMIC);
+			else if (ieee80211_is_any_nullfunc(hdr->frame_control))
 				cfg80211_probe_status(sdata->dev, hdr->addr1,
 						      cookie, acked,
 						      info->status.ack_signal,
@@ -654,12 +666,8 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 							skb->data, skb->len,
 							acked, GFP_ATOMIC);
 			else
-				cfg80211_control_port_tx_status(&sdata->wdev,
-								cookie,
-								skb->data,
-								skb->len,
-								acked,
-								GFP_ATOMIC);
+				pr_warn("Unknown status report in ack skb\n");
+
 		}
 		rcu_read_unlock();

--
2.27.0

