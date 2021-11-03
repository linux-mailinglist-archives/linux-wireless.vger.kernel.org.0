Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FCA444859
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 19:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhKCSjF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhKCSjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 14:39:05 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785FCC061714
        for <linux-wireless@vger.kernel.org>; Wed,  3 Nov 2021 11:36:28 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so4804345otf.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Nov 2021 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hSioDWyJC1XuSNB5d2/2eDny4thKJlnYlP184y8q0mI=;
        b=TPp/YIH7HMBf4BHwl5n03ifmyIivMXOef0+oAWRWrDvQ7wZQC8GdhEhkGFpFbdjKul
         C9LJ1j7MEA/hLRqHwJHKeAHy+v7/suWjhWKf6YhjK70LPIa+i/ciNLJbU88wfiXBQQco
         waGRBl45/YdskKnjCwyvm/kjZ+v0FKZNAf0BVHF5a44eoOvRlgU5s5fS/Mt96QAOZRK/
         mrNBzjTVKiiX7tp5hWTCduA7NFwZhT8PF+gmR0/uSIYjWo20LW/nREbcRD3cBfMFftAZ
         6zorIDy+VsfWpN+99igulNnPt/nwgZDZZZae8lvCSpJb51LNWa9u6TuhrjWob3/EfYPR
         4sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hSioDWyJC1XuSNB5d2/2eDny4thKJlnYlP184y8q0mI=;
        b=fgG2NND/XMostqsfSJtoloJyyZHxjwUNs+tmqe6FlXEOKcnKGv9l/m7FX7ojQfbq1l
         Y/jRfGm/5DvMjqanuvlEBZOy+hVi98AmFp6LhzCsk7hg3nugi7qFluqAmG2vfLqXkkSf
         cAOqw5TdjXGLZZ//mTxaAN1s+WWp3EQ4D6XRZz0XHgbt822rhlu0Bl/LAjN2GNIuBrvf
         Yf1MKS3oXykUMyrofY3L0t3HZD5pnuFRSsyHv3nMNkzuhu27eYy5knB5BVPBxWd6SJso
         3bTmw5oFbPlZJzHWZo/x7xUjSTAbuBbCrexqeLJ7YZxCj/gx8+9v/GgAnUFUJ5YB/lbe
         v9rw==
X-Gm-Message-State: AOAM531NBohdwPFU5bjVZovk3mcBbTzyEV+/rGl2WaVd7WDA5mpy95f9
        pUTgSBT1IovJ4ZBqp69icMI=
X-Google-Smtp-Source: ABdhPJwBroxvM08KdwhMBb7CeyZIMezcaUOfBfBttBR0QsS/w+y0nmyz0Lo5tPu7zxME2zjlf6xbkg==
X-Received: by 2002:a9d:68cd:: with SMTP id i13mr6526790oto.142.1635964587884;
        Wed, 03 Nov 2021 11:36:27 -0700 (PDT)
Received: from [192.168.1.103] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id i205sm794409oih.54.2021.11.03.11.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 11:36:27 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <514c3786-a00f-365d-b936-0f3d03d0034c@lwfinger.net>
Date:   Wed, 3 Nov 2021 13:36:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: No support for Realtek 8821CE RFE Type 6
Content-Language: en-US
To:     Bogdan Nicolae <bogdan.nicolae@acm.org>,
        Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CA+ORkNR97EvqPzHu-CoJXwKGH-HQ4B++57RE88MEF-mG=D=Jeg@mail.gmail.com>
 <46a80ab50f594ec1af1016ca272e82fd@realtek.com>
 <CA+ORkNQ_shEZGYQUmRT-_uSp3xkFA2fvfUbyGXzGkP6AmqXf6Q@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CA+ORkNQ_shEZGYQUmRT-_uSp3xkFA2fvfUbyGXzGkP6AmqXf6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/3/21 12:25, Bogdan Nicolae wrote:
> The Realtek Wifi 8821CE RFE Type 6 is used in a broad range of
> embedded systems based on Intel Celeron J4125 SoCs. A popular example
> is GK3 Mini PC, sold under a large number of brands, for example:
> https://www.amazon.com/gp/product/B09FTCPBHK/
> These systems are rising in popularity in favor of laptops, as people
> tend to stay at home and are looking for affordable upgrades.
> Unfortunately, lack of Wifi Linux support is a major drawback.

Bogdan,

That is a very interesting piece of hardware at $200. Does that quad-core 
Celeron have enough power to handle Windows 10 with reasonable response? I used 
to volunteer at refurbishing donated computers for resale to low-income users. 
When Microsoft's refurbishing program stopped supporting Windows 7, we 
immediately stopped installing Windows on anything lower than an i3. Quality 
machines with less than that processor got Linux. Those machines were free to users.

Larry
