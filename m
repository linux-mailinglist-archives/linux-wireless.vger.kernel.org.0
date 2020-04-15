Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DDD1AA8DC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636189AbgDONjg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 09:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633321AbgDONjb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 09:39:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79155C061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2020 06:39:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r17so2675433lff.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2020 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYbKtTdIlAS2MrOYv3ktp5ynh9zmAurxtliyxz228HM=;
        b=kNmfCTMrncJz3Mf/q8c7XdNw/+aM367/99PvPs2dC40uoDdbWKW1e5Ka1VrjrIIXZN
         EWKQAeD41UH7JTlXSR2Oni+zm12n4KErP+aTQMcwUQTWszpBTKmX4onmjQL50Dec0ulk
         Oi6VJylUjzXADIznlAe70TVHYFljOlYz5pmYHnDSHHRsshUyyxJR06c+zQkapSjGMpB2
         GtKLORJXT3ydl4ITIvKl3QV77AjyB8MZPzxUdClUdDGnVVgideHJufH3CidXt3Wct8cI
         VK11gylh6XQ1fno/KgxM+rHfVxV2tTg4uxUIPx6NlgWkQ/s19QJrUOzUUOsOInQ5q4B/
         ZY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYbKtTdIlAS2MrOYv3ktp5ynh9zmAurxtliyxz228HM=;
        b=Ucdq7F9k70e4wv+f1OsxqEpU4MNhSdQ7cezyhV/nDPte3P1geWKg+j1I7nqKBWjLoR
         21vxUeAifjf6jtbShG5wayzPILaiQOsRrXz/5XUROmr1R2pqDbfvBdg/+lSmsXlwKx1z
         z590wCPbVZsg6vRkpcNHFm4xJeOuX12kwYtNPA1fTlB+z/i09kEA/EFuYKO/krCCubAQ
         xJh/mVOAi/Ha0fcxkAayqim9BiRH97VKgJ7+V/ExEACZ0K+cUBbNfPk25Y/ZgN2zoYUN
         sA7QSJ/XJhsEXiVG+gaPj/MofFEKb3udxwCVNShpYIDnlSjSYkAiYeDsrjYtabROYfEP
         Uq1g==
X-Gm-Message-State: AGi0PuaN7GEI5KqWtyP8dQgMf0IdLmqvgf7pr5pTTZ5+uMA5KSFpQWx3
        rKxqHMtR3HCGCLJa2zkPv+oca/Ic0qXOrrzshc9u4A==
X-Google-Smtp-Source: APiQypKspEOb/rj3icJNNhJ9x/jVreqO36OImyQUXuDaYRNwL1zpsCDOBI49RUO4ArSUzLvFrl5EOyBzPKgoU8LVqX4=
X-Received: by 2002:ac2:4c34:: with SMTP id u20mr3207171lfq.40.1586957969813;
 Wed, 15 Apr 2020 06:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <1586254255-28713-1-git-send-email-sumit.garg@linaro.org>
 <CABPxzY+hL=jD6Zy=netP3oqNXg69gDL2g0KiPe40eaXXgZBnxw@mail.gmail.com>
 <CAFA6WYMZAq6X5m++h33ySCa6jOQCq_tHL=8mUi-kPMcn4FH=jA@mail.gmail.com>
 <CAFA6WYOW9ne0iffwC1dc48a_aSaYkkxQzyHQXTV2Wkob9KOXQg@mail.gmail.com> <CA+icZUUDm=WPjmwh5ikp8t+xt7dqTgghCeB8F0+czaUh-sHXxA@mail.gmail.com>
In-Reply-To: <CA+icZUUDm=WPjmwh5ikp8t+xt7dqTgghCeB8F0+czaUh-sHXxA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 15 Apr 2020 19:09:18 +0530
Message-ID: <CAFA6WYPdJMt-h=9HrV-DcHZnO7xCu74Dh9FuRMnp16qhotyo0g@mail.gmail.com>
Subject: Re: [PATCH v2] mac80211: fix race in ieee80211_register_hw()
To:     sedat.dilek@gmail.com, Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Matthias=2DPeter_Sch=C3=B6pfer?= 
        <matthias.schoepfer@ithinx.io>,
        "Berg Philipp (HAU-EDS)" <Philipp.Berg@liebherr.com>,
        "Weitner Michael (HAU-EDS)" <Michael.Weitner@liebherr.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 15 Apr 2020 at 18:49, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Apr 15, 2020 at 3:10 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> [.. ]
>
> > > In case we don't have any further comments, could you fix this nitpick
> > > from Chaitanya while applying or would you like me to respin and send
> > > v3?
> >
> > A gentle ping. Is this patch a good candidate for 5.7-rc2?
> >
>
> Hi Sumit,
>
> it's in [1] (see [2]) with slightly mods by Johannes but not in Linus tree.
>

Thanks Sedat for this information.

> Johannes requested a pull-request means will be merged in a next step
> in net.git and then hopefully land in Linus tree after Dave M.
> requested a pull-request.

I didn't get this PR notification as currently I am not subscribed to
linux-wireless ML. So apologies for the noise here.

BTW, thanks Johannes for picking up this patch.

-Sumit

>
> Thanks for your patch.
>
> Regards,
> - Sedat -
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/tag/?h=mac80211-for-net-2020-04-15
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?h=mac80211-for-net-2020-04-15&id=52e04b4ce5d03775b6a78f3ed1097480faacc9fd
