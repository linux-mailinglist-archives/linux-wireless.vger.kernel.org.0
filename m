Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1519A20F86
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 22:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfEPUPq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 16:15:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39900 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfEPUPq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 16:15:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so2159053plm.6
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2019 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9TAmp4NOIoqiTleh4x/fnZ8ZUvceG680b/No5RmOTqc=;
        b=bgA3/2AEPX9OaVk/Q/3X5BomldSRLhdSiRNe8S7RUxNIeHOMy/Fyz3lTsHjfVaEm1A
         OiZl2J5du2dKenLCew0wf99XVdgZb2RE61Pv1UZg38ZnC4ORqja2/iD8zjlPNv+jNj+C
         E05d5IJYjTy5K5JqbCmUqSfrlmOthYnVtu6Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9TAmp4NOIoqiTleh4x/fnZ8ZUvceG680b/No5RmOTqc=;
        b=D7TqqYbxuJCpk80gdjPgIvWZ2MgXR3DdMz20IIygT96E5YrUWag7HsWPGZ3psEuqLB
         JOLDqwugHe+FDXijWd25O3kknV5sR4iRC/JK3NAW+nbe4+qgHTbpOry0ggeFNYrupIEe
         lwQ0sIWqa6IS6vS68hNaZuleiHIpaHnjQsDUHlRpShXkDb8IkuqkCM8082O/hABPIyB2
         Usqw9h6X9YAmUMW6k4+dfVglkOA0EREi4kKzFe6Oh7rWT7HN8lqupJJ3DbTqPpO1twT3
         TBwijGYf5oavYkxSwN0trBX9WN3nGZzoDhUjm81yU0Kn9oa4F8baI1EhaMnbc4ZWr5OP
         TEeA==
X-Gm-Message-State: APjAAAWd7oBNB2jU7AdSO7AYgLDBZWp+evLVBWrHM3GMsRhXg2EI5AU3
        YN6MLDR3OLEFXJumsJLs/1jcbA==
X-Google-Smtp-Source: APXvYqzbTj2boP+TGTrjnA4CSURAQgp+aHNar388NxdoIynW7cV+1uVH5/Gu109WZVax6ucMJdo7Qg==
X-Received: by 2002:a17:902:e108:: with SMTP id cc8mr41204076plb.145.1558037745346;
        Thu, 16 May 2019 13:15:45 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id q27sm10207403pfg.49.2019.05.16.13.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 13:15:44 -0700 (PDT)
Subject: Re: [PATCH 3/7] brcmsmac: switch source files to using SPDX license
 identifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558008251-13692-4-git-send-email-arend.vanspriel@broadcom.com>
 <20190516173113.GA540@kroah.com>
 <a5d32b2f-a99b-a248-1acd-9de532732e30@broadcom.com>
 <20190516200131.GA15814@kroah.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <eeebea29-4237-6e49-7578-8d3b1ad7df85@broadcom.com>
Date:   Thu, 16 May 2019 22:15:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516200131.GA15814@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/16/2019 10:01 PM, Greg Kroah-Hartman wrote:
> On Thu, May 16, 2019 at 09:45:19PM +0200, Arend Van Spriel wrote:
>> On 5/16/2019 7:31 PM, Greg Kroah-Hartman wrote:
>>> On Thu, May 16, 2019 at 02:04:07PM +0200, Arend van Spriel wrote:
>>>> With ISC license text in place under the LICENSES folder switch
>>>> to using the SPDX license identifier to refer to the ISC license.
>>>>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
>>>> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
>>>> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>> ---
>>>> Hi Thomas, Greg,
>>>>
>>>> The file drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
>>>> did not have license information nor copyright notice and as such
>>>> it got included in commit b24413180f56 ("License cleanup: add SPDX
>>>> GPL-2.0 license identifier to files with no license"). I added you
>>>> guys as I propose to align this source file with the rest of
>>>> the driver sources and change it to ISC license and add the missing
>>>> copyright notice while at it (not sure if that warrants a separate
>>>> patch).
>>>
>>> A separate patch would be good, to make it explicit that you are
>>> changing the license of the file.
>>
>> Ok.
>>
>>> And ISC, ick, why...  :)
>>
>> Because the license text in the other driver source files is a 1:1 match
>> with the ISC license.
> 
> Oh, I am not disagreeing with that, yes, that is obviously the license
> of the files. Just complaining about that choice for Linux kernel code :)

I see.

>> Another option could be MIT license which is in the preferred folder.
>> Will have to consult our legal department about it though.
> 
> Hey, if your legal department is going to get asked this, why not just
> switch it to GPLv2?  That would make everything much simpler.

Hah. Because I already know the answer to that. ;-)

Regards,
Arend
