Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9F648975
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 21:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLIUVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 15:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLIUVZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 15:21:25 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028268D192
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 12:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LCmx1vFAOa+OOIKVNfjNq+NkjLcYAn/X3FEbwKy2qCk=; b=BiJFLPMHAq9rI1B9vYxBIy9UIu
        ZJJVXFF4JrbNNPUgOb6wG7S2iw96X6H4EtekZCpCTa1o53SVl/Fy9lvbWZyN/JV3TgoLo7Fxy8bi4
        uueJ/2ihF2py0emjE6k/4e8TlO/U0JUKX2+olu1kk1lastOCU7OU52SPPWB0k3jixKXA=;
Received: from p200300daa71613018d4aa8a5d898f578.dip0.t-ipconnect.de ([2003:da:a716:1301:8d4a:a8a5:d898:f578] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p3js2-007Tjz-0J; Fri, 09 Dec 2022 21:21:22 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [RFC 2/5] wifi: cfg80211: factor out bridge tunnel / RFC1042 header check
Date:   Fri,  9 Dec 2022 21:21:18 +0100
Message-Id: <20221209202121.55951-2-nbd@nbd.name>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209202121.55951-1-nbd@nbd.name>
References: <20221209202121.55951-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The same check is done in multiple places, unify it.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/wireless/util.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 6848e26707e8..f3e134984e00 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -542,6 +542,21 @@ unsigned int ieee80211_get_mesh_hdrlen(struct ieee80211s_hdr *meshhdr)
 }
 EXPORT_SYMBOL(ieee80211_get_mesh_hdrlen);
 
+static bool ieee80211_get_8023_tunnel_proto(const void *hdr, __be16 *proto)
+{
+	const __be16 *hdr_proto = hdr + ETH_ALEN;
+
+	if (!(ether_addr_equal(hdr, rfc1042_header) &&
+	      *hdr_proto != htons(ETH_P_AARP) &&
+	      *hdr_proto != htons(ETH_P_IPX)) &&
+	    !ether_addr_equal(hdr, bridge_tunnel_header))
+		return false;
+
+	*proto = *hdr_proto;
+
+	return true;
+}
+
 int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 				  const u8 *addr, enum nl80211_iftype iftype,
 				  u8 data_offset, bool is_amsdu)
@@ -633,14 +648,9 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 
 	if (likely(!is_amsdu &&
 		   skb_copy_bits(skb, hdrlen, &payload, sizeof(payload)) == 0 &&
-	           ((ether_addr_equal(payload.hdr, rfc1042_header) &&
-		     payload.proto != htons(ETH_P_AARP) &&
-		     payload.proto != htons(ETH_P_IPX)) ||
-		    ether_addr_equal(payload.hdr, bridge_tunnel_header)))) {
-		/* remove RFC1042 or Bridge-Tunnel encapsulation and
-		 * replace EtherType */
+		   ieee80211_get_8023_tunnel_proto(&payload, &tmp.h_proto))) {
+		/* remove RFC1042 or Bridge-Tunnel encapsulation */
 		hdrlen += ETH_ALEN + 2;
-		tmp.h_proto = payload.proto;
 		skb_postpull_rcsum(skb, &payload, ETH_ALEN + 2);
 	} else {
 		tmp.h_proto = htons(skb->len - hdrlen);
@@ -756,8 +766,6 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 {
 	unsigned int hlen = ALIGN(extra_headroom, 4);
 	struct sk_buff *frame = NULL;
-	u16 ethertype;
-	u8 *payload;
 	int offset = 0, remaining;
 	struct ethhdr eth;
 	bool reuse_frag = skb->head_frag && !skb_has_frag_list(skb);
@@ -811,14 +819,8 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		frame->dev = skb->dev;
 		frame->priority = skb->priority;
 
-		payload = frame->data;
-		ethertype = (payload[6] << 8) | payload[7];
-		if (likely((ether_addr_equal(payload, rfc1042_header) &&
-			    ethertype != ETH_P_AARP && ethertype != ETH_P_IPX) ||
-			   ether_addr_equal(payload, bridge_tunnel_header))) {
-			eth.h_proto = htons(ethertype);
+		if (likely(ieee80211_get_8023_tunnel_proto(frame->data, &eth.h_proto)))
 			skb_pull(frame, ETH_ALEN + 2);
-		}
 
 		memcpy(skb_push(frame, sizeof(eth)), &eth, sizeof(eth));
 		__skb_queue_tail(list, frame);
-- 
2.38.1

