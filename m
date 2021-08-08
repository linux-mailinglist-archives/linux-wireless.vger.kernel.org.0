Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06433E3AC4
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Aug 2021 16:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhHHOX1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Aug 2021 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhHHOX0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Aug 2021 10:23:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B78C061760
        for <linux-wireless@vger.kernel.org>; Sun,  8 Aug 2021 07:23:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so5801899lfu.5
        for <linux-wireless@vger.kernel.org>; Sun, 08 Aug 2021 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WavvQQZOBIVZIE14HNTXDFFXya0UVR0yWNhNi/FOKzw=;
        b=em9EjhKZyXzrZsIuJSXm19/KWWvgZ1wLaVIkVNJp3e+a568prv+f0GugMt5rvqIU/X
         Iku2X1ezIRaX7c6KmDURstRNntl+ePQv6VSkT5BtyJH8hzVNUTmz8FuK2B0Z613RTFds
         qUFrSvk+g4vPtH970uYkmFvuRUvmOaTp+n+l7U3fte2eiHtcaUFAX8jv2nVjTMpOfamv
         ZDxQp96gA9y9rixA+FBgCQ7ll/Po++u4BQfq1ygFpzQb70r6+vuRqB0KpWmFR0o0jrB5
         9JYapNsiE5Y9mwKWTzTqM6tjAxS9QW98EfvTo62wwLbxe4nKfQM6+jFWus25vNbsFCOA
         1oyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WavvQQZOBIVZIE14HNTXDFFXya0UVR0yWNhNi/FOKzw=;
        b=WJZdYZNcaYqVDc8CAHXWXmhWX7YOjXW50wxcsfvrBx3J1UIgL4wWa4jZCfYY5AJY3Y
         o+lCddk1U745Av1G6xBKo2VY+id1/uBeGIpmxS8fsoFNf1HvzPK8nfe+gPpSl35Q9wHq
         pf/j/nh28JglwdhFeQL0DSqy2822nJo8pbp/KIsphLB0UisxIGzXIh+VzA6JvAq49wzA
         hxSXIblYGfZWCMzau2nUYvAXQYTo8IqV/OBNyeSe0LKDdwrJvmUxwLDv7qYcegG8HwcV
         HJ6vJjP7QbsH21dfX8Kw50ZeZbZxT8oBlZZncmfaw1wHfp/VGzcfrmiF/Qi61NKxMitj
         g5mQ==
X-Gm-Message-State: AOAM532mV7kQv58Zxx7SDgf8PJ5GZkW+BNsc5gmXrCsYfj2uLkBysfT4
        eBOgybuPHC7/3G7YiCksCLM=
X-Google-Smtp-Source: ABdhPJx0f09SGu4pdXGIchzllpVtRWCphAk8fE5MYWNZvYGtKkDqHakWp/TEsUGnojG3OgVVppFnFQ==
X-Received: by 2002:a19:4349:: with SMTP id m9mr13679580lfj.404.1628432585169;
        Sun, 08 Aug 2021 07:23:05 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id b19sm493403lfs.112.2021.08.08.07.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 07:23:04 -0700 (PDT)
Subject: Re: [PATCH v3] brcmfmac: firmware: Fix firmware loading
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stefan Hansson <newbyte@disroot.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20210805093023.3465081-1-linus.walleij@linaro.org>
 <9316a403-e755-3870-6393-62f20792af44@gmail.com>
 <CACRpkdZs4Zw5k6Hv0-PDKtrqXpEhTDn9OjwDJDvwJvsXJWDUvQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <018613ac-d479-46e4-5654-9b8ee56e3937@gmail.com>
Date:   Sun, 8 Aug 2021 17:23:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZs4Zw5k6Hv0-PDKtrqXpEhTDn9OjwDJDvwJvsXJWDUvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

08.08.2021 02:02, Linus Walleij пишет:
> On Thu, Aug 5, 2021 at 12:31 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> Combining my previous comments together, I rewrote it like this:
> 
> I like this, can you fold in your patch on top of mine, add your
> Signed-off-by at the end and resend to the list?
> 
> That way we get a clean record of the delivery path and also the
> patch looks like you want it :)
> 
> You can perhaps tag on v4 on the [PATCH] as well so it's clear
> for Kalle to apply this version. (Hoping Arnd will be fine with it as
> well.)

Alright, let's try that.
