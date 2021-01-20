Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4804F2FDA21
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 20:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbhATTmZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jan 2021 14:42:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43152 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392531AbhATTe5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jan 2021 14:34:57 -0500
X-UUID: d41e1668d947474d997ff8b2e1af3573-20210121
X-UUID: d41e1668d947474d997ff8b2e1af3573-20210121
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 934772853; Thu, 21 Jan 2021 03:33:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Jan 2021 03:33:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jan 2021 03:33:55 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v6 13/15] mt76: mt7921: introduce support for hardware beacon filter
Date:   Thu, 21 Jan 2021 03:33:49 +0800
Message-ID: <09e1716c7a1ea891cd7a258c6fd13e3ab74d4750.1611060302.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611060302.git.objelf@gmail.com>
References: <cover.1611060302.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce support for hw beacon filter available in the mt7921 firmware.

According to mt7921e firmware, enabling hardware filter would rely on
mt7921_mcu_uni_bss_bcnft and disabling hardware filter still rely on legacy
mt7921_mcu_set_bss_pm.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 75 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  4 +
 3 files changed, 80 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 1e7be1d58850..945d0e44ae71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -2564,3 +2564,78 @@ int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
 				 &ps_req, sizeof(ps_req), true);
 }
+
+int mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			     bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bcnft_tlv {
+			__le16 tag;
+			__le16 len;
+			__le16 bcn_interval;
+			u8 dtim_period;
+			u8 pad;
+		} __packed bcnft;
+	} __packed bcnft_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.bcnft = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BCNFT),
+			.len = cpu_to_le16(sizeof(struct bcnft_tlv)),
+			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = vif->bss_conf.dtim_period,
+		},
+	};
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return 0;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				 &bcnft_req, sizeof(bcnft_req), true);
+}
+
+int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			  bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		u8 bss_idx;
+		u8 dtim_period;
+		__le16 aid;
+		__le16 bcn_interval;
+		__le16 atim_window;
+		u8 uapsd;
+		u8 bmc_delivered_ac;
+		u8 bmc_triggered_ac;
+		u8 pad;
+	} req = {
+		.bss_idx = mvif->idx,
+		.aid = cpu_to_le16(vif->bss_conf.aid),
+		.dtim_period = vif->bss_conf.dtim_period,
+		.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+	};
+	struct {
+		u8 bss_idx;
+		u8 pad[3];
+	} req_hdr = {
+		.bss_idx = mvif->idx,
+	};
+	int err;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return 0;
+
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT, &req_hdr,
+				sizeof(req_hdr), false);
+	if (err < 0 || !enable)
+		return err;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED, &req,
+				 sizeof(req), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 2103e1d3ac94..de3a9aabec04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -211,6 +211,7 @@ enum {
 	UNI_BSS_INFO_QBSS = 15,
 	UNI_BSS_INFO_UAPSD = 19,
 	UNI_BSS_INFO_PS = 21,
+	UNI_BSS_INFO_BCNFT = 22,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 2e617e85670d..d5f443f99ee3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -363,4 +363,8 @@ int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
 			      struct ieee80211_vif *vif);
 u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx);
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
+int mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			     bool enable);
+int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			  bool enable);
 #endif
-- 
2.25.1

