Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA394AB16E
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Feb 2022 19:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiBFSxt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Feb 2022 13:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiBFSxs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Feb 2022 13:53:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C0C06173B
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 10:53:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 665DC61209
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 18:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFFCC340E9;
        Sun,  6 Feb 2022 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173626;
        bh=eHzI7XA7UZJrXdBZHDMc/ITpzOGoVvXX6NvndNyGTI4=;
        h=From:To:Cc:Subject:Date:From;
        b=fHxTmU0AJr9fOh5sC62xbIYwdYY7EN1Zlwv576bdfTAiMxEaP+pm1EAI9OJn9j4xc
         yFd3JQnIuL3u/BGR+fHgnDqDZu8rxpXKcvORUTcRQf1ofQlgSatpe7DqCDby2iaDgx
         98oZFmxuKcpnUo4saReGBSqpFK/Lao7YcB0XFjMxIS3caHojpqOjnsfgfLI3mjtzQz
         HGEqz76plq+waVjbbuYl3X5hINqFRayrZ3Jtr09LPf/SB77RLqYw39csE7S2X1lEBz
         GZaRlyXnaAEnv9qDSqvrhLhmzs0rXsklRFYSwAvWbS30SPgHBUQtBQH9GD7mb5AX0s
         Pl+pQcZMpyBiQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        xing.song@mediatek.com
Subject: [PATCH] mt76: fix endianness errors in reverse_frag0_hdr_trans
Date:   Sun,  6 Feb 2022 19:53:23 +0100
Message-Id: <6c0181e3aa1197e9fc6bc1c2aa037211ba163a7c.1644173467.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix ht ctl field size in mt{7615,7915,7921}_reverse_frag0_hdr_trans.
Fix the following endianness warnings in mt{7615,7915,7921}_reverse_frag0_hdr_trans:

drivers/net/wireless/mediatek/mt76/mt7915/mac.c:417:29: warning: cast to restricted __le32
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:417:29: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:417:29: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:417:27: warning: incorrect type in assignment (different base types)
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:417:27:    expected restricted __le16 [usertype] frame_control
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:417:27:    got unsigned long
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:418:24: warning: cast to restricted __le32
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:418:24: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:418:24: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:418:22: warning: incorrect type in assignment (different base types)
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:418:22:    expected restricted __le16 [usertype] seq_ctrl
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:418:22:    got unsigned long
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:419:20: warning: cast to restricted __le32
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:419:20: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:419:20: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:419:18: warning: incorrect type in assignment (different base types)
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:419:18:    expected restricted __le32 [usertype] qos_ctrl
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:419:18:    got unsigned long
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:420:19: warning: cast to restricted __le32
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:420:19: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:420:19: warning: restricted __le32 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:420:17: warning: incorrect type in assignment (different base types)
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:420:17:    expected restricted __le32 [usertype] ht_ctrl
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:420:17:    got unsigned long
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:448:25: warning: restricted __be16 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:448:38: warning: restricted __be16 degrades to integer
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1450:23: warning: incorrect type in assignment (different base types)
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1450:23:    expected unsigned int [usertype] *cur_info
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1450:23:    got restricted __le32 *
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1451:34: warning: cast to restricted __le32

Fixes: dc5399a50b45f ("mt76: reverse the first fragmented frame to 802.11")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 31 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 30 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 30 +++++++++++-------
 3 files changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f035cd880696..80592d446bc3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -259,7 +259,7 @@ static int mt7615_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 	struct ieee80211_hdr hdr;
-	__le32 qos_ctrl, ht_ctrl;
+	u16 frame_control;
 
 	if (FIELD_GET(MT_RXD1_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[1])) !=
 	    MT_RXD1_NORMAL_U2M)
@@ -275,16 +275,15 @@ static int mt7615_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
 
 	/* store the info from RXD and ethhdr to avoid being overridden */
