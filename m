Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE8621B58C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 14:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGJM4j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 08:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJM4e (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 08:56:34 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96D7D20720;
        Fri, 10 Jul 2020 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594385793;
        bh=PT49Sd30pfn+aE6f769VTReSLki78JjpGxAx8WCkMH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlVb4pzjJ6ZQ3VKewfLT11YcqdB9pDV5aNLGPyaoWvIkINrv03YUdwIwQP8o7dFy2
         jmHW6wXSEfG+Bh/6bEH0DX39mHbmeZ5TeKvvMnqb2FihVdpT/3OqVuw3d/Io2JMoF3
         e5z56oS0Br6CNSLAK/cimQCniFAekDzRu+9ItoN4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/6] mt76: mt7615: take into account sdio bus configuring txwi
Date:   Fri, 10 Jul 2020 14:56:15 +0200
Message-Id: <adca9db8fc1e99f2db3296e6bf4b2c1444ddab33.1594384887.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594384887.git.lorenzo@kernel.org>
References: <cover.1594384887.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

usb and sdio relies on SF architecture. This is a preliminary patch to
add SDIO support to mt76 driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d75f4b1e05bf..049e6a2532c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -529,18 +529,18 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct ieee80211_sta *sta, int pid,
 			  struct ieee80211_key_conf *key, bool beacon)
 {
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
 	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	struct ieee80211_vif *vif = info->control.vif;
+	bool is_mmio = mt76_is_mmio(&dev->mt76);
+	u32 val, sz_txd = is_mmio ? MT_TXD_SIZE : MT_USB_TXD_SIZE;
 	struct mt76_phy *mphy = &dev->mphy;
-	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
-	bool is_usb = mt76_is_usb(&dev->mt76);
-	int tx_count = 8;
-	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	__le16 fc = hdr->frame_control;
-	u32 val, sz_txd = is_usb ? MT_USB_TXD_SIZE : MT_TXD_SIZE;
+	int tx_count = 8;
 	u16 seqno = 0;
 
 	if (vif) {
@@ -566,10 +566,10 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 		p_fmt = MT_TX_TYPE_FW;
 		q_idx = ext_phy ? MT_LMAC_BCN1 : MT_LMAC_BCN0;
 	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
-		p_fmt = is_usb ? MT_TX_TYPE_SF : MT_TX_TYPE_CT;
+		p_fmt = is_mmio ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
 		q_idx = ext_phy ? MT_LMAC_ALTX1 : MT_LMAC_ALTX0;
 	} else {
-		p_fmt = is_usb ? MT_TX_TYPE_SF : MT_TX_TYPE_CT;
+		p_fmt = is_mmio ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
 		q_idx = wmm_idx * MT7615_MAX_WMM_SETS +
 			mt7615_lmac_mapping(dev, skb_get_queue_mapping(skb));
 	}
@@ -675,7 +675,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	txwi[7] = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
 		  FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype) |
 		  FIELD_PREP(MT_TXD7_SPE_IDX, 0x18);
-	if (is_usb)
+	if (!is_mmio)
 		txwi[8] = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
 			  FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
 
-- 
2.26.2

