Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFC3645C34
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 15:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLGOQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 09:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiLGOQm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 09:16:42 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE38F5D680
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 06:16:38 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NRzlP2k6PzJp9w;
        Wed,  7 Dec 2022 22:13:05 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 22:16:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <pkshih@realtek.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH v3 1/3] wifi: rtlwifi: rtl8821ae: don't call kfree_skb() under spin_lock_irqsave()
Date:   Wed, 7 Dec 2022 22:14:09 +0800
Message-ID: <20221207141411.46098-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207141411.46098-1-yangyingliang@huawei.com>
References: <20221207141411.46098-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
context or with interrupts being disabled. All the SKBs have
been dequeued from the old queue, so it's safe to enqueue these
SKBs to a free queue, then free them after spin_unlock_irqrestore()
at once. Compile tested only.

Fixes: 5c99f04fec93 ("rtlwifi: rtl8723be: Update driver to match Realtek release of 06/28/14")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 7e0f62d59fe1..a7e3250957dc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -26,8 +26,10 @@ static void _rtl8821ae_return_beacon_queue_skb(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl8192_tx_ring *ring = &rtlpci->tx_ring[BEACON_QUEUE];
+	struct sk_buff_head free_list;
 	unsigned long flags;
 
+	skb_queue_head_init(&free_list);
 	spin_lock_irqsave(&rtlpriv->locks.irq_th_lock, flags);
 	while (skb_queue_len(&ring->queue)) {
 		struct rtl_tx_desc *entry = &ring->desc[ring->idx];
@@ -37,10 +39,12 @@ static void _rtl8821ae_return_beacon_queue_skb(struct ieee80211_hw *hw)
 				 rtlpriv->cfg->ops->get_desc(hw, (u8 *)entry,
 						true, HW_DESC_TXBUFF_ADDR),
 				 skb->len, DMA_TO_DEVICE);
-		kfree_skb(skb);
+		__skb_queue_tail(&free_list, skb);
 		ring->idx = (ring->idx + 1) % ring->entries;
 	}
 	spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
+
+	__skb_queue_purge(&free_list);
 }
 
 static void _rtl8821ae_set_bcn_ctrl_reg(struct ieee80211_hw *hw,
-- 
2.25.1

