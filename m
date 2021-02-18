Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB29331E3F4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Feb 2021 02:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBRBfb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Feb 2021 20:35:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33948 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229989AbhBRBfa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Feb 2021 20:35:30 -0500
X-UUID: ffb2b44be9f54a84a2b7a7a302223398-20210218
X-UUID: ffb2b44be9f54a84a2b7a7a302223398-20210218
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 893111422; Thu, 18 Feb 2021 09:34:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Feb 2021 09:34:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Feb 2021 09:34:42 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/3] mt76: mt7615: enable hw rx-amsdu de-aggregation
Date:   Thu, 18 Feb 2021 09:34:38 +0800
Message-ID: <b7883f5ee09d13f7cbdf5ab1d5fef61ebc79dcc4.1613603857.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8C5240DE6316DEE306FD2BCACADC91B690D6D2DEDA363B2D5279E379E4E592D02000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable hw rx-amsdu de-aggregation support.
This is a preliminary patch to enable rx checksum offload.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c |  3 +--
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 15 ++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h  |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h |  1 +
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 571390fa4de7..a97cc723094c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -116,10 +116,9 @@ mt7615_mac_init(struct mt7615_dev *dev)
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_EN);
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_EN);
 
-	/* disable hdr translation and hw AMSDU */
 	mt76_wr(dev, MT_DMA_DCR0,
 		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072) |
-		MT_DMA_DCR0_RX_VEC_DROP);
+		MT_DMA_DCR0_RX_VEC_DROP | MT_DMA_DCR0_DAMSDU_EN);
 	/* disable TDLS filtering */
 	mt76_clear(dev, MT_WF_PFCR, MT_WF_PFCR_TDLS_EN);
 	mt76_set(dev, MT_WF_MIB_SCR0, MT_MIB_SCR0_AGG_CNT_RANGE_EN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 9bae2f66e1ce..928edd158f64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -238,7 +238,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	bool unicast, remove_pad, insert_ccmp_hdr = false;
 	int phy_idx;
 	int i, idx;
-	u8 chfreq;
+	u8 chfreq, amsdu_info;
 
 	memset(status, 0, sizeof(*status));
 
@@ -254,6 +254,9 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	else
 		phy_idx = -1;
 
+	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
+		return -EINVAL;
+
 	unicast = (rxd1 & MT_RXD1_NORMAL_ADDR_TYPE) == MT_RXD1_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);
 	status->wcid = mt7615_rx_get_wcid(dev, idx, unicast);
@@ -446,6 +449,16 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	skb_pull(skb, (u8 *)rxd - skb->data + 2 * remove_pad);
 
+	amsdu_info = FIELD_GET(MT_RXD1_NORMAL_PAYLOAD_FORMAT, rxd1);
+	status->amsdu = !!amsdu_info;
+	if (status->amsdu) {
+		status->first_amsdu = amsdu_info == MT_RXD1_FIRST_AMSDU_FRAME;
+		status->last_amsdu = amsdu_info == MT_RXD1_LAST_AMSDU_FRAME;
+		memmove(skb->data + 2, skb->data,
+			ieee80211_get_hdrlen_from_skb(skb));
+		skb_pull(skb, 2);
+	}
+
 	if (insert_ccmp_hdr) {
 		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 169f4e17b5b4..ed009d085a53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -33,6 +33,9 @@ enum rx_pkt_type {
 
 #define MT_RXD1_NORMAL_BSSID		GENMASK(31, 26)
 #define MT_RXD1_NORMAL_PAYLOAD_FORMAT	GENMASK(25, 24)
+#define MT_RXD1_FIRST_AMSDU_FRAME	GENMASK(1, 0)
+#define MT_RXD1_MID_AMSDU_FRAME		BIT(1)
+#define MT_RXD1_LAST_AMSDU_FRAME	BIT(0)
 #define MT_RXD1_NORMAL_HDR_TRANS	BIT(23)
 #define MT_RXD1_NORMAL_HDR_OFFSET	BIT(22)
 #define MT_RXD1_NORMAL_MAC_HDR_LEN	GENMASK(21, 16)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 6e5db015b32c..4ebffe52cb8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -368,6 +368,7 @@ enum mt7615_reg_base {
 
 #define MT_DMA_DCR0			MT_WF_DMA(0x000)
 #define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 2)
+#define MT_DMA_DCR0_DAMSDU_EN		BIT(16)
 #define MT_DMA_DCR0_RX_VEC_DROP		BIT(17)
 
 #define MT_DMA_RCFR0(_band)		MT_WF_DMA(0x070 + (_band) * 0x40)
-- 
2.18.0

