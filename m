Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B986B6373
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Mar 2023 07:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjCLGLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Mar 2023 01:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCLGLm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Mar 2023 01:11:42 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2832B580CF
        for <linux-wireless@vger.kernel.org>; Sat, 11 Mar 2023 22:11:36 -0800 (PST)
X-UUID: bab5b722c09c11ed945fc101203acc17-20230312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UpWrqzJtjnV3b9TA3AdJJfz5fDe0IeOdNHGAdv239Hw=;
        b=g1f4a1+A+V2dTlbIDdMx2YygAcjkyu29fYCMXsqYGF2Bc5T91KLuuNzMCRNpSYiLAz8EC9mHplsiqQMkdfK28LrtD7EikyuIS/Usi0zzKmNOVN/18lGlAkscyBWoa08XEb4XEEN1bJWdj3A/hG+dXDSud3pv9OeVUhtXd5Nagk4=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.20,REQID:d4e06922-6c7e-4857-8808-b10992f5c190,IP:0,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS6885AD,ACT
        ION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.20,REQID:d4e06922-6c7e-4857-8808-b10992f5c190,IP:0,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:120
X-CID-META: VersionHash:25b5999,CLOUDID:5fc81528-564d-42d9-9875-7c868ee415ec,B
        ulkID:230312141130PET8BG1G,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:5,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: bab5b722c09c11ed945fc101203acc17-20230312
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1850403614; Sun, 12 Mar 2023 14:11:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Sun, 12 Mar 2023 14:11:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Sun, 12 Mar 2023 14:11:28 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7996: enable mesh HW amsdu/de-amsdu support
Date:   Sun, 12 Mar 2023 14:11:25 +0800
Message-ID: <e2c0fadf54ce06cb37df53f765e6fe168e0ec311.1678601023.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This enables HW offloading amsdu/de-amsdu support for 802.11s mesh
interface.

Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 24 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7996/mac.h   |  2 ++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  7 ++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  1 +
 5 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 3c3506c7c87a..3d8332d502b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -632,6 +632,8 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 	u32 rxd4 = le32_to_cpu(rxd[4]);
 	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
 	u32 csum_status = *(u32 *)skb->cb;
+	u32 mesh_mask = MT_RXD0_MESH | MT_RXD0_MHCP;
+	bool is_mesh = (rxd0 & mesh_mask) == mesh_mask;
 	bool unicast, insert_ccmp_hdr = false;
 	u8 remove_pad, amsdu_info, band_idx;
 	u8 mode = 0, qos_ctl = 0;
@@ -823,19 +825,16 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 		int pad_start = 0;
 
 		skb_pull(skb, hdr_gap);
-		if (!hdr_trans && status->amsdu) {
+		if (!hdr_trans && status->amsdu && !(ieee80211_has_a4(fc) && is_mesh)) {
 			pad_start = ieee80211_get_hdrlen_from_skb(skb);
-		} else if (hdr_trans && (rxd2 & MT_RXD2_NORMAL_HDR_TRANS_ERROR)) {
+		} else if (hdr_trans && (rxd2 & MT_RXD2_NORMAL_HDR_TRANS_ERROR) &&
+			   get_unaligned_be16(skb->data + pad_start) == ETH_P_8021Q) {
 			/* When header translation failure is indicated,
 			 * the hardware will insert an extra 2-byte field
 			 * containing the data length after the protocol
 			 * type field.
 			 */
-			pad_start = 12;
-			if (get_unaligned_be16(skb->data + pad_start) == ETH_P_8021Q)
-				pad_start += 4;
-			else
-				pad_start = 0;
+			pad_start = 16;
 		}
 
 		if (pad_start) {
@@ -856,8 +855,17 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 		hdr = mt76_skb_get_hdr(skb);
 		fc = hdr->frame_control;
 		if (ieee80211_is_data_qos(fc)) {
+			u8 *qos = ieee80211_get_qos_ctl(hdr);
+
 			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
-			qos_ctl = *ieee80211_get_qos_ctl(hdr);
+			qos_ctl = *qos;
+
+			/* Mesh DA/SA/Length will be stripped after hardware
+			 * de-amsdu, so here needs to clear amsdu present bit
+			 * to mark it as a normal mesh frame.
+			 */
+			if (ieee80211_has_a4(fc) && is_mesh && status->amsdu)
+				*qos &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
 		}
 	} else {
 		status->flag |= RX_FLAG_8023;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
index 2cc218f735d8..d6b1ee994b54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -12,6 +12,8 @@
 #define MT_RXD0_LENGTH			GENMASK(15, 0)
 #define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
 
+#define MT_RXD0_MESH			BIT(18)
+#define MT_RXD0_MHCP			BIT(19)
 #define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
 #define MT_RXD0_NORMAL_IP_SUM		BIT(23)
 #define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8ad51cbfdbe8..b5ce335056e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1022,6 +1022,7 @@ mt7996_mcu_sta_amsdu_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	struct tlv *tlv;
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
+	    vif->type != NL80211_IFTYPE_MESH_POINT &&
 	    vif->type != NL80211_IFTYPE_AP)
 		return;
 
@@ -1471,6 +1472,12 @@ mt7996_mcu_sta_hdr_trans_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 		hdr_trans->to_ds = true;
 		hdr_trans->from_ds = true;
 	}
+
+	if (vif->type == NL80211_IFTYPE_MESH_POINT) {
+		hdr_trans->to_ds = true;
+		hdr_trans->from_ds = true;
+		hdr_trans->mesh = true;
+	}
 }
 
 static enum mcu_mmps_mode
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index dd0c5ac52703..009f5f06042e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -396,7 +396,7 @@ struct sta_rec_hdr_trans {
 	u8 from_ds;
 	u8 to_ds;
 	u8 dis_rx_hdr_tran;
-	u8 rsv;
+	u8 mesh;
 } __packed;
 
 struct hdr_trans_en {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 902370a2a639..61e42d71810d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -320,6 +320,7 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_fw_txp),
 		.drv_flags = MT_DRV_TXWI_NO_FREE |
+			     MT_DRV_AMSDU_OFFLOAD |
 			     MT_DRV_HW_MGMT_TXQ,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
-- 
2.18.0

