Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA7A72515B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 03:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbjFGBEt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 21:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbjFGBEl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 21:04:41 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6D110EA
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 18:04:35 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-19f8af9aa34so6936390fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jun 2023 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686099875; x=1688691875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXwjXNMu2VjXgBwTHsvAlgo8jZplNHwYMpy+GzueLGE=;
        b=CJDGSXCycqXHlGxoce/1HWVywIRtgHAr0SdnPUeAfIBIrdA1Gb8YKq9dcrH/pB2ETr
         8obwWx3UfS+U8H79Auj9to/8ZJ6DdJAALcj0eM/3m5rHvQPmtrCmTBzCcFGkunD66Ouw
         jMoGD0QCHzP1IlVri+xt83CEKuOWgSwUD93npUo0iuSv9wX7MiGOWjkItaJTRFD+vKEK
         CS1CSrLqOZKnzv5IXphN0t8bgicTr8885+btOFqvABeRDpAQAvIh7SsgEpZ2DbfGtTrN
         An2oX/3EwCfwCsMTcqWSXrY0iKpe3gVGZXrma5xefmUp4MUww1DWQE4kgL8xqe1sIacD
         kzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686099875; x=1688691875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXwjXNMu2VjXgBwTHsvAlgo8jZplNHwYMpy+GzueLGE=;
        b=FzVx4LpVkSac5bIHZNMWm39eNhQ5+GLkbhFvaRSwUzjbQX0iWsDBqfzdm6dSmBwyCJ
         VuQblf+Uz4xVCacLoZ7pa+CwwJxOoSkzreIZ+VQAuzzuVUWRlLpyboTtOvaq9lxVJlWK
         3kdW3ZGjSS2NPl7Rn8YeDbEl0T5uv2nRUJhCPcpmqf8hQbM/WhQ7VrDGADgZvCDViAGv
         dzEhpfUQxfBVfUh+XLhNxtFOhsOInjgN3QIYCNMibZOFEd1TeMecLFT2NXVLDK0ZftIi
         VSlW9kMmoCZ5tgK/q6EKvMmYwgjA4TBpZXCQV0FHeRWjolppTuUYJdh1iBCHmkZ7zHUQ
         IbjA==
X-Gm-Message-State: AC+VfDxtnkIwnHhnrZj+eCB3Xi0fZNxcT8DseFuuXqE3csbMPazz9t4Q
        Pvkysv5+dtodVrg0xoDak2KIlgXS8NfUzEldq9Jq0R2lbkM=
X-Google-Smtp-Source: ACHHUZ42+PLYGIvvo4D7hkhHzFonl4w41whxUPD2DlEUiJ8s0CspqPwK+06KlfPR3UrNr1YNqW9+yNVxtHLoYvmawRI=
X-Received: by 2002:a05:6808:7c3:b0:39b:6f01:babb with SMTP id
 f3-20020a05680807c300b0039b6f01babbmr3610865oij.58.1686099874868; Tue, 06 Jun
 2023 18:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com>
 <CALKa4bQ6quTd6PoHCt9wQ-x6LznzmSz3Vbw1aOTc21USgdnctQ@mail.gmail.com>
 <f622ae86-eead-b22c-10d1-c098754c34db@lockie.ca> <CALKa4bRr8z7FowCtZ-rSR0XMNEyoRbYsDu+Mswc-gs+s9Z0U=w@mail.gmail.com>
 <d443a746-106f-4626-85a8-deefe318b46a@lockie.ca> <1bafa8c6-fc0f-2928-712d-c24dc0a6d18a@lwfinger.net>
In-Reply-To: <1bafa8c6-fc0f-2928-712d-c24dc0a6d18a@lwfinger.net>
From:   Utkarsh Verma <utkarsh.naveen@gmail.com>
Date:   Wed, 7 Jun 2023 06:34:22 +0530
Message-ID: <CALKa4bTJMQqhH5rDcReMWehdc1=Dj3J+danGToMpqe0hj6nNSg@mail.gmail.com>
Subject: Re: RTL8822BE not working after suspend
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, James <bjlockie@lockie.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

Thanks for the clarification. I tried the rtw88 drivers as you
mentioned, and the card works for me after suspend finally. Although,
I did need to use the suspend scripts provided.

I have a small request from my side as a user. Please mention on the
GitHub repo that these drivers are not in the kernel yet and will be
merged around Linux 6.5. This is because I stumbled upon this repo a
couple of times before as well, but I did not trust it enough and even
thought that they might be older than the kernel's drivers.

Additionally, is there any way we can have this working without the
systems module loading/unloading shenanigans? I would love to see this
work by default, as it does on Windows. I can help you with the driver
testing if you wish.

The bug which happens after suspend is, as you mentioned, the card
fails to change the power state from D3cold to D0.

Thanks a lot.
Regards,
Utkarsh

On Fri, Jun 2, 2023 at 10:34=E2=80=AFPM Larry Finger <Larry.Finger@lwfinger=
.net> wrote:
>
> On 6/2/23 08:59, James wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D216386
> >
> > You could try https://github.com/lwfinger/rtw88
> >
> > Jun. 2, 2023 00:19:28 Utkarsh Verma <utkarsh.naveen@gmail.com>:
> >
> >> I had been using Linux v6.3.5 for a while and switched to v6.1.31-lts
> >> only yesterday, hoping it might work. The same issue happens on newer
> >> kernels like Linux v6.3.5 as well.
>
> Utkarsh,
>
> Although James top posting made it difficult to send this properly, he is
> correct to suggest using the rtw88 repo at GitHub.com. It contains code t=
hat
> will not be in released kernels until v6.5.
>
> Most systems handle suspend or hibernation correctly, there are some that=
 do
> not. To my knowledge, all of these have been recent HP or Lenovo laptops =
where
> the BIOS does not handle D3HOT to D0 transitions.
>
> If using rtw88 does not help your system, your best resolution is to inst=
all a
> script in /usr/lib/systemd/system-sleep/ that will unload the driver befo=
re
> sleep/hibernation, and restore it on resume. Repo rtw88 has scripts for a=
ll of
> the PCI drivers, and README.md tells you what to do.
>
> Larry
>
>
