Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655A939A9CD
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFCSMP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 14:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFCSMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 14:12:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA476C06174A;
        Thu,  3 Jun 2021 11:10:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l1so10594457ejb.6;
        Thu, 03 Jun 2021 11:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4UqViyazpqkgaVJoB+LoL1RCTvbUomFbCZhuoWBsgic=;
        b=ju9tPKTljfo6wGF0H+BsBMFK5jNw1s4t01+7lkOYNznld6ZWvr41O5IIq34Tz8ZdKG
         s+JGoB9SBIi/rG4CrsjhrxQutO3SwToFJni+Dj4dObpHYPp+zU3DdGmt/6fQZ2TMLBVo
         SloeopmxTu4rLDX35SBnGeQmVK4oYIsVFQ6Cpqj5Ibvg8HjzZv6wTtf/UaJtVunMsgbk
         CyqxaVuK7ixLs9gxZMmKt75NllcLFoJakuOgOmELXMYQ1yK55qFL4iV8ufIwwF1zCueA
         moXkbJtyag5RAaMaBEkFmNcowVgwOAB8QC9HFu6xoBmr1UE8Sfm5I8lywENbQOn23rYQ
         ZPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4UqViyazpqkgaVJoB+LoL1RCTvbUomFbCZhuoWBsgic=;
        b=NEegEfRNl7fkNMEV4ho7QQJ1DPbOUf6Th2sQlNpxs2SO2M0edOychAN3NNKINSyNaf
         T85i32+IM2EFJ0HkSqbyYQA2jW9+DRnxcDz7ktx9XgzuF3a6V7QiEn7U8TU9AGDq49Bp
         8KUWFcLvaoMTTTNz/4TWzbnnlXEerQraemZd1GGdhzxq/4I9aiOhNSlJ7REfUXwpjtmD
         thzcQ2dl0AvchgoJd6tM+1wg6iIZnv6lhq+MOfmQlPEwr5H5LJ+oPEsVXylaqcBE958A
         tFYR0YoOl7KmL+osssw5MjnugknpszmGZaiIEvXVw3i/Bw4DRZ9UCF9B2bZO01ZJLTLH
         aBTQ==
X-Gm-Message-State: AOAM530cjtEfNdRyZELNGDBBqOlZePML5MOpQTvs+SyV3761aiQwZ2qF
        Nna3zRN72OlPsWWLXXiYASU=
X-Google-Smtp-Source: ABdhPJyUpmjT5hvat9p8DfhoKGNcC/VN23Zf+WsPCx6MA9F7wVqIaGz9XF6gulcTAhKptLjLcOrbgw==
X-Received: by 2002:a17:906:2b8c:: with SMTP id m12mr582827ejg.358.1622743815450;
        Thu, 03 Jun 2021 11:10:15 -0700 (PDT)
Received: from debian64.daheim (p200300d5ff0dbb00d63d7efffebde96e.dip0.t-ipconnect.de. [2003:d5:ff0d:bb00:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id am5sm1794165ejc.28.2021.06.03.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 11:10:14 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.94.2)
        (envelope-from <chunkeey@gmail.com>)
        id 1lormT-0003kX-Jj; Thu, 03 Jun 2021 20:10:13 +0200
Subject: Re: [PATCH v3] wireless: carl9170: fix LEDS build errors & warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20210530031134.23274-1-rdunlap@infradead.org>
 <8043ff50-d592-7666-f001-7505efa0d4c2@gmail.com>
 <c49c07d5-1d6e-5b99-30b4-bc8f48b0fde3@infradead.org>
 <87czt31dt3.fsf@codeaurora.org>
 <5e5a50e0-7e42-9fd3-f927-d3b695a21912@infradead.org>
From:   Christian Lamparter <chunkeey@gmail.com>
Message-ID: <1158a5e5-6b3e-3cab-885d-c72e45d26a0c@gmail.com>
Date:   Thu, 3 Jun 2021 20:10:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <5e5a50e0-7e42-9fd3-f927-d3b695a21912@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/06/2021 17:20, Randy Dunlap wrote:
> On 6/3/21 2:46 AM, Kalle Valo wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>
>>> On 5/30/21 2:31 AM, Christian Lamparter wrote:
>>>> On 30/05/2021 05:11, Randy Dunlap wrote:
>>>>> kernel test robot reports over 200 build errors and warnings
>>>>> that are due to this Kconfig problem when CARL9170=m,
>>>>> MAC80211=y, and LEDS_CLASS=m.
>>>>>
>>>>> WARNING: unmet direct dependencies detected for MAC80211_LEDS
>>>>>     Depends on [n]: NET [=y] && WIRELESS [=y] && MAC80211 [=y] &&
>>>>> (LEDS_CLASS [=m]=y || LEDS_CLASS [=m]=MAC80211 [=y])
>>>>>     Selected by [m]:
>>>>>     - CARL9170_LEDS [=y] && NETDEVICES [=y] && WLAN [=y] &&
>>>>> WLAN_VENDOR_ATH [=y] && CARL9170 [=m]
>>>>>
>>>>> CARL9170_LEDS selects MAC80211_LEDS even though its kconfig
>>>>> dependencies are not met. This happens because 'select' does not follow
>>>>> any Kconfig dependency chains.
>>>>>
>>>>> Fix this by making CARL9170_LEDS depend on MAC80211_LEDS, where
>>>>> the latter supplies any needed dependencies on LEDS_CLASS.
>>>>
>>>> Ok, this is not what I was expecting... I though you would just
>>>> add a "depends on / imply MAC80211_LEDS" on your v2. (this was
>>>> based on the assumption of what mac80211,  ath9k/_htc and mt76
>>>> solutions of the same problem looked like).
>>>
>>> Do you want the user choice/prompt removed, like MT76 is?
>>>
>>>> But since (I assuming here) this patch passed the build-bots
>>>> testing with flying colors in the different config permutations.
>>>
>>> It hasn't passed any build-bots testing that I know of.
>>> I did 8 combinations of kconfigs (well, 2 of them were invalid),
>>> but they all passed my own build testing.
>>
>> So is this ok to take now? Or will there be v4?
> 
> It's all good AFAIK unless Christian wants something changed.
> 
> Christian?
> 
I think it's good. It's probably just that Kalle is busy.
 From what I know, if something was wrong there the build-bots
would have already sent a letter.

Cheers,
Christian
