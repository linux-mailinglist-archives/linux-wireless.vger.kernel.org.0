Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E030F4101EA
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Sep 2021 01:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhIQXzy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 19:55:54 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:61155 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbhIQXzw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 19:55:52 -0400
X-UUID: 96c2bb51248b4501825f47f7b92266b9-20210917
X-UUID: 96c2bb51248b4501825f47f7b92266b9-20210917
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 346231390; Fri, 17 Sep 2021 16:54:25 -0700
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 16:54:24 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 18 Sep 2021 07:54:22 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: not accounting the MCU header size in __mt76_mcu_send_firmware for mt7915/21
Date:   Sat, 18 Sep 2021 07:54:21 +0800
Message-ID: <d1bb53709aa4cebc33acb1f4690683299d68b06f.1631917451.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Each firmware piece with mt7915 and mt7921 do not have the MCU header to
reroute the packet to the internal RAM. So we do not need to consider the
MCU header size in __mt76_mcu_send_firmware.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Fixes: 1c099ab44727 ("mt76: mt7921: add MCU support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
The patch is developed based on ("mt76: introduce __mt76_mcu_send_firmware
routine")
---
 drivers/net/wireless/mediatek/mt76/mcu.c        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h       | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 946694af5dcc..3f94c37251df 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -112,7 +112,7 @@ int __mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
 	int err, cur_len;
 
 	while (len > 0) {
-		cur_len = min_t(int, max_len - dev->mcu_ops->headroom, len);
+		cur_len = min_t(int, max_len, len);
 
 		err = mt76_mcu_send_msg(dev, cmd, data, cur_len, false);
 		if (err)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 644d1417ecdc..274f1d2466e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1263,7 +1263,9 @@ static inline int
 mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
 		       int len)
 {
-	return __mt76_mcu_send_firmware(dev, cmd, data, len, 4096);
+	int max_len = 4096 - dev->mcu_ops->headroom;
+
+	return __mt76_mcu_send_firmware(dev, cmd, data, len, max_len);
 }
 
 static inline int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 39cba8210242..17dd6881eef0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2692,8 +2692,8 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 			goto out;
 		}
 
-		ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
-					     dl, len);
+		ret = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
+					       dl, len, 4096);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Failed to send patch\n");
 			goto out;
@@ -2761,8 +2761,8 @@ mt7915_mcu_send_ram_firmware(struct mt7915_dev *dev,
 			return err;
 		}
 
-		err = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
-					     data + offset, len);
+		err = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
+					       data + offset, len, 4096);
 		if (err) {
 			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
 			return err;
-- 
2.25.1