-	hdr.frame_control = FIELD_GET(MT_RXD4_FRAME_CONTROL, rxd[4]);
-	hdr.seq_ctrl = FIELD_GET(MT_RXD6_SEQ_CTRL, rxd[6]);
-	qos_ctrl = FIELD_GET(MT_RXD6_QOS_CTL, rxd[6]);
-	ht_ctrl = FIELD_GET(MT_RXD7_HT_CONTROL, rxd[7]);
-
+	frame_control = le32_get_bits(rxd[4], MT_RXD4_FRAME_CONTROL);
+	hdr.frame_control = cpu_to_le16(frame_control);
+	hdr.seq_ctrl = cpu_to_le16(le32_get_bits(rxd[6], MT_RXD6_SEQ_CTRL));
 	hdr.duration_id = 0;
+
 	ether_addr_copy(hdr.addr1, vif->addr);
 	ether_addr_copy(hdr.addr2, sta->addr);
-	switch (le16_to_cpu(hdr.frame_control) &
-		(IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) {
+	switch (frame_control & (IEEE80211_FCTL_TODS |
+				 IEEE80211_FCTL_FROMDS)) {
 	case 0:
 		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
 		break;
@@ -306,15 +305,23 @@ static int mt7615_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
 	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
 		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
-	else if (eth_hdr->h_proto >= cpu_to_be16(ETH_P_802_3_MIN))
+	else if (be16_to_cpu(eth_hdr->h_proto) >= ETH_P_802_3_MIN)
 		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
 	else
 		skb_pull(skb, 2);
 
 	if (ieee80211_has_order(hdr.frame_control))
-		memcpy(skb_push(skb, 2), &ht_ctrl, 2);
-	if (ieee80211_is_data_qos(hdr.frame_control))
-		memcpy(skb_push(skb, 2), &qos_ctrl, 2);
+		memcpy(skb_push(skb, IEEE80211_HT_CTL_LEN), &rxd[7],
+		       IEEE80211_HT_CTL_LEN);
+
+	if (ieee80211_is_data_qos(hdr.frame_control)) {
+		__le16 qos_ctrl;
+
+		qos_ctrl = cpu_to_le16(le32_get_bits(rxd[6], MT_RXD6_QOS_CTL));
+		memcpy(skb_push(skb, IEEE80211_QOS_CTL_LEN), &qos_ctrl,
+		       IEEE80211_QOS_CTL_LEN);
+	}
+
 	if (ieee80211_has_a4(hdr.frame_control))
 		memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 08ee78f6309b..713e534bf946 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -398,7 +398,7 @@ static int mt7915_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 	struct ieee80211_hdr hdr;
-	__le32 qos_ctrl, ht_ctrl;
+	u16 frame_control;
 
 	if (FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[3])) !=
 	    MT_RXD3_NORMAL_U2M)
@@ -414,16 +414,15 @@ static int mt7915_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
 
 	/* store the info from RXD and ethhdr to avoid being overridden */
-	hdr.frame_control = FIELD_GET(MT_RXD6_FRAME_CONTROL, rxd[6]);
-	hdr.seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, rxd[8]);
-	qos_ctrl = FIELD_GET(MT_RXD8_QOS_CTL, rxd[8]);
-	ht_ctrl = FIELD_GET(MT_RXD9_HT_CONTROL, rxd[9]);
-
+	frame_control = le32_get_bits(rxd[6], MT_RXD6_FRAME_CONTROL);
+	hdr.frame_control = cpu_to_le16(frame_control);
+	hdr.seq_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_SEQ_CTRL));
 	hdr.duration_id = 0;
+
 	ether_addr_copy(hdr.addr1, vif->addr);
 	ether_addr_copy(hdr.addr2, sta->addr);
