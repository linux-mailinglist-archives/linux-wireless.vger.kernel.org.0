Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4354101E9B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 09:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfKSIxh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 03:53:37 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45791 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKSIxh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 03:53:37 -0500
Received: by mail-wr1-f43.google.com with SMTP id z10so22754495wrs.12
        for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2019 00:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PlDxeYsK8cvJ37usLatoNozqAuDAmK2o/VAYNOuB+OI=;
        b=QpD1V00WWWCGLc1wYsB4YMueO7vl3iN10gTDeK0Zv3sBkEsscF8+HTvqOiUAtYqbz9
         x/Z2++yTcixHkIiP6Ajb8YvEw+IrFvLHhW+sssxhoIjYnVxMJl/yibmI2bDxl1UEj6UZ
         rFUiu7DcLDqJJB1/EE9fGrrbEwP65h4MhvA4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PlDxeYsK8cvJ37usLatoNozqAuDAmK2o/VAYNOuB+OI=;
        b=U2ZGrMSdPWk/VCSTiFPvJe1YZ1U1NBJabjjQxo7QMax9Kl+wj9UVznixrOvc1Qf5fk
         H7HmkXWXy6WjMX6XpCC14jv4zNlaea0L59EBCzKYlDIPbTF/nuyW8E5QAcy7hi1WIV8c
         UZJWBZBZRg++8IpA26lT0gt7jwd/YsaHj3wxMMbvMxQfMJBoIsEuT/namC4aJ2ZCee/0
         5pmp9A1hxkrby/oiRw/x5vvmyoL86H05RZ64on5Kq8C2nNvSHEbg6GdhZbmtYfTuCP23
         G/5O9ZFNaEL61yhdYkAebyln1bYleyPTnSgLt7UsHMLnVj8XvpVqTTGaSpGe45oWLUEH
         rUtA==
X-Gm-Message-State: APjAAAXXvm4x5R6FgDYiudNZjnKLMydwdAMKH3VBztHaix7eorqrLr7i
        2xyIx140vMOp8LzNLdKzYeJ8fw==
X-Google-Smtp-Source: APXvYqyx7rrwpqcFVWFJT0Yrsv67JidQfFuSa13mLgS9S6r1iNLkN39ypjSdDYgtrGRVbczWVOXOGA==
X-Received: by 2002:a5d:6548:: with SMTP id z8mr25069796wrv.273.1574153615091;
        Tue, 19 Nov 2019 00:53:35 -0800 (PST)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id x11sm26730761wro.84.2019.11.19.00.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 00:53:34 -0800 (PST)
Subject: Re: BCM4335 SDIO firmware crash/problem
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-wireless@vger.kernel.org
Cc:     franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chi-hsien.lin@cypress.com, wright.feng@cypress.com,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
References: <CAFBinCAbmvUJym2KD5Y4DcF_iGUwB6SrQSGd7qU6qmuctJ06Cg@mail.gmail.com>
 <CAFBinCD8TXZD6q662kFm_ZNe+kUi74q=SaEz_PHUev=AnWZSBw@mail.gmail.com>
 <CAFBinCCY=9Acen_YSkCxrwgx0txCGym_qVax9GfaVL7WC6MKWg@mail.gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <8c5c682c-da4b-0fb4-2173-8c3082614a56@broadcom.com>
Date:   Tue, 19 Nov 2019 09:53:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCCY=9Acen_YSkCxrwgx0txCGym_qVax9GfaVL7WC6MKWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/18/2019 9:47 PM, Martin Blumenstingl wrote:
> Hi Arend and linux-wireless supporters,
> 
> On Sat, Nov 9, 2019 at 3:55 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> On Sun, Nov 3, 2019 at 12:49 PM Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com> wrote:
>> [...]
>>> The Android installation that my device came with ships a newer
>>> firmware version: "BCM4335/1 wl0: May 18 2014 16:56:54 version
>>> 6.34.171.58.2". This is also available in CoreELEC's repository: [2].
>>> I went ahead and used this newer on my Arch Linux ARM installation and
>>> it seems to have fixed my problem
>> I am now at 12 days of uptime and wifi is still working with that firmware
> gentle ping on this
> I can send a patch against linux-firmware if you want but I'm not sure
> about the license or any internals of that firmware

Hi Martin,

Sorry I did not chime in earlier. I have not looked at the CoreELEC 
repository for license files. Without such info I am inclined to say you 
are not licensed to redistribute the firmware. The BCM4335 is 
end-of-life for us although maybe Cypress is still selling the device 
and may want to provide a firmware update.

Regards,
Arend
