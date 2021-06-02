Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E283E398E3B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 17:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhFBPUL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 11:20:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48207 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231618AbhFBPUK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:10 -0400
X-UUID: 36bace2b19b64c5496c75d4df3d970f7-20210602
X-UUID: 36bace2b19b64c5496c75d4df3d970f7-20210602
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 266100842; Wed, 02 Jun 2021 23:18:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Jun 2021 23:18:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 23:18:24 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: enable VHT BFee capabiliity
Date:   Wed, 2 Jun 2021 23:17:52 +0800
Message-ID: <a5748514496b2b4e4b23be7b0b560d2585feafb6.1622627260.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

enable BFee functions with proper BFee IEs

Tested-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7921/main.c   | 18 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mt7921.h |  1 +
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 59da29032645..82b01a2cea69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -219,6 +219,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 
 	mt76_set_stream_caps(&dev->mphy, true);
+	mt7921_set_stream_vht_bf_caps(&dev->phy);
 	mt7921_set_stream_he_caps(&dev->phy);
 
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 84930ad5ebc7..95502708b840 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -140,6 +140,24 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 	return idx;
 }
 
+void mt7921_set_stream_vht_bf_caps(struct mt7921_phy *phy)
+{
+	u32 *cap;
+
+	if (!phy->mt76->cap.has_5ghz)
+		return;
+
+	cap = &phy->mt76->sband_5g.sband.vht_cap.cap;
+
+	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+		IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+		(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+
+	*cap &= ~(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK |
+		  IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
+		  IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
+}
+
 void mt7921_set_stream_he_caps(struct mt7921_phy *phy)
 {
 	struct ieee80211_sband_iftype_data *data;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 8aa8d2ecdffa..abf8be358786 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -356,6 +356,7 @@ void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7921_stats_work(struct work_struct *work);
 void mt7921_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *txwi);
+void mt7921_set_stream_vht_bf_caps(struct mt7921_phy *phy);
 void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
 void mt7921_update_channel(struct mt76_dev *mdev);
 int mt7921_init_debugfs(struct mt7921_dev *dev);
-- 
2.18.0

