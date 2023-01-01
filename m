Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DC365A9DF
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjAALxy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAALxx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:53:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C1426D6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:53:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5507AB8091A
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EEBC433F1;
        Sun,  1 Jan 2023 11:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672574030;
        bh=LPvAURvDIj8vO8luALUitQUOEHfTgvOhNjd8S26jXf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKCZLo8xiK5NHVEWO3UM6UjRuikDjP4fhtGsarod80Gj75aCxYfMZaroI/fmMuBHz
         kd/gdUMcdSfVzC0NzlUL6W/hs3LyCay962k9PHRaUL2ntxeHBUqCMKyrzBlpT66yej
         915EnwWs8qPhkJzc8QzIIpYUZwFZZ1gXx/t+LDntbS3UR9gkqe2v+OVfqBIsx3qzAB
         Xuc5kIroVDZdIVOwxAJYS5d4KqLP7qLuk8OPl9jOV7445eTLHXr2zqenlFVhHT62N4
         JMXH1Izq+Nkjhlu4I85ZMRxk8oRz9jAIodkUcRh1ydKSVOXriVfE2gYI4Y22hUx4Zc
         klR/KseZKsVnA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 5/6] wifi: mt76: mt7996: avoid mcu_restart function pointer
Date:   Sun,  1 Jan 2023 12:53:22 +0100
Message-Id: <c75c8fb3779c16f03d1c6e6fe41949a81fb12118.1672573894.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1672573894.git.lorenzo@kernel.org>
References: <cover.1672573894.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run mt7996_mcu_restart routine directly and avoid mcu_restart function
pointer whenever it is possible.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 45 +++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index af6d80655471..158f8387547f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2241,6 +2241,26 @@ mt7996_firmware_state(struct mt7996_dev *dev, bool wa)
 	return 0;
 }
 
+static int
+mt7996_mcu_restart(struct mt76_dev *dev)
+{
+	struct {
+		u8 __rsv1[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 power_mode;
+		u8 __rsv2[3];
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_POWER_OFF),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.power_mode = 1,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_WM_UNI_CMD(POWER_CREL), &req,
+				 sizeof(req), false);
+}
+
 static int mt7996_load_firmware(struct mt7996_dev *dev)
 {
 	int ret;
@@ -2248,7 +2268,7 @@ static int mt7996_load_firmware(struct mt7996_dev *dev)
 	/* make sure fw is download state */
 	if (mt7996_firmware_state(dev, false)) {
 		/* restart firmware once */
-		__mt76_mcu_restart(&dev->mt76);
+		mt7996_mcu_restart(&dev->mt76);
 		ret = mt7996_firmware_state(dev, false);
 		if (ret) {
 			dev_err(dev->mt76.dev,
@@ -2377,33 +2397,12 @@ mt7996_mcu_init_rx_airtime(struct mt7996_dev *dev)
 				     MCU_WM_UNI_CMD(VOW), true);
 }
 
-static int
-mt7996_mcu_restart(struct mt76_dev *dev)
-{
-	struct {
-		u8 __rsv1[4];
-
-		__le16 tag;
-		__le16 len;
-		u8 power_mode;
-		u8 __rsv2[3];
-	} __packed req = {
-		.tag = cpu_to_le16(UNI_POWER_OFF),
-		.len = cpu_to_le16(sizeof(req) - 4),
-		.power_mode = 1,
-	};
-
-	return mt76_mcu_send_msg(dev, MCU_WM_UNI_CMD(POWER_CREL), &req,
-				 sizeof(req), false);
-}
-
 int mt7996_mcu_init(struct mt7996_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7996_mcu_ops = {
 		.headroom = sizeof(struct mt76_connac2_mcu_txd), /* reuse */
 		.mcu_skb_send_msg = mt7996_mcu_send_message,
 		.mcu_parse_response = mt7996_mcu_parse_response,
-		.mcu_restart = mt7996_mcu_restart,
 	};
 	int ret;
 
@@ -2451,7 +2450,7 @@ int mt7996_mcu_init(struct mt7996_dev *dev)
 
 void mt7996_mcu_exit(struct mt7996_dev *dev)
 {
-	__mt76_mcu_restart(&dev->mt76);
+	mt7996_mcu_restart(&dev->mt76);
 	if (mt7996_firmware_state(dev, false)) {
 		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
 		goto out;
-- 
2.38.1

