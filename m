Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1058C264957
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 18:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgIJQJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731349AbgIJQHC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:07:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6FC061757
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 09:07:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so7311531wrm.9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q5joK7IyZm+1PxXmSacKbjhTdCv+NTSFwipuQ+Kj3lM=;
        b=GgE5PI/g7w7LTIM8+Nr4TTiaIILBaok/v4G/rPgyKWyytydA7JAGlIMxU+aptQkYmq
         68gbIKxbShEyb7RNATDAfsJhGyq6SY7Nt16DUkHEP1AppweJJzUbxSPl6IMUvX9fECyz
         71NsrYb34XBVjdQIlNrJ5kICBMm3An1KdogUIX0oxZo71Lq9eX6zWxDMUwyCx4KG4GPd
         pArDmRGwPxHQwVl0tYadu39R/gE/DA4+y5ntCupPEWUB2+kX3g5RG0WX8GSvX3/stKfE
         NaFFq2NptHXWTzLzLbQNk9Cjob57Cmk1KfuYqsMHQnE+4VIWq7xd3FPEEmo4xJz3xpHB
         2aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q5joK7IyZm+1PxXmSacKbjhTdCv+NTSFwipuQ+Kj3lM=;
        b=sK5A0Q7G899MyYJVmUB70lrV8emSeW6xaCtvp6AGeOpKy0a3eEpVgvPHiYmvj58k97
         iQAFQ9y8vAtPOmpiF08+6eUN7fKTfUY7Zvbuo5iRsQu4S2PV+ksZ2buTMALsp9idNqXe
         L2K72McOyAhUCYwUQ/gqMD/rkeCbHvzg2rIqRrAnEcOrGXw8wv7IVvYjHyWUxm3XtHe1
         XB6biNRtDyy2gKyav5buNrkLtBkLK9JoYUu5jjNzcc5rO0JXimJQkyXu2G89TKVtqSYD
         kElptGA3+Z7/jZHn24KatlcqKa7S0kWgXNaNf1xB1cnsYCO0eTttLne+pJIV7b5tirr0
         5n3g==
X-Gm-Message-State: AOAM532jq/96EUi02BcGxnOorYi7ieqdbfiFqqNTQ6iv+kABMXRo/m0G
        7DRUGshxsEflWDyqsMOGHc3BSg==
X-Google-Smtp-Source: ABdhPJxTLEO55/PJ8U73qCB2bhXnGwqRFhDkaYrZwSfiafwhwUGvvuhGZ/2NHYW351phL07dWRfg+g==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr9665052wrx.173.1599754018962;
        Thu, 10 Sep 2020 09:06:58 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y2sm4130870wmg.23.2020.09.10.09.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 09:06:58 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] wcn36xx: Miscellaneous updates
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     shawn.guo@linaro.org, loic.poulain@linaro.org
References: <20200910150845.2179320-1-bryan.odonoghue@linaro.org>
 <84a86a12-62d2-cc94-95b3-34b360ad4255@nexus-software.ie>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <266ec526-a69d-431c-dbeb-0b112eb7d6f2@linaro.org>
