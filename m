Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264BD31CCDF
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Feb 2021 16:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBPPWw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Feb 2021 10:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhBPPWt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Feb 2021 10:22:49 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CB9C061574
        for <linux-wireless@vger.kernel.org>; Tue, 16 Feb 2021 07:22:09 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id a16so8571221ilq.5
        for <linux-wireless@vger.kernel.org>; Tue, 16 Feb 2021 07:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SCrgrLSKV5HQB6OBnUPMDNWqngKo2XMqSrnq8eY6WsA=;
        b=ajjegBvT4OQM+IdOuLpL2uld2MxN/oDN6kZGeQJ6jVE0ibi30A0gcI4qbR9hT+SZCM
         5xoSEvrsss7NQehq3M+FqsXtU8DQ0gdGxQkulre0qG0YTQMb0HgQXAykzpEb+D7K5m5S
         UpDkHHhPyzJyEjDFP0lQRO3TDLGDiqmaU9Rpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SCrgrLSKV5HQB6OBnUPMDNWqngKo2XMqSrnq8eY6WsA=;
        b=fYK3Q/su186X4rYPPiXZ48bI0R+0IKW5MYJP1Ub76HO3rXqQJzyXJp48zoMZUotexV
         HFFn8/O/0a9lIctdPNrUZfuQsWcfS2osYIaEy5TCIF6dUHkcfRLMJQf5zxfguH0Z8Ocx
         6MhuDpyAWLrGwF9Mos7c2glfNWD2DXMBQhaQIbOop12ERSFinSqtMY+NDcIAGjGOGV2f
         6MkbPLhUqg0d+xJz9BLjxP6jGrTXhUewDKGvJNIhH3JbEqVKYUOqEMrXr8th5UxmJ5kS
         MQdQmQSVUGf9ddZCrGyFMgpJjapV003UVYz8oP96nQyRsyBfeSEkOdE6HH4WPTY9vufW
         zuNA==
X-Gm-Message-State: AOAM531lrmBhNIjitX43zvBiovTPhWI0xV4ydAWX7z4LO2ZgNO0mu0w4
        cRMa26JVsmqFyPRFT2+M0oMTbA==
X-Google-Smtp-Source: ABdhPJx3G2o9JD9i7oWOVErd5QMCAoO1+MR1d8GDb1F3pSgZpS4a6A8llKG9+kyOBG7Q5e+j9HmybA==
X-Received: by 2002:a92:d691:: with SMTP id p17mr16842092iln.135.1613488929142;
        Tue, 16 Feb 2021 07:22:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i4sm10577363ioa.30.2021.02.16.07.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 07:22:08 -0800 (PST)
Subject: Re: [PATCH 2/2] ath9k: fix ath_tx_process_buffer() potential null ptr
 dereference
To:     Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <43ed9abb9e8d7112f3cc168c2f8c489e253635ba.1613090339.git.skhan@linuxfoundation.org>
 <20210216070336.D138BC43463@smtp.codeaurora.org>
 <0fd9a538-e269-e10e-a7f9-02d4c5848420@nbd.name>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <caac2b21-d5de-32ac-0fe0-75af8fb80bbb@linuxfoundation.org>
Date:   Tue, 16 Feb 2021 08:22:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <0fd9a538-e269-e10e-a7f9-02d4c5848420@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/16/21 12:53 AM, Felix Fietkau wrote:
> 
> On 2021-02-16 08:03, Kalle Valo wrote:
>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>> ath_tx_process_buffer() references ieee80211_find_sta_by_ifaddr()
>>> return pointer (sta) outside null check. Fix it by moving the code
>>> block under the null check.
>>>
>>> This problem was found while reviewing code to debug RCU warn from
>>> ath10k_wmi_tlv_parse_peer_stats_info() and a subsequent manual audit
>>> of other callers of ieee80211_find_sta_by_ifaddr() that don't hold
>>> RCU read lock.
>>>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>
>> Patch applied to ath-next branch of ath.git, thanks.
>>
>> a56c14bb21b2 ath9k: fix ath_tx_process_buffer() potential null ptr dereference
> I just took another look at this patch, and it is completely bogus.
> Not only does the stated reason not make any sense (sta is simply passed
> to other functions, not dereferenced without checks), but this also
> introduces a horrible memory leak by skipping buffer completion if sta
> is NULL.
> Please drop it, the code is fine as-is.
> 

A comment describing what you said here might be a good addition to this
comment block though.

thanks,
-- Shuah

