Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743E44700C
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFOMuZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 08:50:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43017 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfFOMuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 08:50:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so7819452edr.10
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jun 2019 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yh9Nx8oRAUAyws0D5sqXXyAoVwFxgqminG+bbb3CbKw=;
        b=NtnYATcyGmfd4pnuK1Umqun/1PjX6jl98/q9C1+oKB+/Rq+TtwQ5klJEv2bc5WFZWy
         U6CCahYGN1ugKDM+4Ksf9YjW3KodWBf7PnISBBTaWVAWwtlojrA5yzWlNKp/cz+OCKng
         0djUXPAhnlB/8bwpmv/JwYUSnqyPzMpXjW/5bDGBi08J4DfHsIDfTdDvtzTdB4Awilwf
         2YrWqvaDbCvYNEyfBQqLsiRK+7/sjfUPvr/GWEX/lfvF0jsLriI2TvVB+3Tlm1jqqkl2
         0bAmEA7HEVi6Ygjwd/MWbEdi4Za89Ob1C0b/xY0rDd/BzkQyB8py8gG8ysybNyuWtw9Q
         cPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yh9Nx8oRAUAyws0D5sqXXyAoVwFxgqminG+bbb3CbKw=;
        b=fovanVwISxJ3U0aBsiBmn7ZlUKiVQP4YIEkXED9ddkUQG/IM9ECUUR7WlYrbBu0ydn
         VsYTmtz/p/BG85lCxn79wPTjC+ygJrcWH1gvfvRrMNQf0R1+alcZKC6sirPovAKlnu+f
         RkFS9zYGmYVpOsJGh3IAeBcS+jgtvcXUa8XtG7r6jJWWh6ZyJmsHimlo7h+fNT8aOhJo
         js4wz2fJZ6Z2rm3Ktq/FNw6w8btUI7dEauhSaMLqzBeDf6x/kjMBS1hDsDtjEgIY90VK
         9oTdZElmgQv/9HGn3AuDs61BpAlf6s2JA/7n0bA43iTNHIzjCboHPBImjNvIFmFTFAFG
         eS+Q==
X-Gm-Message-State: APjAAAVe8Nzp94Sfp6L3l51RKMzFlLgl80OkTKnxDgM66orRU20/EDIK
        aAcZn9EQDGm0mc7QPF0YJK7R8btQQ/w=
X-Google-Smtp-Source: APXvYqwpeZDSc+mOrXIZQixY97/oFLvRAtmaYR85t/aaJla8xHAQe8lkVVMxPtI13U2ExQKbDwk7ng==
X-Received: by 2002:a50:9d43:: with SMTP id j3mr108448813edk.59.1560603022956;
        Sat, 15 Jun 2019 05:50:22 -0700 (PDT)
Received: from ?IPv6:2001:db8:4b:222::197? ([2a02:810a:8c0:6498:61e4:37ed:10fa:e4d2])
        by smtp.gmail.com with ESMTPSA id c24sm1149310ejd.2.2019.06.15.05.50.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 05:50:21 -0700 (PDT)
From:   "g.schlmm" <g.schlmm@googlemail.com>
X-Google-Original-From: "g.schlmm" <g.schlmm@gmail.com>
Subject: Re: rtw88: M.2 RTL8822BE not working - rfe 3 isn't supported
To:     Tony Chuang <yhchuang@realtek.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        "g.schlmm" <g.schlmm@googlemail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <0d0159a8-a83e-cef3-fd32-4928a2301719@gmail.com>
 <20190612091330.GC2965@redhat.com>
 <F7CD281DE3E379468C6D07993EA72F84D180639E@RTITMBSVM04.realtek.com.tw>
Openpgp: preference=signencrypt
Message-ID: <16b3aeaf-db0c-4ab8-c66f-e96dd01fec53@gmail.com>
Date:   Sat, 15 Jun 2019 14:50:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D180639E@RTITMBSVM04.realtek.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: fr-CA
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14.06.19 10:24, Tony Chuang wrote:
>> Subject: Re: rtw88: M.2 RTL8822BE not working - rfe 3 isn't supported
>>
>> Cc Tony
>>
>> On Sat, Jun 08, 2019 at 02:26:51PM +0200, g.schlmm wrote:
>>> my RTL8822BE M.2 card is not working with linux 5.2rc3
>>>
>>> the staging r8822be driver in linux 5.1 was working for this card
>>>
>>> from dmesg:
>>>> [    8.001186] rtw_pci 0000:04:00.0: rfe 3 isn't supported
>>>> [    8.003870] rtw_pci 0000:04:00.0: failed to setup chip efuse info
>>>> [    8.006405] rtw_pci 0000:04:00.0: failed to setup chip information
>>>
>>> lspci:
>>>> 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
>> RTL8822BE 802.11a/b/g/n/ac WiFi adapter
>>>>         Subsystem: Lenovo RTL8822BE 802.11a/b/g/n/ac WiFi adapter
>>>>         Flags: fast devsel, IRQ 19
>>>>         I/O ports at c000 [size=256]
>>>>         Memory at 81200000 (64-bit, non-prefetchable) [size=64K]
>>>>         Capabilities: [40] Power Management version 3
>>>>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>>>         Capabilities: [70] Express Endpoint, MSI 00
>>>>         Capabilities: [100] Advanced Error Reporting
>>>>         Capabilities: [148] Device Serial Number
>> 00-e0-4c-ff-fe-b8-22-01
>>>>         Capabilities: [158] Latency Tolerance Reporting
>>>>         Capabilities: [160] L1 PM Substates
>>>>         Kernel modules: rtwpci
>>
> 
> Hi,
> 
> Please use the attached patch. And RFE type 3 has not been well tested,
> I am not sure if the quality is expected. But it should work fine I guess.
> If there is any further problems, just tell me, thanks.
> 
> Yan-Hsuan
> 

Hello,

Thanks for the patch. i applied it on top of 5.2rc4 and everything is
playing nice so far.

i use the card as a hotspot with hostapd

the download speed changed from ~10Mbit/s (with the 5.1 staging driver)
to ~100Mbit/s

very nice work!
