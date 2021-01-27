Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9562306464
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 20:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhA0Tnx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 14:43:53 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43373 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344688AbhA0TjZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 14:39:25 -0500
X-UUID: 86f0839fc32941149b9628bb74b16903-20210128
X-UUID: 86f0839fc32941149b9628bb74b16903-20210128
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1333374993; Thu, 28 Jan 2021 03:34:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 03:34:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 03:34:00 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v8 09/20] mt76: mt7921: introduce 802.11 PS support in sta mode
Date:   Thu, 28 Jan 2021 03:33:46 +0800
Message-ID: <f01d2c72d2c823f4bb42478bc34cd905612cfd73.1611774181.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611774181.git.objelf@gmail.com>
References: <cover.1611774181.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 06CD471C92DEDF6C513618FE66AB151AB9EA7450A922A7042061AC25EBAA88362000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Enable 802.11 power-save support available in mt7921 firmware

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 ++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 37 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  2 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 6 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 14d78370d525..ca293fbc682e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -83,6 +83,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, SUPPORTS_PS);
+	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 
 	hw->max_tx_fragments = 4;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index a24fba857b39..968894cfc98b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -690,8 +690,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 	txwi[1] = cpu_to_le32(val);
 	txwi[2] = 0;
 
-	val = MT_TXD3_SW_POWER_MGMT |
-	      FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
+	val = FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
 	if (key)
 		val |= MT_TXD3_PROTECT_FRAME;
 	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 018025a666a2..441ebed190f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -561,6 +561,9 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
 		mt7921_mcu_set_tx(dev, vif);
 
+	if (changed & BSS_CHANGED_PS)
+		mt7921_mcu_uni_bss_ps(dev, vif);
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 6f2b4086ca81..913b56065de6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -2463,3 +2463,40 @@ u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx)
 
 	return 0;
 }
+
+int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct ps_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 ps_state; /* 0: device awake
+				      * 1: static power save
+				      * 2: dynamic power saving
+				      * 3: enter TWT power saving
+				      * 4: leave TWT power saving
+				      */
+			u8 pad[3];
+		} __packed ps;
+	} __packed ps_req = {
+		.hdr = {
+			.bss_idx = mvif->mt76.idx,
+		},
+		.ps = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_PS),
+			.len = cpu_to_le16(sizeof(struct ps_tlv)),
+			.ps_state = vif->bss_conf.ps ? 2 : 0,
+		},
+	};
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return -EOPNOTSUPP;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				 &ps_req, sizeof(ps_req), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 6894b44ff62d..2103e1d3ac94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -185,7 +185,6 @@ struct mt7921_mcu_uni_event {
 /* offload mcu commands */
 enum {
 	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
-	MCU_CMD_SET_PS_PROFILE = MCU_CE_PREFIX | 0x05,
 	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
 	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
 	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
@@ -211,6 +210,7 @@ enum {
 	UNI_BSS_INFO_BCN_CONTENT = 7,
 	UNI_BSS_INFO_QBSS = 15,
 	UNI_BSS_INFO_UAPSD = 19,
+	UNI_BSS_INFO_PS = 21,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 8cd9d3e214ed..f4435cc1712f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -355,4 +355,5 @@ int mt7921_mcu_sched_scan_enable(struct mt7921_phy *phy,
 int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
 			      struct ieee80211_vif *vif);
 u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx);
+int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 #endif
-- 
2.25.1

