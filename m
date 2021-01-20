Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5518D2FCF79
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 13:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbhATLbj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jan 2021 06:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388331AbhATKyf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jan 2021 05:54:35 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AF2C061575
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jan 2021 02:53:34 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id d85so710020qkg.5
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jan 2021 02:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8LWikLvvunCGEEQg/rbWVeuYqmasKn/ETQdSjfwMTvI=;
        b=MaFslMl5UgXp29IIbMVoFD94NLajzN6WCUI8+T1TAQK90Mxjb+IEcUCIOtebn9zowL
         h84AxvSjlF+mrKjH8tB6oI+mpNrXuErMRYGiQxHzJfmvRJKuewVWEFC3Vdvsu/B7L6WM
         KnhLEnhY7bjHSUNvAYLZPbvNMpSydgT7+tiKiwkaOSnAj24WJdZoNkh+BEgx7y1/4wkM
         lFo6nR2maKMrO+eZCSP4vc0zSf1ijHlAaDNEg1kAoagIVPRm++Z07L9crelLkK/onGmR
         pG5uaNQHOLp9hA2zMAcxlwEbsLZbB0t2IfmCALfxDTfPopEcidTPeCS9p1HbM0IcCBBh
         JYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8LWikLvvunCGEEQg/rbWVeuYqmasKn/ETQdSjfwMTvI=;
        b=qThgyRIaapYjlt2gZEms2iSWdjHcMHLskasxb4iTPi8sTv+bYpgszpZgv8Lp13ZCJC
         UU3pKBkXdAnObP5AePFjo7h3owb6BNwjZNSZyqmdQVCQpIFjisGyw3nSgABhzN9IOyoa
         9+thqdqhlpI8B9lO2nDIYkzg3bG9Q4b30OUtBqIOKfmZL0Pqm4tUvqxR2hKcz4c2Et/7
         DlsvY13cNpy9GXrGiw4CmAf0JJXDSc/Y9C9BZNAQzVYSpI/n9jjQAoiuq+LD9uXm5uty
         mVu7DoWE//fnkfqD77E80Y4dBH/loYQQwbgSm8oKasP4gqd49AGI7tm0+49ZOyihtOIR
         vb8A==
X-Gm-Message-State: AOAM533FoJzgsEjWExNGciOBBKNjuGC/G1afMrS1rFGJrT/lIxEJUSiH
        o8MOL92ICLboQSADPvw/UP8dAQ==
X-Google-Smtp-Source: ABdhPJxYwqevUcYXkMHO48PbPu6SpJFol4PvEjt2YPC4HRK5MDgfIa5YYNPfHz8tmR9fXeokkJjoTQ==
X-Received: by 2002:a37:2e87:: with SMTP id u129mr1126123qkh.344.1611140014030;
        Wed, 20 Jan 2021 02:53:34 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id v8sm883164qtq.80.2021.01.20.02.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 02:53:33 -0800 (PST)
Subject: Re: [PATCH 0/2] thermal: Replace thermal_notify_framework with
 thermal_zone_device_update
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "Errera, Nathan" <nathan.errera@intel.com>
References: <20210119140541.2453490-1-thara.gopinath@linaro.org>
 <fb5571b452f7495eb76396795eeec096@intel.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <4063d06f-ccae-cad7-e470-60f0526b4f56@linaro.org>
Date:   Wed, 20 Jan 2021 05:53:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fb5571b452f7495eb76396795eeec096@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 1/19/21 9:56 PM, Zhang, Rui wrote:
> Hi, Thara,
> 
> Thanks for the cleanup. I've proposed similar patches previously.
> https://patchwork.kernel.org/project/linux-pm/patch/20200430063229.6182-2-rui.zhang@intel.com/
> https://patchwork.kernel.org/project/linux-pm/patch/20200430063229.6182-3-rui.zhang@intel.com/
> can you please also address the comments in the previous discussion, like doc cleanup?

Hi Rui,

Thanks for the quick feedback. I am sorry, I was not aware of your 
earlier series. I will add a patch cleaning up the Documentation and
send the v2. I have not tested this patch much. But I see from the
comments on your patches that this has been tested out. So that is good.

> 
> Thanks,
> rui
> 
>> -----Original Message-----
>> From: Thara Gopinath <thara.gopinath@linaro.org>
>> Sent: Tuesday, January 19, 2021 10:06 PM
>> To: Zhang, Rui <rui.zhang@intel.com>; daniel.lezcano@linaro.org;
>> kvalo@codeaurora.org; davem@davemloft.net; kuba@kernel.org; Coelho,
>> Luciano <luciano.coelho@intel.com>
>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>> netdev@vger.kernel.org; linux-pm@vger.kernel.org; amitk@kernel.org;
>> Errera, Nathan <nathan.errera@intel.com>
>> Subject: [PATCH 0/2] thermal: Replace thermal_notify_framework with
>> thermal_zone_device_update
>> Importance: High
>>
>> thermal_notify_framework just updates for a single trip point where as
>> thermal_zone_device_update does other bookkeeping like updating the
>> temperature of the thermal zone, running through the list of trip points and
>> setting the next trip point etc. Since  the later is a more thorough version of
>> former, replace thermal_notify_framework with
>> thermal_zone_device_update.
>>
>> Thara Gopinath (2):
>>    net: wireless: intel: iwlwifi: mvm: tt: Replace
>>      thermal_notify_framework
>>    drivers: thermal: Remove thermal_notify_framework
>>
>>   drivers/net/wireless/intel/iwlwifi/mvm/tt.c |  4 ++--
>>   drivers/thermal/thermal_core.c              | 18 ------------------
>>   include/linux/thermal.h                     |  4 ----
>>   3 files changed, 2 insertions(+), 24 deletions(-)
>>
>> --
>> 2.25.1
> 

-- 
Warm Regards
Thara
