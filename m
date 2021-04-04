Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB935373C
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Apr 2021 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhDDHsm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Apr 2021 03:48:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36456 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229569AbhDDHsl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Apr 2021 03:48:41 -0400
X-UUID: f16c3bb2a3f546859d5678e291bf383f-20210404
X-UUID: f16c3bb2a3f546859d5678e291bf383f-20210404
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2119883454; Sun, 04 Apr 2021 15:48:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 4 Apr 2021 15:48:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 4 Apr 2021 15:48:25 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7615: fix .add_beacon_offload()
Date:   Sun, 4 Apr 2021 15:48:23 +0800
Message-ID: <e4f7df8a29d59656cff1c24dce0c2b695436e9f9.1617522253.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 107E1DE47BFFE049BF3324AC3A36DE74FC65B65B725E15F0D9C5F58DFB9999A92000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_beacon_get_template() returns NULL when beacon state is disabled,
so beacon_offload cannot be disabled for some devices.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 04b21ec611bb..3274d079bd11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -702,6 +702,9 @@ mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
 	};
 	struct sk_buff *skb;
 
+	if (!enable)
+		goto out;
+
 	skb = ieee80211_beacon_get_template(hw, vif, &offs);
 	if (!skb)
 		return -EINVAL;
@@ -731,6 +734,7 @@ mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
 	}
 	dev_kfree_skb(skb);
 
+out:
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_BCN_OFFLOAD, &req,
 				 sizeof(req), true);
 }
@@ -1165,8 +1169,8 @@ mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 			__le16 tim_ie_pos;
 			__le16 csa_ie_pos;
 			__le16 bcc_ie_pos;
-			/* 0: enable beacon offload
-			 * 1: disable beacon offload
+			/* 0: disable beacon offload
+			 * 1: enable beacon offload
 			 * 2: update probe respond offload
 			 */
 			u8 enable;
@@ -1189,6 +1193,9 @@ mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 	};
 	struct sk_buff *skb;
 
+	if (!enable)
+		goto out;
+
 	skb = ieee80211_beacon_get_template(mt76_hw(dev), vif, &offs);
 	if (!skb)
 		return -EINVAL;
@@ -1213,6 +1220,7 @@ mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 	}
 	dev_kfree_skb(skb);
 
+out:
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
 				 &req, sizeof(req), true);
 }
-- 
2.18.0

