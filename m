Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C94078F9E8
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 10:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbjIAIWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 04:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjIAIWA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 04:22:00 -0400
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0ECD7
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 01:21:53 -0700 (PDT)
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by forward205b.mail.yandex.net (Yandex) with ESMTP id 8708C67A05
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 11:21:50 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:9396:0:640:dd2a:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 392406028E;
        Fri,  1 Sep 2023 11:20:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id sKOYUPfDWSw0-6NnMzerT;
        Fri, 01 Sep 2023 11:20:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1693556455;
        bh=4f6bHYegSQwLCn6VtkijdaC7TwfrnHHXgXJt1Fm7i68=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=KgCaNl7Y6g+eBCudZcpYO/5ZhQpfYFR4NkSA11lbg0KPmcxZ+SpjU5BdWNlZ1dxBK
         /IDSYj0SeBY7VVx8NZ9HQ/AlqVjz2twZSEJ+khIrmiGdTIwl7ek8hBS/hag/cLXCMf
         EfppGVUpL8uHO1SAKSwwIUr4klhxIxMQ7yKRM5gE=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-mediatek@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mt76: add DMA mapping error check in mt76_alloc_txwi()
Date:   Fri,  1 Sep 2023 11:19:04 +0300
Message-ID: <20230901081908.44399-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add 'dma_mapping_error()' check in 'mt76_alloc_txwi()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 05d9ab3ce819..5af666f03398 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -53,6 +53,11 @@ mt76_alloc_txwi(struct mt76_dev *dev)
 
 	addr = dma_map_single(dev->dma_dev, txwi, dev->drv->txwi_size,
 			      DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev->dma_dev, addr))) {
+		kfree(txwi);
+		return NULL;
+	}
+
 	t = (struct mt76_txwi_cache *)(txwi + dev->drv->txwi_size);
 	t->dma_addr = addr;
 
-- 
2.41.0

