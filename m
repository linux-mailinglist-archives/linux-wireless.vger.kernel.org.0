Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6819E150DC
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfEFQFU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 12:05:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41889 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFQFT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 12:05:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so15862528edd.8
        for <linux-wireless@vger.kernel.org>; Mon, 06 May 2019 09:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7kAz1+Z51tvw2opcrMQjw6Dq/g17HazdZTaAQbA0zpA=;
        b=Ao3M0oqOZZwQGsCQL2gK4Lua4puhX+h473IfUDGrmmWCJUrvHvevtw3KUj1mzxRpI8
         Msx3fSV4FYgluxQVMyTi+f9Ps+frN2ID29Lqf9Gf1VLHV5BSV83Mk+vZ108nO/uiCf8m
         K4pQlddfzsx53t+Y0RDIpo2CzaE9kBW7S9cTcXrskRhxUfVGTQqej1IQYA6/pT/BqkgL
         NFf1JyihBJutJxsEKDuAwP988weXkWnSNH6Ph+3rwAHvoPB+lGxQ16qyZVZMjShOc2xF
         8h+8hbaJN0Cuh9Y1ECJpkzWfNYKN2HgGj4rYEsB0R62zCVaEC7u9iUARUogEleyqBAJ/
         3zJQ==
X-Gm-Message-State: APjAAAWJWe/nRrapfQ6iWuApgqjjyu0cxIxPnvELeRb9Q4vqGnDsGqH+
        TVig4n1cfGe1x8expTbp69vFFg==
X-Google-Smtp-Source: APXvYqyKZiHoyTQVnVWoq+9/z12oY37alfcUhw1IsuXmlbo71MsqQkUjqe8oa0tPQsiQgwcy5rKKQQ==
X-Received: by 2002:a50:deca:: with SMTP id d10mr26557704edl.25.1557158717949;
        Mon, 06 May 2019 09:05:17 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id d17sm520436ejb.15.2019.05.06.09.05.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:05:16 -0700 (PDT)
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
To:     Victor Bravo <1905@spmblk.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3f3cca6e-50b7-c61d-4a62-26ce508af9e7@redhat.com>
Date:   Mon, 6 May 2019 18:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506152441.ifjcdi73elxuq5it@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 06-05-19 17:24, Victor Bravo wrote:
> On Mon, May 06, 2019 at 03:26:28PM +0300, Kalle Valo wrote:
>> Hans de Goede <hdegoede@redhat.com> writes:
>>
>>> If we're going to do some filtering, then I suggest we play it safe and also
>>> disallow other chars which may be used as a separator somewhere, specifically
>>> ':' and ','.
>>>
>>> Currently upstream linux-firmware has these files which rely on the DMI
>>> matching:
>>>
>>> brcmfmac4330-sdio.Prowise-PT301.txt
>>> brcmfmac43430-sdio.Hampoo-D2D3_Vi8A1.txt
>>> brcmfmac43430a0-sdio.ONDA-V80 PLUS.txt
>>>
>>> The others are either part of the DMI override table for devices with unsuitable
>>> DMI strings like "Default String"; or are device-tree based.
>>>
>>> So as long as we don't break those 3 (or break the ONDA one but get a symlink
>>> in place) we can sanitize a bit more then just non-printable and '/'.
>>>
>>> Kalle, Arend, what is your opinion on this?
>>>
>>> Note I do not expect the ONDA V80 Plus to have a lot of Linux users,
>>> but it definitely has some.
>>
>> To me having spaces in filenames is a bad idea, but on the other hand we
>> do have the "don't break existing setups" rule, so it's not so simple. I
>> vote for not allowing spaces, I think that's the best for the long run,
>> but don't know what Arend thinks.
> 
> I have found a fresh judicate on this:
> https://lkml.org/lkml/2018/12/22/221
> 
> It seems clear that we have to support at least spaces for some time
> (maybe wih separate config option which will be deprecated but on by
> defaut until old files are considered gone).

Ah that issue, well that is not really comparable in that case a lot of
peoples setups were completely broken by that commit and it was a
quite surprising behavior change in a userspace facing API.

The nvram loading path already does 2 tries, I really don't want to
unnecessary complicate it with a third try.

The Onda V80 Plus is a X86 based Windows / Android dual boot tablet,
as said before I do not expect a ton of users to be running regular
Linux on it.

Given Kalle's clear preference for getting rid of the spaces lets
just do that. But first we must get a symlink added to linux-firmware
using the name with the _, newer kernels requiring a newer linux-firmware
to match is not unheard of AFAIK, so combined with the limited amount
of users I think this is a reasonable compromise.

Kalle, do you agree with getting the symlink added to linux-firmware
ASAP as a fix for the V80 Plus issue; or do you want to see a fallback
to the un-cleaned name as you suggested before ?

Regards,

Hans
