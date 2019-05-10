Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10E19D32
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 14:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfEJMZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 08:25:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46472 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfEJMZ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 08:25:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi2so2758459plb.13
        for <linux-wireless@vger.kernel.org>; Fri, 10 May 2019 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnVIZDxnd0kEyrDCPIaIICh1v6B5djz4lFgkebP+I0U=;
        b=ks6g1IZri8AzzL2Z/Sekh46nlKvX0lPLCP6q1vHc3VawPqG2JBFcUNQIbMhWVfRNck
         /g60XtjGD56oSr91jQlB/0vZcCLyCOeVcfFoIUIz0XuvSwpi2xuwCS0/EM/hMBtB2d50
         /6Rwih2UKTjYyXtBSFY8Rt7/dqy4eXiizaAGoT6YBAZAUCDM7NDW0x8U+ovpb7ZSRd9p
         3S9MVF9KPIN6zroUuD8lNa5PFbG49LBYSDupu1rXiQ5aiuOHOg18M2z0bNkO4i/cgODP
         vOKBFAHp6OXxrQA4Zdh9TxdBWU7TmEeVLK6yiv5ssaXttd8Dz9wHGvzwohyk131sj1vU
         wE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnVIZDxnd0kEyrDCPIaIICh1v6B5djz4lFgkebP+I0U=;
        b=B/mD43DKGCgGAi5cNcD8z9gCb6mNvO1iVddeqJvSeT2+ZEeT9Ln99ejO638Fd5NUEH
         C5Up65pgHR63vuWQm8fnKY094Ajtgk5o+LTCXW5E4L1MXVqWHVX//TyjtV3T68U3n56/
         6JYNHQcHWpND7Re8Pgvi+NY5CUM8q+qnv00/+Wvwz6d51gvcaKhYuA9GIQfflKrmB1Te
         OhNrLBd+r/rj7l1dqzVMdESaZR49yPMhr6IBBzD515U/hF8wccXSbpJ/bFR/FPQKxTEn
         X5SVRpjyQqt4T+2sc/+240IznoTG1YWpaKy5I4rDkBT4TAWVoD63gICBSfQa3L6Rs0Cd
         OJJA==
X-Gm-Message-State: APjAAAXyszhm/M/IjUeD8Aif6IAW6pyClWlp7x87wrMkTQcXNrC5EAct
        ofPKSxjov5AiWjz/QIlXufu3xE7RQ60rQcZjv0v+qD84IIs=
X-Google-Smtp-Source: APXvYqymw800JfAsq/fca67/PjD5ZO/DNdkah38J2POt71VwpmYcmFgZY9hcOodBnt4cn72VZwx8gC/PQBgnGj1upRY=
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr12658630pln.10.1557491128296;
 Fri, 10 May 2019 05:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <75ce3040b4086ffa2d2e088ad7f24f5e4a87be56.1523552145.git.andreyknvl@google.com>
 <20180604042900.GB31498@zurbaran.ger.intel.com> <CAAeHK+yvf-LqrfdQ18FMzaCNqdNHqAjgrDMrwUReZq8ei=hTYQ@mail.gmail.com>
In-Reply-To: <CAAeHK+yvf-LqrfdQ18FMzaCNqdNHqAjgrDMrwUReZq8ei=hTYQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 10 May 2019 14:25:17 +0200
Message-ID: <CAAeHK+wDMGOWYAegV20A5VpkwtT3_jFXSraT3LeueASzb8gEUw@mail.gmail.com>
Subject: Re: [PATCH] NFC: fix attrs checks in netlink interface
To:     Samuel Ortiz <sameo@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, Jan 2, 2019 at 4:30 PM
To: Samuel Ortiz
Cc: David S . Miller, <linux-wireless@vger.kernel.org>, netdev, LKML,
Dmitry Vyukov, Kostya Serebryany

> On Mon, Jun 4, 2018 at 6:29 AM Samuel Ortiz <sameo@linux.intel.com> wrote:
> >
> > Hi Andrey,
> >
> > On Thu, Apr 12, 2018 at 06:56:56PM +0200, Andrey Konovalov wrote:
> > > nfc_genl_deactivate_target() relies on the NFC_ATTR_TARGET_INDEX
> > > attribute being present, but doesn't check whether it is actually
> > > provided by the user. Same goes for nfc_genl_fw_download() and
> > > NFC_ATTR_FIRMWARE_NAME.
> > >
> > > This patch adds appropriate checks.
> > >
> > > Found with syzkaller.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >  net/nfc/netlink.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > Thanks, applied to nfc-next.
>
> Hi Samuel,
>
> It's been 6 months and this fix is still not in mainline. Did it get lost?

More than a year passed since I've sent this patch, it's still sitting
in the nfc-next tree which hasn't been updated since June last year.
Did NFC stopped being maintained?

>
> Thanks!
>
> >
> > Cheers,
> > Samuel.
