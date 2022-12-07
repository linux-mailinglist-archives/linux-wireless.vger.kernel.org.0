Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613B564528C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 04:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLGDcP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 22:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLGDcP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 22:32:15 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84365554E8
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 19:32:10 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B73UESS0012076, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B73UESS0012076
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 7 Dec 2022 11:30:14 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 7 Dec 2022 11:31:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 7 Dec 2022 11:31:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 7 Dec 2022 11:31:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH resend 1/3] rtlwifi: rtl8821ae: don't call kfree_skb() under spin_lock_irqsave()
Thread-Topic: [PATCH resend 1/3] rtlwifi: rtl8821ae: don't call kfree_skb()
 under spin_lock_irqsave()
Thread-Index: AQHZCXTBd7UL9gBmHkG5RI2in6WwBq5hxFHw
Date:   Wed, 7 Dec 2022 03:31:01 +0000
Message-ID: <758b8caa9e8243bb84471baf50706e6d@realtek.com>
References: <20221206131249.2181693-1-yangyingliang@huawei.com>
 <20221206131249.2181693-2-yangyingliang@huawei.com>
In-Reply-To: <20221206131249.2181693-2-yangyingliang@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/12/7_=3F=3F_01:28:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: Tuesday, December 6, 2022 9:13 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org
> Cc: linux-wireless@vger.kernel.org; yangyingliang@huawei.com
> Subject: [PATCH resend 1/3] rtlwifi: rtl8821ae: don't call kfree_skb() under spin_lock_irqsave()
> 
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with interrupts being disabled. So add all skb to
> a free list, then free them after spin_unlock_irqrestore() at
> once.

The patch doesn't change logic, so it should work. But, I would like to know
if there is a comment about this in kernel code. Could you point it out?

> 
> Fixes: 5c99f04fec93 ("rtlwifi: rtl8723be: Update driver to match Realtek release of 06/28/14")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> index 7e0f62d59fe1..a7e3250957dc 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> @@ -26,8 +26,10 @@ static void _rtl8821ae_return_beacon_queue_skb(struct ieee80211_hw *hw)
>  	struct rtl_priv *rtlpriv = rtl_priv(hw);
>  	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
>  	struct rtl8192_tx_ring *ring = &rtlpci->tx_ring[BEACON_QUEUE];
> +	struct sk_buff_head free_list;
>  	unsigned long flags;
> 
> +	skb_queue_head_init(&free_list);
>  	spin_lock_irqsave(&rtlpriv->locks.irq_th_lock, flags);
>  	while (skb_queue_len(&ring->queue)) {
>  		struct rtl_tx_desc *entry = &ring->desc[ring->idx];
> @@ -37,10 +39,12 @@ static void _rtl8821ae_return_beacon_queue_skb(struct ieee80211_hw *hw)
>  				 rtlpriv->cfg->ops->get_desc(hw, (u8 *)entry,
>  						true, HW_DESC_TXBUFF_ADDR),
>  				 skb->len, DMA_TO_DEVICE);
> -		kfree_skb(skb);
> +		__skb_queue_tail(&free_list, skb);
>  		ring->idx = (ring->idx + 1) % ring->entries;
>  	}
>  	spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
> +
> +	__skb_queue_purge(&free_list);
>  }
> 
>  static void _rtl8821ae_set_bcn_ctrl_reg(struct ieee80211_hw *hw,
> --
> 2.25.1
> 
> 
> ------Please consider the environment before printing this e-mail.
