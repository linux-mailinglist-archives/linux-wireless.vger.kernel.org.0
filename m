Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE731D939
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Feb 2021 13:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhBQMK1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Feb 2021 07:10:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36261 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232684AbhBQMKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Feb 2021 07:10:13 -0500
X-UUID: fa6aa7f5254b44bfb5bdd670b2a67f7c-20210217
X-UUID: fa6aa7f5254b44bfb5bdd670b2a67f7c-20210217
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 833576; Wed, 17 Feb 2021 20:09:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Feb 2021 20:09:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Feb 2021 20:09:22 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7615: enable radar detection for non-offloading firmware
Date:   Wed, 17 Feb 2021 20:09:21 +0800
Message-ID: <6316b1b277fa1ec36972d4043e3109d51ef9662f.1613563280.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6B2150D646FAAF0BBE92045F79C86FC20BAC6E077EEE5C3289C2C4E8E4844BD52000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The non-offloading version should support radar detection.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 88a2ee7e7143..debeb66ce182 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -338,7 +338,7 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	hw->sta_data_size = sizeof(struct mt7615_sta);
 	hw->vif_data_size = sizeof(struct mt7615_vif);
 
-	if (is_mt7663(&phy->dev->mt76)) {
+	if (mt7615_firmware_offload(phy->dev)) {
 		wiphy->iface_combinations = if_comb;
 		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f2dd56674acb..72587def7422 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2238,7 +2238,7 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 	bool ext_phy = phy != &dev->phy;
 	int err;
 
-	if (is_mt7663(&dev->mt76))
+	if (mt7615_firmware_offload(dev))
 		return 0;
 
 	if (dev->mt76.region == NL80211_DFS_UNSET) {
-- 
2.18.0

