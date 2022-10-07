Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722785F7861
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Oct 2022 14:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJGM4V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 08:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJGM4T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 08:56:19 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2EA59B1
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Oj0IhwamM3/YVm4UvrgulacZ3yhJ989c6P+eDpXpA2g=; b=bnwMpvZwvTiDI9U0JYwvmKLdE1
        E6Nn9Fys9ZIBB6F9Ca9DF3nTAbqKRAFIdVTXy7FxouIcXH/jmsbRZeQ4JF5q3H5NUe5QHQoU3M2lV
        uSIfbu1gsjiq3t+wp0yafR/eczWWfz0UJBEnnLoBomqThy638o6JYDL5EW3RAGlWNX6s=;
Received: from p200300daa7301d00c861250ac39289eb.dip0.t-ipconnect.de ([2003:da:a730:1d00:c861:250a:c392:89eb] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ogmth-00B0Mq-VH; Fri, 07 Oct 2022 14:56:14 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Chad Monroe <chad.monroe@smartrg.com>
Subject: [PATCH v2 6.1 1/2] wifi: cfg80211: fix ieee80211_data_to_8023_exthdr handling of small packets
Date:   Fri,  7 Oct 2022 14:56:11 +0200
Message-Id: <20221007125612.88211-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
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

STP topology change notification packets only have a payload of 7 bytes,
so they get dropped due to the skb->len < hdrlen + 8 check.
Fix this by removing skb->len based checks and instead check the return code
on the skb_copy_bits calls.

Fixes: 2d1c304cb2d5 ("cfg80211: add function for 802.3 conversion with separate output buffer")
Reported-by: Chad Monroe <chad.monroe@smartrg.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/wireless/util.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 01493568a21d..1f285b515028 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -559,7 +559,7 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 		return -1;
 
 	hdrlen = ieee80211_hdrlen(hdr->frame_control) + data_offset;
-	if (skb->len < hdrlen + 8)
+	if (skb->len < hdrlen)
 		return -1;
 
 	/* convert IEEE 802.11 header + possible LLC headers into Ethernet
@@ -574,8 +574,9 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 	memcpy(tmp.h_dest, ieee80211_get_DA(hdr), ETH_ALEN);
 	memcpy(tmp.h_source, ieee80211_get_SA(hdr), ETH_ALEN);
 
-	if (iftype == NL80211_IFTYPE_MESH_POINT)
-		skb_copy_bits(skb, hdrlen, &mesh_flags, 1);
+	if (iftype == NL80211_IFTYPE_MESH_POINT &&
+	    skb_copy_bits(skb, hdrlen, &mesh_flags, 1) < 0)
+		return -1;
 
 	mesh_flags &= MESH_FLAGS_AE;
 
@@ -595,11 +596,12 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 		if (iftype == NL80211_IFTYPE_MESH_POINT) {
 			if (mesh_flags == MESH_FLAGS_AE_A4)
 				return -1;
-			if (mesh_flags == MESH_FLAGS_AE_A5_A6) {
-				skb_copy_bits(skb, hdrlen +
-					offsetof(struct ieee80211s_hdr, eaddr1),
-					tmp.h_dest, 2 * ETH_ALEN);
-			}
+			if (mesh_flags == MESH_FLAGS_AE_A5_A6 &&
+			    skb_copy_bits(skb, hdrlen +
+					  offsetof(struct ieee80211s_hdr, eaddr1),
+					  tmp.h_dest, 2 * ETH_ALEN) < 0)
+				return -1;
+
 			hdrlen += __ieee80211_get_mesh_hdrlen(mesh_flags);
 		}
 		break;
@@ -613,10 +615,11 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 		if (iftype == NL80211_IFTYPE_MESH_POINT) {
 			if (mesh_flags == MESH_FLAGS_AE_A5_A6)
 				return -1;
-			if (mesh_flags == MESH_FLAGS_AE_A4)
-				skb_copy_bits(skb, hdrlen +
-					offsetof(struct ieee80211s_hdr, eaddr1),
-					tmp.h_source, ETH_ALEN);
+			if (mesh_flags == MESH_FLAGS_AE_A4 &&
+			    skb_copy_bits(skb, hdrlen +
+					  offsetof(struct ieee80211s_hdr, eaddr1),
+					  tmp.h_source, ETH_ALEN) < 0)
+				return -1;
 			hdrlen += __ieee80211_get_mesh_hdrlen(mesh_flags);
 		}
 		break;
@@ -628,16 +631,15 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 		break;
 	}
 
-	skb_copy_bits(skb, hdrlen, &payload, sizeof(payload));
-	tmp.h_proto = payload.proto;
-
-	if (likely((!is_amsdu && ether_addr_equal(payload.hdr, rfc1042_header) &&
-		    tmp.h_proto != htons(ETH_P_AARP) &&
-		    tmp.h_proto != htons(ETH_P_IPX)) ||
-		   ether_addr_equal(payload.hdr, bridge_tunnel_header))) {
+	if (likely(skb_copy_bits(skb, hdrlen, &payload, sizeof(payload)) == 0 &&
+	           ((!is_amsdu && ether_addr_equal(payload.hdr, rfc1042_header) &&
+		     payload.proto != htons(ETH_P_AARP) &&
+		     payload.proto != htons(ETH_P_IPX)) ||
+		    ether_addr_equal(payload.hdr, bridge_tunnel_header)))) {
 		/* remove RFC1042 or Bridge-Tunnel encapsulation and
 		 * replace EtherType */
 		hdrlen += ETH_ALEN + 2;
+		tmp.h_proto = payload.proto;
 		skb_postpull_rcsum(skb, &payload, ETH_ALEN + 2);
 	} else {
 		tmp.h_proto = htons(skb->len - hdrlen);
-- 
2.36.1

