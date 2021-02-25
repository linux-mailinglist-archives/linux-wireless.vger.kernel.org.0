Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D203251D8
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 16:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBYO7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 09:59:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39372 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231445AbhBYO73 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 09:59:29 -0500
X-UUID: dd46eddd189e4798a0836487b2df6ab6-20210225
X-UUID: dd46eddd189e4798a0836487b2df6ab6-20210225
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 509862757; Thu, 25 Feb 2021 22:58:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Feb 2021 22:58:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 22:58:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] mt76: mt7615: add missing capabilities for DBDC
Date:   Thu, 25 Feb 2021 22:58:36 +0800
Message-ID: <7d82c4070c96c32a3fcca07366d1c5183b0c0258.1614239710.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <dd852df70c61ad730f39566ed6fa22c736ce5942.1614239710.git.ryder.lee@mediatek.com>
References: <dd852df70c61ad730f39566ed6fa22c736ce5942.1614239710.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Same as mt7915, this should improve performance.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - adjust setup sequence.
---
 .../net/wireless/mediatek/mt76/mt7615/init.c    | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 88a2ee7e7143..bc908514a510 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -368,6 +368,17 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 		hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
 	else
 		hw->max_tx_fragments = MT_HW_TXP_MAX_BUF_NUM;
+
+	if (phy->mt76->cap.has_2ghz)
+		phy->mt76->sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING;
+
+	if (phy->mt76->cap.has_5ghz) {
+		phy->mt76->sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING;
+		phy->mt76->sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+	}
 }
 
 static void
@@ -424,7 +435,6 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	phy->mt76 = mphy;
 	mphy->chainmask = dev->chainmask & ~dev->mphy.chainmask;
 	mphy->antenna_mask = BIT(hweight8(mphy->chainmask)) - 1;
-	mt7615_init_wiphy(mphy->hw);
 
 	INIT_DELAYED_WORK(&mphy->mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&phy->scan_work, mt7615_scan_work);
@@ -448,6 +458,7 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 
 	/* second phy can only handle 5 GHz */
 	mphy->cap.has_5ghz = true;
+	mt7615_init_wiphy(mphy->hw);
 
 	/* mt7615 second phy shares the same hw queues with the primary one */
 	for (i = 0; i <= MT_TXQ_PSD ; i++)
@@ -505,10 +516,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
 
 	mt7615_init_wiphy(hw);
 	dev->pm.idle_timeout = MT7615_PM_TIMEOUT;
-	dev->mphy.sband_2g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
-	dev->mphy.sband_5g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
-	dev->mphy.sband_5g.sband.vht_cap.cap |=
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 	mt7615_cap_dbdc_disable(dev);
 	dev->phy.dfs_state = -1;
 
-- 
2.18.0

