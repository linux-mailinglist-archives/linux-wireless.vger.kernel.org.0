Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B8B3194BF
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 21:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBKUyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 15:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhBKUyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 15:54:33 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CFBC061756
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 12:53:53 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id f20so7130471ioo.10
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 12:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z6ZG5Dmpcr3dphEuMXhR4ohnjOhh91pyYZOXK8YBBQ8=;
        b=SwQEk23nQu49/7zGvXpYbPxTTfQhd6o7wAYudESH1lMiZQYROCK9GrzJrOl2Bh84Zl
         o/RJiF9S+Nv6YIJsJs9mHanLZCn57L0+7WYavg7+z7foM6R7Jd//qEu+5oJIcCnPjXOf
         xktxquW2pcwEdLVdDtL00ytKmXKh1pNsWBuGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z6ZG5Dmpcr3dphEuMXhR4ohnjOhh91pyYZOXK8YBBQ8=;
        b=qjqZeQvbSiH4wiqirQcMdRe47GTGB65sGHvqiXkwv9nNaJWPCmYo/MymxZl5Bp/NzR
         f9szglGy4Y1zJMP+zTfwahuh5GNAR0SL3+2TTUWDbLUap3GF2QoQZ+PF51dsp+NpBjKN
         3IuJm5brLAGuELZQ/gdUvnXzGR+VuRL8RBYHvtrRqSVybXvTENoez/Xggub2LMNmdzAO
         MFQdJanMMpm1fRigs70apEfCepu5MGcirenqnH5tdJX4hwWIGjV5PAz75tfFdITfvfaa
         AugdGaLmYGpm/WgxgvCsLvx6tEitJJYtq1rK8xbgEKZvr7gjxtLAPGwpsvB8VEf/KaRx
         oivA==
X-Gm-Message-State: AOAM531BCB0/qAG2B/LoWvr9SzU78FEr3JotZt5t/Si+Ax7nEdEq1O7s
        0S2IHAehPcVo+wR4+jx4f/XA/uopEa/gaQ==
X-Google-Smtp-Source: ABdhPJxS+FbWEJCWFiOb19bw5JWTzO423ZZjhYNmsV3ct5XHCjciv+zdMEIgaDhb4egTqrnav0Krmw==
X-Received: by 2002:a5d:9586:: with SMTP id a6mr7220881ioo.83.1613076832081;
        Thu, 11 Feb 2021 12:53:52 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h13sm3006905ioe.40.2021.02.11.12.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 12:53:51 -0800 (PST)
Subject: Re: [PATCH 4/5] ath10k: detect conf_mutex held ath10k_drain_tx()
 calls
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        kuba@kernel.org, davem@davemloft.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1612915444.git.skhan@linuxfoundation.org>
 <a980abfb143f5240375f3f1046f0f26971c695e6.1612915444.git.skhan@linuxfoundation.org>
 <87lfbwtjls.fsf@codeaurora.org>
 <d6d8c7b8-f69d-01ef-6d66-8a33ea98920f@linuxfoundation.org>
 <871rdmu9z9.fsf@codeaurora.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f0905d6c-065f-a29c-2c83-77f55e77d36e@linuxfoundation.org>
Date:   Thu, 11 Feb 2021 13:53:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <871rdmu9z9.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/11/21 4:20 AM, Kalle Valo wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> On 2/10/21 1:25 AM, Kalle Valo wrote:
>>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>>
>>>> ath10k_drain_tx() must not be called with conf_mutex held as workers can
>>>> use that also. Add check to detect conf_mutex held calls.
>>>>
>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> The commit log does not answer to "Why?". How did you find this? What
>>> actual problem are you trying to solve?
>>>
>>
>> I came across the comment block above the ath10k_drain_tx() as I was
>> reviewing at conf_mutex holds while I was debugging the conf_mutex
>> lock assert in ath10k_debug_fw_stats_request().
>>
>> My reasoning is that having this will help detect incorrect usages
>> of ath10k_drain_tx() while holding conf_mutex which could lead to
>> locking problems when async worker routines try to call this routine.
> 
> Ok, makes sense. I prefer having this background info in the commit log,
> for example "found by code review" or something like that. Or just copy
> what you wrote above :)
> 

Thanks. I will do that.

>>>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>>>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>>>> @@ -4566,6 +4566,7 @@ static void
>>>> ath10k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
>>>>    /* Must not be called with conf_mutex held as workers can use that also. */
>>>>    void ath10k_drain_tx(struct ath10k *ar)
>>>>    {
>>>> +	WARN_ON(lockdep_is_held(&ar->conf_mutex));
>>>
>>> Empty line after WARN_ON().
>>>
>>
>> Will do.
>>
>>> Shouldn't this check debug_locks similarly lockdep_assert_held() does?
>>>
>>> #define lockdep_assert_held(l)	do {				\
>>> 		WARN_ON(debug_locks && !lockdep_is_held(l));	\
>>> 	} while (0)
>>>
>>> And I suspect you need #ifdef CONFIG_LOCKDEP which should fix the kbuild
>>> bot error.
>>>
>>
>> Yes.
>>
>>> But honestly I would prefer to have lockdep_assert_not_held() in
>>> include/linux/lockdep.h, much cleaner that way. Also
>>> i915_gem_object_lookup_rcu() could then use the same macro.
>>>
>>
>> Right. This is the right way to go. That was first instinct and
>> decided to have the discussion evolve in that direction. Now that
>> it has, I will combine this change with
>> include/linux/lockdep.h and add lockdep_assert_not_held()
>>
>> I think we might have other places in the kernel that could use
>> lockdep_assert_not_held() in addition to i915_gem_object_lookup_rcu()
> 

I looked at i915_gem_object_lookup_rcu(). The following can be replaced
by lockdep_assert_held().

#ifdef CONFIG_LOCKDEP
         WARN_ON(debug_locks && !lock_is_held(&rcu_lock_map));
#endif

> Great, thank you. The only problem is that lockdep.h changes have to go
> via some other tree, I just don't know which :) I think it would be
> easiest if also the ath10k patch goes via that other tree, I can ack the
> ath10k changes.
> 
> Another option is that I'll apply the ath10k patch after the lockdep.h
> change has trickled down to my tree, but that usually happens only after
> the merge window and means weeks of waiting. Either is fine for me.
> 

I will send the include/linux/lockdep.h and ath10k patch together and
we will take it from there.

thanks,
-- Shuah
