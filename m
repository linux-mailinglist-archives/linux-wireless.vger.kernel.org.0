Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BCD543A75
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiFHRbN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 13:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiFHRbK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 13:31:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7151CF
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 10:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB40561B3B
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 17:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2318C34116;
        Wed,  8 Jun 2022 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654709466;
        bh=fj5CJYjT8Hd107d3E7VWLNVo0k2IxWrju5V5ZIk2J1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgQpfKUOWBloEeFQsNCes7pHlgjQrX+LH7X4rUMmUDgYopPI3cqIA7mwlw7YVIxbQ
         nOb0ixCTSCbAVCvv3T4pkxz1VX0rFki900WQMFYGg7LSW2IxMmd73HP11xZ+974bq4
         vLh430xuGhoHXyT8M7FknEdo+9IH9Kic2eELYhRYBgCbrFxa4kaEerdXzXd1yH5er1
         KOq4yXTpmXO9dBb7RSuTqEj5QBLsLuypa9O44azSleJ1ycOcGrC2sUS+kBBdk1Fbef
         csWXweeSOgSvpwcG4cBctuTSi7Y2/r4rOKpfVlLOpgWKR12jPFyFL11bnE23V9Lpb/
         AhZ7tokEdy8dw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 2/3] mt76: connac: move mt76_connac2_reverse_frag0_hdr_trans in mt76-connac module
Date:   Wed,  8 Jun 2022 19:30:30 +0200
Message-Id: <606ede0ee0352e0d8767a8fe0378f75dbe199417.1654709072.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654709072.git.lorenzo@kernel.org>
References: <cover.1654709072.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76_connac2_reverse_frag0_hdr_trans routine is shared between mt7921
and mt7915e drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  2 +
 .../wireless/mediatek/mt76/mt76_connac2_mac.h | 86 ++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 76 +++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 97 +++----------------
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 87 -----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 95 +++---------------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 84 ----------------
 7 files changed, 189 insertions(+), 338 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index c06a320b53bc..27ab1f2355ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -256,5 +256,7 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
 					 struct sk_buff *skb,
 					 __le32 *rxv, u32 mode);
