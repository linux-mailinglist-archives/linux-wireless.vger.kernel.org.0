Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08E72CF79A
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 00:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgLDXiG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 18:38:06 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45926 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726061AbgLDXiG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 18:38:06 -0500
X-UUID: c98dc0ddbedf41bc912eb03ffbf4703b-20201205
X-UUID: c98dc0ddbedf41bc912eb03ffbf4703b-20201205
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 932169252; Sat, 05 Dec 2020 07:37:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Dec 2020 07:37:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Dec 2020 07:37:18 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] mt76: mt7615: add vif check in mt7615_update_vif_beacon()
Date:   Sat, 5 Dec 2020 07:37:15 +0800
Message-ID: <5e89627ba5632db6da460f153bf00d7a3e8f9254.1607124652.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <65336148b5d440dceb967a401488b119e14b9c5a.1607124652.git.ryder.lee@mediatek.com>
References: <65336148b5d440dceb967a401488b119e14b9c5a.1607124652.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This avoids the WARN_ON(1) calltrace in station mode.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2: add default:
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 0f360be0b885..9e0765ddcb5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2017,7 +2017,16 @@ mt7615_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
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
+	default:
+		break;
+	}
 }
 
 static void
-- 
2.18.0

