Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A3B48FCCE
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiAPMoB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiAPMoB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:44:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97024C06161C
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 04:44:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07B3360E05
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 12:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36131C36AE7;
        Sun, 16 Jan 2022 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642337039;
        bh=0IuUBHjxCPOi9w+Wo3W1aMyTUQce9Exu5KvAt/7pQac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhHiPNmw9X3iSxuR3Z3z2s5qVnGztm9fxJrOrzLSOjUCn+pa6mJ/47TKLNsBwR+6B
         3GXVMzJrGPtNyf9xYwm0s74ni7I1DwTsgb/H9jfBmfXTcQczMCD+yQHWvKkzChJUFA
         drku4yTvG14HOVDnz9K4rF/oJPI7fnqK/FCaK+HQHO3xAm4esSqKMdbr4u166/BqGW
         AiN11/O2F7L3R+QK6EruB/or4+HmiN8fP+TDypfXxa9TC5Q7UgnUb8IFCG9U3VHraa
         8/eKFfnQNggYMZMcSfcLexixXP7psxcGxWycJvpI6DdydWORRnf/v+lNWhfiXtfOf5
         39x8lQDxqhwFA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 3/5] mt76: connac: move mt76_connac_reverse_frag0_hdr_trans in common module
Date:   Sun, 16 Jan 2022 13:43:16 +0100
Message-Id: <61211a4a3cfe2925dc83f8fac86292e46395606b.1642336806.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642336806.git.lorenzo@kernel.org>
References: <cover.1642336806.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_reverse_frag0_hdr_trans in mt76-connac since it is
shared between mt7921 and mt7915 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 68 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 88 +++----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 88 +++----------------
 4 files changed, 97 insertions(+), 150 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index e624843c2a25..04fa8706e7f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -239,5 +239,8 @@ void mt76_connac_pm_queue_skb(struct ieee80211_hw *hw,
 			      struct sk_buff *skb);
 void mt76_connac_pm_dequeue_skbs(struct mt76_phy *phy,
 				 struct mt76_connac_pm *pm);
+int mt76_connac_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_offset,
+					struct ieee80211_sta *sta,
+					struct ieee80211_vif *vif);
 
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 306e9eaea917..78864252b782 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: ISC
 /* Copyright (C) 2020 MediaTek Inc. */
 
+#include "mt76_connac_mac.h"
 #include "mt76_connac.h"
 
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
@@ -115,3 +116,70 @@ void mt76_connac_pm_dequeue_skbs(struct mt76_phy *phy,
 	mt76_worker_schedule(&phy->dev->tx_worker);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_pm_dequeue_skbs);
+
+/* The HW does not translate the mac header to 802.3 for mesh point */
+int mt76_connac_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_offset,
+					struct ieee80211_sta *sta,
+					struct ieee80211_vif *vif)
+{
+	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_offset);
+	__le32 *rxd = (__le32 *)skb->data;
+	struct ieee80211_hdr hdr;
+	__le32 qos_ctrl, ht_ctrl;
+
+	if (FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[3])) !=
+	    MT_RXD3_NORMAL_U2M)
+		return -EINVAL;
+
+	if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))
+		return -EINVAL;
+
+	/* store the info from RXD and ethhdr to avoid being overridden */
+	hdr.frame_control = FIELD_GET(MT_RXD6_FRAME_CONTROL, rxd[6]);
+	hdr.seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, rxd[8]);
+	qos_ctrl = FIELD_GET(MT_RXD8_QOS_CTL, rxd[8]);
+	ht_ctrl = FIELD_GET(MT_RXD9_HT_CONTROL, rxd[9]);
+
+	hdr.duration_id = 0;
+	ether_addr_copy(hdr.addr1, vif->addr);
+	ether_addr_copy(hdr.addr2, sta->addr);
+	switch (le16_to_cpu(hdr.frame_control) &
+		(IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) {
+	case 0:
+		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
+		break;
+	case IEEE80211_FCTL_FROMDS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_source);
+		break;
+	case IEEE80211_FCTL_TODS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		break;
+	case IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		ether_addr_copy(hdr.addr4, eth_hdr->h_source);
+		break;
+	default:
+		break;
+	}
+
+	skb_pull(skb, hdr_offset + sizeof(struct ethhdr) - 2);
+	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
+	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
+		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
+	else if (eth_hdr->h_proto >= cpu_to_be16(ETH_P_802_3_MIN))
+		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
+	else
+		skb_pull(skb, 2);
+
+	if (ieee80211_has_order(hdr.frame_control))
+		memcpy(skb_push(skb, 2), &ht_ctrl, 2);
+	if (ieee80211_is_data_qos(hdr.frame_control))
+		memcpy(skb_push(skb, 2), &qos_ctrl, 2);
+	if (ieee80211_has_a4(hdr.frame_control))
+		memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+	else
+		memcpy(skb_push(skb, sizeof(hdr) - 6), &hdr, sizeof(hdr) - 6);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_reverse_frag0_hdr_trans);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index d11002342f01..121ac5b59107 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -387,80 +387,6 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u32 mode)
 	}
 }
 
