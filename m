Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141A235B70C
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 23:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhDKVhi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 17:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbhDKVhi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 17:37:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D602C061574
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 14:37:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w186so1156510wmg.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2N8ppbdTIHJd96OP32NRT/xio0kXQc9r97vw4I6brw=;
        b=GOqQtpeRfLyV8pwDr1hf588uGcPU1BwgNjUAWigXkK2UCVs89BeAwbeXDLhdX0CYlc
         4cMS6eurgNmMLcc4DbTbib7XNz/n+PMRtIgYB5Tw/pgXnKMbf1hJHWzSVr+pl9niVorm
         c4yrOpv6JfgaPjwdzrtOGhNhaWk0D2i1Aj+8Sj9vlj0FCsL7TJttcQwPQDcypZ3nxTX4
         tfCnuDluAr8k0Aw55hOemioy5jcSG/E2KKXM5nsfcX25z7z4lWRhVgVBmc1djNJPR15F
         bw7OuNohFMbzL+cRdG2qBRGlasUBVda/H3WOIn2jaPQDondNXpXLLFyMuoQ9mDKcpNMF
         1t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2N8ppbdTIHJd96OP32NRT/xio0kXQc9r97vw4I6brw=;
        b=H9AqEpJMMkwK+HdOdtNLkXMtiJFuA5ffxWfweHrBPaQSkJnJBciN7KWq8mBIu2G1cC
         RVBAqp0rvazkcfB5HFmvR0GalcAmXnAhuHgQHm/1RbEJzjVdebiuY7omo2P8b+GzLGOI
         NSNhKpqHoe006e5FqxnbWqRNwFoFyy1Re01dR9ObrT41VQ5qSNKuJW/R8BmLz67F9NAP
         VByUpyjdVcJ7ridd553AcEEPtF+oGFCcRmS27tmZAH/8P3E9I96eraFwqNf2fk6RETMw
         AtKiwGXP5BsSCsUCmhzX8sn3xx9i3U9oP2P1jukSUmr19AKt5xBqrJMd+M8bU9CZr7I3
         A3tg==
X-Gm-Message-State: AOAM531qQa9kg49k8BGvnHjHaM9Y4ZfOPYe2au30Az9sIZBbgBs7MNBz
        TD5L/MLBssSWI78bO7mfviuQG6als8OQprYfpE3SMg==
X-Google-Smtp-Source: ABdhPJxAX6KlShGYKaO/wmfvWA1RA1lsklk1Mt7qFTV7rlGgHBsTTE6KGGgX9iNqqWCfD6qt252RyoGrsbM+l61EAA8=
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr16419600wmj.168.1618177040051;
 Sun, 11 Apr 2021 14:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRuZ0hACdwH1N23OZrxEVyM2W9gn_O4wZRcFSq_74Gkqg@mail.gmail.com>
 <CA+icZUW-Ja4dDr8huyiwZrgCxf8vdxkYmP=tiueciJq5TAZsow@mail.gmail.com>
In-Reply-To: <CA+icZUW-Ja4dDr8huyiwZrgCxf8vdxkYmP=tiueciJq5TAZsow@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 11 Apr 2021 15:37:03 -0600
Message-ID: <CAJCQCtQTq4ddWnMpu0ZasZ=jxG8uTKAFK=Pz1YwtfZxvCYtH_Q@mail.gmail.com>
Subject: Re: iwlwifi, WARNING at kernel/softirq.c:178 __local_bh_enable_ip
To:     sedat.dilek@gmail.com
Cc:     Chris Murphy <lists@colorremedies.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 16, 2021 at 8:13 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Tue, Mar 16, 2021 at 2:50 AM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > Hi,
> >
> > I'm getting a warning, new with kernel 5.12-rc3
> >
> > [   14.156547] WARNING: CPU: 0 PID: 766 at kernel/softirq.c:178
> > __local_bh_enable_ip+0x97/0xd0
> >
> > This is with Intel Corporation Wireless 8260, and firmware version
> > 36.ad812ee0.0 8000C-36.ucode
> >
> > Bug contains complete dmesg attached;
> > https://bugzilla.kernel.org/show_bug.cgi?id=212297
> >
> > Thanks,
> >
>
> Hi Chris,
>
> can you try "[PATCH] iwlwifi: Fix softirq/hardirq disabling in
> iwl_pcie_enqueue_hcmd()" from [1]?
>
> Thanks.
>
> Regards,
> - Sedat -
>
> [1] https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm/


This appears to fix the problem.


-- 
Chris Murphy
