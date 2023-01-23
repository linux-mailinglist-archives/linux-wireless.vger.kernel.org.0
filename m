Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5256779A4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjAWKzu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 05:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjAWKzt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 05:55:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616DB1630C
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 02:55:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05CDB60E87
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 10:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1576FC433D2;
        Mon, 23 Jan 2023 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674471347;
        bh=xTRF2Oyj7z5ywXCPFeu28wglIEuDcvhTlbgt5bEXm5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyFwpRl8K19QF3arH3ULF3MRDtUFcaWKAJuQs+6rZwehJdrWgWyTlUr30QylLVQWS
         IDqtlbq3NVVkRC7rlxKVvMIfH43KNXtSjGCrczAWP433vu6Hc4saA9U5vieBuwHc6p
         nhrfZ57vbAzFNfvv5mQTmYAOLHUiqlKuDMEWzO2BPHdIjuYuj5B7vxN5IWLItVkMiN
         E+reVJ/u6Ces6jY0CxTnuyaqENh3UfYyT8jm5+N6WfwHOax2pHl15gyzUeG3Ja4dFR
         vcuE0XwZnkT4i+OsHX6IVAsk7gCl5FTdYUsqTFnbNsqRQwCGslc3OX37MfhRQTqMz2
         XFODcLCIDiL9A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 1/2] wifi: mt76: mt7996: avoid mcu_restart function pointer
Date:   Mon, 23 Jan 2023 11:55:28 +0100
Message-Id: <b8e21ed0eea26faa02955cc4008638d82ed04fe4.1674471203.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674471203.git.lorenzo@kernel.org>
References: <cover.1674471203.git.lorenzo@kernel.org>
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
index d593ed9e3f73..7983008d74b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2247,6 +2247,26 @@ mt7996_firmware_state(struct mt7996_dev *dev, bool wa)
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
+	return mt76_mcu_send_msg(dev, MCU_WM_UNI_CMD(POWER_CTRL), &req,
+				 sizeof(req), false);
+}
+
 static int mt7996_load_firmware(struct mt7996_dev *dev)
 {
 	int ret;
@@ -2254,7 +2274,7 @@ static int mt7996_load_firmware(struct mt7996_dev *dev)
 	/* make sure fw is download state */
 	if (mt7996_firmware_state(dev, false)) {
 		/* restart firmware once */
-		__mt76_mcu_restart(&dev->mt76);
+		mt7996_mcu_restart(&dev->mt76);
 		ret = mt7996_firmware_state(dev, false);
 		if (ret) {
 			dev_err(dev->mt76.dev,
@@ -2383,33 +2403,12 @@ mt7996_mcu_init_rx_airtime(struct mt7996_dev *dev)
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
-	return mt76_mcu_send_msg(dev, MCU_WM_UNI_CMD(POWER_CTRL), &req,
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
 
@@ -2457,7 +2456,7 @@ int mt7996_mcu_init(struct mt7996_dev *dev)
 
 void mt7996_mcu_exit(struct mt7996_dev *dev)
 {
-	__mt76_mcu_restart(&dev->mt76);
+	mt7996_mcu_restart(&dev->mt76);
 	if (mt7996_firmware_state(dev, false)) {
 		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
 		goto out;
-- 
2.39.1