+int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,
+					 struct sk_buff *skb, u16 hdr_offset);
 
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index f2de2f6d04a1..0d04207b4292 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -164,6 +164,92 @@ enum {
 
 #define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
 
+/* RXD DW1 */
+#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
+#define MT_RXD1_NORMAL_GROUP_1		BIT(11)
+#define MT_RXD1_NORMAL_GROUP_2		BIT(12)
+#define MT_RXD1_NORMAL_GROUP_3		BIT(13)
+#define MT_RXD1_NORMAL_GROUP_4		BIT(14)
+#define MT_RXD1_NORMAL_GROUP_5		BIT(15)
+#define MT_RXD1_NORMAL_SEC_MODE		GENMASK(20, 16)
+#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
+#define MT_RXD1_NORMAL_CM		BIT(23)
+#define MT_RXD1_NORMAL_CLM		BIT(24)
+#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
+#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
+#define MT_RXD1_NORMAL_FCS_ERR		BIT(27)
+#define MT_RXD1_NORMAL_BAND_IDX		BIT(28)
+#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
+#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
+#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
+
+/* RXD DW2 */
+#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
+#define MT_RXD2_NORMAL_CO_ANT		BIT(6)
+#define MT_RXD2_NORMAL_BF_CQI		BIT(7)
+#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
+#define MT_RXD2_NORMAL_HDR_TRANS	BIT(13)
+#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 14)
+#define MT_RXD2_NORMAL_TID		GENMASK(19, 16)
+#define MT_RXD2_NORMAL_MU_BAR		BIT(21)
+#define MT_RXD2_NORMAL_SW_BIT		BIT(22)
+#define MT_RXD2_NORMAL_AMSDU_ERR	BIT(23)
+#define MT_RXD2_NORMAL_MAX_LEN_ERROR	BIT(24)
+#define MT_RXD2_NORMAL_HDR_TRANS_ERROR	BIT(25)
+#define MT_RXD2_NORMAL_INT_FRAME	BIT(26)
+#define MT_RXD2_NORMAL_FRAG		BIT(27)
+#define MT_RXD2_NORMAL_NULL_FRAME	BIT(28)
+#define MT_RXD2_NORMAL_NDATA		BIT(29)
+#define MT_RXD2_NORMAL_NON_AMPDU	BIT(30)
+#define MT_RXD2_NORMAL_BF_REPORT	BIT(31)
+
+/* RXD DW4 */
+#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
+#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
+#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
+#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
+#define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
+#define MT_RXD4_NORMAL_CLS		BIT(10)
+#define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
+#define MT_RXD4_NORMAL_MAGIC_PKT	BIT(13)
+#define MT_RXD4_NORMAL_WOL		GENMASK(18, 14)
+#define MT_RXD4_NORMAL_CLS_BITMAP	GENMASK(28, 19)
+#define MT_RXD3_NORMAL_PF_MODE		BIT(29)
+#define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
+
+#define MT_RXV_HDR_BAND_IDX		BIT(24)
+
+/* RXD DW3 */
+#define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
+#define MT_RXD3_NORMAL_CH_FREQ		GENMASK(15, 8)
+#define MT_RXD3_NORMAL_ADDR_TYPE	GENMASK(17, 16)
+#define MT_RXD3_NORMAL_U2M		BIT(0)
+#define MT_RXD3_NORMAL_HTC_VLD		BIT(0)
+#define MT_RXD3_NORMAL_TSF_COMPARE_LOSS	BIT(19)
+#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
+#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
+#define MT_RXD3_NORMAL_AMSDU		BIT(22)
+#define MT_RXD3_NORMAL_MESH		BIT(23)
+#define MT_RXD3_NORMAL_MHCP		BIT(24)
+#define MT_RXD3_NORMAL_NO_INFO_WB	BIT(25)
+#define MT_RXD3_NORMAL_DISABLE_RX_HDR_TRANS	BIT(26)
+#define MT_RXD3_NORMAL_POWER_SAVE_STAT	BIT(27)
+#define MT_RXD3_NORMAL_MORE		BIT(28)
+#define MT_RXD3_NORMAL_UNWANT		BIT(29)
+#define MT_RXD3_NORMAL_RX_DROP		BIT(30)
+#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
+
+/* RXD GROUP4 */
+#define MT_RXD6_FRAME_CONTROL		GENMASK(15, 0)
+#define MT_RXD6_TA_LO			GENMASK(31, 16)
+
+#define MT_RXD7_TA_HI			GENMASK(31, 0)
+
+#define MT_RXD8_SEQ_CTRL		GENMASK(15, 0)
+#define MT_RXD8_QOS_CTL			GENMASK(31, 16)
+
+#define MT_RXD9_HT_CONTROL		GENMASK(31, 0)
+
 /* P-RXV DW0 */
 #define MT_PRXV_TX_RATE			GENMASK(6, 0)
 #define MT_PRXV_TX_DCM			BIT(4)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 08cd2e1d8625..6ac1ac3f5480 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -708,3 +708,79 @@ void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
 	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_decode_he_radiotap);
