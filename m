Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770A57D0DD9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 12:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377167AbjJTKrS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377097AbjJTKrI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 06:47:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA093275
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 03:45:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682CBC433C8;
        Fri, 20 Oct 2023 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697798726;
        bh=QYS87VmaIdJZXTsmHkpT3eJIWnTu6R6ehZGHddHZ7wU=;
        h=From:To:Cc:Subject:Date:From;
        b=VGizGXMHT4W3/Co3ME+YVe+7x/7WBwX0D1xOQYvkWA0br54GW3a7VU7uxvHFTwfDp
         f80FkmdT2gCfaODjryh2NJC6N8TZx2bvSusxkG9qba0vri5/J0NachhotBBuBh/AFE
         rOnjk5DUcpjqmaRWWTaVpWBlHJZnN9UAivgpz77OzbpfafbIOweGSi9nV1rRixnvTY
         JiYoD6R0cVA2C63lnAf0idhABLkQDmqg5iriN2HRRs0+CJ+rSEp+kassuBiW0hf9mk
         VQhQhYJn1JzLwj8vRyO2ci9GOB+bXXiW9TD+rzoWXrlTeW7eBY+2e1t1cD13jsZ2Am
         z592wJUPXtXkw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7915: fallback to non-wed mode if platform_get_resource fails in mt7915_mmio_wed_init()
Date:   Fri, 20 Oct 2023 12:45:19 +0200
Message-ID: <6481c37a50fb68db56af88e07e31da71d04aff40.1697798663.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76 assumes mt7915_mmio_wed_init can fail just after wed driver has
been attached running mtk_wed_device_attach().
Fall back to non-wed mode if platform_get_resource fails in
mt7915_mmio_wed_init routines.

Fixes: eebb70976be5 ("wifi: mt76: mt7915: enable wed for mt7986-wmac chipset")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index c404c90b58a6..aff4f21e843d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -636,7 +636,7 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 
 		res = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
 		if (!res)
-			return -ENOMEM;
+			return 0;
 
 		wed->wlan.platform_dev = plat_dev;
 		wed->wlan.bus_type = MTK_WED_BUS_AXI;
-- 
2.41.0

