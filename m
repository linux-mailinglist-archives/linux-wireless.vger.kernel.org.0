Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35646452A1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 04:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLGDor (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 22:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLGDoq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 22:44:46 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E091B57
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 19:44:45 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRjjY4QmbznTdX;
        Wed,  7 Dec 2022 11:40:33 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 11:44:13 +0800
Subject: Re: [PATCH resend 1/3] rtlwifi: rtl8821ae: don't call kfree_skb()
 under spin_lock_irqsave()
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        <yangyingliang@huawei.com>
References: <20221206131249.2181693-1-yangyingliang@huawei.com>
 <20221206131249.2181693-2-yangyingliang@huawei.com>
 <758b8caa9e8243bb84471baf50706e6d@realtek.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <c9096bc2-8765-8bf5-484b-da949c99e236@huawei.com>
Date:   Wed, 7 Dec 2022 11:44:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <758b8caa9e8243bb84471baf50706e6d@realtek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


On 2022/12/7 11:31, Ping-Ke Shih wrote:
>> -----Original Message-----
>> From: Yang Yingliang <yangyingliang@huawei.com>
>> Sent: Tuesday, December 6, 2022 9:13 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org
>> Cc: linux-wireless@vger.kernel.org; yangyingliang@huawei.com
>> Subject: [PATCH resend 1/3] rtlwifi: rtl8821ae: don't call kfree_skb() under spin_lock_irqsave()
>>
>> It is not allowed to call kfree_skb() from hardware interrupt
>> context or with interrupts being disabled. So add all skb to
>> a free list, then free them after spin_unlock_irqrestore() at
>> once.
> The patch doesn't change logic, so it should work. But, I would like to know
> if there is a comment about this in kernel code. Could you point it out?
You can see comment of dev_kfree_skb_irq() in include/linux/netdevice.h
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/netdevice.h?h=v6.1-rc8

Thanks,
Yang
>
>> Fixes: 5c99f04fec93 ("rtlwifi: rtl8723be: Update driver to match Realtek release of 06/28/14")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
>> index 7e0f62d59fe1..a7e3250957dc 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
>> @@ -26,8 +26,10 @@ static void _rtl8821ae_return_beacon_queue_skb(struct ieee80211_hw *hw)
>>   	struct rtl_priv *rtlpriv = rtl_priv(hw);
>>   	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
>>   	struct rtl8192_tx_ring *ring = &rtlpci->tx_ring[BEACON_QUEUE];
>> +	struct sk_buff_head free_list;
>>   	unsigned long flags;
>>
>> +	skb_queue_head_init(&free_list);
>>   	spin_lock_irqsave(&rtlpriv->locks.irq_th_lock, flags);
>>   	while (skb_queue_len(&ring->queue)) {
>>   		struct rtl_tx_desc *entry = &ring->desc[ring->idx];
>> @@ -37,10 +39,12 @@ static void _rtl8821ae_return_beacon_queue_skb(struct ieee80211_hw *hw)
>>   				 rtlpriv->cfg->ops->get_desc(hw, (u8 *)entry,
>>   						true, HW_DESC_TXBUFF_ADDR),
>>   				 skb->len, DMA_TO_DEVICE);
>> -		kfree_skb(skb);
>> +		__skb_queue_tail(&free_list, skb);
>>   		ring->idx = (ring->idx + 1) % ring->entries;
>>   	}
>>   	spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
>> +
>> +	__skb_queue_purge(&free_list);
>>   }
>>
>>   static void _rtl8821ae_set_bcn_ctrl_reg(struct ieee80211_hw *hw,
>> --
>> 2.25.1
>>
>>
>> ------Please consider the environment before printing this e-mail.
> .
