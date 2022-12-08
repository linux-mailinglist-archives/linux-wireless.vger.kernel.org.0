Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150D4646674
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 02:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLHBZi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 20:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHBZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 20:25:37 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3D68C45C
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 17:25:35 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NSGfN1HpKz15N4n;
        Thu,  8 Dec 2022 09:24:44 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 09:25:33 +0800
Subject: Re: [PATCH] wifi: rtl8xxxu: don't call dev_kfree_skb() under
 spin_lock_irqsave()
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        <yangyingliang@huawei.com>
References: <20221207143738.67721-1-yangyingliang@huawei.com>
 <0cfea9eaf08446d5a7dfcb85da34dcf2@realtek.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <c3ca010a-3c1a-5c64-a58a-a66d31f5869b@huawei.com>
Date:   Thu, 8 Dec 2022 09:25:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0cfea9eaf08446d5a7dfcb85da34dcf2@realtek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2022/12/8 8:38, Ping-Ke Shih wrote:
>> -----Original Message-----
>> From: Yang Yingliang <yangyingliang@huawei.com>
>> Sent: Wednesday, December 7, 2022 10:38 PM
>> To: Jes.Sorensen@gmail.com; kvalo@kernel.org
>> Cc: linux-wireless@vger.kernel.org
>> Subject: [PATCH] wifi: rtl8xxxu: don't call dev_kfree_skb() under spin_lock_irqsave()
>>
>> It is not allowed to call consume_skb() from hardware interrupt context
>                              ^^^^^^^^^^^^^ kfree_skb()?
> because this patch is to replace dev_kfree_skb().
>
>> or with interrupts being disabled. So replace dev_kfree_skb() with
>> dev_consume_skb_irq() under spin_lock_irqsave(). Compile tested only.
>>
>> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index ac641a56efb0..d0600af5bef4 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -5274,7 +5274,7 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
>>   		pending = priv->rx_urb_pending_count;
>>   	} else {
>>   		skb = (struct sk_buff *)rx_urb->urb.context;
>> -		dev_kfree_skb(skb);
>> +		dev_consume_skb_irq(skb);
> Why not dev_kfree_skb_irq() instead? any reason?
#define dev_kfree_skb(a)        consume_skb(a)
dev_kfree_skb() is consume_skb(), so use dev_consume_skb_irq() instead.

static inline void dev_kfree_skb_irq(struct sk_buff *skb)
{
         __dev_kfree_skb_irq(skb, SKB_REASON_DROPPED);
}

static inline void dev_consume_skb_irq(struct sk_buff *skb)
{
         __dev_kfree_skb_irq(skb, SKB_REASON_CONSUMED);
}
They have different free reasons.

Thanks,
Yang
>
>>   		usb_free_urb(&rx_urb->urb);
>>   	}
>>
>> --
>> 2.25.1
>>
>>
>> ------Please consider the environment before printing this e-mail.
> .
