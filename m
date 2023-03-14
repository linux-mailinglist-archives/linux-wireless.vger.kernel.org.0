Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDEF6B8F1D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 11:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCNKAX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCNKAO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 06:00:14 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6947040E
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tbKE/nYJ+7Lun0DwdA+0fm889JkIwEA4/XvzMJWgXUc=; b=M+qu3+/tP67Dw85Q+w08A54FkZ
        9X91gN6gvhCsExyq/OkfUJpiQ4nV0s/hP45ABZsUKXL4xUy80un1LXa2GQRrCtSvBRBl+1SJtxWI+
        NYJDcCIwrxITPepFvX0+iqgVja9T+6Y0Ie6EYI4Uqkwoyc6gw/KIK5to7whr7qfo9/gg=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pc1Ro-001pV5-RQ; Tue, 14 Mar 2023 11:00:00 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 7/7] mac80211: implement support for yet another mesh A-MSDU format
Date:   Tue, 14 Mar 2023 10:59:56 +0100
Message-Id: <20230314095956.62085-7-nbd@nbd.name>
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

MT7996 hardware supports mesh A-MSDU subframes in hardware, but uses a
big-endian length field

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 include/net/cfg80211.h  | 11 +++++++----
 net/mac80211/rx.c       | 22 ++++++++++++++++------
 net/mac80211/sta_info.h |  5 ++++-
 net/wireless/util.c     | 36 +++++++++++++++++++++++-------------
 4 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7cebba1c4135..86cb048dc924 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6274,10 +6274,13 @@ static inline int ieee80211_data_to_8023(struct sk_buff *skb, const u8 *addr,
  * mesh control field.
  *
  * @skb: The input A-MSDU frame without any headers.
- * @mesh_hdr: use standard compliant mesh A-MSDU subframe header
+ * @mesh_hdr: the type of mesh header to test
+ *	0: non-mesh A-MSDU length field
+ *	1: big-endian mesh A-MSDU length field
+ *	2: little-endian mesh A-MSDU length field
  * Returns: true if subframe header lengths are valid for the @mesh_hdr mode
  */
-bool ieee80211_is_valid_amsdu(struct sk_buff *skb, bool mesh_hdr);
+bool ieee80211_is_valid_amsdu(struct sk_buff *skb, u8 mesh_hdr);
 
 /**
  * ieee80211_amsdu_to_8023s - decode an IEEE 802.11n A-MSDU frame
@@ -6294,13 +6297,13 @@ bool ieee80211_is_valid_amsdu(struct sk_buff *skb, bool mesh_hdr);
  * @extra_headroom: The hardware extra headroom for SKBs in the @list.
  * @check_da: DA to check in the inner ethernet header, or NULL
  * @check_sa: SA to check in the inner ethernet header, or NULL
- * @mesh_control: A-MSDU subframe header includes the mesh control field
+ * @mesh_control: see mesh_hdr in ieee80211_is_valid_amsdu
  */
 void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 			      const u8 *addr, enum nl80211_iftype iftype,
 			      const unsigned int extra_headroom,
 			      const u8 *check_da, const u8 *check_sa,
-			      bool mesh_control);
+			      u8 mesh_control);
 
 /**
  * ieee80211_get_8023_tunnel_proto - get RFC1042 or bridge tunnel encap protocol
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 2a883d956260..3635d036375a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2983,13 +2983,23 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 		return RX_DROP_UNUSABLE;
 
 	if (rx->sta && rx->sta->amsdu_mesh_control < 0) {
-		bool valid_std = ieee80211_is_valid_amsdu(skb, true);
-		bool valid_nonstd = ieee80211_is_valid_amsdu(skb, false);
+		s8 valid = -1;
+		int i;
+
+		for (i = 0; i <= 2; i++) {
+			if (!ieee80211_is_valid_amsdu(skb, i))
+				continue;
+
+			if (valid >= 0) {
+				/* ambiguous */
+				valid = -1;
+				break;
+			}
+
+			valid = i;
+		}
 