+
+/* The HW does not translate the mac header to 802.3 for mesh point */
+int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,
+					 struct sk_buff *skb, u16 hdr_offset)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_offset);
+	__le32 *rxd = (__le32 *)skb->data;
+	struct ieee80211_sta *sta;
+	struct ieee80211_hdr hdr;
+	u16 frame_control;
+
+	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=
+	    MT_RXD3_NORMAL_U2M)
+		return -EINVAL;
+
+	if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))
+		return -EINVAL;
+
+	sta = container_of((void *)status->wcid, struct ieee80211_sta, drv_priv);
+
+	/* store the info from RXD and ethhdr to avoid being overridden */
+	frame_control = le32_get_bits(rxd[6], MT_RXD6_FRAME_CONTROL);
+	hdr.frame_control = cpu_to_le16(frame_control);
+	hdr.seq_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_SEQ_CTRL));
+	hdr.duration_id = 0;
+
+	ether_addr_copy(hdr.addr1, vif->addr);
+	ether_addr_copy(hdr.addr2, sta->addr);
+	switch (frame_control & (IEEE80211_FCTL_TODS |
+				 IEEE80211_FCTL_FROMDS)) {
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
+	else if (be16_to_cpu(eth_hdr->h_proto) >= ETH_P_802_3_MIN)
+		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
+	else
+		skb_pull(skb, 2);
+
+	if (ieee80211_has_order(hdr.frame_control))
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
+	if (ieee80211_has_a4(hdr.frame_control))
+		memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+	else
+		memcpy(skb_push(skb, sizeof(hdr) - 6), &hdr, sizeof(hdr) - 6);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_reverse_frag0_hdr_trans);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 27b2a9edb317..1d83f8790c44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -176,7 +176,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		/*
 		 * We don't support reading GI info from txs packets.
 		 * For accurate tx status reporting and AQL improvement,
-		 * we need to make sure that flags match so polling GI
+		  we need to make sure that flags match so polling GI
 		 * from per-sta counters directly.
 		 */
 		rate = &msta->wcid.rate;
@@ -214,86 +214,6 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 	rcu_read_unlock();
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
-	u16 frame_control;
-
-	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=
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
-	frame_control = le32_get_bits(rxd[6], MT_RXD6_FRAME_CONTROL);
-	hdr.frame_control = cpu_to_le16(frame_control);
-	hdr.seq_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_SEQ_CTRL));
-	hdr.duration_id = 0;
-
-	ether_addr_copy(hdr.addr1, vif->addr);
-	ether_addr_copy(hdr.addr2, sta->addr);
-	switch (frame_control & (IEEE80211_FCTL_TODS |
-				 IEEE80211_FCTL_FROMDS)) {
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
-	else if (be16_to_cpu(eth_hdr->h_proto) >= ETH_P_802_3_MIN)
-		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
-	else
-		skb_pull(skb, 2);
-
-	if (ieee80211_has_order(hdr.frame_control))
-		memcpy(skb_push(skb, IEEE80211_HT_CTL_LEN), &rxd[9],
-		       IEEE80211_HT_CTL_LEN);
-	if (ieee80211_is_data_qos(hdr.frame_control)) {
-		__le16 qos_ctrl;
-
-		qos_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_QOS_CTL));
-		memcpy(skb_push(skb, IEEE80211_QOS_CTL_LEN), &qos_ctrl,
-		       IEEE80211_QOS_CTL_LEN);
-	}
-
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
@@ -414,6 +334,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	bool unicast, insert_ccmp_hdr = false;
 	u8 remove_pad, amsdu_info;
 	u8 mode = 0, qos_ctl = 0;
+	struct mt7915_sta *msta;
 	bool hdr_trans;
 	u16 hdr_gap;
 	u16 seq_ctrl = 0;
@@ -450,8 +371,6 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	status->wcid = mt7915_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
-		struct mt7915_sta *msta;
-
 		msta = container_of(status->wcid, struct mt7915_sta, wcid);
 		spin_lock_bh(&dev->sta_poll_lock);
 		if (list_empty(&msta->poll_list))