-/* The HW does not translate the mac header to 802.3 for mesh point */
-static int mt7915_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
-{
-	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_gap);
-	struct mt7915_sta *msta = (struct mt7915_sta *)status->wcid;
-	__le32 *rxd = (__le32 *)skb->data;
-	struct ieee80211_sta *sta;
-	struct ieee80211_vif *vif;
-	struct ieee80211_hdr hdr;
-	__le32 qos_ctrl, ht_ctrl;
-
-	if (FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[3])) !=
-	    MT_RXD3_NORMAL_U2M)
-		return -EINVAL;
-
-	if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))
-		return -EINVAL;
-
-	if (!msta || !msta->vif)
-		return -EINVAL;
-
-	sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
-	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
-
-	/* store the info from RXD and ethhdr to avoid being overridden */
-	hdr.frame_control = FIELD_GET(MT_RXD6_FRAME_CONTROL, rxd[6]);
-	hdr.seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, rxd[8]);
-	qos_ctrl = FIELD_GET(MT_RXD8_QOS_CTL, rxd[8]);
-	ht_ctrl = FIELD_GET(MT_RXD9_HT_CONTROL, rxd[9]);
-
-	hdr.duration_id = 0;
-	ether_addr_copy(hdr.addr1, vif->addr);
-	ether_addr_copy(hdr.addr2, sta->addr);
-	switch (le16_to_cpu(hdr.frame_control) &
-		(IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) {
-	case 0:
-		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
-		break;
-	case IEEE80211_FCTL_FROMDS:
-		ether_addr_copy(hdr.addr3, eth_hdr->h_source);
-		break;
-	case IEEE80211_FCTL_TODS:
-		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
-		break;
-	case IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS:
-		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
-		ether_addr_copy(hdr.addr4, eth_hdr->h_source);
-		break;
-	default:
-		break;
-	}
-
-	skb_pull(skb, hdr_gap + sizeof(struct ethhdr) - 2);
-	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
-	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
-		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
-	else if (eth_hdr->h_proto >= cpu_to_be16(ETH_P_802_3_MIN))
-		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
-	else
-		skb_pull(skb, 2);
-
-	if (ieee80211_has_order(hdr.frame_control))
-		memcpy(skb_push(skb, 2), &ht_ctrl, 2);
-	if (ieee80211_is_data_qos(hdr.frame_control))
-		memcpy(skb_push(skb, 2), &qos_ctrl, 2);
-	if (ieee80211_has_a4(hdr.frame_control))
-		memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
-	else
-		memcpy(skb_push(skb, sizeof(hdr) - 6), &hdr, sizeof(hdr) - 6);
-
-	return 0;
-}
-
 static int
 mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			struct mt76_rx_status *status,
@@ -781,8 +707,20 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	hdr_gap = (u8 *)rxd - skb->data + 2 * remove_pad;
 	if (hdr_trans && ieee80211_has_morefrags(fc)) {
-		if (mt7915_reverse_frag0_hdr_trans(skb, hdr_gap))
+		struct mt7915_sta *msta = (struct mt7915_sta *)status->wcid;
+		struct ieee80211_sta *sta;
+		struct ieee80211_vif *vif;
+
+		if (!msta || !msta->vif)
+			return -EINVAL;
+
+		sta = container_of((void *)msta, struct ieee80211_sta,
+				   drv_priv);
+		vif = container_of((void *)msta->vif, struct ieee80211_vif,
+				   drv_priv);
+		if (mt76_connac_reverse_frag0_hdr_trans(skb, hdr_gap, sta, vif))
 			return -EINVAL;
+
 		hdr_trans = false;
 	} else {
 		int pad_start = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 0d3f6bbc0c5f..74ebd518b8f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -398,80 +398,6 @@ mt7921_mac_assoc_rssi(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt7921_mac_rssi_iter, skb);
 }
 
