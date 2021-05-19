Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A53899FB
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 01:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhESXmn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 19:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhESXmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 19:42:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8434DC061574
        for <linux-wireless@vger.kernel.org>; Wed, 19 May 2021 16:41:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j10so21607684lfb.12
        for <linux-wireless@vger.kernel.org>; Wed, 19 May 2021 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zA7CnL9dQSxKOznAmz1nRpcMB24lJb+0AOSFAkhWXAg=;
        b=lvmj8ZGlFsvUdD11DYlYOwesHcwNvqzCG+aT1Yt7azdijuuCiDnYhf5AYqWHI0nNxR
         dky6VKTHVRWpAz0IVdR/y2lUW7aY8sqM9fWqjie3+/A+lB7CjM0EiJB9Mp/nggBo0lrA
         JhguXYzGPPnTMtNMMqIb2ROvYvNGEpZxKtXmvom92NnNeTcaFp2HlFlEsN6yTjkIIUCZ
         Ds4takiYrgX8FgDsJsCI/cviBM0/mi2Y2p2XpmFqW6+fr/bP565jsFGxMKKW83M/x4UL
         KkUEJt665rmSkTWzZ4kh/oSE4Sv2LYuKU7bWdI1ClF1PqyiUpb/NH+cDaVHwEFa67M1Z
         oV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zA7CnL9dQSxKOznAmz1nRpcMB24lJb+0AOSFAkhWXAg=;
        b=AW/urA3sTHFc3VLOEIRmUp5An5hclY+lCct0m62TgxQaMVglxC5ofzDgI3lZraFdZ7
         p/1uKbi/jHogMLwd9RikyLZvbYSmXwPJ63LgYs67975FTPvSowYmxrkSIz1SJa6taHkz
         iNoamWdpAA8mrixVuAGELTHzPhDFe5MkoJNCuF1cFzQPYP99J6KEMrA69fhlS8gnP0fL
         r0ZWM1ne9FoYyVHjUWH4WUwsvXhIArLPoIzOV4UES3QgbTLzPE2bKaY20/KOUmpQZ9PY
         ljuTIN0/HqdRswX0jPT4mSjht8rYOK8cVC0vrQmpHkDPReEaN0SCyPYFT3Gckw01GxAL
         YoWw==
X-Gm-Message-State: AOAM5316Q66HQDx6g5ZIWILTeJBeX6VojgPoBVWbxx0I9c/nUJHYiudi
        8A7m2esvHPEqN0k11t+hIs5YwsJrxdcoGLK9GZtcaw==
X-Google-Smtp-Source: ABdhPJyKCqG8XvrGY+BHuSfjdddFvHI8jCH6NdNwRG7Y1bGuqZHkbkv6XeTxl2L1KN+1z+yHZ2MwfmVWwqIQJCbB8us=
X-Received: by 2002:a19:ef10:: with SMTP id n16mr1056412lfh.649.1621467680897;
 Wed, 19 May 2021 16:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210509224226.348127-1-linus.walleij@linaro.org>
 <c5370b69-eac2-815e-27cb-f865a7885830@broadcom.com> <CAPDyKFq6PEx9YNF5VDjEy2giLOe=NJPxM2KCAWOOQxeGR_3jMw@mail.gmail.com>
 <30a7bbeb-d588-4780-bd6c-d99f72898138@broadcom.com> <CAPDyKFpiXWygrBBHzGXBU2dC3SuxC3Uj868BAgagbv8FMmyGeQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpiXWygrBBHzGXBU2dC3SuxC3Uj868BAgagbv8FMmyGeQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:41:10 +0200
Message-ID: <CACRpkdY9RUc78dj7sw5_A5XJwpbYROzaq1ziYmN2=cqs_AJfrw@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Obtain reset GPIO
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 11, 2021 at 10:48 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> I think this boils down to that to allow the mmc core to detect and
> initialize the SDIO card, it needs to manage potential reset pins as
> well.
>
> In cases when the SDIO func driver may need to execute a reset, the
> mmc core provides two APIs, mmc_hw|sw_reset().
>
> Does this make sense to you?

I think so, in this case (Samsung Janice on Ux500) the boot loader
desserts reset so we are fine, but I think it should be utilized properly
somehow, the vendor went to lots of trouble to put this reset line
there physically.

What is my next step? :D

Yours,
Linus Walleij