-	switch (le16_to_cpu(hdr.frame_control) &
-		(IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) {
+	switch (frame_control & (IEEE80211_FCTL_TODS |
+				 IEEE80211_FCTL_FROMDS)) {
 	case 0:
 		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
 		break;
@@ -445,15 +444,22 @@ static int mt7915_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
 	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
 		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
-	else if (eth_hdr->h_proto >= cpu_to_be16(ETH_P_802_3_MIN))
+	else if (be16_to_cpu(eth_hdr->h_proto) >= ETH_P_802_3_MIN)
 		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
 	else
 		skb_pull(skb, 2);
 
 	if (ieee80211_has_order(hdr.frame_control))
-		memcpy(skb_push(skb, 2), &ht_ctrl, 2);
-	if (ieee80211_is_data_qos(hdr.frame_control))
-		memcpy(skb_push(skb, 2), &qos_ctrl, 2);
+		memcpy(skb_push(skb, IEEE80211_HT_CTL_LEN), &rxd[9],
+		       IEEE80211_HT_CTL_LEN);
+	if (ieee80211_is_data_qos(hdr.frame_control)) {
+		__le16 qos_ctrl;
+
+		qos_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_QOS_CTL));
+		memcpy(skb_push(skb, IEEE80211_QOS_CTL_LEN), &qos_ctrl,
+		       IEEE80211_QOS_CTL_LEN);
+	}
+
 	if (ieee80211_has_a4(hdr.frame_control))
 		memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index d17558349a17..9487ad4812c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -407,7 +407,7 @@ static int mt7921_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 	struct ieee80211_hdr hdr;
-	__le32 qos_ctrl, ht_ctrl;
+	u16 frame_control;
 
 	if (FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[3])) !=
 	    MT_RXD3_NORMAL_U2M)
@@ -423,16 +423,15 @@ static int mt7921_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
 
 	/* store the info from RXD and ethhdr to avoid being overridden */
-	hdr.frame_control = FIELD_GET(MT_RXD6_FRAME_CONTROL, rxd[6]);
-	hdr.seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, rxd[8]);
-	qos_ctrl = FIELD_GET(MT_RXD8_QOS_CTL, rxd[8]);
-	ht_ctrl = FIELD_GET(MT_RXD9_HT_CONTROL, rxd[9]);
-
+	frame_control = le32_get_bits(rxd[6], MT_RXD6_FRAME_CONTROL);
+	hdr.frame_control = cpu_to_le16(frame_control);
+	hdr.seq_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_SEQ_CTRL));
 	hdr.duration_id = 0;
+
 	ether_addr_copy(hdr.addr1, vif->addr);
 	ether_addr_copy(hdr.addr2, sta->addr);
-	switch (le16_to_cpu(hdr.frame_control) &
-		(IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) {
+	switch (frame_control & (IEEE80211_FCTL_TODS |
+				 IEEE80211_FCTL_FROMDS)) {
 	case 0:
 		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
 		break;
@@ -454,15 +453,22 @@ static int mt7921_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
 	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
 		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
-	else if (eth_hdr->h_proto >= cpu_to_be16(ETH_P_802_3_MIN))
+	else if (be16_to_cpu(eth_hdr->h_proto) >= ETH_P_802_3_MIN)
 		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
 	else
 		skb_pull(skb, 2);
 
 	if (ieee80211_has_order(hdr.frame_control))
-		memcpy(skb_push(skb, 2), &ht_ctrl, 2);
-	if (ieee80211_is_data_qos(hdr.frame_control))
-		memcpy(skb_push(skb, 2), &qos_ctrl, 2);
+		memcpy(skb_push(skb, IEEE80211_HT_CTL_LEN), &rxd[9],
+		       IEEE80211_HT_CTL_LEN);
+	if (ieee80211_is_data_qos(hdr.frame_control)) {
+		__le16 qos_ctrl;
+
+		qos_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_QOS_CTL));
+		memcpy(skb_push(skb, IEEE80211_QOS_CTL_LEN), &qos_ctrl,
+		       IEEE80211_QOS_CTL_LEN);
+	}
+
 	if (ieee80211_has_a4(hdr.frame_control))
 		memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
 	else
-- 
2.34.1

