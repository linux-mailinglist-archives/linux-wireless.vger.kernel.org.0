Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC527E87E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 14:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgI3MY4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 08:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3MYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:46 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BDEC0613D1
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wjatDQ3NEDd4WlztJubIrKsBYGFRVeTolZM59S14V0s=; b=E6GOANX2DeAiZAxDP6r06qhpE4
        DtTPfZEvOEc/qrtzoM2SdKDv7mIHY1p8uoGpqPt/XwH8ZkDJ6tYDqcdFDATkXymaOdlbqRmBXcFmJ
        iewvQE2YAc6oEGtbefPcykUZR1tCaqT3US8ySJzeMlZ4rfWGUtswfOMa8LAA/E/3+z5w=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNbA4-0005MT-Gm
        for linux-wireless@vger.kernel.org; Wed, 30 Sep 2020 14:24:44 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 09/10] mt76: mt7915: move eeprom parsing out of mt7915_mcu_parse_response
Date:   Wed, 30 Sep 2020 14:24:40 +0200
Message-Id: <20200930122441.64523-9-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930122441.64523-1-nbd@nbd.name>
References: <20200930122441.64523-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the new mt76_mcu_send_and_get_msg function

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 40 ++++++++-----------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index cafcafe62c64..a87b10e8fda7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -215,29 +215,10 @@ mt7915_mcu_get_sta_nss(u16 mcs_map)
 	return nss - 1;
 }
 
-static int
-mt7915_mcu_parse_eeprom(struct mt7915_dev *dev, struct sk_buff *skb)
-{
-	struct mt7915_mcu_eeprom_info *res;
-	u8 *buf;
-
-	if (!skb)
-		return -EINVAL;
-
-	skb_pull(skb, sizeof(struct mt7915_mcu_rxd));
-
-	res = (struct mt7915_mcu_eeprom_info *)skb->data;
-	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
-	memcpy(buf, res->data, 16);
-
-	return 0;
-}
-
 static int
 mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
 {
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	struct mt7915_mcu_rxd *rxd;
 	int ret = 0;
 
@@ -260,10 +241,8 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		skb_pull(skb, sizeof(*rxd) + 4);
 		ret = le32_to_cpu(*(__le32 *)skb->data);
 		break;
-	case MCU_EXT_CMD_EFUSE_ACCESS:
-		ret = mt7915_mcu_parse_eeprom(dev, skb);
-		break;
 	default:
+		skb_pull(skb, sizeof(struct mt7915_mcu_rxd));
 		break;
 	}
 
@@ -3247,9 +3226,22 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 	struct mt7915_mcu_eeprom_info req = {
 		.addr = cpu_to_le32(round_down(offset, 16)),
 	};
+	struct mt7915_mcu_eeprom_info *res;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
-				 sizeof(req), true);
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
+				sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7915_mcu_eeprom_info *)skb->data;
+	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, 16);
+	dev_kfree_skb(skb);
+
+	return 0;
 }
 
 int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index)
-- 
2.28.0