Date:   Thu, 10 Sep 2020 17:07:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <84a86a12-62d2-cc94-95b3-34b360ad4255@nexus-software.ie>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/09/2020 16:55, Bryan O'Donoghue wrote:
> On 10/09/2020 16:08, Bryan O'Donoghue wrote:
>> This series is seven in a set of seven to add support for wcn3680 at 
>> 802.11ac
>> data-rates.
>>
>> This set marks functions previously declared non-static as static. In 
>> order
>> to facilitate granular standalone commits and avoid single patch
>> code-bombs. A series of functions were previously declared non-static.
>> Antecedent changes have made use of those functions so we can now mark 
>> them
>> static.
>>
>> In a similar theme of cleanup, I've added on a fix for some whitespace
>> damage in main.c and smd.c which while not strictly related to wcn3680 
>> I've
>> opted to throw into the bucket under a "miscellaneous update" title.
>>
>> Hope that's OK.
>>
>> V5:
>> - No change to V4 but need to send the set again so that
>>    prerequisite-patch-id makes sense to the build robot here.
>>
>> V4:
>> - No functional change.
>>    Sending out full set again using --base=ath-202009090652 to aid kernel
>>    test robot
>> - 
>> https://lore.kernel.org/linux-wireless/20200908183424.2871101-1-bryan.odonoghue@linaro.org/T/#t 
>>
>>
>> V3/RESEND:
>> - Messed up my .git/config resending from my @linaro.org address
>>
>> Bryan O'Donoghue (2):
>>    wcn36xx: Mark internal smd functions static
>>    wcn36xx: Ensure spaces between functions
>>
>>   drivers/net/wireless/ath/wcn36xx/main.c |  1 +
>>   drivers/net/wireless/ath/wcn36xx/smd.c  | 65 +++++++++----------------
>>   2 files changed, 23 insertions(+), 43 deletions(-)
>>
>>
>> base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
>> prerequisite-patch-id: 9a4ac7faca179f6594c9b3a115ee69a2da540a69
>> prerequisite-patch-id: 183286f9c22d1aaa12f356651224e6b337ef1938
>> prerequisite-patch-id: af468d413daaf8d2aad195fcb43c6e66390d8468
>> prerequisite-patch-id: 08122a9557904ce5358f52dd08cc33270fa202c1
>> prerequisite-patch-id: 82e0b7c5b2e9fa80baca001cce12577d98e306a9
>> prerequisite-patch-id: 8ee7f5bd6cb5b7b7d713947b554ad93bb90d8230
>> prerequisite-patch-id: d05c2253e4523b05b2e43491aa13ceeef68fd2f0
>> prerequisite-patch-id: 8be29513d3efa64df15297bcf81ec3db55088ee1
>> prerequisite-patch-id: d267dcd834afad75a69bcd2adcccfdad6566a7ba
>> prerequisite-patch-id: 47145acae6e24e8e6580fca1dbddfbec24f7b50b
>> prerequisite-patch-id: 8c66bccb923be821cf109a3a0d3a1a028edb4930
>> prerequisite-patch-id: d0f5f3769b2963208fd2348840726fa1d3501b63
>> prerequisite-patch-id: 746f63cf58fa3bf62736435c81dba2558aba8e81
>> prerequisite-patch-id: 375bb7847ae74c63d2eacdbd0d73371aef1546fe
>> prerequisite-patch-id: 8a598e22a08b0ec233d0ec56eeb53673eb1b8feb
>> prerequisite-patch-id: b0eba574ddc35ecec2d0e39c0d3351d1b260420e
>> prerequisite-patch-id: 143a1019813b7e4974a67e9eea1f1d599c0fdfdf
>> prerequisite-patch-id: f66d9fe9eb731272b825c9430c15dca89d6c6129
>> prerequisite-patch-id: c8c2d2dd1452c357f73fc4c92e5b564d59a05562
>> prerequisite-patch-id: 273c13464a69354d32790ed7509472d9c2b11231
>> prerequisite-patch-id: adbde1c98b85a16a6500b4210d4f055b9493418c
>> prerequisite-patch-id: 559b6f9af6b26f860896dea4c7eb385ba9bdf0d5
>> prerequisite-patch-id: 94c091c0c78b754d4c842a097a6db126bf6e770f
>> prerequisite-patch-id: f2e549349c09f4675775b40bf9bb9b1f2bec6db8
>> prerequisite-patch-id: c3a6aa788141f5b8782d28dac264470c8081bb97
>> prerequisite-patch-id: 452450f26295dc4fc48dec07ba85538d78bae4b4
>> prerequisite-patch-id: 8e7850077db9ec00df9be4fe3e0e4a4e8b06fbba
>> prerequisite-patch-id: 233db8337812d9d34f99b41ccebd8758a6ada6d9
>> prerequisite-patch-id: 0bbaaf402d2dd50a50aaa6505e5d10e743cf03e5
>>
> 
> Is there any reason these emails are percolating through this list so 
> slowly ?
> 
> http://lists.infradead.org/pipermail/wcn36xx/2020-September/thread.html

BTW this happened yesterday too, mails were visible in wcn36xx but not 
on linux-wireless. I sent a mail about it and the emails appeared.

Is there some sort of moderation queue ?

Every email is visible in the wcn36xx mailing list. For an unknown 
reason not arriving at linux-wireless.

For example the second email in this set. I have it in my inbox, in my 
sent items and it has appeared in wcn36xx

?

http://lists.infradead.org/pipermail/wcn36xx/2020-September/002234.html
