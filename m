Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EF641E52A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 01:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350875AbhJAAAN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 20:00:13 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:28959 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350768AbhJAAAM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 20:00:12 -0400
X-UUID: e23ed52f28994f8ca5b41cccb8ed14fe-20210930
X-UUID: e23ed52f28994f8ca5b41cccb8ed14fe-20210930
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 550788883; Thu, 30 Sep 2021 16:58:25 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Sep 2021 16:48:34 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Oct 2021 07:48:34 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 07/16] mt76: mt7663s: rely on mcu reg access utility
Date:   Fri, 1 Oct 2021 07:47:54 +0800
Message-ID: <85361034e0548095b442ec2e093c28e46798eac0.1632961096.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1632961096.git.objelf@gmail.com>
References: <cover.1632961096.git.objelf@gmail.com>
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
index a39776833efd..017413c90970 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2761,31 +2761,3 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
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

