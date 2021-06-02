Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6682397F4F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 05:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhFBDGn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 23:06:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53771 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229541AbhFBDGn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 23:06:43 -0400
X-UUID: 3365a395963347f4b9fe53e470215e7c-20210602
X-UUID: 3365a395963347f4b9fe53e470215e7c-20210602
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1973579451; Wed, 02 Jun 2021 11:04:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Jun 2021 11:04:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 11:04:06 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] mt76: mt7615: update radar parameters
Date:   Wed, 2 Jun 2021 11:04:03 +0800
Message-ID: <eb3defe02d970e7b2b0cce5841d7fb63b9239e06.1622599797.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Patch radar parameters to match the SDK to avoid possible false alarms.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - fix return value
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 17 ++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c |  4 ++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 2ac7d0b0eff4..55b1694f8f9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -20,7 +20,7 @@
 #define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
 
 static const struct mt7615_dfs_radar_spec etsi_radar_specs = {
-	.pulse_th = { 40, -10, -80, 800, 3360, 128, 5200 },
+	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
 	.radar_pattern = {
 		[5] =  { 1, 0,  6, 32, 28, 0, 17,  990, 5010, 1, 1 },
 		[6] =  { 1, 0,  9, 32, 28, 0, 27,  615, 5010, 1, 1 },
@@ -34,7 +34,7 @@ static const struct mt7615_dfs_radar_spec etsi_radar_specs = {
 };
 
 static const struct mt7615_dfs_radar_spec fcc_radar_specs = {
-	.pulse_th = { 40, -10, -80, 800, 3360, 128, 5200 },
+	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
 	.radar_pattern = {
 		[0] = { 1, 0,  9,  32, 28, 0, 13, 508, 3076, 1,  1 },
 		[1] = { 1, 0, 12,  32, 28, 0, 17, 140,  240, 1,  1 },
@@ -45,7 +45,7 @@ static const struct mt7615_dfs_radar_spec fcc_radar_specs = {
 };
 
 static const struct mt7615_dfs_radar_spec jp_radar_specs = {
-	.pulse_th = { 40, -10, -80, 800, 3360, 128, 5200 },
+	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
 	.radar_pattern = {
 		[0] =  { 1, 0,  8, 32, 28, 0, 13,  508, 3076, 1,  1 },
 		[1] =  { 1, 0, 12, 32, 28, 0, 17,  140,  240, 1,  1 },
@@ -2109,14 +2109,12 @@ mt7615_dfs_init_radar_specs(struct mt7615_phy *phy)
 {
 	const struct mt7615_dfs_radar_spec *radar_specs;
 	struct mt7615_dev *dev = phy->dev;
-	int err, i;
+	int err, i, lpn = 500;
 
 	switch (dev->mt76.region) {
 	case NL80211_DFS_FCC:
 		radar_specs = &fcc_radar_specs;
-		err = mt7615_mcu_set_fcc5_lpn(dev, 8);
-		if (err < 0)
-			return err;
+		lpn = 8;
 		break;
 	case NL80211_DFS_ETSI:
 		radar_specs = &etsi_radar_specs;
@@ -2128,6 +2126,11 @@ mt7615_dfs_init_radar_specs(struct mt7615_phy *phy)
 		return -EINVAL;
 	}
 
+	/* avoid FCC radar detection in non-FCC region */
+	err = mt7615_mcu_set_fcc5_lpn(dev, lpn);
+	if (err < 0)
+		return err;
+
 	for (i = 0; i < ARRAY_SIZE(radar_specs->radar_pattern); i++) {
 		err = mt7615_mcu_set_radar_th(dev, i,
 					      &radar_specs->radar_pattern[i]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 313f46b5eb50..7022b78062a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -430,6 +430,10 @@ mt7615_mcu_rx_radar_detected(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	r = (struct mt7615_mcu_rdd_report *)skb->data;
 
+	if (!dev->radar_pattern.n_pulses && !r->long_detected &&
+	    !r->constant_prf_detected && !r->staggered_prf_detected)
+		return;
+
 	if (r->band_idx && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
-- 
2.18.0

