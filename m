Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9356924C3E7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 19:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgHTRAz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgHTRAm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 13:00:42 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824DC061385
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 10:00:41 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id e14so1492382ybf.4
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ielpATpoxC175HlYVPaZRtGDG6wSM3NX2rG0U8KO0UY=;
        b=OFGFrB6vca/XtMglGGZg2XKNmwxfBv0Mn1uwyAtX1jQ31VEUPu+aUij6QbloZhxh1J
         SIjYaXz0jrbJZd7XZN8iZhPJIfS0IVJ9/O2u2tk7LFon+SwPs/OD2L+8435k0JECCJn0
         B4trMKLLoBa4CELX4Cj2KlW3qF2SjU/ZP6s15rqDbJixNY4Sdl2pMkxBbFYAHZ1tnu6E
         EeAefEkbZhzsVZBbTk7pm9xwiIaHNoDSpAwkVleud7YLNlsqg6Fw/NIN8BODYAQFnphl
         BwA40Ls+MDXuoJIUJzorWmEHAIqvjk/PrAT79/2jdOfVxxenLaPgcz+ymJTSQeiltgW3
         OsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ielpATpoxC175HlYVPaZRtGDG6wSM3NX2rG0U8KO0UY=;
        b=fO4i8O1/6hqKTeKjGwD/FPxEVUE/SNOUIgQN7m66sD0dG1Q8+ZKWNav1S+ChHBE0On
         SvdPTyG/c8j2meuVrTKzo4gWSczquN+H9qFCdZU2idKouFIo3TqipjfrelbddtmFboaF
         lB1/zV0cSf9dCQjHGb8hs7CB4YasworTwLcc7xinfgXPgIVgL/ER/EPgCNjmEVTVmhm6
         Dej4tYU6Aak3TkeqKVSe1fPQCgfgO+k4sUcFbPq6Uhm0N7RkYFn+4yrYHWzuWazkJZWa
         w5BQo3es5BJIN2ZGAXEzCJT8ITlcTIM2a+NI4G+ohsQUkNa49DDKnm+aLHBg4FaYin7f
         gAYA==
X-Gm-Message-State: AOAM530jtA8PiqjE+3I0FQKGwhtcEMMj7xBo7yE5lKYPxNZMv2/O+9SP
        JkP/e+rJcYOPK4b9RDFoIx6kQZdOHJ4+nzajAWU=
X-Google-Smtp-Source: ABdhPJyNQMMD2zR8BWTB1wL+EHZM+sQMKgXyMKJJQec1TwpoaXaBC9NtlevNEH0jJP9IfzF3QpTCyJtijgaDUtvqS5s=
X-Received: by 2002:a25:1943:: with SMTP id 64mr6213588ybz.14.1597942840261;
 Thu, 20 Aug 2020 10:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200214035555.24762-1-wgong@codeaurora.org> <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
 <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org> <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
 <dcc45384935dca14ac6ab31ec1123414@codeaurora.org> <CABPxzYLu_81h+aWWeNKRyH=CJ=+waB3zmT41BTZ9Mo733PqErQ@mail.gmail.com>
 <acb2bd58-2f95-e09c-9575-b45c0e2aeb70@candelatech.com>
In-Reply-To: <acb2bd58-2f95-e09c-9575-b45c0e2aeb70@candelatech.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Thu, 20 Aug 2020 22:30:28 +0530
Message-ID: <CABPxzY+tPos8ByT76hU1ngoxwYcBHaRpFMCKGQJcc_ssoqGNSw@mail.gmail.com>
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
To:     Ben Greear <greearb@candelatech.com>
Cc:     Wen Gong <wgong@codeaurora.org>, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 20, 2020 at 10:02 PM Ben Greear <greearb@candelatech.com> wrote:
>
> On 8/20/20 9:08 AM, Krishna Chaitanya wrote:
> > On Thu, Aug 20, 2020 at 8:07 PM Wen Gong <wgong@codeaurora.org> wrote:
> >>
> >> On 2020-08-20 18:52, Krishna Chaitanya wrote:
> >>> On Thu, Aug 20, 2020 at 3:45 PM Wen Gong <wgong@codeaurora.org> wrote:
> >>>>
> >>>> On 2020-08-20 17:19, Krishna Chaitanya wrote:
> >> ...
> >>>>>> I'm not really convinced that this is the right fix, but I'm no NAPI
> >>>>>> expert. Can anyone else help?
> >>>>> Calling napi_disable() twice can lead to hangs, but moving NAPI from
> >>>>> start/stop to
> >>>>> the probe isn't the right approach as the datapath is tied to
> >>>>> start/stop.
> >>>>>
> >>>>> Maybe check the state of NAPI before disable?
> >>>>>
> >>>>>   if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
> >>>>>    napi_disable(&ar->napi)
> >>>>> or maintain napi_state like this
> >>>>> https://patchwork.kernel.org/patch/10249365/
> >>>> it is better to use above link's patch.
> >>>> napi.state is controlled by napi API, it is better ath10k not know it.
> >>> Sure, but IMHO just canceling the async rx work should solve the issue.
> >> Oh no, canceling the async rx work will not solve this issue, rx worker
> >> ath10k_rx_indication_async_work call napi_schedule, after napi_complete,
> >> the NAPI_STATE_SCHED will clear.
> >> The issue of this patch is because 2 thread called to hif_stop and
> >> NAPI_STATE_SCHED not clear.
> > That fix is still valid and good to have.
> >
> > ndev_stop being called twice is typical scenarios (stop vs rmmod), so
> >   just checking the netdev_flags for IFF_UP and returning from hif_Stop
> > should suffice, no?
>
> My approach to fix this problem was to add a boolean in ath10k as to whether
> it had napi enabled or not, and then check that before trying to enable/disable
> it again.  Seems to work fine, and cleaner in my mind than checking internal
> napi flags.
A much simpler approach is just to check for IFF_UP and skip NAPI (and others)
in the hif_stop no? (provided proper RTNL locking is done if hif_stop
is being called
internally as well).
