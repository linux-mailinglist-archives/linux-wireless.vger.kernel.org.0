Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2CC166FC
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 17:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEGPi4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 11:38:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40770 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfEGPiz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 11:38:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id e56so19145065ede.7
        for <linux-wireless@vger.kernel.org>; Tue, 07 May 2019 08:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lhOeBJyYPj/2xFqOsRFr3svYvc4ZmMF8TMLQhzpX+Nk=;
        b=qrBg/CyZNzogJVti+AME9cpjw07t4syLPF/59xwO2SDyGLJwlRv0Flh9E+0DKCJwtg
         dGzGJ7bXC3zFdxC/tVw3eLJVgvvAUz5LH4r2N21zxuWEdEgIYMUY3uqb4c+dJVSvyHeM
         bfi/M0fV4UDqobDLpK2m6ED53N4h7GW1SC0V9BRPpIFBr12ll0f4XwSfNpsGj5p9DsWA
         swN0A+39diomTtES6AL7NH811MbKXaweNti2Nz3nFCDFJeamV83N50Ci2+sx02rMUCb/
         PYcxuQS2v0SqI3Uq6JHBOy/AzJ930LaQOxNkMGHiVeSGSx28d29faGUZtjdO3qc2qfzI
         a7cQ==
X-Gm-Message-State: APjAAAXnXEUAojCBP3sQseSIBoa2vUfz1HHeaNA7+0Ccjw8imQ237jQU
        MlrOcBUC396Y3zc9Fn7x4X7uAQ==
X-Google-Smtp-Source: APXvYqzqRVjvsHYPB7HNahla42M8BPHt/LdhjXouCI2RW5NMjuN35WYNIXfQpz7wBSkBhLyfV5FXaw==
X-Received: by 2002:a50:97d2:: with SMTP id f18mr33311946edb.130.1557243533683;
        Tue, 07 May 2019 08:38:53 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a61sm4240118edf.8.2019.05.07.08.38.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 08:38:52 -0700 (PDT)
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Victor Bravo <1905@spmblk.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
 <20190504194440.4zcxjrtj2aft3ka4@localhost>
 <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20190505150355.3fbng4ny34x255vk@localhost>
 <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com>
 <20190506090609.msudhncj7e5vdtzw@localhost>
 <70677dff-4336-28d5-7ab9-7ba7c3d74ebc@redhat.com>
 <20190506102032.3ximjecado4mz62j@localhost>
 <fb07ae01-4cca-98e7-1c2d-dfdf44909900@redhat.com>
 <87d0kvvkej.fsf@codeaurora.org> <20190506152441.ifjcdi73elxuq5it@localhost>
 <3f3cca6e-50b7-c61d-4a62-26ce508af9e7@redhat.com>
 <95cd81ea-3970-92de-7983-5c1919e2bbd9@broadcom.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <02a6dc11-7def-7d72-4640-d9d42ccec47c@redhat.com>
