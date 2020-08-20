Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A128124C4B7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 19:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHTRmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 13:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgHTRlo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 13:41:44 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB0C061386
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 10:41:43 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id q16so1555557ybk.6
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyX3R1AKP6JirtUc1Xq7LP0pQ3j6g8z4OI4gzACWuuM=;
        b=lf9B50+C2qeZdZvA8Jx/CU3xIilL3xpMaMLYrlej5+qzVyvN0MTTXPtdXlX+A9OCkO
         X9t1hJ7OcTmXYFNXOAr5OBSa+2eLqH6AZ9Jy4maqdEP5PO5ww7A2lMPTzkzz2Pdq0ddl
         wQ0LIYP13yVhwhfVaYUOcFd4vzxhQrPiW3LtbbU1oYIpiWC+okKnt8kQHKPoXQuj9gug
         c7K+v+hvjzLZal2zl3SacaXEgHo6P+YroTgwD8vcCu52DuakaTOLvQulQWQYA6uDnQT8
         z3aAt8Dej+0tpvU2hcb5rRsqWaKgG8H18XmPKCqObBRSM/jfAXhdTLQXJtACp9I28IZO
         3ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyX3R1AKP6JirtUc1Xq7LP0pQ3j6g8z4OI4gzACWuuM=;
        b=jLwexKJz1/K/lFERSftg57ZrB8dDvH1b8u/Hk8QNeqbxbV2WktPZc0i2qv5pCrsAfc
         ZG4qH/zHOOakOHHAXJ96nM4W8HWEb4RjzbfAbSP92rqsHERFrMQ66sUay3qNVq8FreIs
         MSzobQZ6etzdU0ozr2aKmsDkfhG8eDNqnhefTEqOiKtxFx81pusqzKx9QKhLTBStD2Ir
         A+lnh7lsLOzmA5IGvIkDHyPd3hBBnv/s7GNY2JgjUiM9B41eJ+Z4ic+xnmSaezPQ+Q2G
         MHvIE+YG9yIty5SwR783ewJi/0rJfBdE2JQsi4PQefj9YuKQDuEm4yhAut+v4kC5H18o
         Y0fQ==
X-Gm-Message-State: AOAM530zZUoqyM01yNghCAH41s+5QO7JPOw4dd9BNtQqzH8C0nKbNhYD
        Ax/88aAajNKAE2cdgfsBayOfbSBc2MZzPUow8XHA+mAf
X-Google-Smtp-Source: ABdhPJwkjixMq1Pwt/JBpr+Gyh9E+tyFFna/Dics0Emb+q/tNW3ZN8F3ea9Qb7H0wJBxqf9XZzioCC5QHdwB5riSMhw=
X-Received: by 2002:a25:d387:: with SMTP id e129mr6570128ybf.370.1597945302213;
 Thu, 20 Aug 2020 10:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200214035555.24762-1-wgong@codeaurora.org> <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
 <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org> <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
 <dcc45384935dca14ac6ab31ec1123414@codeaurora.org> <CABPxzYLu_81h+aWWeNKRyH=CJ=+waB3zmT41BTZ9Mo733PqErQ@mail.gmail.com>
 <acb2bd58-2f95-e09c-9575-b45c0e2aeb70@candelatech.com> <CABPxzY+tPos8ByT76hU1ngoxwYcBHaRpFMCKGQJcc_ssoqGNSw@mail.gmail.com>
 <47c1b1e0-afc4-b9b4-5fc0-4636d8b3b981@candelatech.com>
In-Reply-To: <47c1b1e0-afc4-b9b4-5fc0-4636d8b3b981@candelatech.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Thu, 20 Aug 2020 23:11:30 +0530
Message-ID: <CABPxzYLD-M5wpWF6r=K=8YTosSfjctmaaBPCyBP72q-mY0PTcw@mail.gmail.com>
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

On Thu, Aug 20, 2020 at 10:38 PM Ben Greear <greearb@candelatech.com> wrote:
>
> On 8/20/20 10:00 AM, Krishna Chaitanya wrote:
> > On Thu, Aug 20, 2020 at 10:02 PM Ben Greear <greearb@candelatech.com> wrote:
> >>
> >> On 8/20/20 9:08 AM, Krishna Chaitanya wrote:
> >>> On Thu, Aug 20, 2020 at 8:07 PM Wen Gong <wgong@codeaurora.org> wrote:
> >>>>
> >>>> On 2020-08-20 18:52, Krishna Chaitanya wrote:
> >>>>> On Thu, Aug 20, 2020 at 3:45 PM Wen Gong <wgong@codeaurora.org> wrote:
> >>>>>>
> >>>>>> On 2020-08-20 17:19, Krishna Chaitanya wrote:
> >>>> ...
> >>>>>>>> I'm not really convinced that this is the right fix, but I'm no NAPI
> >>>>>>>> expert. Can anyone else help?
> >>>>>>> Calling napi_disable() twice can lead to hangs, but moving NAPI from
> >>>>>>> start/stop to
> >>>>>>> the probe isn't the right approach as the datapath is tied to
> >>>>>>> start/stop.
> >>>>>>>
> >>>>>>> Maybe check the state of NAPI before disable?
> >>>>>>>
> >>>>>>>    if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
> >>>>>>>     napi_disable(&ar->napi)
> >>>>>>> or maintain napi_state like this
> >>>>>>> https://patchwork.kernel.org/patch/10249365/
> >>>>>> it is better to use above link's patch.
> >>>>>> napi.state is controlled by napi API, it is better ath10k not know it.
> >>>>> Sure, but IMHO just canceling the async rx work should solve the issue.
> >>>> Oh no, canceling the async rx work will not solve this issue, rx worker
> >>>> ath10k_rx_indication_async_work call napi_schedule, after napi_complete,
> >>>> the NAPI_STATE_SCHED will clear.
> >>>> The issue of this patch is because 2 thread called to hif_stop and
> >>>> NAPI_STATE_SCHED not clear.
> >>> That fix is still valid and good to have.
> >>>
> >>> ndev_stop being called twice is typical scenarios (stop vs rmmod), so
> >>>    just checking the netdev_flags for IFF_UP and returning from hif_Stop
> >>> should suffice, no?
> >>
> >> My approach to fix this problem was to add a boolean in ath10k as to whether
> >> it had napi enabled or not, and then check that before trying to enable/disable
> >> it again.  Seems to work fine, and cleaner in my mind than checking internal
> >> napi flags.
> > A much simpler approach is just to check for IFF_UP and skip NAPI (and others)
> > in the hif_stop no? (provided proper RTNL locking is done if hif_stop
> > is being called
> > internally as well).
> >
>
> I'm not sure, but I think the driver should be internally consistent and not
> spend a lot of time trying to guess about interactions with objects higher
> in the stack.
Fair enough, the network interface state is a basic thing controlled
by the driver,
so, should be okay to use. Anyways, the in-driver approach has more control.
>
> Here is my original patch to fix this, it is not complex.
>
> https://patchwork.kernel.org/patch/10249363/
Sure, I have shared your patch above :).
