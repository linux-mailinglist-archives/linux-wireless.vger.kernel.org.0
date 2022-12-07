Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25638645D30
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 16:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiLGPDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 10:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiLGPCw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 10:02:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16054264D
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 07:02:35 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NS0qW2KmRzmWPN;
        Wed,  7 Dec 2022 23:01:43 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 23:02:33 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <kvalo@kernel.org>, <libertas-dev@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
CC:     <yangyingliang@huawei.com>
Subject: [PATCH v2 1/4] libertas_tf: don't call kfree_skb() under spin_lock_irqsave()
Date:   Wed, 7 Dec 2022 23:00:05 +0800
Message-ID: <20221207150008.111743-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207150008.111743-1-yangyingliang@huawei.com>
References: <20221207150008.111743-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is not allowed to call kfree_skb() from hardware interrupt
context or with interrupts being disabled. So replace kfree_skb()
with dev_kfree_skb_irq() under spin_lock_irqsave(). Compile
tested only.

Fixes: fc75122fabb5 ("libertas_tf: use irqsave() in USB's complete callback")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/wireless/marvell/libertas_tf/if_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
index 75b5319d033f..1750f5e93de2 100644
--- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
@@ -613,7 +613,7 @@ static inline void process_cmdrequest(int recvlength, uint8_t *recvbuff,
 	spin_lock_irqsave(&priv->driver_lock, flags);
 	memcpy(priv->cmd_resp_buff, recvbuff + MESSAGE_HEADER_LEN,
 	       recvlength - MESSAGE_HEADER_LEN);
-	kfree_skb(skb);
+	dev_kfree_skb_irq(skb);
 	lbtf_cmd_response_rx(priv);
 	spin_unlock_irqrestore(&priv->driver_lock, flags);
 }
-- 
2.25.1

