Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC81B3F51F7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 22:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhHWUUb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 16:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhHWUUb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 16:20:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B603C061575
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 13:19:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s12so8438098ljg.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0vaj0uznqYe2FBJmFOITTJ3IqWEuG169317oUglvcEY=;
        b=OtuDeDNUrV3Rzk/bqFdRCFW++lG/hxojlu0nhwhJ+N6MH8Klju7+XzQ4GPEvbEJj4s
         7jPo+P/J8AfRNOswbzuSfWcDQQvLnWoomlHvoxKoOiSbO6EKb8LLGgQBU2rrlB8g96RT
         fhvZ7uBvosEEGqt5o0FGOMsBvQOjsXMOuifN/lXC/kcZPuNb1fYBIggHBfejJ5s7z0V9
         811Dm6zLSqT06sb8jU9V6cNet5dOOHnmxTjyuW7Nm6s3YoRN5D9VhRpJfAoteBwZNUsH
         GTqk15EYOdCGz/vtnXMZnvP7M2dhWcwXSPio/StYPE2C9SkSib0ckhpH4NZ/XSmzhDS7
         EUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0vaj0uznqYe2FBJmFOITTJ3IqWEuG169317oUglvcEY=;
        b=aJS9T2a+kS2W6FnhF56UGHn7vj0A+XdD8HwQNMnoDM3qyy1AVBluw44KGIP8qP84IX
         vQ9+qOvuxNuVuI1e/UG45C/fBapN4JlflI85Fz0R4rHLWkVX8zpdDxD8uORpO7fjZY3f
         aw39ejnU2QpAoD8Gri92dR8i10zbgxWD0C7fhe1OD46350xg5CU6bSwQFq7ZTP3PW7vr
         Pqk6F4SWG/KtmD4lAlpW5vsQOgciD7eEMEIxyzhzzy8k+BsF5PWeDrYyjmyzoszicRUS
         prWNQJikK96xMmB0rTVTrHJ+TAjCn+rpxu7vmQSrYlrANvzZC17qFfeGuSHrbcTI9f+Y
         5Ibw==
X-Gm-Message-State: AOAM531liXnf5ox1sTwhInnPWnCqqGrhOh95Po7XfrVgfB1qE6JuHqZD
        UMLbSgNWUKnJ8223kXlShAc=
X-Google-Smtp-Source: ABdhPJwVfQcHNGRhsCMeMkAJgni0sp5/uJ0FX2VPazA3Al25tmUcQGNsQu0/6f7rxszKJFFH5QcSBA==
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr29323870ljn.349.1629749985913;
        Mon, 23 Aug 2021 13:19:45 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id j20sm1288275lji.41.2021.08.23.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:19:44 -0700 (PDT)
Date:   Mon, 23 Aug 2021 23:19:43 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Julian Calaby <julian.calaby@gmail.com>, svp <svpm@yandex.ru>,
        felix+debian@gueux.org, Massimo Maggi <me@massimo-maggi.eu>
Subject: Re: Revert: ath: add support for special 0x0 regulatory domain
Message-ID: <YSQC32TygIq2SHJR@skv.local>
References: <YSJ//ki/A1EgfLga@skv.local>
 <CA+ASDXNzv6D1PthjUU-CVw6amT+JHmJP2mNSL=LVJKGm0zkEXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+ASDXNzv6D1PthjUU-CVw6amT+JHmJP2mNSL=LVJKGm0zkEXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21-08-23 10:23, Brian Norris wrote:
> On Sun, Aug 22, 2021 at 9:49 AM Andrey Skvortsov
> <andrej.skvortzov@gmail.com> wrote:
> > 4) As many users are affected by this problem and maintainers don't really
> > want to revert the problematic patch,
> 
> I'm not totally sure that's true. So far, it looks like an oversight.
> 
> Over a year ago, Kalle said he "just need[ed] to check something
> internally first":
> https://lore.kernel.org/linux-wireless/87r1rsbdnx.fsf@codeaurora.org/
> 
> I don't see the result of that, except that this is marked Superseded:
> https://patchwork.kernel.org/project/linux-wireless/patch/20200730124923.271429-1-alsi@bang-olufsen.dk/
> and this is marked Rejected:
> https://patchwork.kernel.org/project/linux-wireless/patch/20200527165718.129307-1-briannorris@chromium.org/
> I'm not sure if the Rejected was before or after the last reply above...
> 
> Maybe it needs an Nth person to submit a revert?

Later (Dec 23, 2020) said "Actually I don't see how I could apply the
revert due to the regulatory problems explained by Jouni". [1]
I think this could be the date when your patch was marked as Rejected.

1. http://lists.infradead.org/pipermail/ath10k/2020-December/012370.html

-- 
Best regards,
Andrey Skvortsov
