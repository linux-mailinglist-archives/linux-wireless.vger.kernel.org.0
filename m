Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36E348B27
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Mar 2021 09:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhCYIGa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Mar 2021 04:06:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42742 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229944AbhCYIGP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Mar 2021 04:06:15 -0400
X-UUID: 915f937c9d124875b049511318f2d5d0-20210325
X-UUID: 915f937c9d124875b049511318f2d5d0-20210325
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1144540723; Thu, 25 Mar 2021 16:06:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Mar 2021 16:06:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Mar 2021 16:06:10 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 5/5] mt76: mt7915: keep mcu_add_bss_info enabled till interface removal
Date:   Thu, 25 Mar 2021 16:06:05 +0800
Message-ID: <eb9851d4be7b9887d27efdd79c4cda7c54a66715.1616657048.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20744fae1cbe0dcc098b3112b0a5ccb0b6254587.1616657048.git.ryder.lee@mediatek.com>
References: <20744fae1cbe0dcc098b3112b0a5ccb0b6254587.1616657048.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DF0AB339BFE85DC6CF47A159BA20BFA89C77DCB2135D7065C562ECA81C2610702000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The same as mt7615. Keep BSS_INFO_BASIC enabled throughout interfaces
life cycle.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index cde8c1ce3ae0..0f2a86b3aa9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -256,7 +256,8 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
-	/* TODO: disable beacon for the bss */
+	mt7915_mcu_add_bss_info(phy, vif, false);
+	mt7915_mcu_add_sta(dev, vif, NULL, false);
 
 	mutex_lock(&dev->mt76.mutex);
 	mt76_testmode_reset(phy->mt76, true);
@@ -544,9 +545,9 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (changed & BSS_CHANGED_BEACON_ENABLED) {
-		mt7915_mcu_add_bss_info(phy, vif, info->enable_beacon);
-		mt7915_mcu_add_sta(dev, vif, NULL, info->enable_beacon);
+	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
+		mt7915_mcu_add_bss_info(phy, vif, true);
+		mt7915_mcu_add_sta(dev, vif, NULL, true);
 	}
 
 	/* ensure that enable txcmd_mode after bss_info */
-- 
2.18.0