Date:   Tue, 7 May 2019 17:38:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <95cd81ea-3970-92de-7983-5c1919e2bbd9@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 06-05-19 21:30, Arend Van Spriel wrote:
> + Luis (for real this time)
> 
> On 5/6/2019 6:05 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 06-05-19 17:24, Victor Bravo wrote:
>>> On Mon, May 06, 2019 at 03:26:28PM +0300, Kalle Valo wrote:
>>>> Hans de Goede <hdegoede@redhat.com> writes:
>>>>
>>>>> If we're going to do some filtering, then I suggest we play it safe and also
>>>>> disallow other chars which may be used as a separator somewhere, specifically
>>>>> ':' and ','.
>>>>>
>>>>> Currently upstream linux-firmware has these files which rely on the DMI
>>>>> matching:
>>>>>
>>>>> brcmfmac4330-sdio.Prowise-PT301.txt
>>>>> brcmfmac43430-sdio.Hampoo-D2D3_Vi8A1.txt
>>>>> brcmfmac43430a0-sdio.ONDA-V80 PLUS.txt
>>>>>
>>>>> The others are either part of the DMI override table for devices with unsuitable
>>>>> DMI strings like "Default String"; or are device-tree based.
>>>>>
>>>>> So as long as we don't break those 3 (or break the ONDA one but get a symlink
>>>>> in place) we can sanitize a bit more then just non-printable and '/'.
>>>>>
>>>>> Kalle, Arend, what is your opinion on this?
>>>>>
>>>>> Note I do not expect the ONDA V80 Plus to have a lot of Linux users,
>>>>> but it definitely has some.
>>>>
>>>> To me having spaces in filenames is a bad idea, but on the other hand we
>>>> do have the "don't break existing setups" rule, so it's not so simple. I
>>>> vote for not allowing spaces, I think that's the best for the long run,
>>>> but don't know what Arend thinks.
> 
> Hi,
> 
> Had a day off today so I did see some of the discussion, but was not able to chime in until now.
> 
> To be honest I always disliked spaces in filenames, but that does not necessarily make it a bad idea. What I would like to know is why built-in firmware can not deal with spaces in the firmware file names. I think Hans mentioned it in the thread and it crossed my mind as well last night. From driver perspective, being brcmfmac or any other for that matter, there is only one API to request firmware and in my opinion it should behave the same no matter where the firmware is coming from. I would prefer to fix that for built-in firmware, but we need to understand where this limitation is coming 
> from. Hopefully Luis can elaborate on that.

Ok.


>>> I have found a fresh judicate on this:
>>> https://lkml.org/lkml/2018/12/22/221
>>>
>>> It seems clear that we have to support at least spaces for some time
>>> (maybe wih separate config option which will be deprecated but on by
>>> defaut until old files are considered gone).
>>
>> Ah that issue, well that is not really comparable in that case a lot of
>> peoples setups were completely broken by that commit and it was a
>> quite surprising behavior change in a userspace facing API.
>>
>> The nvram loading path already does 2 tries, I really don't want to
>> unnecessary complicate it with a third try.
>>
>> The Onda V80 Plus is a X86 based Windows / Android dual boot tablet,
>> as said before I do not expect a ton of users to be running regular
>> Linux on it.
>>
>> Given Kalle's clear preference for getting rid of the spaces lets
>> just do that. But first we must get a symlink added to linux-firmware
>> using the name with the _, newer kernels requiring a newer linux-firmware
>> to match is not unheard of AFAIK, so combined with the limited amount
>> of users I think this is a reasonable compromise.
> 
> Right. In the brcm folder we have bcm4329-fullmac-4.bin for older kernels and brcmfmac4329-sdio.bin for later kernels when we switched to stricter firmware naming convention.
> 
>> Kalle, do you agree with getting the symlink added to linux-firmware
>> ASAP as a fix for the V80 Plus issue; or do you want to see a fallback
>> to the un-cleaned name as you suggested before ?
> 
> How many releases have an issue and how many V80 Plus users running regular linux are actually using built-in firmware. And is it really a regression for them? Not saying it does not require fixing. However, as stated above I would prefer to fix the built-in firmware limitation if possible and backport that fix if it is only a few kernel releases provided stable allows such a backport.

The issue is not V80 Plus users running regular linux with built-in firmware.
The issue is that the 5.0+ kernel + a new enough linux-firmware will just
work on the V80 Plus, since linux-firmware contains a nvram file for the V80 Plus,
with the space in the name.

So if we replace the space with an _ then things will stop working for those
users. But we can avoid this by adding a compat symlink to linux-firmware, then
users will require a new linux-firmware together with the new kernel, but that
is not unheard of.

As for how many users / releases. Users who have a fresh Fedora 30 install or
a fresh install of a rolling-release distro may rely on things working ootb.

Users with an older Linux install will have manually added the nvram using
the non board specific name to get things to work, so I expect things to
stay working for them.

So taking the group of people putting regular Linux on a V80 Plus
and then taking the cross-section of the group with users with a very recent
install, I expect the amount of affected users to be very small and both
Fedora and rolling-release updates update linux-firmware regularly.

So IMHO we should be fine with the sanitizing of the DMI strings, combined
with pushing a compat patch to linux-firmware.

Regards,

Hans




> 
> Regards,
> Arend
