Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762214CA964
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 16:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiCBPrH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 10:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiCBPrB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 10:47:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB02DC6262
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 07:46:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2908261723
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 15:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A570AC004E1;
        Wed,  2 Mar 2022 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646235974;
        bh=obZbTOYADNC1/h/Uq3Xi7lkk1yhBQj13ywBHgEqhCWc=;
        h=From:To:Cc:Subject:Date:From;
        b=gzcy0mCQKQw3tcW2sKaJxjzgoGjiIhz3AlpVH+kKrgNIaiXCBiYAtWtcA7rtUrZ8m
         +t19DiQugDjsOPH+rGiceFzS1Ocgu+mkJPTAvvq+pTXTYhycMhg6Uc/6JaWBKagfMD
         1t3ttfJGWbP3Jueiu32xUfIFcWFKmEcarNMkssJJGqLOHi84SSKy/EcZpUMK0NVYmb
         +XvkFh0Ne3Be/mcI5Mlr4RCa3MOiz6HeegsYL1WcK/JEk1ENWL06vFuYJ+fx+dcGJq
         MiAXhLt+/f0+Ms7x0p6tzKvNn+TfXOpXFgENgRLA4R8T5lzaoOUQSSoAp/yKnrupbo
         EmvdsNZ4H/5HA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: fix xmit-queue dump for usb and sdio
Date:   Wed,  2 Mar 2022 16:46:06 +0100
Message-Id: <4dec3e0aea1ae34f7bc8547f0ed7465f7b639840.1646235228.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use proper xmit queue handler to dump queue stats.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index dd04909d980a..1bb388ecc334 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -429,8 +429,13 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 	if (!dir)
 		return -ENOMEM;
 
-	debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
-				    mt7921_queues_read);
+	if (mt76_is_mmio(&dev->mt76))
+		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
+					    dir, mt7921_queues_read);
+	else
+		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
+					    dir, mt76_queues_read);
+
 	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
 				    mt7921_queues_acq);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower_sku", dir,
-- 
2.35.1

