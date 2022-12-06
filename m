Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A4644160
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 11:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiLFKkg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 05:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiLFKkJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 05:40:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6C91DF0A
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 02:40:08 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRGzK5ZlfzqST0;
        Tue,  6 Dec 2022 18:35:57 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 6 Dec
 2022 18:40:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <pkshih@realtek.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH 3/3] rtlwifi: rtl8723be: don't call kfree_skb() under spin_lock_irqsave()
Date:   Tue, 6 Dec 2022 18:37:40 +0800
Message-ID: <20221206103740.1963605-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221206103740.1963605-1-yangyingliang@huawei.com>
References: <20221206103740.1963605-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
context or with interrupts being disabled. So add all skb to
a free list, then free them after spin_unlock_irqrestore() at
once.

Fixes: 5c99f04fec93 ("rtlwifi: rtl8723be: Update driver to match Realtek release of 06/28/14")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
index 189cc6437600..3d105960a835 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -30,8 +30,10 @@ static void _rtl8723be_return_beacon_queue_skb(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl8192_tx_ring *ring = &rtlpci->tx_ring[BEACON_QUEUE];
+	struct sk_buff_head free_list;
 	unsigned long flags;
 
+	skb_queue_head_init(&free_list);
 	spin_lock_irqsave(&rtlpriv->locks.irq_th_lock, flags);
 	while (skb_queue_len(&ring->queue)) {
 		struct rtl_tx_desc *entry = &ring->desc[ring->idx];
@@ -42,9 +44,12 @@ static void _rtl8723be_return_beacon_queue_skb(struct ieee80211_hw *hw)
 						true, HW_DESC_TXBUFF_ADDR),
 				 skb->len, DMA_TO_DEVICE);
 		kfree_skb(skb);
+		__skb_queue_tail(&free_list, skb);
 		ring->idx = (ring->idx + 1) % ring->entries;
 	}
 	spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
+
+	__skb_queue_purge(&free_list);
 }
 
 static void _rtl8723be_set_bcn_ctrl_reg(struct ieee80211_hw *hw,
-- 
2.25.1