-/* The HW does not translate the mac header to 802.3 for mesh point */
-static int mt7921_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
-{
-	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_gap);
-	struct mt7921_sta *msta = (struct mt7921_sta *)status->wcid;
-	__le32 *rxd = (__le32 *)skb->data;
-	struct ieee80211_sta *sta;
-	struct ieee80211_vif *vif;
-	struct ieee80211_hdr hdr;
-	__le32 qos_ctrl, ht_ctrl;
-
-	if (FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, le32_to_cpu(rxd[3])) !=
-	    MT_RXD3_NORMAL_U2M)
-		return -EINVAL;
-
-	if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))
-		return -EINVAL;
-
-	if (!msta || !msta->vif)
-		return -EINVAL;
-
-	sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
-	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
-
-	/* store the info from RXD and ethhdr to avoid being overridden */
-	hdr.frame_control = FIELD_GET(MT_RXD6_FRAME_CONTROL, rxd[6]);
-	hdr.seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, rxd[8]);
-	qos_ctrl = FIELD_GET(MT_RXD8_QOS_CTL, rxd[8]);
-	ht_ctrl = FIELD_GET(MT_RXD9_HT_CONTROL, rxd[9]);
-
-	hdr.duration_id = 0;
-	ether_addr_copy(hdr.addr1, vif->addr);
-	ether_addr_copy(hdr.addr2, sta->addr);
-	switch (le16_to_cpu(hdr.frame_control) &
-		(IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) {
-	case 0:
-		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
-		break;
-	case IEEE80211_FCTL_FROMDS:
-		ether_addr_copy(hdr.addr3, eth_hdr->h_source);
-		break;
-	case IEEE80211_FCTL_TODS:
-		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
-		break;
-	case IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS:
-		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
-		ether_addr_copy(hdr.addr4, eth_hdr->h_source);
-		break;
-	default:
-		break;
-	}
-
-	skb_pull(skb, hdr_gap + sizeof(struct ethhdr) - 2);
-	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
-	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
-		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
-	else if (eth_hdr->h_proto >= cpu_to_be16(ETH_P_802_3_MIN))
-		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
-	else
-		skb_pull(skb, 2);
-
-	if (ieee80211_has_order(hdr.frame_control))
-		memcpy(skb_push(skb, 2), &ht_ctrl, 2);
-	if (ieee80211_is_data_qos(hdr.frame_control))
-		memcpy(skb_push(skb, 2), &qos_ctrl, 2);
-	if (ieee80211_has_a4(hdr.frame_control))
-		memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
-	else
-		memcpy(skb_push(skb, sizeof(hdr) - 6), &hdr, sizeof(hdr) - 6);
-
-	return 0;
-}
-
 static int
 mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -758,8 +684,20 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	hdr_gap = (u8 *)rxd - skb->data + 2 * remove_pad;
 	if (hdr_trans && ieee80211_has_morefrags(fc)) {
-		if (mt7921_reverse_frag0_hdr_trans(skb, hdr_gap))
+		struct mt7921_sta *msta = (struct mt7921_sta *)status->wcid;
+		struct ieee80211_sta *sta;
+		struct ieee80211_vif *vif;
+
+		if (!msta || !msta->vif)
+			return -EINVAL;
+
+		sta = container_of((void *)msta, struct ieee80211_sta,
+				   drv_priv);
+		vif = container_of((void *)msta->vif, struct ieee80211_vif,
+				   drv_priv);
+		if (mt76_connac_reverse_frag0_hdr_trans(skb, hdr_gap, sta, vif))
 			return -EINVAL;
+
 		hdr_trans = false;
 	} else {
 		skb_pull(skb, hdr_gap);
-- 
2.34.1

