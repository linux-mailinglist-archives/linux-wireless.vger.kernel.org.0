Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5684B40C7E2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 17:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhIOPJQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 11:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234169AbhIOPJP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 11:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA8BA61250;
        Wed, 15 Sep 2021 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631718476;
        bh=QKSCWYegkc7kAft+X8afIP01OvgZw44JQM07YyLgCpo=;
        h=From:To:Cc:Subject:Date:From;
        b=dKaqu+YEhSSXOfbJWatxUdqkdY0DeYiwNczgT5oRMk9aXk0U6zzoHc29CrcZCk/TL
         ZjsTF0tMsWmdvkbIRnykbaCnaGy0G2+fjq5ReR7epxBArfwv982utTG0P3UWO2OrAW
         cVOKTCUGfCiMXP3/qB0twB+fRiHLTEv18yRJ9rYJBvnc2kz2ce3xMgHbMSJZMfbYs7
         hOoNijj5gpV26K3W7Nk4Rb9wpXQ1J08gG/LD9nRH5dQdtRa7M46tGcaQuaXU2ZKyce
         CZZ76belKvWAZDbH08OWl7nZng4l7hhGeaSBWo2ecac6a3xap5mVQ8Dvjgy5DsMpiI
         dc0ZuMn1bBIHQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: introduce __mt76_mcu_send_firmware routine
Date:   Wed, 15 Sep 2021 17:07:45 +0200
Message-Id: <3f080a06fb49fb350425fc410e427371cae3a764.1631718389.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce __mt76_mcu_send_firmware routine to specify mcu message max
length. This is a preliminary patch to support mt7921s driver.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mcu.c        |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt76.h       | 11 +++++++++--
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c |  8 ++++----
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index d3a5e2c4f12a..946694af5dcc 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -106,13 +106,13 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_skb_send_and_get_msg);
 
-int mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
-			   int len)
+int __mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
+			     int len, int max_len)
 {
 	int err, cur_len;
 
 	while (len > 0) {
-		cur_len = min_t(int, 4096 - dev->mcu_ops->headroom, len);
+		cur_len = min_t(int, max_len - dev->mcu_ops->headroom, len);
 
 		err = mt76_mcu_send_msg(dev, cmd, data, cur_len, false);
 		if (err)
@@ -129,4 +129,4 @@ int mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mt76_mcu_send_firmware);
+EXPORT_SYMBOL_GPL(__mt76_mcu_send_firmware);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e76fb04de047..644d1417ecdc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1257,8 +1257,15 @@ int mt76_mcu_send_and_get_msg(struct mt76_dev *dev, int cmd, const void *data,
 			      int len, bool wait_resp, struct sk_buff **ret);
 int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 				  int cmd, bool wait_resp, struct sk_buff **ret);
-int mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
-			   int len);
+int __mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
+			     int len, int max_len);
+static inline int
+mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
+		       int len)
+{
+	return __mt76_mcu_send_firmware(dev, cmd, data, len, 4096);
+}
+
 static inline int
 mt76_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data, int len,
 		  bool wait_resp)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 34038f182bb0..552e4552f463 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -716,8 +716,8 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 			goto out;
 		}
 
-		ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
-					     dl, len);
+		ret = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+					       dl, len, 4096);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Failed to send patch\n");
 			goto out;
@@ -788,8 +788,8 @@ mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
 			return err;
 		}
 
-		err = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
-					     data + offset, len);
+		err = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+					       data + offset, len, 4096);
 		if (err) {
 			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
 			return err;
-- 
2.31.1

