Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3699C41F24C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354713AbhJAQoP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 12:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhJAQoO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 12:44:14 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E4CC061775
        for <linux-wireless@vger.kernel.org>; Fri,  1 Oct 2021 09:42:30 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so12192031ota.13
        for <linux-wireless@vger.kernel.org>; Fri, 01 Oct 2021 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dDvpguwZnkblm1LboM7MYwfmQ/ExwC22p0SLyGpe/vY=;
        b=bbHDWwTbW6ckg49e4naV8rThVMIvvRKnpRXvmdCCMG7qr2wgY85pfyvhINnhulVHlK
         qfWYpllIbfqns4uxcj0minXUZlANCv3Mp96mxEXaLh+7IboUnamaw3JzlfzULtd4jGYw
         Hc+gLIT/7Urj7fKduJ9X2VQW8riPmQLgahyS/3xJsqntHbjVA1kdGZK+nmfD9cr7o9WJ
         V+SU93SP21B7v6zJsnHaIotty5DYQXUuUfMvlrYcwdBadOnrcKapHM5nyK/GPw+KKPHb
         s0ihURs6J0HzETAIa/B81Y5eabzGBPNOtJ3YYu2n+DB/++MAgIoq0ef0db9nTRV0UHA/
         iDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dDvpguwZnkblm1LboM7MYwfmQ/ExwC22p0SLyGpe/vY=;
        b=c7JUp5QaNrxfX3OfqKk24brkygpok4+PdDnl7igYXqkWuthMtOVASKX34Ge4ubawDF
         ALK6IqpxsUcfxS+nojGi6G2JKpHrJEmL5FpEawJBSsucdC2UFLN/yE348MDx6MLy4Zqv
         gh6KMljVdzmLBalMI2tdj2T2zoZfMZEyZhtj//MdW5SqkqLt1egbvxrVxdHpeVbYAQ0c
         3mWi2zCA+m3zEoEhbv22fF4GckigaeHHGgurqf+Mesh0Q8M7zBPJRh7Oqk2FxdCWwvsd
         LYU7qp+VPa4kwnLK2COGe/WMNfkcj5OjPqdOx3omUzD6cGi+X3aU6TRhGOt1mUulOFE6
         CZSA==
X-Gm-Message-State: AOAM5328CvbxY9rvxrjHfNwJ43cnBzfqUBuErGo2XTo+4FzstoHRy5PA
        0d5ZpWoPrQC7uhNAfs56XxVX4B3aUgM=
X-Google-Smtp-Source: ABdhPJxtysYBaZF5NSLRa8JYEfbQMnx/pIwCqFOBHQzgQovn3EqWYyr0KCo0hDIrvD5P9mLNkurL1g==
X-Received: by 2002:a9d:71c8:: with SMTP id z8mr10796404otj.149.1633106549478;
        Fri, 01 Oct 2021 09:42:29 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1014? (2603-8090-2005-39b3-0000-0000-0000-1014.res6.spectrum.com. [2603:8090:2005:39b3::1014])
        by smtp.gmail.com with ESMTPSA id e6sm1247039otr.79.2021.10.01.09.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 09:42:28 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <7df9058b-4983-6d0e-07f7-8fe4df1cff27@lwfinger.net>
Date:   Fri, 1 Oct 2021 11:42:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
References: <20210820043538.12424-1-pkshih@realtek.com>
 <8735pkiu0t.fsf@codeaurora.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <8735pkiu0t.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/1/21 11:34, Kalle Valo wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
>> This driver named rtw89, which is the next generation of rtw88, supports
>> Realtek 8852AE 802.11ax 2x2 chip whose new features are OFDMA, DBCC,
>> Spatial reuse, TWT and BSS coloring; now some of them aren't implemented
>> though.
>>
>> The chip architecture is entirely different from the chips supported by
>> rtw88 like RTL8822CE 802.11ac chip. First of all, register address ranges
>> are totally redefined, so it's impossible to reuse register definition. To
>> communicate with firmware, new H2C/C2H format is proposed. In order to have
>> better utilization, TX DMA flow is changed to two stages DMA. To provide
>> rich RX status information, additional RX PPDU packets are added.
>>
>> Since there are so many differences mentioned above, we decide to propose
>> a new driver. It has many authors, they are listed in alphabetic order:
> 
> I did a review now and this looks pretty good to me. Kconfig has a
> different license and lots of static/extern variables which are not
> const, otherwise I only saw smaller issues. But I do have to admit that
> after mac.h (in alphabetical order) my review was more on the sloppy
> side, this is a large driver.
> 
> The community has been testing this driver already, right?

Kalle,

As soon as Ping-Ke submitted this driver, I created a stand-alone version at 
GitHub so that people with new laptops containing this chip would have a source 
for the driver. There have been minor hiccups that we have fixed along the way. 
I am also testing it on my system.

Larry

