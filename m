Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927302F1265
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 13:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbhAKMje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 07:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKMje (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 07:39:34 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA2C061786
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jan 2021 04:38:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c5so16228997wrp.6
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jan 2021 04:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B5OLs4AM2iv8VEsflX/Ok1wGdxFeBEFfWQpy/woWR3M=;
        b=WGYbg95Oh3EmhvZ2syTBRGugjwIKRXhkosGrxRbNBgqzSqUCCTWYwaNicAChGR+c3O
         NR43meEjX0WfbFQ9sMnky7tGCWdrhwvT1LaxMKhFrKI17024gzM+iHQEWOFrKgcrAywZ
         drfYzABdVBiZ+2s0M62jwAnmNM4WLbMpe4zL54McToUrAr9VL4m2ru0sto1At2dvXnQr
         ngIs0Y9sM/mPLaI3wcQ0J2wAHot5urZuYkjtPxZqLizWDS/raL7bFKlchxEY4P5ZxB5w
         W4qpUGGvvwC8JlQ1kNdfx1R0STbnTrDza6FVlAd59rx4I+GL3zH/utdLzYuCW+l8OOxZ
         YMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5OLs4AM2iv8VEsflX/Ok1wGdxFeBEFfWQpy/woWR3M=;
        b=swnF7ybtoav0JlZJ2MEQaiITU0JaStv2AYxnX3AdpFgm3gk/NJ4LSu3c1XQYj+uPdU
         7kQQcKOai7ixoqEZ6dBxvQ3aeeJ5ndCMmuW/6bwZio+VQe678nvrJOP9MlLQRY3Ev1ec
         t2r14XYzfAvlfBr1iRToXuG/EaMIkb8X2gT2wI5RJb0PXX+Vtr7NfqtftCZKyGGNorrI
         wMO2tYDmg4Sv8mG1wkUWcR+QJc1T2/bL2jOqgc0URtcb1TdC1rnG+HjcGs8IGbJ4E0b0
         U1WY6dtErBFLvqtFaBK8Q2eWVDsFbC5DTKX8qJvJzzGK0+UryTXWwrKeuwSVZsIxcQvI
         x3DQ==
X-Gm-Message-State: AOAM5307HkizEJkTGsKWOOpzJyG04d3VL1TsYn8Vj741pd/FlAQEtv16
        HmNjtOoz9U8/taTgjHHsVWtgeg==
X-Google-Smtp-Source: ABdhPJw8IYAtyVwn3MFAfzKEZGTJQEpOWOITm4a/iqcP+W5NrKHijXJbhBGZeWwRra0n3h0z7oLTFw==
X-Received: by 2002:a5d:4ccf:: with SMTP id c15mr16218120wrt.237.1610368731009;
        Mon, 11 Jan 2021 04:38:51 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y7sm22257124wmb.37.2021.01.11.04.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 04:38:50 -0800 (PST)
Subject: Re: [PATCH 11/13] wcn36xx: Do not suspend if scan in progress
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
 <20201228162839.369156-12-bryan.odonoghue@linaro.org>
 <87wnwjk8w7.fsf@codeaurora.org>
 <d74c7eaa-3f3e-9eef-8c2a-59f5720c4232@linaro.org>
 <87ft37u0bk.fsf@codeaurora.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <5ca41388-a783-e086-53a8-abfb8405c298@linaro.org>
Date:   Mon, 11 Jan 2021 12:40:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <87ft37u0bk.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/01/2021 12:26, Kalle Valo wrote:
> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
> 
>> On 11/01/2021 11:31, Kalle Valo wrote:
>>> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
>>>
>>>> If a scan is in progress do not attempt to enter into suspend. Allow the
>>>> scan process to quiesce before proceeding.
>>>>
>>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>
>>> Why? I would have considered the opposite and if we go to suspend we
>>> cancel the scan. No strong feelings, just don't see the need for scan
>>> results during suspend. But of course I might be missing something...
>>
>> We need to be switched to the AP's channel when calling the suspend
>> routine. During a s/w scan we switch off channel to scan for 100s of
>> milliseconds.
>>
>> If the suspend() routine is called while that is true, we suspend on
>> the wrong channel.
>>
>> So we would need to switch to the right channel explicitly in suspend
>> but, at the moment wcn36xx_config() for switching channels and I
>> thought it best to leave the channel switching logic in the one place.
>>
>> I'm not opposed in principle to
>>
>> - Entering suspend
>> - Switching to the last known active channel
>> - Suspending
> 
> Should this be fixed in mac80211? Otherwise every driver using software
> scan needs to have a workaround for this, right?
> 

I'll check.

I thought this problem was likely specific to wcn36xx but, conceptually 
I can't argue with you there.

Given I only see this behavior on Android and not on Debian - I test 
both - where Android tends to scan constantly - it is possible I'm the 
only one really triggering the bug given most drivers don't do s/w scan 
and probably wcn36xx is the only s/w scan being used on an Android 
system close to what we have upstream.

So yeah fair point, I'll see if the fix fits better at a higher level.

---
bod
