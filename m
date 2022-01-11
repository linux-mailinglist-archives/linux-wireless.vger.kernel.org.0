Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD27448B07B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 16:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiAKPKS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 10:10:18 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50838 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiAKPKS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 10:10:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CD02ECE17B8
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 15:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E58FC36AEB;
        Tue, 11 Jan 2022 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641913815;
        bh=PEIDX/NK1IgwrjgcmC7KUyvZCr9AC09LwvOEY5DSK8k=;
        h=From:To:Cc:Subject:Date:From;
        b=qgJFqZY3mYRL/Ls5WAQ3JH9iBC8QbW3c7pfkfSOsAEWUKkQAJQd8UQ/Z+rFpjX7vE
         sQt7g4iD01qnJNHo0D567Scntd0D9z6IcFc5c2rvxEcem4TJx0mQ4/BRFmdntz4INj
         JbHhExBpnVlgo7oyGZXViUI6ajzGZoSFwlfevf3IqTIGbqpeayB/uSeVbmi+UYA1qf
         t2uwDHe8aZJRBiJ3YS7GklUNE7/tjxsFIbbjWzAeaIlbe9MW67rBD/OxVfW/Ep4AuP
         t3cA35n6S5NJPyx52jxfx9SOh7AfC8yHb05mLJkHXQJEXa7j7C+tzp5dxTq/rkTCqv
         r4GNAW+wJHNPA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com, xing.song@mediatek.com
Subject: [RFT] mt76: do not always copy ethhdr in reverse_frag0_hdr_trans
Date:   Tue, 11 Jan 2022 16:10:05 +0100
Message-Id: <896ddb611e2f1f68c6da87c6baee61df5d2f295a.1641913505.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not always copy ethernet header in mt{7615,7915,7921}_reverse_frag0_hdr_trans
and use a pointer instead.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 19 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 19 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 19 +++++++++----------
 3 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index bc72791cdcb5..beb4c8db157d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -253,12 +253,12 @@ static void mt7615_mac_fill_tm_rx(struct mt7615_phy *phy, __le32 *rxv)
 static int mt7615_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_gap);
 	struct mt7615_sta *msta = (struct mt7615_sta *)status->wcid;
+	__le32 *rxd = (__le32 *)skb->data;
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 	struct ieee80211_hdr hdr;
-	struct ethhdr eth_hdr;
-	__le32 *rxd = (__le32 *)skb->data;
 	__le32 qos_ctrl, ht_ctrl;
 
 	if (FIELD_GET(MT_RXD1_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[1])) !=
@@ -275,7 +275,6 @@ static int mt7615_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
 
 	/* store the info from RXD and ethhdr to avoid being overridden */
-	memcpy(&eth_hdr, skb->data + hdr_gap, sizeof(eth_hdr));
 	hdr.frame_control = FIELD_GET(MT_RXD4_FRAME_CONTROL, rxd[4]);
 	hdr.seq_ctrl = FIELD_GET(MT_RXD6_SEQ_CTRL, rxd[6]);
 	qos_ctrl = FIELD_GET(MT_RXD6_QOS_CTL, rxd[6]);
@@ -290,24 +289,24 @@ static int mt7615_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
 		break;
 	case IEEE80211_FCTL_FROMDS:
-		ether_addr_copy(hdr.addr3, eth_hdr.h_source);
+		ether_addr_copy(hdr.addr3, eth_hdr->h_source);
 		break;
 	case IEEE80211_FCTL_TODS:
-		ether_addr_copy(hdr.addr3, eth_hdr.h_dest);
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
 		break;
 	case IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS:
-		ether_addr_copy(hdr.addr3, eth_hdr.h_dest);
-		ether_addr_copy(hdr.addr4, eth_hdr.h_source);
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		ether_addr_copy(hdr.addr4, eth_hdr->h_source);
 		break;
 	default:
 		break;
 	}
 
 	skb_pull(skb, hdr_gap + sizeof(struct ethhdr) - 2);
-	if (eth_hdr.h_proto == htons(ETH_P_AARP) ||
-	    eth_hdr.h_proto == htons(ETH_P_IPX))
+	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
+	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
 		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
-	else if (eth_hdr.h_proto >= htons(ETH_P_802_3_MIN))
+	else if (eth_hdr->h_proto >= cpu_to_be16(ETH_P_802_3_MIN))
 		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
 	else
 		skb_pull(skb, 2);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 08ec8ce34d77..39163567d712 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -391,12 +391,12 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u32 mode)
 static int mt7915_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_gap);
 	struct mt7915_sta *msta = (struct mt7915_sta *)status->wcid;