@@ -605,8 +524,18 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	hdr_gap = (u8 *)rxd - skb->data + 2 * remove_pad;
 	if (hdr_trans && ieee80211_has_morefrags(fc)) {
-		if (mt7915_reverse_frag0_hdr_trans(skb, hdr_gap))
+		struct ieee80211_vif *vif;
+		int err;
+
+		if (!msta || !msta->vif)
 			return -EINVAL;
+
+		vif = container_of((void *)msta->vif, struct ieee80211_vif,
+				   drv_priv);
+		err = mt76_connac2_reverse_frag0_hdr_trans(vif, skb, hdr_gap);
+		if (err)
+			return err;
+
 		hdr_trans = false;
 	} else {
 		int pad_start = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 611bf23b2eb0..724feb2df4a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -29,93 +29,6 @@ enum rx_pkt_type {
 	PKT_TYPE_TXRX_NOTIFY_V0 = 0x18,
 };
 
-/* RXD DW1 */
-#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
-#define MT_RXD1_NORMAL_GROUP_1		BIT(11)
-#define MT_RXD1_NORMAL_GROUP_2		BIT(12)
-#define MT_RXD1_NORMAL_GROUP_3		BIT(13)
-#define MT_RXD1_NORMAL_GROUP_4		BIT(14)
-#define MT_RXD1_NORMAL_GROUP_5		BIT(15)
-#define MT_RXD1_NORMAL_SEC_MODE		GENMASK(20, 16)
-#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
-#define MT_RXD1_NORMAL_CM		BIT(23)
-#define MT_RXD1_NORMAL_CLM		BIT(24)
-#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
-#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
-#define MT_RXD1_NORMAL_FCS_ERR		BIT(27)
-#define MT_RXD1_NORMAL_BAND_IDX		BIT(28)
-#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
-#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
-#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
-
-/* RXD DW2 */
-#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
-#define MT_RXD2_NORMAL_CO_ANT		BIT(6)
-#define MT_RXD2_NORMAL_BF_CQI		BIT(7)
-#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
-#define MT_RXD2_NORMAL_HDR_TRANS	BIT(13)
-#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 14)
-#define MT_RXD2_NORMAL_TID		GENMASK(19, 16)
-#define MT_RXD2_NORMAL_MU_BAR		BIT(21)
-#define MT_RXD2_NORMAL_SW_BIT		BIT(22)
-#define MT_RXD2_NORMAL_AMSDU_ERR	BIT(23)
-#define MT_RXD2_NORMAL_MAX_LEN_ERROR	BIT(24)
-#define MT_RXD2_NORMAL_HDR_TRANS_ERROR	BIT(25)
-#define MT_RXD2_NORMAL_INT_FRAME	BIT(26)
-#define MT_RXD2_NORMAL_FRAG		BIT(27)
-#define MT_RXD2_NORMAL_NULL_FRAME	BIT(28)
-#define MT_RXD2_NORMAL_NDATA		BIT(29)
-#define MT_RXD2_NORMAL_NON_AMPDU	BIT(30)
-#define MT_RXD2_NORMAL_BF_REPORT	BIT(31)
-
-/* RXD DW3 */
-#define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
-#define MT_RXD3_NORMAL_CH_FREQ		GENMASK(15, 8)
-#define MT_RXD3_NORMAL_ADDR_TYPE	GENMASK(17, 16)
-#define MT_RXD3_NORMAL_U2M		BIT(0)
-#define MT_RXD3_NORMAL_HTC_VLD		BIT(0)
-#define MT_RXD3_NORMAL_TSF_COMPARE_LOSS	BIT(19)
-#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
-#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
-#define MT_RXD3_NORMAL_AMSDU		BIT(22)
-#define MT_RXD3_NORMAL_MESH		BIT(23)
-#define MT_RXD3_NORMAL_MHCP		BIT(24)
-#define MT_RXD3_NORMAL_NO_INFO_WB	BIT(25)
-#define MT_RXD3_NORMAL_DISABLE_RX_HDR_TRANS	BIT(26)
-#define MT_RXD3_NORMAL_POWER_SAVE_STAT	BIT(27)
-#define MT_RXD3_NORMAL_MORE		BIT(28)
-#define MT_RXD3_NORMAL_UNWANT		BIT(29)
-#define MT_RXD3_NORMAL_RX_DROP		BIT(30)
-#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
-
-/* RXD DW4 */
-#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
-#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
-#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
-#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
-
-#define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
-#define MT_RXD4_NORMAL_CLS		BIT(10)
-#define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
-#define MT_RXD4_NORMAL_MAGIC_PKT	BIT(13)
-#define MT_RXD4_NORMAL_WOL		GENMASK(18, 14)
-#define MT_RXD4_NORMAL_CLS_BITMAP	GENMASK(28, 19)
-#define MT_RXD3_NORMAL_PF_MODE		BIT(29)
-#define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
-
-#define MT_RXV_HDR_BAND_IDX		BIT(24)
-
-/* RXD GROUP4 */
-#define MT_RXD6_FRAME_CONTROL		GENMASK(15, 0)
-#define MT_RXD6_TA_LO			GENMASK(31, 16)
-
-#define MT_RXD7_TA_HI			GENMASK(31, 0)
-
-#define MT_RXD8_SEQ_CTRL		GENMASK(15, 0)
-#define MT_RXD8_QOS_CTL			GENMASK(31, 16)
-
-#define MT_RXD9_HT_CONTROL		GENMASK(31, 0)
-
 enum tx_port_idx {
 	MT_TX_PORT_IDX_LMAC,
 	MT_TX_PORT_IDX_MCU
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 4c2f62696b56..5b48a725e637 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -218,86 +218,6 @@ mt7921_mac_assoc_rssi(struct mt7921_dev *dev, struct sk_buff *skb)
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
-	u16 frame_control;
-
-	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=
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
-	frame_control = le32_get_bits(rxd[6], MT_RXD6_FRAME_CONTROL);
-	hdr.frame_control = cpu_to_le16(frame_control);
-	hdr.seq_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_SEQ_CTRL));
-	hdr.duration_id = 0;
-
-	ether_addr_copy(hdr.addr1, vif->addr);
-	ether_addr_copy(hdr.addr2, sta->addr);
-	switch (frame_control & (IEEE80211_FCTL_TODS |
-				 IEEE80211_FCTL_FROMDS)) {
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
-	else if (be16_to_cpu(eth_hdr->h_proto) >= ETH_P_802_3_MIN)
-		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
-	else
-		skb_pull(skb, 2);
-
-	if (ieee80211_has_order(hdr.frame_control))
-		memcpy(skb_push(skb, IEEE80211_HT_CTL_LEN), &rxd[9],
-		       IEEE80211_HT_CTL_LEN);
-	if (ieee80211_is_data_qos(hdr.frame_control)) {
-		__le16 qos_ctrl;
-
-		qos_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_QOS_CTL));
-		memcpy(skb_push(skb, IEEE80211_QOS_CTL_LEN), &qos_ctrl,
-		       IEEE80211_QOS_CTL_LEN);
-	}
-
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
@@ -315,6 +235,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
 	u32 rxd4 = le32_to_cpu(rxd[4]);
