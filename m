Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B81BC10DA41
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfK2T7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 14:59:35 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:40855 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfK2T7f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 14:59:35 -0500
Received: by mail-oi1-f171.google.com with SMTP id 6so1775714oix.7
        for <linux-wireless@vger.kernel.org>; Fri, 29 Nov 2019 11:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9vH783y5MYTDbU8lZNHgkxq13PJCK1x4eP+gZV1+/4A=;
        b=HsGxX0BMtb9afJOpO7I9CBN6Hpj4C8zB9Phy+i3PhxeD0j5AfCcpFtlB4QsadvMWDQ
         0WVL4A58edK1HT6YigiG3HkWIItJjwV16eo87CbhhThIT7iSOMXKd1fDi3ttN3+0GrcC
         5BCi/x7lqFBNW5aGO+EDo56hIWfw5/G0+50oN/KeTLk6C05tbDAr12RLFT/K/whdfRJy
         8ma1z/04WeYBe5HfL5RvsOI1PoGkra5hKj0bnW2k+L+kvYgqiHngwsYCbBVuerv8SXLP
         KFrLO4gXGudo0Xw35XADPgozakdLKURFH9d7AcJ6SjdVux/oM1cyE3VrDLmvvJPpGz4z
         kE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9vH783y5MYTDbU8lZNHgkxq13PJCK1x4eP+gZV1+/4A=;
        b=cR93lowvgjuu7Q2s/Gs7DCEq/j7vxLaNP3RHpvwMUOXEOjQPKhFfkwKDdCXsTfyu0/
         SOg40syrRBRS0NUgYC1pS2/1A9rJKZ0kpb34Kcjh7VIN/OzbUzD+xQotf+R7rla96QqG
         cKb+DKWe/DoXQlRGrViui3F23ag5zn6i6br/zZGw3+D919aHM1aselieome/0qTBuYLm
         F/MpmEhC06gpX4VD/s5A5hfwJnsWJSds2WErsOEX2lXNhm9R9s236vQQWLASeJvn47wL
         WPf2Z3GxGbruIf/yucF5tZv5uv0eIS/NisP33IiYTsjHvYjyUS+981Q1pVRY3iLUgv8/
         E8jQ==
X-Gm-Message-State: APjAAAUHjYHZkLN+Z35GLLttSweNPeeflXtr7UMdX1dcKBvrqTmUFUeT
        GTUJaMpihAwJ0SEu4/Z2Zo4=
X-Google-Smtp-Source: APXvYqzYVlyq3BGvMjqmFbrsZxBWHefQFTcfL5wVUM3zhrCr5OyU/c+tS75DyD/xeDkdfsGpB3m29A==
X-Received: by 2002:aca:52c4:: with SMTP id g187mr10856948oib.76.1575057573324;
        Fri, 29 Nov 2019 11:59:33 -0800 (PST)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 11sm1916582otz.3.2019.11.29.11.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 11:59:32 -0800 (PST)
Subject: Re: What is the license for linux/lib/math/cordic.c?
To:     "ambai.masaki@fujitsu.com" <ambai.masaki@fujitsu.com>,
        "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>
Cc:     "'brcm80211-dev-list.pdl@broadcom.com'" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "'brcm80211-dev-list@cypress.com'" <brcm80211-dev-list@cypress.com>
References: <OSBPR01MB21689E8028F2AFDBBA89076C83460@OSBPR01MB2168.jpnprd01.prod.outlook.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <afb1b412-a632-f2dc-0b76-52c345c25491@lwfinger.net>
Date:   Fri, 29 Nov 2019 13:59:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB21689E8028F2AFDBBA89076C83460@OSBPR01MB2168.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/29/19 4:03 AM, ambai.masaki@fujitsu.com wrote:
> Hi,
> 
> What is the license for linux/lib/math/cordic.c?
> 
>>   * Copyright (c) 2011 Broadcom Corporation
>>   *
>>   * Permission to use, copy, modify, and/or distribute this software for any
>>   * purpose with or without fee is hereby granted, provided that the above
>>   * copyright notice and this permission notice appear in all copies.
>>   *
>>   * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
>>   * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
>>   * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
>>   * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
>>   * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
>>   * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
>>   * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> I think this license is an ISC license.
> 
>> MODULE_LICENSE("Dual BSD/GPL");
> However, MODULE _ LICENSE declares a different license.
> I don't know which license is correct.
> What licenses are declared in this file?
> 

I am a little confused. If the author(s) declare the license to be "Dual  
BSD/GPL", why do you not believe them?

Larry