+	__le32 *rxd = (__le32 *)skb->data;
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 	struct ieee80211_hdr hdr;
-	struct ethhdr eth_hdr;
-	__le32 *rxd = (__le32 *)skb->data;
 	__le32 qos_ctrl, ht_ctrl;
 
 	if (FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[3])) !=
@@ -413,7 +413,6 @@ static int mt7915_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
 
 	/* store the info from RXD and ethhdr to avoid being overridden */
-	memcpy(&eth_hdr, skb->data + hdr_gap, sizeof(eth_hdr));
 	hdr.frame_control = FIELD_GET(MT_RXD6_FRAME_CONTROL, rxd[6]);
 	hdr.seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, rxd[8]);
 	qos_ctrl = FIELD_GET(MT_RXD8_QOS_CTL, rxd[8]);
@@ -428,24 +427,24 @@ static int mt7915_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
 		break;
 	case IEEE80211_FCTL_FROMDS:
-		ether_addr_copy(hdr.addr3, eth_hdr.h_source);
+		ether_addr_copy(hdr.addr3, eth_hdr->h_source);
 		break;
 	case IEEE80211_FCTL_TODS:
-		ether_addr_copy(hdr.addr3, eth_hdr.h_dest);
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
 		break;
 	case IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS:
-		ether_addr_copy(hdr.addr3, eth_hdr.h_dest);
-		ether_addr_copy(hdr.addr4, eth_hdr.h_source);
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		ether_addr_copy(hdr.addr4, eth_hdr->h_source);
 		break;
 	default:
 		break;
 	}
 
 	skb_pull(skb, hdr_gap + sizeof(struct ethhdr) - 2);
-	if (eth_hdr.h_proto == htons(ETH_P_AARP) ||
-	    eth_hdr.h_proto == htons(ETH_P_IPX))
+	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
+	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
 		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
-	else if (eth_hdr.h_proto >= htons(ETH_P_802_3_MIN))
+	else if (eth_hdr->h_proto >= cpu_to_be16(ETH_P_802_3_MIN))
 		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
 	else
 		skb_pull(skb, 2);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 0744f6e42ba3..83fd4fb6283c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -402,12 +402,12 @@ mt7921_mac_assoc_rssi(struct mt7921_dev *dev, struct sk_buff *skb)
 static int mt7921_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_gap);
 	struct mt7921_sta *msta = (struct mt7921_sta *)status->wcid;
+	__le32 *rxd = (__le32 *)skb->data;
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 	struct ieee80211_hdr hdr;
-	struct ethhdr eth_hdr;
-	__le32 *rxd = (__le32 *)skb->data;
 	__le32 qos_ctrl, ht_ctrl;
 
 	if (FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[3])) !=
@@ -424,7 +424,6 @@ static int mt7921_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
 
 	/* store the info from RXD and ethhdr to avoid being overridden */
-	memcpy(&eth_hdr, skb->data + hdr_gap, sizeof(eth_hdr));
 	hdr.frame_control = FIELD_GET(MT_RXD6_FRAME_CONTROL, rxd[6]);
 	hdr.seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, rxd[8]);
 	qos_ctrl = FIELD_GET(MT_RXD8_QOS_CTL, rxd[8]);
@@ -439,24 +438,24 @@ static int mt7921_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
 		break;
 	case IEEE80211_FCTL_FROMDS:
-		ether_addr_copy(hdr.addr3, eth_hdr.h_source);
+		ether_addr_copy(hdr.addr3, eth_hdr->h_source);
 		break;
 	case IEEE80211_FCTL_TODS:
-		ether_addr_copy(hdr.addr3, eth_hdr.h_dest);
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
 		break;
 	case IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS:
-		ether_addr_copy(hdr.addr3, eth_hdr.h_dest);
-		ether_addr_copy(hdr.addr4, eth_hdr.h_source);
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		ether_addr_copy(hdr.addr4, eth_hdr->h_source);
 		break;
 	default:
 		break;
 	}
 
 	skb_pull(skb, hdr_gap + sizeof(struct ethhdr) - 2);
-	if (eth_hdr.h_proto == htons(ETH_P_AARP) ||
-	    eth_hdr.h_proto == htons(ETH_P_IPX))
+	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
+	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
 		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
-	else if (eth_hdr.h_proto >= htons(ETH_P_802_3_MIN))
+	else if (eth_hdr->h_proto >= cpu_to_be16(ETH_P_802_3_MIN))
 		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
 	else
 		skb_pull(skb, 2);
-- 
2.34.1

