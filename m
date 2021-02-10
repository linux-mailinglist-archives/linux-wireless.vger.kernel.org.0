Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8299E316A90
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhBJP5w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhBJP5r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:57:47 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA250C061574
        for <linux-wireless@vger.kernel.org>; Wed, 10 Feb 2021 07:57:06 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l3so2538706oii.2
        for <linux-wireless@vger.kernel.org>; Wed, 10 Feb 2021 07:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yBNnyv08MV67kjLVdIyECXp/12nd8XUPVrYdyrWhw80=;
        b=aFtU6sU+k/QSlSdVczSVRwOa0OQYlIlkXqMs8fmabdtJ2KTico+vi2Tvo6qwHZLnym
         awEH55Dkft9hl2Cvo8lXT6HbyykMuW5CWx3rLl8p6rZF+ivhmxX+1PIWk5gsP9IszVJ3
         vGYsSGf8V0ZGchdfQfdsp//KlKjC7PQrLvwQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yBNnyv08MV67kjLVdIyECXp/12nd8XUPVrYdyrWhw80=;
        b=UjPpN73+HT3NvI6rRStsQ5bSdd+yczmFIR2HPG2rDW9GzXGorIDgk4Rl2sPgpID9ao
         vCVVwaqFESJoCl4vtI3ncuggGYUNZxwuaK/1zt1ofm0xAmBjclbSo57bHZpmjTdT9Mkm
         8+ZcbuNPVdiaD5OCQ2XF83wTVKyQ+wVXX6hrfqJCJ7X5bMsNax0WTujDtAe/an9a1Xxt
         A/2eJJuOTjrH1bXWw17tEFrJ22C5Wq0kFnUW4iWPfgK8vR4na+Rsj2GogC+6DB69KdR0
         dT7dy/GilO1nfCcipHpdWZfUIJh4oYvjPB6DfMRLyQiPLmWIS7LG647j1zZy3wuAKPZy
         ImZQ==
X-Gm-Message-State: AOAM530FgGpq+zeNE/buzBWA/ygJ+Gd4N3GOR6NdCQa8ZdZWay3S74z+
        BJwpOdEGMKPq8CgSMZAgwk5DcA==
X-Google-Smtp-Source: ABdhPJzXHwwIMWKtGJtYSb8Q3H0yElai/XdDilRjxI2noBBZcfvp6wpRhAliH3x0TRTylvoapvE4PA==
X-Received: by 2002:a05:6808:10f:: with SMTP id b15mr2584739oie.92.1612972626194;
        Wed, 10 Feb 2021 07:57:06 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r13sm435237oot.41.2021.02.10.07.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:57:05 -0800 (PST)
Subject: Re: [PATCH 4/5] ath10k: detect conf_mutex held ath10k_drain_tx()
 calls
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1612915444.git.skhan@linuxfoundation.org>
 <a980abfb143f5240375f3f1046f0f26971c695e6.1612915444.git.skhan@linuxfoundation.org>
 <87lfbwtjls.fsf@codeaurora.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d6d8c7b8-f69d-01ef-6d66-8a33ea98920f@linuxfoundation.org>
Date:   Wed, 10 Feb 2021 08:57:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <87lfbwtjls.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/10/21 1:25 AM, Kalle Valo wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> ath10k_drain_tx() must not be called with conf_mutex held as workers can
>> use that also. Add check to detect conf_mutex held calls.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> The commit log does not answer to "Why?". How did you find this? What
> actual problem are you trying to solve?
> 

I came across the comment block above the ath10k_drain_tx() as I was
reviewing at conf_mutex holds while I was debugging the conf_mutex
lock assert in ath10k_debug_fw_stats_request().

My reasoning is that having this will help detect incorrect usages
of ath10k_drain_tx() while holding conf_mutex which could lead to
locking problems when async worker routines try to call this routine.

>> ---
>>   drivers/net/wireless/ath/ath10k/mac.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
>> index 53f92945006f..3545ce7dce0a 100644
>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>> @@ -4566,6 +4566,7 @@ static void ath10k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
>>   /* Must not be called with conf_mutex held as workers can use that also. */
>>   void ath10k_drain_tx(struct ath10k *ar)
>>   {
>> +	WARN_ON(lockdep_is_held(&ar->conf_mutex));
> 
> Empty line after WARN_ON().
> 

Will do.

> Shouldn't this check debug_locks similarly lockdep_assert_held() does?
> 
> #define lockdep_assert_held(l)	do {				\
> 		WARN_ON(debug_locks && !lockdep_is_held(l));	\
> 	} while (0)
> 
> And I suspect you need #ifdef CONFIG_LOCKDEP which should fix the kbuild
> bot error.
> 

Yes.

> But honestly I would prefer to have lockdep_assert_not_held() in
> include/linux/lockdep.h, much cleaner that way. Also
> i915_gem_object_lookup_rcu() could then use the same macro.
> 

Right. This is the right way to go. That was first instinct and
decided to have the discussion evolve in that direction. Now that
it has, I will combine this change with
include/linux/lockdep.h and add lockdep_assert_not_held()

I think we might have other places in the kernel that could use
lockdep_assert_not_held() in addition to i915_gem_object_lookup_rcu()

thanks,
-- Shuah
