Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A463968E3
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 22:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhEaUdB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 16:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhEaUcs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 16:32:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8882DC061760;
        Mon, 31 May 2021 13:30:31 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lnoYP-000F87-L1; Mon, 31 May 2021 22:30:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     stable@vger.kernel.org, Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH v4.9 03/10] mac80211: properly handle A-MSDUs that start with an RFC 1042 header
Date:   Mon, 31 May 2021 22:30:14 +0200
Message-Id: <20210531203021.180010-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531203021.180010-1-johannes@sipsolutions.net>
References: <20210531203021.180010-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>

commit a1d5ff5651ea592c67054233b14b30bf4452999c upstream.

Properly parse A-MSDUs whose first 6 bytes happen to equal a rfc1042
header. This can occur in practice when the destination MAC address
equals AA:AA:03:00:00:00. More importantly, this simplifies the next
patch to mitigate A-MSDU injection attacks.

Cc: stable@vger.kernel.org
Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Link: https://lore.kernel.org/r/20210511200110.0b2b886492f0.I23dd5d685fe16d3b0ec8106e8f01b59f499dffed@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 5 +++--
 net/mac80211/rx.c      | 3 ++-
 net/wireless/util.c    | 5 +++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 28a0d7a8c142..ba388549b38c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4056,7 +4056,8 @@ unsigned int ieee80211_get_mesh_hdrlen(struct ieee80211s_hdr *meshhdr);
  * Return: 0 on success. Non-zero on error.
  */
 int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
-				  const u8 *addr, enum nl80211_iftype iftype);
+				  const u8 *addr, enum nl80211_iftype iftype,
+				  bool is_amsdu);
 
 /**
  * ieee80211_data_to_8023 - convert an 802.11 data frame to 802.3
@@ -4068,7 +4069,7 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 static inline int ieee80211_data_to_8023(struct sk_buff *skb, const u8 *addr,
 					 enum nl80211_iftype iftype)
 {
-	return ieee80211_data_to_8023_exthdr(skb, NULL, addr, iftype);
+	return ieee80211_data_to_8023_exthdr(skb, NULL, addr, iftype, false);
 }
 
 /**
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index d3aee2859f0a..6c54941a3265 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2428,7 +2428,8 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
 
 	if (ieee80211_data_to_8023_exthdr(skb, &ethhdr,
 					  rx->sdata->vif.addr,
-					  rx->sdata->vif.type))
+					  rx->sdata->vif.type,
+					  true))
 		return RX_DROP_UNUSABLE;
 
 	ieee80211_amsdu_to_8023s(skb, &frame_list, dev->dev_addr,
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 262922cf6a0c..8c67b7cf1def 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -421,7 +421,8 @@ unsigned int ieee80211_get_mesh_hdrlen(struct ieee80211s_hdr *meshhdr)
 EXPORT_SYMBOL(ieee80211_get_mesh_hdrlen);
 
 int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
-				  const u8 *addr, enum nl80211_iftype iftype)
+				  const u8 *addr, enum nl80211_iftype iftype,
+				  bool is_amsdu)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct {
@@ -509,7 +510,7 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 	skb_copy_bits(skb, hdrlen, &payload, sizeof(payload));
 	tmp.h_proto = payload.proto;
 
-	if (likely((ether_addr_equal(payload.hdr, rfc1042_header) &&
+	if (likely((!is_amsdu && ether_addr_equal(payload.hdr, rfc1042_header) &&
 		    tmp.h_proto != htons(ETH_P_AARP) &&
 		    tmp.h_proto != htons(ETH_P_IPX)) ||
 		   ether_addr_equal(payload.hdr, bridge_tunnel_header)))
-- 
2.31.1

