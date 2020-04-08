Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187A31A2489
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2020 17:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgDHPCW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Apr 2020 11:02:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39781 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgDHPCV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Apr 2020 11:02:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id y24so216921wma.4
        for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2020 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OHNbHrS4QDf2uU0Rs3jo9i5TE/pQa6lFi0dwdzXi0NA=;
        b=ROX7rURGPNuF23LgTS+LQwQ1cg0J7FkD6S5t4m1WfIHwOTgE7PIOuMPBbYPIc26R+C
         3Et8pKGhruMa63bwDStBo1R+Ohyi8Vwrq8oRBXw1l6dFUbMcdJlXKvuNi5xMveJ7qttR
         iN3lhXxYbf4Fi14EQRGqURrDqS7FfAfJHA8qwhj+jMXkN4HKI1Zf+tmIvfd6rJsydEmw
         3OxgVAKmAJTKonMQobw7lXLzeFUCzooOPPJvC6+GqBlQ2cADbRslVDydl1aG8uz48iNz
         igI9Qgi+d2yfQZLL5uwKJrllVVtaOoZYniG9co0CbuKgJbdN8nfmWFTnJFovt/MzA+Ai
         NQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OHNbHrS4QDf2uU0Rs3jo9i5TE/pQa6lFi0dwdzXi0NA=;
        b=PlVNoV570XTAFwrHVhR5Wv8Cp2AXtIH/kzsDAoSb94k3OnuMczuALAUPlD5rYvQwmA
         XoWNDV9BnjPMHk8oK+b9tVobzqgAd/tu3IcLjVsKpJSis/hV7ioXbTaEjRV16/hsvCKX
         aYDf18FNwsV96K5cD0DuVOOWjrBYYdrF7bB03H+BTZBInIznXdUzvgMhrXZbz5BiWJb7
         1z4FghW1xae801Yr8w+Wl3VQhacvs8n7T3UF6vo/561TVA18pmeRu7SVgrx3ue+fsUgm
         4qZHGNWKmY83adIFEEkdF+POS0gddOEB8vzIHE7PEo9Mn7oiCfnY3Dm7QBAj3YaivLdC
         /PtQ==
X-Gm-Message-State: AGi0PuZVm9MpzL/X0eqhuOlWd7U7Wat6XBWeOAnhFquGoPq0e806fku5
        uvvTqdZ78iadBUcttzN0Pj/oe3mXBrE=
X-Google-Smtp-Source: APiQypLP30cQdKCkXHJUWwugq8bew80JCM7ZaQcSeRkFKsASblWL+t9vwKVNc2UG8/9sBXJ4XZrhKA==
X-Received: by 2002:a1c:8141:: with SMTP id c62mr5023397wmd.87.1586358138890;
        Wed, 08 Apr 2020 08:02:18 -0700 (PDT)
Received: from [10.202.0.7] (d5152e8e2.static.telenet.be. [81.82.232.226])
        by smtp.gmail.com with ESMTPSA id g3sm22095026wrw.47.2020.04.08.08.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 08:02:18 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] mac80211: Allow deleting stations in ibss mode to
 reset their state
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Nicolas Cavallari <cavallar@lri.fr>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.com>
References: <20200305135754.12094-1-cavallar@lri.fr>
 <20200305135754.12094-2-cavallar@lri.fr>
 <bc2934fe-ee0b-c593-e866-692487e06d4e@ncentric.com>
 <ff459a4c-9bf8-30e9-a486-86d171640e79@green-communications.fr>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <92b907d7-6ef2-e0e1-fad0-d3deca75f72b@ncentric.com>
Date:   Wed, 8 Apr 2020 17:02:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ff459a4c-9bf8-30e9-a486-86d171640e79@green-communications.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 08.04.20 16:31, Nicolas Cavallari wrote:
> On 08/04/2020 13:56, Koen Vandeputte wrote:
>> Quick test setup overview:
>>
>> - Device mounted on top of a vessel, sailing around in windfarms.
>> - Lots of turbines are equiped with 4x 90deg sectors
>> - 802.11n HT40 2x2 custom mesh over IBSS, using Dynack
>> - As the vessel moves around,  IBSS links are continuously dropped and
>> re-added throughout the field
>> - Output of my app, fyi:  https://pastebin.com/raw/vtZSwHC9
>>
>> I've made 2 identical builds, one containing your patches and one without.
>>
>> When your patches are used:
>>
>> --> On devices with multiple radio's, all radio's went deaf within a few
>> minutes without any notice in logs.
>>
>> --> Only a reboot solved the issue but everything goes deaf again within
>> a few minutes. (after dropping/adding some links)
>>
>>
>> Any idea?
> I would highly suspect the hasty wpa_supplicant patch more than the
> kernel patches.
>
> I suppose you don't have any wpa_supplicant verbose logs ? (with the -dd
> option).
>
> I don't have physical access to any hardware given the current crisis,
> but if you could tell which kernel and wpa_supplicant version you
> applied the patch on, and whether you took the patches from the mailing
> list or from git including the cleanup patches.
>
> Also, which driver/card did you use ? I mainly tested this with ath9k
> with ar93xx.


hw used:

1) (moving)

- cns3xxx board (GW2388)

- 4x pci ar9220 (ath9k)

2)

- imx6

- 2x ar93xx (ath9k)

Sw:

OpenWrt 19.07

Kernel: 4.14.174

mac80211: 4.19.112

wpa sup: 2.9


The timeslots to play are short, so I cannot easily test manually for 
extra verbosity using wpa_sup.
Using tcpdump shows EAPOL packets being exchanged but I guess it fails 
somewhere there.
I used the kernel patches from mailinglist (V3).

If you could cook up a clean patch properly implementing the required 
bits over there, I would be happy to test it again.


Regards,

Koen

