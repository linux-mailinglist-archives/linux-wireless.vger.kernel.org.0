Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230C9465ED2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 08:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355841AbhLBHoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 02:44:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44562 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1355839AbhLBHoW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 02:44:22 -0500
X-UUID: 68159f89a9284599b761f7ed98fa5c14-20211202
X-UUID: 68159f89a9284599b761f7ed98fa5c14-20211202
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 843579322; Thu, 02 Dec 2021 15:40:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 2 Dec 2021 15:40:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Dec 2021 15:40:55 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: fix 802.3 RX fail by hdr_trans
Date:   Thu, 2 Dec 2021 15:40:54 +0800
Message-ID: <0b88b34cc5103e247c134901f9c39614128eb599.1638424783.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Should not run hdr_trans process for 802.3 packets,
this would cause all data frame RX fail.

Fixes: d9930ec65b9f ("mt76: only set rx radiotap flag from within decoder functions")
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6c14cb1cfd5a..5757284b24a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -794,7 +794,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_8023;
 	}
 
-	if (rxv && mode >= MT_PHY_TYPE_HE_SU)
+	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
 		mt7915_mac_decode_he_radiotap(skb, rxv, mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index e17c8f4c9747..eaffe665cb28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -780,7 +780,6 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 			mt76_insert_ccmp_hdr(skb, key_id);
 		}
 
-		hdr = mt76_skb_get_hdr(skb);
 		fc = hdr->frame_control;
 		if (ieee80211_is_data_qos(fc)) {
 			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
@@ -792,7 +791,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	mt7921_mac_assoc_rssi(dev, skb);
 
-	if (rxv && mode >= MT_PHY_TYPE_HE_SU)
+	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
 		mt7921_mac_decode_he_radiotap(skb, rxv, mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
-- 
2.18.0

