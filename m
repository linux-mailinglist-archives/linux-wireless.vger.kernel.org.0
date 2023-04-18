Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE8A6E5DDA
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDRJtD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDRJtB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:49:01 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D291729
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EL/LVRgnCU+H58QIAhOB1fmH0r40YqxBGw/oXGKnlIM=; b=T9KtAsID4kuFbipSt3j2y3O6j6
        7tA8Pbxa+Ecmyi9EmEfIlb1NDyIKTvxV2xX7jUKHhGxfaPK11ARUrsn2RBbD5VqrYk4ClCB15mkS3
        jIes66Y2aJSTEvb2PO79LkC/5fZU7fKxeT78c8KCDbzok4ty2KJlWJVRkt6TebCj+AEA=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pohxG-00Fwil-Jf
        for linux-wireless@vger.kernel.org; Tue, 18 Apr 2023 11:48:54 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] wifi: mt76: dma: use napi_build_skb
Date:   Tue, 18 Apr 2023 11:48:52 +0200
Message-Id: <20230418094853.95197-2-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230418094853.95197-1-nbd@nbd.name>
References: <20230418094853.95197-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Improves performance by using bulk allocation

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 6c0174313d09..465190ebaf1c 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -853,7 +853,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		    !(dev->drv->rx_check(dev, data, len)))
 			goto free_frag;
 
-		skb = build_skb(data, q->buf_size);
+		skb = napi_build_skb(data, q->buf_size);
 		if (!skb)
 			goto free_frag;
 
-- 
2.39.0

