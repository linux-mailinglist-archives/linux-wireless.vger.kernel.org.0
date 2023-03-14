Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC086B8F1B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 11:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCNKAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 06:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCNKAN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 06:00:13 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE7D7B980
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=N8rLPVnIVIwMemDyqxdvDTJmdXw8on0SmkAEdMmNBHE=; b=JWl9ns1jYxlLJ6wHvZ7n9oIIYB
        pW7m7BcLAlthPc8r2FHb0rEt1aJw2Kmk/oeLj1gZWLNt4pGG9I4P+s9dJXnNkuBOFJwX0EImdu8WU
        lOE1NS83nJcgyiSO1SLDDTa/7etl/nux5a3AIY7oEz41ATYIBrRMq1viSFMvBg6fO/Zs=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pc1Ro-001pV5-Id; Tue, 14 Mar 2023 11:00:00 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 6/7] wifi: mac80211: add mesh fast-rx support
Date:   Tue, 14 Mar 2023 10:59:55 +0100
Message-Id: <20230314095956.62085-6-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230314095956.62085-1-nbd@nbd.name>
References: <20230314095956.62085-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This helps bring down rx CPU usage by avoiding calls to the rx handlers in
the slow path. Supports forwarding and local rx, including A-MSDU.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/rx.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index cdad8a081cf1..2a883d956260 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4542,6 +4542,12 @@ void ieee80211_check_fast_rx(struct sta_info *sta)
 			fastrx.internal_forward = 0;
 		}
 
+		break;
+	case NL80211_IFTYPE_MESH_POINT:
+		fastrx.expected_ds_bits = cpu_to_le16(IEEE80211_FCTL_FROMDS |
+						      IEEE80211_FCTL_TODS);
+		fastrx.da_offs = offsetof(struct ieee80211_hdr, addr3);
+		fastrx.sa_offs = offsetof(struct ieee80211_hdr, addr4);
 		break;
 	default:
 		goto clear;
@@ -4751,6 +4757,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	static ieee80211_rx_result res;
 	int orig_len = skb->len;
 	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
 	int snap_offs = hdrlen;
@@ -4812,7 +4819,8 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		snap_offs += IEEE80211_CCMP_HDR_LEN;
 	}
 
-	if (!(status->rx_flags & IEEE80211_RX_AMSDU)) {
+	if (!ieee80211_vif_is_mesh(&rx->sdata->vif) &&
+	    !(status->rx_flags & IEEE80211_RX_AMSDU)) {
 		if (!pskb_may_pull(skb, snap_offs + sizeof(*payload)))
 			return false;
 
@@ -4851,13 +4859,29 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	/* do the header conversion - first grab the addresses */
 	ether_addr_copy(addrs.da, skb->data + fast_rx->da_offs);
 	ether_addr_copy(addrs.sa, skb->data + fast_rx->sa_offs);
-	skb_postpull_rcsum(skb, skb->data + snap_offs,
-			   sizeof(rfc1042_header) + 2);
-	/* remove the SNAP but leave the ethertype */
-	skb_pull(skb, snap_offs + sizeof(rfc1042_header));
+	if (ieee80211_vif_is_mesh(&rx->sdata->vif)) {
+	    skb_pull(skb, snap_offs - 2);
+	    put_unaligned_be16(skb->len - 2, skb->data);
+	} else {
+	    skb_postpull_rcsum(skb, skb->data + snap_offs,
+			       sizeof(rfc1042_header) + 2);
+
+	    /* remove the SNAP but leave the ethertype */
+	    skb_pull(skb, snap_offs + sizeof(rfc1042_header));
+	}
 	/* push the addresses in front */
 	memcpy(skb_push(skb, sizeof(addrs)), &addrs, sizeof(addrs));
 
+	res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
+	switch (res) {
+	case RX_QUEUED:
+		return true;
+	case RX_CONTINUE:
+		break;
+	default:
+		goto drop;
+	}
+
 	ieee80211_rx_8023(rx, fast_rx, orig_len);
 
 	return true;
-- 
2.39.0

