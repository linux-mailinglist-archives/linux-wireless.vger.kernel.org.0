Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E8F65A9CF
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAALqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAALqH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:46:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC1ACE9
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:46:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 846E360C01
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9A9C433EF;
        Sun,  1 Jan 2023 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672573565;
        bh=gf+1dWhONcgKs9nzc+dWswVgyP4V9iPOTVLIE4Ik3TM=;
        h=From:To:Cc:Subject:Date:From;
        b=Q9+Zbn/5TkS12fGh72L5eZFI7DsO4YBjn7MgHAFLknS/cKUjTa1vGl/cPRJIcz1e8
         etxX9u4KZ2asOC0pgTLY5SraOgRK5n9SVjh9kJ+SjSOWgjuPOu1Ha+ZnCcD2Qs8C3I
         CCR/p2CyS3LiD3R+tYhd/4c4m6tFEEc4kHep94rSM89dp6wHKMaVvZvs9KUVjTR4WY
         Eyn+rGfmbETqEsTr/9/wvO6B+muJnIHRnFr3rKxxOuiL+9BdDn56mlQ7n2MEiJlPsR
         +bC1kuIM6/DVG/79mZvtRWdKch6NDvZV6qrnrLC5iNTHUg7fLhiqjP2tG8BvBMt7Bn
         2NkzgcX5yH0Wg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: fix memory leak in mt7915_mcu_exit
Date:   Sun,  1 Jan 2023 12:42:04 +0100
Message-Id: <00b787803dc720980b7c6e5ef6e0203945fadb79.1672573088.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Always purge mcu skb queues in mt7915_mcu_exit routine even if
mt7915_firmware_state fails.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b2652de082ba..e69ef2828925 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2349,13 +2349,14 @@ void mt7915_mcu_exit(struct mt7915_dev *dev)
 	__mt76_mcu_restart(&dev->mt76);
 	if (mt7915_firmware_state(dev, false)) {
 		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
-		return;
+		goto out;
 	}
 
 	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND(0), MT_TOP_LPCR_HOST_FW_OWN);
 	if (dev->hif2)
 		mt76_wr(dev, MT_TOP_LPCR_HOST_BAND(1),
 			MT_TOP_LPCR_HOST_FW_OWN);
+out:
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 
-- 
2.38.1

