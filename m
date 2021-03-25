Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF26348B24
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Mar 2021 09:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhCYIG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Mar 2021 04:06:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41866 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229738AbhCYIGO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Mar 2021 04:06:14 -0400
X-UUID: 751633ca21df4d0ab33d0a4074db7175-20210325
X-UUID: 751633ca21df4d0ab33d0a4074db7175-20210325
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1990164669; Thu, 25 Mar 2021 16:06:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Mar 2021 16:06:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Mar 2021 16:06:09 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 4/5] mt76: mt7615: keep mcu_add_bss_info enabled till interface removal
Date:   Thu, 25 Mar 2021 16:06:04 +0800
Message-ID: <02d52818307a85b66e59ca11e36a9da47e2fe4df.1616657048.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20744fae1cbe0dcc098b3112b0a5ccb0b6254587.1616657048.git.ryder.lee@mediatek.com>
References: <20744fae1cbe0dcc098b3112b0a5ccb0b6254587.1616657048.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BSS_INFO_BASIC is never called alone with inactive state, which always
follows beacon offload disable, so keep it enabled throughout interfaces
life cycle. Inactive state also removes sta record of all connected
stations, thurs causes connection lost which defeats the purpose of CSA.

Lastly, this is especially an unexpected behavior that keeping mt7622
failing beacon buffer recyled when scanning channels.

bss_conf change is updated with active state only, so just overwrite it.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 342e2c5d9766..ef879d71faa2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -253,7 +253,8 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
-	/* TODO: disable beacon for the bss */
+	mt7615_mcu_add_bss_info(phy, vif, NULL, false);
+	mt7615_mcu_sta_add(phy, vif, NULL, false);
 
 	mt7615_mutex_acquire(dev);
 
@@ -558,11 +559,11 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (changed & BSS_CHANGED_BEACON_ENABLED) {
-		mt7615_mcu_add_bss_info(phy, vif, NULL, info->enable_beacon);
-		mt7615_mcu_sta_add(phy, vif, NULL, info->enable_beacon);
+	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
+		mt7615_mcu_add_bss_info(phy, vif, NULL, true);
+		mt7615_mcu_sta_add(phy, vif, NULL, true);
 
-		if (vif->p2p && info->enable_beacon)
+		if (vif->p2p)
 			mt7615_mcu_set_p2p_oppps(hw, vif);
 	}
 
-- 
2.18.0

