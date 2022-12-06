Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B3644435
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 14:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiLFNLe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 08:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiLFNK5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 08:10:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0906C7C
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 05:09:34 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRLHl5lV1zqSsw;
        Tue,  6 Dec 2022 21:05:23 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 21:08:59 +0800
Subject: Re: [PATCH 0/3] rtlwifi: don't call kfree_skb() under
 spin_lock_irqsave()
To:     <pkshih@realtek.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <yangyingliang@huawei.com>
References: <20221206103740.1963605-1-yangyingliang@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <d8d69776-b660-68c7-4919-751a00196e84@huawei.com>
Date:   Tue, 6 Dec 2022 21:08:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221206103740.1963605-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

I send a wrong patch, please ignore this patchset, I will resend it.

On 2022/12/6 18:37, Yang Yingliang wrote:
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with interrupts being disabled. This patchset is
> trying to add all skb to a free list, then free them after
> spin_unlock_irqrestore() at once.
>
> Yang Yingliang (3):
>    rtlwifi: rtl8821ae: don't call kfree_skb() under spin_lock_irqsave()
>    rtlwifi: rtl8188ee: don't call kfree_skb() under spin_lock_irqsave()
>    rtlwifi: rtl8723be: don't call kfree_skb() under spin_lock_irqsave()
>
>   drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c | 6 +++++-
>   drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c | 5 +++++
>   drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 6 +++++-
>   3 files changed, 15 insertions(+), 2 deletions(-)
>
