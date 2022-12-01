Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759BB63EB9C
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 09:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiLAIwJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 03:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiLAIwG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 03:52:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18833BC87
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 00:52:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C75FB81E4E
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 08:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD25C433D6;
        Thu,  1 Dec 2022 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669884722;
        bh=LoX5pwqgBqd/+18b/OaxIvbdapL+th5ckV8FMt+jX8M=;
        h=From:To:Cc:Subject:Date:From;
        b=T8fM6AFXljmDv4ut/vEc9aK9CZE9F0xWxDv+eMxDYZGRwVKZTjGSJrZSooZnwQ2vs
         ZsHrhSXGcz0TFeWdEKOh9M/Kk/cEYpmxGvI95+sylpUJ+WXoOziJTDE4zG/9RM5BRI
         xo3YPvRs5nZslqUOOSGAiQ/e9CwkHOO+S1j1yGctlwSmXpAhLg7JmNE3ep0mcem9mS
         Q5Yh9/Cfi/fSr12y2A7CTwweq/2IRB0xSqbWQzafczPxY+e72i6kuPKQINA4cyhY1q
         RTaqYlg/q+Oz8P6D9AGDQRY+q5T0FAHqD3jcMZXe8mn9ESEPjAyVS2bF7CCtorgpYi
         oiHq6tjwWzYJQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: mmio: fix naming convention
Date:   Thu,  1 Dec 2022 09:51:55 +0100
Message-Id: <9db00e67dd4310885215ea765032e310d68b6abe.1669884630.git.lorenzo@kernel.org>
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

Rename mt7915_wed_release_rx_buf in mt7915_mmio_wed_release_rx_buf,
mt7915_wed_init_rx_buf in mt7915_mmio_wed_init_rx_buf and
mt7915_wed_release_rx_buf in mt7915_mmio_wed_release_rx_buf

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 3b4ede3b85ea..d63779c50276 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -591,7 +591,7 @@ static void mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
 			   MT_AGG_ACR_PPDU_TXS2H);
 }
 
-static void mt7915_wed_release_rx_buf(struct mtk_wed_device *wed)
+static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
 {
 	struct mt7915_dev *dev;
 	struct page *page;
@@ -621,7 +621,7 @@ static void mt7915_wed_release_rx_buf(struct mtk_wed_device *wed)
 	memset(&wed->rx_buf_ring.rx_page, 0, sizeof(wed->rx_buf_ring.rx_page));
 }
 
-static u32 mt7915_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
+static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 {
 	struct mtk_rxbm_desc *desc = wed->rx_buf_ring.desc;
 	struct mt7915_dev *dev;
@@ -661,7 +661,7 @@ static u32 mt7915_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 	return 0;
 
 unmap:
-	mt7915_wed_release_rx_buf(wed);
+	mt7915_mmio_wed_release_rx_buf(wed);
 	return -ENOMEM;
 }
 
@@ -768,8 +768,8 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	wed->wlan.init_buf = mt7915_wed_init_buf;
 	wed->wlan.offload_enable = mt7915_mmio_wed_offload_enable;
 	wed->wlan.offload_disable = mt7915_mmio_wed_offload_disable;
-	wed->wlan.init_rx_buf = mt7915_wed_init_rx_buf;
-	wed->wlan.release_rx_buf = mt7915_wed_release_rx_buf;
+	wed->wlan.init_rx_buf = mt7915_mmio_wed_init_rx_buf;
+	wed->wlan.release_rx_buf = mt7915_mmio_wed_release_rx_buf;
 	wed->wlan.update_wo_rx_stats = mt7915_mmio_wed_update_rx_stats;
 
 	dev->mt76.rx_token_size = wed->wlan.rx_npkt;
-- 
2.38.1

