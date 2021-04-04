Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C2835373B
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Apr 2021 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhDDHsm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Apr 2021 03:48:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34594 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229550AbhDDHsl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Apr 2021 03:48:41 -0400
X-UUID: ab7b507e141743619df071ff6bdfcba8-20210404
X-UUID: ab7b507e141743619df071ff6bdfcba8-20210404
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 469943707; Sun, 04 Apr 2021 15:48:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 4 Apr 2021 15:48:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 4 Apr 2021 15:48:31 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7915: fix mt7915_mcu_add_beacon
Date:   Sun, 4 Apr 2021 15:48:24 +0800
Message-ID: <c55cfe46b687902fccef4c5428b516614ca16645.1617522253.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <e4f7df8a29d59656cff1c24dce0c2b695436e9f9.1617522253.git.ryder.lee@mediatek.com>
References: <e4f7df8a29d59656cff1c24dce0c2b695436e9f9.1617522253.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5D5E0432BA407BD1CD2D454D980094F6B26B7C043BB9E18AF3E8580CFB86F1482000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_beacon_get_template() returns NULL when beacon state is disabled.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 2d2bae93133b..d2e5306b153c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2451,6 +2451,17 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	struct bss_info_bcn *bcn;
 	int len = MT7915_BEACON_UPDATE_SIZE + MAX_BEACON_SIZE;
 
+	rskb = mt7915_mcu_alloc_sta_req(dev, mvif, NULL, len);
+	if (IS_ERR(rskb))
+		return PTR_ERR(rskb);
+
+	tlv = mt7915_mcu_add_tlv(rskb, BSS_INFO_OFFLOAD, sizeof(*bcn));
+	bcn = (struct bss_info_bcn *)tlv;
+	bcn->enable = en;
+
+	if (!en)
+		goto out;
+
 	skb = ieee80211_beacon_get_template(hw, vif, &offs);
 	if (!skb)
 		return -EINVAL;
@@ -2461,16 +2472,6 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 		return -EINVAL;
 	}
 
-	rskb = mt7915_mcu_alloc_sta_req(dev, mvif, NULL, len);
-	if (IS_ERR(rskb)) {
-		dev_kfree_skb(skb);
-		return PTR_ERR(rskb);
-	}
-
-	tlv = mt7915_mcu_add_tlv(rskb, BSS_INFO_OFFLOAD, sizeof(*bcn));
-	bcn = (struct bss_info_bcn *)tlv;
-	bcn->enable = en;
-
 	if (mvif->band_idx) {
 		info = IEEE80211_SKB_CB(skb);
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
@@ -2481,6 +2482,7 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	mt7915_mcu_beacon_cont(dev, rskb, skb, bcn, &offs);
 	dev_kfree_skb(skb);
 
+out:
 	return mt76_mcu_skb_send_msg(&phy->dev->mt76, rskb,
 				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
 }
-- 
2.18.0

