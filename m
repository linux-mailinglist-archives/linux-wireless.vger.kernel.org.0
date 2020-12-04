Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FDE2CF433
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 19:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgLDShJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 13:37:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55687 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726021AbgLDShJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 13:37:09 -0500
X-UUID: d25bcafe154a4befaabb94ac4d3e914b-20201205
X-UUID: d25bcafe154a4befaabb94ac4d3e914b-20201205
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 744986383; Sat, 05 Dec 2020 02:36:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Dec 2020 02:36:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Dec 2020 02:36:22 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7615: add vif check in mt7615_update_vif_beacon()
Date:   Sat, 5 Dec 2020 02:36:22 +0800
Message-ID: <87747c34f3dd0f91a5fb68d1a40dd4adc6591092.1607104742.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <6f63bc0fbba35c3005a9d6999104f41174466cb6.1607104742.git.ryder.lee@mediatek.com>
References: <6f63bc0fbba35c3005a9d6999104f41174466cb6.1607104742.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This avoids the WARN_ON(1) calltrace in station mode.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 0f360be0b885..49dced019482 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2017,7 +2017,14 @@ mt7615_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	struct ieee80211_hw *hw = priv;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 
-	mt7615_mcu_add_beacon(dev, hw, vif, vif->bss_conf.enable_beacon);
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_AP:
+		mt7615_mcu_add_beacon(dev, hw, vif,
+				      vif->bss_conf.enable_beacon);
+		break;
+	}
 }
 
 static void
-- 
2.18.0

