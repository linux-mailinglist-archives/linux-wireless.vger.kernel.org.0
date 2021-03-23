Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E097345A87
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 10:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCWJOG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 05:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCWJNh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 05:13:37 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF77C061574;
        Tue, 23 Mar 2021 02:13:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e8so16916931iok.5;
        Tue, 23 Mar 2021 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=hUu76xvBuKlFUtxA4sEFLwZtnBeONf1UGq6mrYmq+do=;
        b=G7jTbDii/LboOW8tmRhRZapGx+LJoEdZ9fElgmms3ersZSkrRi6XNborl8LuVNMO7/
         4KnsL8zISN+f+k10rEgydHqJUanRrb4L1ago/n4yXQKY0SXCk/CF4Uj/Il+WeXfixSj9
         WAbaioscGzhtKYEoNJyzEetwLxpUyl40FY8YjdywC4taeeW9v9trAf/iiNHPQ/sAhJEn
         +R0crJAAMpS4RllyThucCRFteiFkFW34Q3qI4+ZXGA7Kor6zDYD6lXi0chxb3oXkidjb
         2i8YScKdtMKXvQmCigeOOGxd+LRURvrVJDKHRFD5H9vgowlvBD6JVT6XlrsSGUne0T77
         FFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=hUu76xvBuKlFUtxA4sEFLwZtnBeONf1UGq6mrYmq+do=;
        b=JbJz5LzV8FJFE1IqAEZX74IPGYBmm1FLIpq8PVGMFhpjluiDQnqf3TnNXU1Xb/aIfl
         0HjYSv3ghHDFH3fL3ngQVebReYUNOhMwI3vAY3JPko3+5Mj6KzP8CKM7BTSJXI2F39ao
         BI69ixlsCgF/pNAiLC+lmEG2qpeNiMiEm0sM01omR6ccZHbevtX4BrpzhvnA/dkLxE1D
         ctSo9IXfFoL9zAfX6MFUDuofAfyegrNDXxEA6uwPZwEYv0p/eK9xHGWYkEd6IBEJ+2JK
         HYMpsIWNZirbpxhKpV5jNG0CBToK81im83CnwLhtC6Af648rZ1dATUVk3xkUbAoC9KWn
         Gk/Q==
X-Gm-Message-State: AOAM531RVC0mam1i2b7adLHiqOkap+q/YHYfnD7v4cVf6RJNLggfPbPM
        03HvjOTcMJI0e6v8xNq4j9GfxY76zn2tUP/259s=
X-Google-Smtp-Source: ABdhPJy/iw32GvYyZ8GrFs0bVcF60DnRU9mR9mCPomSVX8taAezyBvnTsoOWf3OrgRO12U9MNCTRNcvcPUMUqU5u9Cs=
X-Received: by 2002:a5e:8610:: with SMTP id z16mr3379020ioj.57.1616490816696;
 Tue, 23 Mar 2021 02:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2103080925230.12405@cbobk.fhfr.pm> <nycvar.YFH.7.76.2103130242460.12405@cbobk.fhfr.pm>
 <87h7lfbowr.fsf@tynnyri.adurom.net> <nycvar.YFH.7.76.2103131642290.12405@cbobk.fhfr.pm>
 <f103b4a29b7c1942f091bd7b90d7a927d72c20a2.camel@coelho.fi>
 <87zgz7t246.fsf@codeaurora.org> <c1681fa49280189c48ecf9f86fe54b81d662dc07.camel@coelho.fi>
 <nycvar.YFH.7.76.2103221311560.12405@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2103221311560.12405@cbobk.fhfr.pm>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 23 Mar 2021 10:13:00 +0100
Message-ID: <CA+icZUWNbOpTXEy8SXMSJM=Or82gyVD8GUr10-A62dNtXa_Bnw@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Luca Coelho <luca@coelho.fi>, Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 22, 2021 at 1:13 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Sat, 13 Mar 2021, Luca Coelho wrote:
>
> > > > > > > > > It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs
> > > > > > > > > disabled (e.g. from LED core). We can't enable BHs in such a situation.
> > > > > > > > >
> > > > > > > > > Turn the unconditional BH-enable/BH-disable code into
> > > > > > > > > hardirq-disable/conditional-enable.
> > > > > > > > >
> > > > > > > > > This fixes the warning below.
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > friendly ping on this one ...
> > > > > > >
> > > > > > > Luca,
> > > > > > >
> > > > > > > Johannes is telling me that he merged this patch internally, but I have no
> > > > > > > idea what is happening to it ... ?
> > > > > > >
> > > > > > > The reported splat is a clear bug, so it should be fixed one way or the
> > > > > > > other.
> > > > > >
> > > > > > Should I take this to wireless-drivers?
> > > > >
> > > > > I can't speak for the maintainers, but as far as I am concerned, it
> > > > > definitely is a 5.12 material, as it fixes real scheduling bug.
> > > >
> > > > Yes, please take this to w-d.  We have a similar patch internally, but
> > > > there's a backlog and it will take me some time to get to it.  I'll
> > > > resolve eventual conflicts when time comes.
> > >
> > > Ok, can I have your ack for patchwork?
> >
> > Sorry, forgot that.
> >
> > Acked-by: Luca Coelho <luciano.coelho@intel.com>
>
> Sorry for sounding like broken record :) but this fix is still not in any
> tree as far as I can tell. And it's fixing real scheduling in atomic bug.
>
> Thanks,
>

[ CC Chris Murphy <lists@colorremedies.com> ]

A week ago Chris sent an email to linux-wireless with pointing to:

https://bugzilla.kernel.org/show_bug.cgi?id=212297

AFAICS, that is the same bug.

- Sedat -
