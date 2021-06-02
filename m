Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF083980A3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 07:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhFBF0t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 01:26:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33042 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229637AbhFBF0s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 01:26:48 -0400
X-UUID: 67648dd547c04139900e449759fae694-20210602
X-UUID: 67648dd547c04139900e449759fae694-20210602
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 661833872; Wed, 02 Jun 2021 13:25:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Jun 2021 13:25:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 13:25:01 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/3] mt76: mt7921: add mt7921_mcu_sta_update support
Date:   Wed, 2 Jun 2021 13:24:52 +0800
Message-ID: <b6998d5ed25f86e1afce68060d840e0e37cb6670.1622610746.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <db74f1c3acd2a2729066810ad72b656681a30693.1622610746.git.objelf@gmail.com>
References: <db74f1c3acd2a2729066810ad72b656681a30693.1622610746.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add mt7921_mcu_sta_update support to make we are able to update the station
record with the current state the station has into the mt7921 firmware at
runtime. That is the prerequisite patch to fix .sta_state incorrect
implementation for the mt7921 driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v1->v2: no change
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 20 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 631f408520c9..3f53bd9b2b55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1342,6 +1342,26 @@ int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 	return mt76_connac_mcu_add_sta_cmd(&dev->mphy, &info);
 }
 
+int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
+			  struct ieee80211_vif *vif, u8 state)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int rssi = -ewma_rssi_read(&mvif->rssi);
+	struct mt76_sta_cmd_info info = {
+		.sta = sta,
+		.vif = vif,
+		.enable = true,
+		.state = state,
+		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
+		.rcpi = to_rcpi(rssi),
+	};
+	struct mt7921_sta *msta;
+
+	msta = sta ? (struct mt7921_sta *)sta->drv_priv : NULL;
+	info.wcid = msta ? &msta->wcid : &mvif->sta.wcid;
+	return mt76_connac_mcu_update_sta_cmd(&dev->mphy, &info);
+}
+
 int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 694f85e52222..13d0f472b043 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -262,6 +262,8 @@ int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 int mt7921_set_channel(struct mt7921_phy *phy);
 int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 		       struct ieee80211_vif *vif, bool enable, u8 state);
+int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
+			  struct ieee80211_vif *vif, u8 state);
 int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
-- 
2.25.1

