Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2629298E88
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbfHVI7h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 04:59:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35890 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfHVI7h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 04:59:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so4925126wme.1;
        Thu, 22 Aug 2019 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=78pqoKdZXETPoori3ZQpBSltw/MaYZw9G9/iPYn/5yQ=;
        b=tPW6HApcTAbryhZrul4iHHpQIDvMYRmfipQqusn4ebDcMj9/21GYO/D03NLABNOjGV
         Q3uJFw/Zh2aAhwcEawzVdAQgLlYVDLpKQsyLixKzkxswz3iGm2/w4v6+GZGun77YTzzI
         8ONvPSJKhyWd5yVtBFRxLz0EdUCRC1dc1PxsNL28Az2RvDKyIqtkZJrAREr+xkAHYJuv
         UJ1cktZtlC3QvM81I9MGfOTXDojQcsDKpJN2Td62Xkb3No9wWW8JFnVsGbv+kIK0q8Mm
         hKQDbUk5OiuYh6EYeT9/DSre7ddsMmcbK2VNQus/86S5HpcEURvSdxFjNJyDYqDHUHNq
         awIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=78pqoKdZXETPoori3ZQpBSltw/MaYZw9G9/iPYn/5yQ=;
        b=FtsJC4w0aEOH7ZaI5ofg5QHR+bEwssO4isH/qvQkJXh9rv9Mh4gPJg9KGniSMsex5T
         k9u2P+/OCZAP+37WFZtkOxA+bsCQHjjEQZC/8kR59h1EYlNTpMp8KTs7gPceMHTKJxDD
         yItKF9NSHbAyPse5v2KYdciMAOhvMbPvXjAWAgEQpxwYym3bzaPMR1N8bfcVeB9te+92
         R2lG9nZuZ0uZrJjigSt7UGZbpm03KptdwqV6OuhuKuc+IEm7/j2f6THYRANn9I7C1pJt
         EYFoxcsRTY4SVPPBzb4Uzz0pPjpratHnXlg9n9mpRApAzNDAc4fjTvrA7IxiGKxD5qGR
         dsMg==
X-Gm-Message-State: APjAAAXGrI8SpXLyOr34AQFL2L1K55jNsdlF9fXK49+F3aJRaCaU/kZ6
        mZZftB1cXHf+HaVry3OIGzS7CnIi
X-Google-Smtp-Source: APXvYqy4vbmtbFxWtcXZ//1P+EpEu1o8c/AonZwD5bNCE6zHAwGgwQmEw3lyBdYqJ94BkdCf1m6RyQ==
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr5238102wmk.9.1566464374780;
        Thu, 22 Aug 2019 01:59:34 -0700 (PDT)
Received: from [192.168.1.20] (host109-153-59-46.range109-153.btcentralplus.com. [109.153.59.46])
        by smtp.googlemail.com with ESMTPSA id 91sm76101053wrp.3.2019.08.22.01.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 01:59:34 -0700 (PDT)
From:   Chris Clayton <chris2553@googlemail.com>
Subject: Re: PROBLEM: 5.3.0-rc* causes iwlwifi failure
To:     Stuart Little <achirvasub@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <fd102579-d83d-b86d-e165-8168c74a4bac@googlemail.com>
 <20190818105530.GA1247@chirva-void>
Message-ID: <5e3ed328-7eea-f112-45d7-4ddee04c4b77@googlemail.com>
Date:   Thu, 22 Aug 2019 09:59:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818105530.GA1247@chirva-void>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks, Stuart.

On 18/08/2019 11:55, Stuart Little wrote:
> On Sun, Aug 18, 2019 at 09:17:59AM +0100, Chris Clayton wrote:
>>
>>
>> On 17/08/2019 22:44, Stuart Little wrote:
>>> After some private coaching from Serge Belyshev on git-revert I can confirm that reverting that commit atop the current tree resolves the issue (the wifi card scans for and finds networks just fine, no dmesg errors reported, etc.).
>>>
>>
>> I've reported the "Microcode SW error detected" issue too, but, wrongly, only to LKML. I'll point that thread to this
>> one. I've also been experiencing my network stopping working after suspend resume, but haven't got round to reporting
>> that yet.
>>
>> What was the git magic that you acquired to revert the patch, please?
>>

By following the advice below, I reverted 4fd445a2c855bbcab81fbe06d110e78dbd974a5b and using the resultant kernel I
haven't seen the "Microcode SW error detected" again. I am, however, still experiencing the problem of my network not
working after resume from suspend. I've reported it to LKML, so it can be followed there should anyone need/want to.

> 
> $ git revert <offending commit>
> 
> This will fail as noted, but will place in a revert mode where you can fix the errors.
> 
> $ git status
> 
> will show (it did in my case, for the latest Linux tree at the time I did this) a modified file
> 
> drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> 
> to be committed without issue and a conflicted file
> 
> drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
> 
> whose conflicts you have to first resolve.
> 
> I then opened that conflicted file in a text editor and simply removed everything between the lines
> 
> <<<<<<< HEAD
> 
> and 
> 
>>>>>>>> parent of 4fd445a2c855... iwlwifi: mvm: Add log information about SAR status
> 
> (inclusive). This resolved the conflict, whereupon
> 
> $ git revert --continue
> 
> and
> 
> $ git commit -a
> 
> will finish the reversion. 
> 
>>> On Sat, Aug 17, 2019 at 11:59:59AM +0300, Serge Belyshev wrote:
>>>>
>>>>> I am on an Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz running Linux
>>>>> x86_64 (Slackware), with a custom-compiled 5.3.0-rc4 (.config
>>>>> attached).
>>>>>
>>>>> I am using the Intel wifi adapter on this machine:
>>>>>
>>>>> 02:00.0 Network controller: Intel Corporation Device 24fb (rev 10)
>>>>>
>>>>> with the iwlwifi driver. I am attaching the output to 'lspci -vv -s
>>>>> 02:00.0' as the file device-info.
>>>>>
>>>>> All 5.3.0-rc* versions I have tried (including rc4) cause multiple
>>>>> dmesg iwlwifi-related errors (dmesg attached). Examples:
>>>>>
>>>>> iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
>>>>> iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000
>>>>> iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND
>>>>>
>>>>
>>>> I have my logs filled with similar garbage throughout 5.3-rc*. Also
>>>> since 5.3-rcsomething not only it WARNS in dmesg about firmware failure,
>>>> but completely stops working after suspend/resume cycle.
>>>>
>>>> It looks like that:
>>>>
>>>> commit 4fd445a2c855bbcab81fbe06d110e78dbd974a5b
>>>> Author: Haim Dreyfuss <haim.dreyfuss@intel.com>
>>>> Date:   Thu May 2 11:45:02 2019 +0300
>>>>
>>>>     iwlwifi: mvm: Add log information about SAR status
>>>>     
>>>>     Inform users when SAR status is changing.
>>>>     
>>>>     Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
>>>>     Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>>>
>>>>
>>>> is the culprit. (manually) reverting it on top of 5.3-rc4 makes
>>>> everything work again.
>>>