+	struct mt7921_sta *msta;
 	u16 seq_ctrl = 0;
 	__le16 fc = 0;
 	u32 mode = 0;
@@ -345,8 +266,6 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	status->wcid = mt7921_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
-		struct mt7921_sta *msta;
-
 		msta = container_of(status->wcid, struct mt7921_sta, wcid);
 		spin_lock_bh(&dev->sta_poll_lock);
 		if (list_empty(&msta->poll_list))
@@ -581,8 +500,18 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	hdr_gap = (u8 *)rxd - skb->data + 2 * remove_pad;
 	if (hdr_trans && ieee80211_has_morefrags(fc)) {
-		if (mt7921_reverse_frag0_hdr_trans(skb, hdr_gap))
+		struct ieee80211_vif *vif;
+		int err;
+
+		if (!msta || !msta->vif)
 			return -EINVAL;
+
+		vif = container_of((void *)msta->vif, struct ieee80211_vif,
+				   drv_priv);
+		err = mt76_connac2_reverse_frag0_hdr_trans(vif, skb, hdr_gap);
+		if (err)
+			return err;
+
 		hdr_trans = false;
 	} else {
 		skb_pull(skb, hdr_gap);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index 6e31ae7d39d3..ca2ec83bc831 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -29,90 +29,6 @@ enum rx_pkt_type {
 	PKT_TYPE_NORMAL_MCU,
 };
 
-/* RXD DW1 */
-#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
-#define MT_RXD1_NORMAL_GROUP_1		BIT(11)
-#define MT_RXD1_NORMAL_GROUP_2		BIT(12)
-#define MT_RXD1_NORMAL_GROUP_3		BIT(13)
-#define MT_RXD1_NORMAL_GROUP_4		BIT(14)
-#define MT_RXD1_NORMAL_GROUP_5		BIT(15)
-#define MT_RXD1_NORMAL_SEC_MODE		GENMASK(20, 16)
-#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
-#define MT_RXD1_NORMAL_CM		BIT(23)
-#define MT_RXD1_NORMAL_CLM		BIT(24)
-#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
-#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
-#define MT_RXD1_NORMAL_FCS_ERR		BIT(27)
-#define MT_RXD1_NORMAL_BAND_IDX		BIT(28)
-#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
-#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
-#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
-
-/* RXD DW2 */
-#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
-#define MT_RXD2_NORMAL_CO_ANT		BIT(6)
-#define MT_RXD2_NORMAL_BF_CQI		BIT(7)
-#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
-#define MT_RXD2_NORMAL_HDR_TRANS	BIT(13)
-#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 14)
-#define MT_RXD2_NORMAL_TID		GENMASK(19, 16)
-#define MT_RXD2_NORMAL_MU_BAR		BIT(21)
-#define MT_RXD2_NORMAL_SW_BIT		BIT(22)
-#define MT_RXD2_NORMAL_AMSDU_ERR	BIT(23)
-#define MT_RXD2_NORMAL_MAX_LEN_ERROR	BIT(24)
-#define MT_RXD2_NORMAL_HDR_TRANS_ERROR	BIT(25)
-#define MT_RXD2_NORMAL_INT_FRAME	BIT(26)
-#define MT_RXD2_NORMAL_FRAG		BIT(27)
-#define MT_RXD2_NORMAL_NULL_FRAME	BIT(28)
-#define MT_RXD2_NORMAL_NDATA		BIT(29)
-#define MT_RXD2_NORMAL_NON_AMPDU	BIT(30)
-#define MT_RXD2_NORMAL_BF_REPORT	BIT(31)
-
-/* RXD DW3 */
-#define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
-#define MT_RXD3_NORMAL_CH_FREQ		GENMASK(15, 8)
-#define MT_RXD3_NORMAL_ADDR_TYPE	GENMASK(17, 16)
-#define MT_RXD3_NORMAL_U2M		BIT(0)
-#define MT_RXD3_NORMAL_HTC_VLD		BIT(0)
-#define MT_RXD3_NORMAL_TSF_COMPARE_LOSS	BIT(19)
-#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
-#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
-#define MT_RXD3_NORMAL_AMSDU		BIT(22)
-#define MT_RXD3_NORMAL_MESH		BIT(23)
-#define MT_RXD3_NORMAL_MHCP		BIT(24)
-#define MT_RXD3_NORMAL_NO_INFO_WB	BIT(25)
-#define MT_RXD3_NORMAL_DISABLE_RX_HDR_TRANS	BIT(26)
-#define MT_RXD3_NORMAL_POWER_SAVE_STAT	BIT(27)
-#define MT_RXD3_NORMAL_MORE		BIT(28)
-#define MT_RXD3_NORMAL_UNWANT		BIT(29)
-#define MT_RXD3_NORMAL_RX_DROP		BIT(30)
-#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
-
-/* RXD DW4 */
-#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
-#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
-#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
-#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
-#define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
-#define MT_RXD4_NORMAL_CLS		BIT(10)
-#define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
-#define MT_RXD4_NORMAL_MAGIC_PKT	BIT(13)
-#define MT_RXD4_NORMAL_WOL		GENMASK(18, 14)
-#define MT_RXD4_NORMAL_CLS_BITMAP	GENMASK(28, 19)
-#define MT_RXD3_NORMAL_PF_MODE		BIT(29)
-#define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
-
-/* RXD GROUP4 */
-#define MT_RXD6_FRAME_CONTROL		GENMASK(15, 0)
-#define MT_RXD6_TA_LO			GENMASK(31, 16)
-
-#define MT_RXD7_TA_HI			GENMASK(31, 0)
-
-#define MT_RXD8_SEQ_CTRL		GENMASK(15, 0)
-#define MT_RXD8_QOS_CTL			GENMASK(31, 16)
-
-#define MT_RXD9_HT_CONTROL		GENMASK(31, 0)
-
 enum tx_port_idx {
 	MT_TX_PORT_IDX_LMAC,
 	MT_TX_PORT_IDX_MCU
-- 
2.35.3

