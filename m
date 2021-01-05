Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F28B2EA6C9
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 09:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbhAEI4w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 03:56:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54459 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbhAEI4w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 03:56:52 -0500
X-UUID: b691036bc7cd40ee8d30abd40362fc4f-20210105
X-UUID: b691036bc7cd40ee8d30abd40362fc4f-20210105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 688891166; Tue, 05 Jan 2021 16:56:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 16:56:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 16:56:06 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 6/6] mt76: mt7915: clean hw queue before starting new testmode tx
Date:   Tue, 5 Jan 2021 16:55:29 +0800
Message-ID: <20210105085529.14206-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210105085529.14206-1-shayne.chen@mediatek.com>
References: <20210105085529.14206-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BC75EFC5F96D58FA74A45154A7EC7F1BB98760C0FD3DBA75C9679D0FDA9072022000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a testmode mcu command to clean up hw tx queue before a new
testmode tx starts.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/testmode.c | 16 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/testmode.h |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 66d34d78c1d4..163b6f330e67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -50,6 +50,7 @@ enum {
 	MCU_ATE_SET_TRX = 0x1,
 	MCU_ATE_SET_FREQ_OFFSET = 0xa,
 	MCU_ATE_SET_SLOT_TIME = 0x13,
+	MCU_ATE_CLEAN_TXQUEUE = 0x1c,
 };
 
 struct mt7915_mcu_rxd {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index a8e639ffe6de..6f6e02038c6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -132,6 +132,21 @@ mt7915_tm_set_trx(struct mt7915_phy *phy, int type, bool en)
 				 sizeof(req), false);
 }
 
+static int
+mt7915_tm_clean_hwq(struct mt7915_phy *phy, u8 wcid)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct mt7915_tm_cmd req = {
+		.testmode_en = 1,
+		.param_idx = MCU_ATE_CLEAN_TXQUEUE,
+		.param.clean.wcid = wcid,
+		.param.clean.band = phy != &dev->phy,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
+				 sizeof(req), false);
+}
+
 static int
 mt7915_tm_set_slot_time(struct mt7915_phy *phy, u8 slot_time, u8 sifs)
 {
@@ -408,6 +423,7 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 	u32 ipg = td->tx_ipg;
 
 	mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, false);
+	mt7915_tm_clean_hwq(phy, dev->mt76.global_wcid.idx);
 
 	if (en) {
 		mutex_unlock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
index 784d4c948886..da92cad0aa9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
@@ -26,6 +26,13 @@ struct mt7915_tm_slot_time {
 	u8 _rsv1[5];
 };
 
+struct mt7915_tm_clean_txq {
+	bool sta_pause;
+	u8 wcid;	/* 256 sta */
+	u8 band;
+	u8 rsv;
+};
+
 struct mt7915_tm_cmd {
 	u8 testmode_en;
 	u8 param_idx;
@@ -35,6 +42,7 @@ struct mt7915_tm_cmd {
 		struct mt7915_tm_trx trx;
 		struct mt7915_tm_freq_offset freq;
 		struct mt7915_tm_slot_time slot;
+		struct mt7915_tm_clean_txq clean;
 		u8 test[72];
 	} param;
 } __packed;
-- 
2.29.2

