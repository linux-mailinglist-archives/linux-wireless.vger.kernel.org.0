Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D731E786772
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 08:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbjHXGYO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 02:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbjHXGYJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 02:24:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD16FD
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 23:24:07 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RWXxr3pDtztRs5;
        Thu, 24 Aug 2023 14:20:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 24 Aug
 2023 14:24:01 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-wireless@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] rtlwifi: rtl8723: Remove unused function rtl8723_cmd_send_packet()
Date:   Thu, 24 Aug 2023 14:23:39 +0800
Message-ID: <20230824062339.1885385-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function rtl8723_cmd_send_packet() is not used anywhere, so remove it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 .../realtek/rtlwifi/rtl8723com/fw_common.c    | 28 -------------------
 .../realtek/rtlwifi/rtl8723com/fw_common.h    |  2 --
 2 files changed, 30 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c
index 36c00b89ccae..50b79cf8fb3c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c
@@ -215,31 +215,3 @@ int rtl8723_download_fw(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(rtl8723_download_fw);
 
-bool rtl8723_cmd_send_packet(struct ieee80211_hw *hw,
-			     struct sk_buff *skb)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
-	struct rtl8192_tx_ring *ring;
-	struct rtl_tx_desc *pdesc;
-	struct sk_buff *pskb = NULL;
-	unsigned long flags;
-
-	ring = &rtlpci->tx_ring[BEACON_QUEUE];
-
-	pskb = __skb_dequeue(&ring->queue);
-	kfree_skb(pskb);
-	spin_lock_irqsave(&rtlpriv->locks.irq_th_lock, flags);
-
-	pdesc = &ring->desc[0];
-	rtlpriv->cfg->ops->fill_tx_cmddesc(hw, (u8 *)pdesc, 1, 1, skb);
-
-	__skb_queue_tail(&ring->queue, skb);
-
-	spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
-
-	rtlpriv->cfg->ops->tx_polling(hw, BEACON_QUEUE);
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(rtl8723_cmd_send_packet);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.h
index b527fcbbdf08..c8e04f9722ae 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.h
@@ -66,7 +66,5 @@ void rtl8723_write_fw(struct ieee80211_hw *hw,
 		      u8 *buffer, u32 size, u8 max_page);
 int rtl8723_fw_free_to_go(struct ieee80211_hw *hw, bool is_8723be, int count);
 int rtl8723_download_fw(struct ieee80211_hw *hw, bool is_8723be, int count);
-bool rtl8723_cmd_send_packet(struct ieee80211_hw *hw,
-			     struct sk_buff *skb);
 
 #endif
-- 
2.34.1

