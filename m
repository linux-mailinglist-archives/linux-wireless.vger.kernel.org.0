Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4265E410254
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Sep 2021 02:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbhIRALJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 20:11:09 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:63455 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245751AbhIRALI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 20:11:08 -0400
X-UUID: 150523e431e1447c9ab37c444ab30b9f-20210917
X-UUID: 150523e431e1447c9ab37c444ab30b9f-20210917
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1977057194; Fri, 17 Sep 2021 17:09:45 -0700
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 17:00:03 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 18 Sep 2021 08:00:03 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 06/16] mt76: connac: move mcu reg access utility routines in mt76_connac_lib module
Date:   Sat, 18 Sep 2021 07:59:22 +0800
Message-ID: <42112d6b7b1c09bcdfa37d4417e55ef45c09ceff.1631918993.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1631918993.git.objelf@gmail.com>
References: <cover.1631918993.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Move mcu reg access shared between mt7663s and mt7921s in mt76_connac_lib
module.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 27 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ae692052de97..a53f6344a184 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2406,6 +2406,33 @@ void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_suspend_iter);
 
+u32 mt76_connac_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
+{
+	struct {
+		__le32 addr;
+		__le32 val;
+	} __packed req = {
+		.addr = cpu_to_le32(offset),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_REG_READ, &req, sizeof(req),
+				 true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_rr);
+
+void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
+{
+	struct {
+		__le32 addr;
+		__le32 val;
+	} __packed req = {
+		.addr = cpu_to_le32(offset),
+		.val = cpu_to_le32(val),
+	};
+
+	mt76_mcu_send_msg(dev, MCU_CMD_REG_WRITE, &req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_wr);
 #endif /* CONFIG_PM */
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ea46dde364e1..6c410c4a8d6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1111,4 +1111,6 @@ void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy);
 int mt76_connac_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif);
+u32 mt76_connac_mcu_reg_rr(struct mt76_dev *dev, u32 offset);
+void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
 #endif /* __MT76_CONNAC_MCU_H */
-- 
2.25.1