-		if (valid_std && !valid_nonstd)
-			rx->sta->amsdu_mesh_control = 1;
-		else if (valid_nonstd && !valid_std)
-			rx->sta->amsdu_mesh_control = 0;
+		rx->sta->amsdu_mesh_control = valid;
 	}
 
 	ieee80211_amsdu_to_8023s(skb, &frame_list, dev->dev_addr,
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index e8e482a82d77..f354d470e174 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -623,7 +623,10 @@ struct link_sta_info {
  * @cparams: CoDel parameters for this station.
  * @reserved_tid: reserved TID (if any, otherwise IEEE80211_TID_UNRESERVED)
  * @amsdu_mesh_control: track the mesh A-MSDU format used by the peer
- *	(-1: not yet known, 0: non-standard [without mesh header], 1: standard)
+ *	(-1: not yet known,
+ *	  0: non-mesh A-MSDU length field
+ *	  1: big-endian mesh A-MSDU length field
+ *	  2: little-endian mesh A-MSDU length field)
  * @fast_tx: TX fastpath information
  * @fast_rx: RX fastpath information
  * @tdls_chandef: a TDLS peer can have a wider chandef that is compatible to
diff --git a/net/wireless/util.c b/net/wireless/util.c
index d1a89e82ead0..3bc0c3072e78 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -776,7 +776,24 @@ __ieee80211_amsdu_copy(struct sk_buff *skb, unsigned int hlen,
 	return frame;
 }
 
-bool ieee80211_is_valid_amsdu(struct sk_buff *skb, bool mesh_hdr)
+static u16
+ieee80211_amsdu_subframe_length(void *field, u8 mesh_flags, u8 hdr_type)
+{
+	__le16 *field_le = field;
+	__be16 *field_be = field;
+	u16 len;
+
+	if (hdr_type >= 2)
+		len = le16_to_cpu(*field_le);
+	else
+		len = be16_to_cpu(*field_be);
+	if (hdr_type)
+		len += __ieee80211_get_mesh_hdrlen(mesh_flags);
+
+	return len;
+}
+
+bool ieee80211_is_valid_amsdu(struct sk_buff *skb, u8 mesh_hdr)
 {
 	int offset = 0, remaining, subframe_len, padding;
 
@@ -790,12 +807,8 @@ bool ieee80211_is_valid_amsdu(struct sk_buff *skb, bool mesh_hdr)
 		if (skb_copy_bits(skb, offset + 2 * ETH_ALEN, &hdr, sizeof(hdr)) < 0)
 			return false;
 
-		if (mesh_hdr)
-			len = le16_to_cpu(*(__le16 *)&hdr.len) +
-			      __ieee80211_get_mesh_hdrlen(hdr.mesh_flags);
-		else
-			len = ntohs(hdr.len);
-
+		len = ieee80211_amsdu_subframe_length(&hdr.len, hdr.mesh_flags,
+						      mesh_hdr);
 		subframe_len = sizeof(struct ethhdr) + len;
 		padding = (4 - subframe_len) & 0x3;
 		remaining = skb->len - offset;
@@ -812,7 +825,7 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 			      const u8 *addr, enum nl80211_iftype iftype,
 			      const unsigned int extra_headroom,
 			      const u8 *check_da, const u8 *check_sa,
-			      bool mesh_control)
+			      u8 mesh_control)
 {
 	unsigned int hlen = ALIGN(extra_headroom, 4);
 	struct sk_buff *frame = NULL;
@@ -837,11 +850,8 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		skb_copy_bits(skb, offset, &hdr, copy_len);
 		if (iftype == NL80211_IFTYPE_MESH_POINT)
 			mesh_len = __ieee80211_get_mesh_hdrlen(hdr.flags);
-		if (mesh_control)
-			len = le16_to_cpu(*(__le16 *)&hdr.eth.h_proto) + mesh_len;
-		else
-			len = ntohs(hdr.eth.h_proto);
-
+		len = ieee80211_amsdu_subframe_length(&hdr.eth.h_proto, hdr.flags,
+						      mesh_control);
 		subframe_len = sizeof(struct ethhdr) + len;
 		padding = (4 - subframe_len) & 0x3;
 
-- 
2.39.0

