Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D867A662A57
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 16:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbjAIPmd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 10:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbjAIPlb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 10:41:31 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D213AB29
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 07:39:37 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id n8so7461967oih.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jan 2023 07:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4A3Ftur2eKpa5av6Mw9JhBpO5ttJgQ/Gh6WYfLvuDMA=;
        b=jpE3nTlhZerX5p05h7yUGA9S9KIoHunY8JIQF4GGh/sXv8JVhrD/18tsYILYoX4Mzc
         9KOofcxbZJF1DOAWmKef6TAsI33PHCrEB7MavqA7cGh62lPdb+jY5C1povDUe+SJDX++
         5xWUWKCS/lnZR48jjSt90MT54dAf6UbRnU0J318VXWHc6FPApr7V966YzNM7mmcS3xx+
         u0lpHQGiwTMHbKIdZsq0y5m+pRYDSdgGWmC15qN/3kyVs5Z9mIiyDwpFBAjATfItdLFq
         Mt5z2oqiEo41ApcZeGbfe5m+jEPI4gJkgN/YX54oGAt/FynmmiHIrqCLhDPqdqVIQRdg
         xeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4A3Ftur2eKpa5av6Mw9JhBpO5ttJgQ/Gh6WYfLvuDMA=;
        b=GoHJ/xc+hvTqhCrEYt7AD8tzEvEKLSYxM5P0oFoLS39MBSe8h11Ya1hvZo/CO5IxXh
         Jdz6lqVoRbw8Mhacz6PuUHWaAaGe/WOGQRJM7dBkUWRE/qhmvgLW2xGA1d9PxTX2YCDa
         WwYJeuAy7usjDdHc/QF0F+Pn78Gkvtyt1TJ3O8KjSfXVaCtuInrJifjnqbVL8vWPg2QA
         HgLb8POAFkyTSxWvc1jZL8RFea5iKI8KL1r+HyI7oaK9LX6dMNDZZPusZeqGTY7N2/Ii
         W+ytXpWsRFasxtwYDF3NAkwifNQDvKmmVxdqAeMO/uvJcgkcnSsgFMO4Ry9pqnCRrORn
         3UFw==
X-Gm-Message-State: AFqh2koOsxH7IlvHLloSpz/ahCk0RxhUXqBR1vQZLFBcocRaJlkLB1DP
        s9PiVcS9Uvy+l0TiumonDWU=
X-Google-Smtp-Source: AMrXdXvUSMPWGI5OIFgCIPPRoBkTq1gbUyEqJOO9eA+A8wvurEjZAv1njxMKsdrggpkpNvVDPV/q6w==
X-Received: by 2002:a05:6808:210d:b0:360:e954:9dda with SMTP id r13-20020a056808210d00b00360e9549ddamr39122810oiw.12.1673278777030;
        Mon, 09 Jan 2023 07:39:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y28-20020a544d9c000000b0035474ff66b3sm3988236oix.35.2023.01.09.07.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 07:39:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6b39574f-e067-395f-f579-b0b805983996@roeck-us.net>
Date:   Mon, 9 Jan 2023 07:39:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Wen Gong <quic_wgong@quicinc.com>
Cc:     johannes@sipsolutions.net, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20221212083607.21536-1-quic_wgong@quicinc.com>
 <20230105052647.GA2477583@roeck-us.net>
 <d28c6340-7ad2-d7f6-939d-3a1a057cb7da@wetzel-home.de>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] wifi: mac80211: change initialize for sk_buff in
 ieee80211_tx_dequeue()
In-Reply-To: <d28c6340-7ad2-d7f6-939d-3a1a057cb7da@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/9/23 06:05, Alexander Wetzel wrote:
> On 05.01.23 06:26, Guenter Roeck wrote:
>> On Mon, Dec 12, 2022 at 03:36:07AM -0500, Wen Gong wrote:
>>> The sk_buff is only set to NULL when initialize, sometimes it will goto
>>> label "begin" after ieee80211_free_txskb(), then it points to a sk_buff
>>> which is already freed. If it run into the "goto out" after arrived to
>>> label "begin", then it will return a sk_buff which is freed, it is a
>>> risk for use-after-free.
>>>
>>> Fixes: ded4698b58cb ("mac80211: run late dequeue late tx handlers without holding fq->lock")
>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>
>> I don't see any progress on this patch. Is there a problem with it ?
>> Did it get lost ?
>>
> 
> Looks ok for me. But I just noticed that my patch
> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
> 
> should also fix the issue as an unintended side effect.
> 

Unless I am missing something, there is still a path

begin:
	...
	
	if (unlikely(test_bit(IEEE80211_TXQ_STOP, &txqi->flags)))
  		goto out;
	...
	skb = ...
	...
                         ieee80211_free_txskb(&local->hw, skb);
                         goto begin;

after your patch is applied. Unless the IEEE80211_TXQ_STOP can never be true
after the first iteration I don't see how your patch would fix the problem.

Guenter

> Alexander
> 
>> Thanks,
>> Guenter
>>
>>> ---
>>>   net/mac80211/tx.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>>
>>> base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
>>>
>>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>>> index 2171cd1ca807..0b23cc9ab9c7 100644
>>> --- a/net/mac80211/tx.c
>>> +++ b/net/mac80211/tx.c
>>> @@ -3776,7 +3776,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>>>       struct ieee80211_local *local = hw_to_local(hw);
>>>       struct txq_info *txqi = container_of(txq, struct txq_info, txq);
>>>       struct ieee80211_hdr *hdr;
>>> -    struct sk_buff *skb = NULL;
>>> +    struct sk_buff *skb;
>>>       struct fq *fq = &local->fq;
>>>       struct fq_tin *tin = &txqi->tin;
>>>       struct ieee80211_tx_info *info;
>>> @@ -3790,6 +3790,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>>>           return NULL;
>>>   begin:
>>> +    skb = NULL;
>>> +
>>>       spin_lock_bh(&fq->lock);
>>>       if (test_bit(IEEE80211_TXQ_STOP, &txqi->flags) ||
> 

