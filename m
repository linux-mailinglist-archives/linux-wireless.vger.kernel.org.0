Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4CF65A9DB
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjAALxh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAALxg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:53:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30FC26D6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:53:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C7FE60DBB
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77421C433EF;
        Sun,  1 Jan 2023 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672574014;
        bh=zB0gr5obkcDIs83XBUPkeP+DX9P5EjI9FfjbGTDI/xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+DDTNWnhSYsx8UlAm4nBvvqEWXrfkPNycDQrch72z1N8hwAgOVegp6C8ePacPVKZ
         ZsJesGz8TBOOGD0K2E8aqWCs77SRHNkjborIiSDaYcTr3Z/gXARXLz6rrXE+24sjh5
         3a6tCTkBZQkVLWTo+XYtgFddkn+qGcIOUono5OIBj9qHJ9vmOgamBrY+1neLvQnnNJ
         bPLU75vtYIce+GZcy6CS1SoRDe+mergY7guu2CHFv0G10FfghSmmVro5RJw/+WBHrR
         HflDIq3GY0lJ+AA34uPthUS7mMBFOJcMNH7tAP+4It8b6ZyL34AcoOLuOnDLet3X5E
         unRc7HBSVHSqA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 1/6] wifi: mt76: mt7915: avoid mcu_restart function pointer
Date:   Sun,  1 Jan 2023 12:53:18 +0100
Message-Id: <671a32a6550323555c1807e1ac83a7bff15e500e.1672573894.git.lorenzo@kernel.org>
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

Run mt76_connac_mcu_restart routine directly and avoid mcu_restart
function pointer whenever it is possible.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e69ef2828925..55517e0f8c84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2104,7 +2104,7 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 	/* make sure fw is download state */
 	if (mt7915_firmware_state(dev, false)) {
 		/* restart firmware once */
-		__mt76_mcu_restart(&dev->mt76);
+		mt76_connac_mcu_restart(&dev->mt76);
 		ret = mt7915_firmware_state(dev, false);
 		if (ret) {
 			dev_err(dev->mt76.dev,
@@ -2336,7 +2336,6 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 		.headroom = sizeof(struct mt76_connac2_mcu_txd),
 		.mcu_skb_send_msg = mt7915_mcu_send_message,
 		.mcu_parse_response = mt7915_mcu_parse_response,
-		.mcu_restart = mt76_connac_mcu_restart,
 	};
 
 	dev->mt76.mcu_ops = &mt7915_mcu_ops;
@@ -2346,7 +2345,7 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 
 void mt7915_mcu_exit(struct mt7915_dev *dev)
 {
-	__mt76_mcu_restart(&dev->mt76);
+	mt76_connac_mcu_restart(&dev->mt76);
 	if (mt7915_firmware_state(dev, false)) {
 		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
 		goto out;
-- 
2.38.1

