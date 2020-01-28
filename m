Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9503114B1F8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2020 10:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgA1Jrn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Jan 2020 04:47:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51464 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgA1Jrn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Jan 2020 04:47:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so1763629wmi.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2020 01:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qGo8vat57oZKbX952ZOsgs3M79WlJfUSUaH5Jb0b7Lg=;
        b=R5ajh80sNA0KcS9gJCaGIaPV6Nq/OTsd33b2r/Brsp75k9Bzenkas6TmhsYjfWnKAC
         ojhTrSg9JY0OkpKgPrS4H7QMnQc7ATWcNYv4UGG23WHjCngU9uZatZdTiQ8aaoT2x8oM
         B78sKfgyftREzVZdXSraE2rIWjmlNeYge6aLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qGo8vat57oZKbX952ZOsgs3M79WlJfUSUaH5Jb0b7Lg=;
        b=F9QZVHDox6tj98u9cDYMXr1eePXrXhOKZftGjCTq61UuBy1nzmEwAcnT1r9HCoF5QB
         FQBITuprcyEq/PiVYV99u4cLY+ILRUisxPXCrWHkvNEMbWZ8gLmMLOCRRXjkWlNB4KBh
         xEDVAMxxMN9OHx8AsEoXcFHjJL5a4hlAo3hojZsdriJqNZNUU5+c6CYaJ/c4qCI2IQxM
         CNL68BM9DEsi3Lrkoq9bkORfHUCzBiSj1HgEfoDDslOtvoisWcOUyvoefzVRZfsfn5vg
         imyqJjHQislkf8/XSPPg+SxB2v/tS3eHNaw3lxkgXUs2H08yJrrSm4ILMwvWdPxm+EJy
         IpBw==
X-Gm-Message-State: APjAAAW4GHP9pVVPwRaBvoP9rsVKj72I+60YchfbHg7w2Ep40ngtVZ3n
        RW/H5vhXoY4f1M167624IO16XA==
X-Google-Smtp-Source: APXvYqzHdILHJfQ0v7X+gakV1nGX5TRxrHQPZU+bJywfnsN8JNTkNGuevTdK/FF9bgcy1IOKQsU2aw==
X-Received: by 2002:a1c:2ed5:: with SMTP id u204mr4110373wmu.170.1580204860561;
        Tue, 28 Jan 2020 01:47:40 -0800 (PST)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id w5sm816444wrs.34.2020.01.28.01.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 01:47:39 -0800 (PST)
Subject: Re: [PATCH v2] brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
References: <20200126155108.7DDD7C433CB@smtp.codeaurora.org>
 <20200126193339.167346-1-sandals@crustytoothpaste.net>
 <16fe3b278d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20200126230029.GI4113372@camp.crustytoothpaste.net>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <71763ca9-ed7a-2403-b85a-d7dc624cd050@broadcom.com>
Date:   Tue, 28 Jan 2020 10:47:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200126230029.GI4113372@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/27/2020 12:00 AM, brian m. carlson wrote:
> On 2020-01-26 at 21:12:02, Arend Van Spriel wrote:
>> On January 26, 2020 8:34:18 PM "brian m. carlson"
>> <sandals@crustytoothpaste.net> wrote:
>>
>>> The 2018 13" MacBook Pro (MacBookPro15,2) has a Broadcom chip, the 4364.
>>> This chip appears to be specific to Apple and is not found in other
>>> hardware.
>>>
>>> Add this chip to the brcmfmac driver so that it can be recognized
>>> automatically.  Note that the PCI device id is 4464 even though the chip
>>> is referred to as the 4364.
>>
>> So what is the plan regarding firmware. In the previous patch you mentioned
>> it can be copied from macos, but I am not sure if that is acceptable from
>> legal perspective. At least Linux distributions will have problem with that
>> for sure.
> 
> I don't have a way to solve that problem.  The firmware copyright
> presumably belongs to Broadcom and they would be able to grant that
> permission or ship firmware through the normal channels.
> 
> As far as I know, this chip only comes with Apple systems, so users will
> acquire the system with macOS.  I'm not aware of any legal reason that a
> user cannot copy the firmware from one location on their hard disk to
> another, so users will probably be able to legally use the firmware,
> even if it's not shipped with distros.

I think you are right provided they use it on the same system they acquired.

> There is also precedent for users acquiring firmware themselves via the
> b43 and b43legacy drivers, where users have to use a script to extract
> the firmware from other drivers.
> 
> I wish I had a better answer to this, but I don't work for Broadcom or
> anyone associated with it and am just trying to get the Mac I was given
> for $DAYJOB to work with Linux.  Perhaps since you do you'd be willing
> to ask them to release the firmware.
> 
> The alternative is that the chip doesn't work at all (and can't be added
> via the new_id sysfs entry because of the rambase setting) and users
> have to compile a custom patched kernel to make their wireless card work
> at all.  I'd really prefer to avoid that if possible, since it's
> a strictly worse experience in every way.

How about putting this device under some Kconfig flag. If distro kernel 
start probing the device and fail, most users will probably turn to 
their distro for help. Having a Kconfig with a good description could 
avoid that. It would mean an extra step of building the driver though.

Regards,
Arend
