Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D721D3B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 20:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfEQSWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 14:22:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44340 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfEQSWV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 14:22:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so11794326edm.11
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2019 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RH7omgbErV7ikDnfSDtSL1nx+YSaC1W4YouoDOopNbw=;
        b=FhD2DTcCcDd8U9yrnqM2N0pDQ1Cmktxpf+9bTOshgIYxyGuKyWXBQAVk4mrk5tVJCu
         ygTGCaGDQo/cj3SbmSGazXRSn+NZyKhfToUlfsfGAuFnZmAJ0N+vcfD3F8mDxpB3ZMAf
         W/s1vKu50fejwZ9X3ul2YHIOcp1r966MGTN48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RH7omgbErV7ikDnfSDtSL1nx+YSaC1W4YouoDOopNbw=;
        b=ABMvLml2bjb8oJ3r27K7im9njml6jiHfbA4NgBIGDGF98M6WjiSE9NsyxbdzQ24OTo
         hkz7Rsx6tAlM0M338CZlfbv6QAGnwqplWFvv7EnMVZ2Qq6iJ6a10XGvm4J73yUHr4ld/
         GXCJzShm0HHMMMttLvPwUNigF0rT/FrwkLpBp2fLSBBIpgPLVI5nB6b9P0U7mNN2kXW+
         RxMbobKF74ID1FTW8TEBPuv5+mndzTB8VvdnaNuuqBFjVAJZl3kPHqAu5lOWwDaL5IU8
         NdIr+BEoU8rX9NfF3cDT388s+AfOGvHSti/1I6sQLle1QdVqjJbJ3b8bPwcYlPFvVdN5
         rn5w==
X-Gm-Message-State: APjAAAWm5HKUE1zQ4HVj2/erRavK7h59M/L7OzgQxkeLiQ/3oAto1D+s
        zK8vv54cl9W+xdO485/uScYJ+O5EMAfj7Q==
X-Google-Smtp-Source: APXvYqzoMAS170U/T7sRHFItvSsA8XIbYU1AhkeBqmhn/t6ii5XylV2PYJQAa7ek0uFNa6RiQZvFVw==
X-Received: by 2002:a17:906:2482:: with SMTP id e2mr46193743ejb.289.1558117339721;
        Fri, 17 May 2019 11:22:19 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id i45sm2971338eda.67.2019.05.17.11.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:22:19 -0700 (PDT)
Subject: Re: [PATCH 3/7] brcmsmac: switch source files to using SPDX license
 identifier
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558008251-13692-4-git-send-email-arend.vanspriel@broadcom.com>
 <20190516173113.GA540@kroah.com>
 <a5d32b2f-a99b-a248-1acd-9de532732e30@broadcom.com>
 <20190516200131.GA15814@kroah.com>
 <eeebea29-4237-6e49-7578-8d3b1ad7df85@broadcom.com>
 <CACna6rxuSFWN8eib7FpJiVQqLwdD5GOTaAFr7msJa01rBSTLKA@mail.gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <ee5abd5c-a496-7d70-7f84-9ff0210ebe1c@broadcom.com>
Date:   Fri, 17 May 2019 20:22:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACna6rxuSFWN8eib7FpJiVQqLwdD5GOTaAFr7msJa01rBSTLKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/17/2019 8:07 PM, Rafał Miłecki wrote:
> On Fri, 17 May 2019 at 01:25, Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>> On 5/16/2019 10:01 PM, Greg Kroah-Hartman wrote:
>>> On Thu, May 16, 2019 at 09:45:19PM +0200, Arend Van Spriel wrote:
>>>> On 5/16/2019 7:31 PM, Greg Kroah-Hartman wrote:
>>>>> On Thu, May 16, 2019 at 02:04:07PM +0200, Arend van Spriel wrote:
>>>>>> With ISC license text in place under the LICENSES folder switch
>>>>>> to using the SPDX license identifier to refer to the ISC license.
>>>>>>
>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
>>>>>> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
>>>>>> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
>>>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>>> ---
>>>>>> Hi Thomas, Greg,
>>>>>>
>>>>>> The file drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
>>>>>> did not have license information nor copyright notice and as such
>>>>>> it got included in commit b24413180f56 ("License cleanup: add SPDX
>>>>>> GPL-2.0 license identifier to files with no license"). I added you
>>>>>> guys as I propose to align this source file with the rest of
>>>>>> the driver sources and change it to ISC license and add the missing
>>>>>> copyright notice while at it (not sure if that warrants a separate
>>>>>> patch).
>>>>>
>>>>> A separate patch would be good, to make it explicit that you are
>>>>> changing the license of the file.
>>>>
>>>> Ok.
>>>>
>>>>> And ISC, ick, why...  :)
>>>>
>>>> Because the license text in the other driver source files is a 1:1 match
>>>> with the ISC license.
>>>
>>> Oh, I am not disagreeing with that, yes, that is obviously the license
>>> of the files. Just complaining about that choice for Linux kernel code :)
>>
>> I see.
>>
>>>> Another option could be MIT license which is in the preferred folder.
>>>> Will have to consult our legal department about it though.
>>>
>>> Hey, if your legal department is going to get asked this, why not just
>>> switch it to GPLv2?  That would make everything much simpler.
>>
>> Hah. Because I already know the answer to that. ;-)
> 
> It's not that obvious to me, sorry. Does your legal department require
> something more permissive than GPLv2? Is that worth asking them about
> dual-licensing? Something like
> GPL-2.0 OR MIT
> ? That assures driver is compatible with Linux, no matter what's the
> current lawyers interpretation of MIT vs. GPL 2.0. I believe Alan Cox
> once told/suggested that dual-licensing is safer for legal reasons.

Thanks, Rafał

Indeed we want a more permissive license. I decided to stick with ISC 
for now. MIT is not off the table, but pending responses from copyright 
holders. If you or anyone else for that matter has additional and/or 
more accurate information about dual-licensing (and its legal safety) 
please let me know.

Regards,
Arend
