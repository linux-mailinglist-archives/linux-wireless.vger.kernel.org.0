Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89584CB41
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 11:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfFTJpA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 05:45:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53831 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfFTJpA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 05:45:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so2365711wmj.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=19FoqvmTc23W19OOeOvYQaetASE8BKJReIRVK5ouWZE=;
        b=RGHvRF7J6QYU4opaG+zJ0xz591qW2KQiG9VVGcUScPVzAkEvyAEdEARojH4ptL6KJJ
         8N9US/UOeUEIBvpj0B+Clq3iktypkfoqrBUJve5EKu6zMjcfrxgzPtf5S027SW9oRa8N
         UzLgaFIpAhcKtxZdXZBqzendQWhiO+RcNF2Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=19FoqvmTc23W19OOeOvYQaetASE8BKJReIRVK5ouWZE=;
        b=W/ez6W90fu4VX5og/Yut1n3BtBGzZtl52H5+mRqxnV/Is5FkPSmEMcCHXrVicfH4aI
         qV8GYYc3cnViHquZ5EASM1sP9gveBFG/hqyJQbuuhtXLliWTxt3C7dWVOircYtibJFvN
         VkaTDTi184MO5TM32dLHXUHclIXEmI84fcf8DzQhcUlD52hravfl3WzFMHWcLPNnysog
         8DMS9jMw5o5xz2Swfdsvt6NWgyKM1PxpvTNkujaSo8di1VQElT5mVnT67MW4Z7QX9uKf
         ZslCdSlIEkrtjOIBKvDNtp2YfBGndWT8WZKG1ngY0w2wODDsrzIgSlepZkxORB3Fli60
         sBkQ==
X-Gm-Message-State: APjAAAWFJji+Nklj/DDfQtCZCOCdAfarDlRh86iMiZBDrLiYvIRKXvmu
        gmglUmdnLS0pgXY84XaPTygcQg==
X-Google-Smtp-Source: APXvYqw1omaEEFrdnJGusfLgV6qFM8tay3F9ebh7+tpA/T3zTS45lvI0uF1IRoQHCNjNKdI530JbFA==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr2055167wmj.167.1561023898143;
        Thu, 20 Jun 2019 02:44:58 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id p26sm20481048wrp.58.2019.06.20.02.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:44:57 -0700 (PDT)
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
To:     Stefan Wahren <wahrenst@gmx.net>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Stanley Hsu <Stanley.Hsu@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Jouni Malinen <j@w1.fi>
References: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
 <9da02861-9151-9700-2c09-b312d74155fa@gmx.net>
 <605ea0a8-3303-b810-6223-18ccc7eb7af4@cypress.com>
 <2AF2E0A7-23F0-4FFE-A658-4906FF546199@holtmann.org>
 <d6bfe313-3aa7-82bb-dfac-25e6261dbf63@cypress.com>
 <d0263c6f-97d0-6571-32e9-778392eafe69@broadcom.com>
 <ab26ac30-e49c-8712-f124-8cf996b32a76@gmx.net>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <56b2550e-e4d3-1601-f569-38c103138c4a@broadcom.com>
Date:   Thu, 20 Jun 2019 11:44:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <ab26ac30-e49c-8712-f124-8cf996b32a76@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/18/2019 7:03 PM, Stefan Wahren wrote:
> Hi,
> 
> Am 18.06.19 um 10:27 schrieb Arend Van Spriel:
>> + Jouni
>>
>> On 6/18/2019 7:33 AM, Chi-Hsien Lin wrote:
>>>
>>>
>>> On 06/17/2019 10:33, Marcel Holtmann wrote:
>>>> Hi Chi-hsien,
>>>>
>>>>>>> i was able to reproduce an (maybe older issue) with 4-way handshake
>>>>>>> offloading for 802.1X in the brcmfmac driver. My setup consists of
>>>>>>> Raspberry Pi 3 B (current linux-next, arm64/defconfig) on STA
>>>>>>> side and a
>>>>>>> Raspberry Pi 3 A+ (Linux 4.19) on AP side.
>>>>>>
>>>>>> Looks like Raspberry Pi isn't the only affected platform [3], [4].
>>>>>>
>>>>>> [3] - https://bugzilla.redhat.com/show_bug.cgi?id=1665608
>>>>>> [4] - https://bugzilla.kernel.org/show_bug.cgi?id=202521
>>>>>
>>>>> Stefan,
>>>>>
>>>>> Could you please try the attached patch for your wpa_supplicant? We'll
>>>>> upstream if it works for you.
> i've forward this patch to the Arch Linux board hoping someone else has
> currently more time.
>>>>
>>>> I hope that someone is also providing a kernel patch to fix the
>>>> issue. Hacking around a kernel issue in userspace is not enough. Fix
>>>> the root cause in the kernel.
>>>
>>> Marcel,
>>>
>>> This is a kernel warning for invalid application PMK set actions, so the
>>> fix is to only set PMK to wifi driver when 4-way is offloaded. I think
>>> Arend added the WARN_ON() intentionally to catch application misuse of
>>   > PMK setting.
>>>
>>> You may also remove the warnings with the attached patch, but let's see
>>> what Arend says first.
> Instead of removing the WARN_ON i suggest to replace it with a more user
> friendly dev_warn().
>>>
>>>
>>> Arend,
>>>
>>> Any comment?
>>
>> Hi Chi-Hsien, Marcel
>>
>>  From the kernel side I do not see an issue. In order to use 802.1X
>> offload the NL80211_ATTR_WANT_1X_4WAY_HS flag must be set in
>> NL80211_CMD_CONNECT. Otherwise, NL80211_CMD_SET_PMK is not accepted.
>> The only improvement would be to document this more clearly in the
>> "WPA/WPA2 EAPOL handshake offload" DOC section in nl80211.h.
> 
> I missed to add my expectation as a user. At first i assume this new
> behavior in wpa_supplicant 2.8 has been tested successful with at least
> one Linux wifi driver. So i'm curious if all drivers behave that way?

As a matter of fact it has been tested with brcmfmac.

> Another point is that in my wpa_supplicant.conf i never enforced 802.1X
> offload and i assume this feature is optional. So can't we do some kind
> of fallback in this case?

So when the driver indicates it supports the offload, wpa_supplicant opt 
in. There is no possibility for the user to opt out.

Regards,
Arend
