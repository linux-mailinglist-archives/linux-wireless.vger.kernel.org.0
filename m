Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89B542AFD7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 00:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhJLWyo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 18:54:44 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:42080 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbhJLWym (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 18:54:42 -0400
X-UUID: f85cd97ca13c4ba0b4e5a013bbf9ccd4-20211012
X-UUID: f85cd97ca13c4ba0b4e5a013bbf9ccd4-20211012
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 307440769; Tue, 12 Oct 2021 15:52:39 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 Oct 2021 15:52:37 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Oct 2021 06:52:36 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 07/16] mt76: mt7663s: rely on mcu reg access utility
Date:   Wed, 13 Oct 2021 06:52:00 +0800
Message-ID: <2dc1961473d2965b7334056725d669cac7b1c412.1634077769.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1634077769.git.objelf@gmail.com>
References: <cover.1634077769.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

rely on mcu reg access utility and drop the duplicated code.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 28 -------------------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 --
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  4 +--
 3 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2ba730808f3b..2cb3969e6432 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2769,31 +2769,3 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_ROC, &req,
 				 sizeof(req), false);
 }
-
-u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
-{
-	struct {
-		__le32 addr;
-		__le32 val;
-	} __packed req = {
-		.addr = cpu_to_le32(offset),
-	};
-
-	return mt76_mcu_send_msg(dev, MCU_CMD_REG_READ, &req, sizeof(req),
-				 true);
-}
-EXPORT_SYMBOL_GPL(mt7615_mcu_reg_rr);
-
-void mt7615_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
-{
-	struct {
-		__le32 addr;
-		__le32 val;
-	} __packed req = {
-		.addr = cpu_to_le32(offset),
-		.val = cpu_to_le32(val),
-	};
-
-	mt76_mcu_send_msg(dev, MCU_CMD_REG_WRITE, &req, sizeof(req), false);
-}
-EXPORT_SYMBOL_GPL(mt7615_mcu_reg_wr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 58a98b5c0cbc..437f14f06e63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -553,8 +553,6 @@ int mt7615_mac_set_beacon_filter(struct mt7615_phy *phy,
 int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
 int __mt7663_load_firmware(struct mt7615_dev *dev);
-u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset);
-void mt7615_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
 void mt7615_coredump_work(struct work_struct *work);
 
 void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 45c1cd3b9f49..517419bb7772 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -137,8 +137,8 @@ int mt7663s_mcu_init(struct mt7615_dev *dev)
 		.mcu_skb_send_msg = mt7663s_mcu_send_message,
 		.mcu_parse_response = mt7615_mcu_parse_response,
 		.mcu_restart = mt7615_mcu_restart,
-		.mcu_rr = mt7615_mcu_reg_rr,
-		.mcu_wr = mt7615_mcu_reg_wr,
+		.mcu_rr = mt76_connac_mcu_reg_rr,
+		.mcu_wr = mt76_connac_mcu_reg_wr,
 	};
 	struct mt7615_mcu_ops *mcu_ops;
 	int ret;
-- 
2.25.1

