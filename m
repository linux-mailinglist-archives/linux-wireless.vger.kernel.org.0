Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C684648978
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 21:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiLIUVd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 15:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLIUVZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 15:21:25 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7258E8DBE3
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 12:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ySnutvI0VeU/Z7Tl80MD70IkzDNzyxzSQwxqHpDCMCs=; b=d1t4rUgwtySjbtf3SRCyHl6q5z
        eOPUWNKdG6Ty4pV47oxq2sO4WJg6vtj5CKivdNLgiFntE+Fu+8ijWBLRRKmMuQGLfcztHD61yNQGh
        LM39jtR+isSy0kDv0IET3WfMklgKf1S1Y95rqltyvSj930lbsyj9lDNvbHsROZcmlu8g=;
Received: from p200300daa71613018d4aa8a5d898f578.dip0.t-ipconnect.de ([2003:da:a716:1301:8d4a:a8a5:d898:f578] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p3js2-007Tjz-KY; Fri, 09 Dec 2022 21:21:22 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [RFC 5/5] wifi: mac80211: add a workaround for receiving non-standard mesh A-MSDU
Date:   Fri,  9 Dec 2022 21:21:21 +0100
Message-Id: <20221209202121.55951-5-nbd@nbd.name>
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

At least ath10k and ath11k supported hardware (maybe more) does not implement
mesh A-MSDU aggregation in a standard compliant way.
802.11-2020 9.3.2.2.2 declares that the Mesh Control field is part of the
A-MSDU header. As such, its length must not be included in the subframe
length field.
Hardware affected by this bug treats the mesh control field as part of the
MSDU data and sets the length accordingly.
In order to avoid packet loss, keep track of which stations are affected
by this and take it into account when converting A-MSDU to 802.3 + mesh control
packets.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h  | 13 +++++++++++++
 net/mac80211/rx.c       | 15 ++++++++++++---
 net/mac80211/sta_info.c |  3 +++
 net/mac80211/sta_info.h |  1 +
 net/wireless/util.c     | 30 ++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 30d555585788..d6661d74b5bf 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6190,6 +6190,19 @@ static inline int ieee80211_data_to_8023(struct sk_buff *skb, const u8 *addr,
 	return ieee80211_data_to_8023_exthdr(skb, NULL, addr, iftype, 0, false);
 }
 
+/**
+ * ieee80211_is_valid_amsdu - check if subframe lengths of an A-MSDU are valid
+ *
+ * This is used to detect non-standard A-MSDU frames, e.g. the ones generated
+ * by ath10k and ath11k, where the subframe length includes the length of the
+ * mesh control field.
+ *
+ * @skb: The input A-MSDU frame without any headers.
+ * @mesh_hdr: use standard compliant mesh A-MSDU subframe header
+ * Returns: true if subframe header lengths are valid for the @mesh_hdr mode
+ */
+bool ieee80211_is_valid_amsdu(struct sk_buff *skb, bool mesh_hdr);
+
 /**
  * ieee80211_amsdu_to_8023s - decode an IEEE 802.11n A-MSDU frame
  *
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index b21bbf98173e..3fa7b36d4324 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2899,7 +2899,6 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 	static ieee80211_rx_result res;
 	struct ethhdr ethhdr;
 	const u8 *check_da = ethhdr.h_dest, *check_sa = ethhdr.h_source;
-	bool mesh = false;
 
 	if (unlikely(ieee80211_has_a4(hdr->frame_control))) {
 		check_da = NULL;
@@ -2917,7 +2916,6 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 		case NL80211_IFTYPE_MESH_POINT:
 			check_sa = NULL;
 			check_da = NULL;
-			mesh = true;
 			break;
 		default:
 			break;
@@ -2932,10 +2930,21 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 					  data_offset, true))
 		return RX_DROP_UNUSABLE;
 
+	if (rx->sta && rx->sta->amsdu_mesh_control < 0) {
+		bool valid_std = ieee80211_is_valid_amsdu(skb, true);
+		bool valid_nonstd = ieee80211_is_valid_amsdu(skb, false);
+
+		if (valid_std && !valid_nonstd)
+			rx->sta->amsdu_mesh_control = 1;
+		else if (valid_nonstd && !valid_std)
+			rx->sta->amsdu_mesh_control = 0;
+	}
+
 	ieee80211_amsdu_to_8023s(skb, &frame_list, dev->dev_addr,
 				 rx->sdata->vif.type,
 				 rx->local->hw.extra_tx_headroom,
-				 check_da, check_sa, mesh);
+				 check_da, check_sa,
+				 rx->sta->amsdu_mesh_control);
 
 	while (!skb_queue_empty(&frame_list)) {
 		rx->skb = __skb_dequeue(&frame_list);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 04e0f132b1d9..bb38156048f0 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -594,6 +594,9 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 
 	sta->sta_state = IEEE80211_STA_NONE;
 
+	if (sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
+		sta->amsdu_mesh_control = -1;
+
 	/* Mark TID as unreserved */
 	sta->reserved_tid = IEEE80211_TID_UNRESERVED;
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 69820b551668..bffe1987d049 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -707,6 +707,7 @@ struct sta_info {
 	struct codel_params cparams;
 
 	u8 reserved_tid;
+	s8 amsdu_mesh_control;
 
 	struct cfg80211_chan_def tdls_chandef;
 
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 8136998f31b7..2ddf3bf380a5 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -776,6 +776,36 @@ __ieee80211_amsdu_copy(struct sk_buff *skb, unsigned int hlen,
 	return frame;
 }
 
+bool ieee80211_is_valid_amsdu(struct sk_buff *skb, bool mesh_hdr)
+{
+	int offset = 0, remaining, subframe_len, padding;
+
+	for (offset = 0; offset < skb->len; offset += subframe_len + padding) {
+		struct {
+		    __be16 len;
+		    u8 mesh_flags;
+		} hdr;
+		u16 len;
+
+		if (skb_copy_bits(skb, offset + 2 * ETH_ALEN, &hdr, sizeof(hdr)) < 0)
+			return false;
+
+		len = ntohs(hdr.len);
+		if (mesh_hdr)
+			len += __ieee80211_get_mesh_hdrlen(hdr.mesh_flags);
+
+		subframe_len = sizeof(struct ethhdr) + len;
+		padding = (4 - subframe_len) & 0x3;
+		remaining = skb->len - offset;
+
+		if (subframe_len > remaining)
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(ieee80211_is_valid_amsdu);
+
 void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 			      const u8 *addr, enum nl80211_iftype iftype,
 			      const unsigned int extra_headroom,
-- 
2.38.1

