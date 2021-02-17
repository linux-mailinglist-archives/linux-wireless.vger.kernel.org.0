Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BCF31DBC1
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Feb 2021 15:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhBQO5k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Feb 2021 09:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbhBQO5h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Feb 2021 09:57:37 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531EEC0613D6
        for <linux-wireless@vger.kernel.org>; Wed, 17 Feb 2021 06:56:57 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id z18so11489238ile.9
        for <linux-wireless@vger.kernel.org>; Wed, 17 Feb 2021 06:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ydHdMTd4ps0AXeryEcGbvz8MsZ78eQIQNAjnZKZ5I+Q=;
        b=QArniZnH1HDN6XbvShuegQf8ATVhoFhQM5Sx7rfRv8KxefFdxWqqxZXVJJRewt1t9B
         ui/nmcdNhusE232TDbipsbl7LSrJ2CDBYSH+/tbcHgCtWSljTZ8gAKTsF6RvKJJUI3SV
         Sz1RjjI5qqmQw+u5ReOCNewVDaMRHDst8qXHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ydHdMTd4ps0AXeryEcGbvz8MsZ78eQIQNAjnZKZ5I+Q=;
        b=PDwCc0FcypqUfiF7Nnwt3iOPOe4GyShTf8hh5t5a4JwR3QwUYeFSSro1Avhtftp1E1
         HAQwED6n6vtMRtHr4tDxYvy5KKbzE0P45z7IE/p0XJ/siU04zDW8jjGL80lQdC7uMH4g
         89vLjd4qyb5LFhpGHPLDQUGSArugac9Uwb+cnTuYXm3hwrEsEdNtDAN+q3djVFVeDb9Z
         Y/naqRxZaQQu5vXoMeNGzD6w5YBtsy7QKD6SQsRBKkHzD1V2yBgNibvW83KThWVHaci7
         aVnJESDPImbN9S1bqUeTq1Hw3YGppZUhPEx5x4v2V2JAPv+Smn5u59aIvJWo9gLJpe8k
         COnA==
X-Gm-Message-State: AOAM532EhJni9WSWsaC3d8aPR353WFsTwUWAriK1T/+lLWyl7yDCW/Dq
        sSFpWMpysBHiKfrnYri7zN4X0g==
X-Google-Smtp-Source: ABdhPJw5y5a0RH3ydxnaC8AND6fqVq95Foh3kAjnn/EOfAMY55LcXRd2zLwX7KDppkSNGv0xtdzQBA==
X-Received: by 2002:a92:8557:: with SMTP id f84mr21452757ilh.4.1613573816719;
        Wed, 17 Feb 2021 06:56:56 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n23sm1415589iog.3.2021.02.17.06.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 06:56:56 -0800 (PST)
Subject: Re: [PATCH 2/2] ath9k: fix ath_tx_process_buffer() potential null ptr
 dereference
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Felix Fietkau <nbd@nbd.name>, davem@davemloft.net, kuba@kernel.org,
        ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <43ed9abb9e8d7112f3cc168c2f8c489e253635ba.1613090339.git.skhan@linuxfoundation.org>
 <20210216070336.D138BC43463@smtp.codeaurora.org>
 <0fd9a538-e269-e10e-a7f9-02d4c5848420@nbd.name>
 <caac2b21-d5de-32ac-0fe0-75af8fb80bbb@linuxfoundation.org>
 <878s7nqhg0.fsf@codeaurora.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6bbeb37f-620e-d92d-d042-a507bbb39808@linuxfoundation.org>
Date:   Wed, 17 Feb 2021 07:56:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <878s7nqhg0.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/17/21 12:30 AM, Kalle Valo wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> On 2/16/21 12:53 AM, Felix Fietkau wrote:
>>>
>>> On 2021-02-16 08:03, Kalle Valo wrote:
>>>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>>> ath_tx_process_buffer() references ieee80211_find_sta_by_ifaddr()
>>>>> return pointer (sta) outside null check. Fix it by moving the code
>>>>> block under the null check.
>>>>>
>>>>> This problem was found while reviewing code to debug RCU warn from
>>>>> ath10k_wmi_tlv_parse_peer_stats_info() and a subsequent manual audit
>>>>> of other callers of ieee80211_find_sta_by_ifaddr() that don't hold
>>>>> RCU read lock.
>>>>>
>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>>>
>>>> Patch applied to ath-next branch of ath.git, thanks.
>>>>
>>>> a56c14bb21b2 ath9k: fix ath_tx_process_buffer() potential null ptr dereference
>>> I just took another look at this patch, and it is completely bogus.
>>> Not only does the stated reason not make any sense (sta is simply passed
>>> to other functions, not dereferenced without checks), but this also
>>> introduces a horrible memory leak by skipping buffer completion if sta
>>> is NULL.
>>> Please drop it, the code is fine as-is.
>>
>> A comment describing what you said here might be a good addition to this
>> comment block though.
> 
> Shuah, can you send a followup patch which reverts your change and adds
> the comment? I try to avoid rebasing my trees.
> 


I can do that.

thanks,
-- Shuah
