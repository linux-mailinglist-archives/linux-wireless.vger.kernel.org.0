Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4312B2E9C7E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 19:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbhADSBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 13:01:44 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33101 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726072AbhADSBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 13:01:44 -0500
X-UUID: ca65faf077274757ada618468d292b43-20210105
X-UUID: ca65faf077274757ada618468d292b43-20210105
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1769995441; Tue, 05 Jan 2021 02:00:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 02:00:22 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 02:00:22 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v5 12/15] mt76: mt7921: introduce 802.11 PS support in sta mode
Date:   Tue, 5 Jan 2021 02:00:16 +0800
Message-ID: <f18c2946e92cec13ad99e7183368a64ee179e67b.1609781247.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1609781247.git.objelf@gmail.com>
References: <cover.1609781247.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4AD92DE587271B366A083A8AD8E3D63A36979B79EE6382F62C23F7DD18B2B6942000:8
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
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  3 +--
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 +++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 21 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 9aa110f6562b..039f9c206b05 100644
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
index a5d3f5023ea4..ca059dc245a7 100644
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
index 2147bcc53148..0af5e536e5cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -560,6 +560,9 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
 		mt7921_mcu_set_tx(dev, vif);
 
+	if (changed & BSS_CHANGED_PS)
+		mt7921_mcu_set_vif_ps(dev, vif);
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 99fa49a69ae5..ab2630ca31ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -2527,3 +2527,24 @@ u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx)
 
 	return 0;
 }
+
+int mt7921_mcu_set_vif_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		u8 bss_idx;
+		u8 ps_state; /* 0: device awake
+			      * 1: static power save
+			      * 2: dynamic power saving
+			      */
+	} req = {
+		.bss_idx = mvif->idx,
+		.ps_state = vif->bss_conf.ps ? 2 : 0,
+	};
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return -EOPNOTSUPP;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_PS_PROFILE, &req,
+				 sizeof(req), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index dc6064100f53..80610fe22af4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -362,4 +362,5 @@ int mt7921_mcu_sched_scan_enable(struct mt7921_phy *phy,
 int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
 			      struct ieee80211_vif *vif);
 u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx);
+int mt7921_mcu_set_vif_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 #endif
-- 
2.25.1

