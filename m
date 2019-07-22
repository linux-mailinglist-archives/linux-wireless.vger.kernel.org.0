Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5516A6FB98
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGVIuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 04:50:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:4849 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725874AbfGVIuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 04:50:19 -0400
X-UUID: 4a27624f4f2848618ed6203cda82a92d-20190722
X-UUID: 4a27624f4f2848618ed6203cda82a92d-20190722
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 152886823; Mon, 22 Jul 2019 16:50:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 22 Jul 2019 16:50:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 22 Jul 2019 16:50:10 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 1/2] mt76: mt7615: add 4 WMM sets support
Date:   Mon, 22 Jul 2019 16:50:08 +0800
Message-ID: <f5c814ad88a8d959376fc77930531582eedf1a63.1563779728.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hardware supports 4 sets of WMM that should be put to good use.
And fix incorrect queue mapping in mt7615_conf_tx().

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 16 ++++++----------
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h   |  1 +
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 8f9a2bb68ded..d85b3904f33a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -314,7 +314,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_vif *vif = info->control.vif;
 	int tx_count = 8;
-	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0;
+	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	__le16 fc = hdr->frame_control;
 	u16 seqno = 0;
 	u32 val;
@@ -323,6 +323,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 
 		omac_idx = mvif->omac_idx;
+		wmm_idx = mvif->wmm_idx;
 	}
 
 	if (sta) {
@@ -335,7 +336,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
 
 	if (ieee80211_is_data(fc) || ieee80211_is_bufferable_mmpdu(fc)) {
-		q_idx = skb_get_queue_mapping(skb);
+		q_idx = skb_get_queue_mapping(skb) + wmm_idx * MT7615_MAX_WMM_SETS;
 		p_fmt = MT_TX_TYPE_CT;
 	} else if (ieee80211_is_beacon(fc)) {
 		q_idx = MT_LMAC_BCN0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 2c702b31d55f..ea48dcdb65c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -85,9 +85,9 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	}
 	mvif->omac_idx = idx;
 
-	/* TODO: DBDC support. Use band 0 and wmm 0 for now */
+	/* TODO: DBDC support. Use band 0 for now */
 	mvif->band_idx = 0;
-	mvif->wmm_idx = 0;
+	mvif->wmm_idx = mvif->idx % MT7615_MAX_WMM_SETS;
 
 	ret = mt7615_mcu_set_dev_info(dev, vif, 1);
 	if (ret)
@@ -241,16 +241,12 @@ static int
 mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = hw->priv;
-	static const u8 wmm_queue_map[] = {
-		[IEEE80211_AC_BK] = 0,
-		[IEEE80211_AC_BE] = 1,
-		[IEEE80211_AC_VI] = 2,
-		[IEEE80211_AC_VO] = 3,
-	};
 
-	/* TODO: hw wmm_set 1~3 */
-	return mt7615_mcu_set_wmm(dev, wmm_queue_map[queue], params);
+	queue += mvif->wmm_idx * MT7615_MAX_WMM_SETS;
+
+	return mt7615_mcu_set_wmm(dev, queue, params);
 }
 
 static void mt7615_configure_filter(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 2f43101343c3..f3f1738a01e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -10,6 +10,7 @@
 #include "regs.h"
 
 #define MT7615_MAX_INTERFACES		4
+#define MT7615_MAX_WMM_SETS		4
 #define MT7615_WTBL_SIZE		128
 #define MT7615_WTBL_RESERVED		(MT7615_WTBL_SIZE - 1)
 #define MT7615_WTBL_STA			(MT7615_WTBL_RESERVED - \
-- 
2.18.0

