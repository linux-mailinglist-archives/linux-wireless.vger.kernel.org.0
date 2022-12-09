Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B320D647CC5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 05:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiLIDyU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 22:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLIDyT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 22:54:19 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF2FFB2ECD
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 19:54:12 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B93SbI92001630, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B93SbI92001630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 9 Dec 2022 11:28:37 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 9 Dec 2022 11:29:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Dec 2022 11:29:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 9 Dec 2022 11:29:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: don't call dev_kfree_skb() under spin_lock_irqsave()
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: don't call dev_kfree_skb() under
 spin_lock_irqsave()
Thread-Index: AQHZCxKwiLtwYwwQM0aow2sFSS4mC65k5qhQ
Date:   Fri, 9 Dec 2022 03:29:24 +0000
Message-ID: <bb02b109787c467494c3886a90b16b95@realtek.com>
References: <20221208143517.2383424-1-yangyingliang@huawei.com>
In-Reply-To: <20221208143517.2383424-1-yangyingliang@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/12/9_=3F=3F_02:13:00?=
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
> Sent: Thursday, December 8, 2022 10:35 PM
> To: Jes.Sorensen@gmail.com; kvalo@kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org; yangyingliang@huawei.com
> Subject: [PATCH v2] wifi: rtl8xxxu: don't call dev_kfree_skb() under spin_lock_irqsave()
> 
> It is not allowed to call kfree_skb() or consume_skb() from hardware
> interrupt context or with hardware interrupts being disabled.
> 
> It should use dev_kfree_skb_irq() or dev_consume_skb_irq() instead.
> The difference between them is free reason, dev_kfree_skb_irq() means
> the SKB is dropped in error and dev_consume_skb_irq() means the SKB
> is consumed in normal.
> 
> In this case, dev_kfree_skb() is called to free and drop the SKB when
> it's shutdown, so replace it with dev_kfree_skb_irq(). Compile tested
> only.
> 
> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> v1 -> v2:
>   Update commit message, and change to use dev_kfree_skb_irq().
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index ac641a56efb0..d0600af5bef4 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -5274,7 +5274,7 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
>  		pending = priv->rx_urb_pending_count;
>  	} else {
>  		skb = (struct sk_buff *)rx_urb->urb.context;
> -		dev_kfree_skb(skb);
> +		dev_kfree_skb_irq(skb);
>  		usb_free_urb(&rx_urb->urb);
>  	}
> 
> --
> 2.25.1
> 
> 
> ------Please consider the environment before printing this e-mail.
