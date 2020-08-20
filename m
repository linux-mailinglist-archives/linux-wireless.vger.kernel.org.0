Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518C024C6AE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgHTUQE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 16:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgHTUQC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 16:16:02 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9EDC061385
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 13:16:01 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id i10so1778717ybt.11
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yL2PYMEwaF7KSjU1XIgM44wQFZt3o+R4J3v1ubBs3g0=;
        b=jbcRaG2eyfybJbbAPebGLhdbjUShJdWzMVWi5ON7j+zzPYXSqYOMtpq+f2IG7apfik
         pWHDmawkv4e9vuOVSTcX7RWQ3Yvi3AzxTNrjywSolQPBit+HZdZtFiyUT83VXLgY3/SO
         CUp49gRYPUlnUvvnMsLLdY97+fegnIELlvNqdpXCZ7Ej9Z/cSa18Zed8QjM+oFx4gi3a
         COYwYzZe0o3wEFmkV7G0y2mlE8idE/X50HL2dHLMCHbHZ02ZmyQKRj77ISbNqhwCUWwJ
         vtg1kVFouqjxn28zzXPzpK36f9e0ejF3gHeUrf+yUwl6Ultla7j599+6Jj9MpvFuxORb
         YOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yL2PYMEwaF7KSjU1XIgM44wQFZt3o+R4J3v1ubBs3g0=;
        b=nROZYWPLEfclE4SzpZEv3I1oz54yRqZ1Iat//ZRXkFiu6OAg3S9Flcsybp2s02uJ8w
         kp4SD/TmrJ/p2TqoaphSqGbeHPruhjKwQ4SagOBeXcR0yBXhRQAF9LpMbcYqMr5N61eC
         qMDtnddDWF341Hg0yj6LFWfm3nM/kBcfTbxMhV/YDtIluIYeX0ieUGyahSXwlbEPAVYs
         Nnp7X1zTzxkEbQg/3m3YF/LZ0aq+qOEt94Ndou5lL7E52MDSItGNvDW/aHdGkdcmEeNo
         kkEajS2E+VzNrH7JE/bXwPPuxIQUgoj2rF9uE4hbQmQc49x0LTs9eOGbOTyLJoc+R1yM
         iQ6w==
X-Gm-Message-State: AOAM53037a5uA1NWYyluyPc1BXO7n3dQXcDVjiSB2SvKyKyFGp79P+gr
        Ft8IklqtgHGEskLVweTPhozXUw5Oh+Ui2T/MpOA=
X-Google-Smtp-Source: ABdhPJxwxU6lRLnz5ToNxC+8qpynxuMGy83QpAyV50kWNa/P95KO/tbTgy5efYGUDIaUDhfOV7gC9+JGl3nV91A4Ees=
X-Received: by 2002:a5b:d12:: with SMTP id y18mr6975663ybp.400.1597954561114;
 Thu, 20 Aug 2020 13:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200214035555.24762-1-wgong@codeaurora.org> <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
 <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org> <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
 <dcc45384935dca14ac6ab31ec1123414@codeaurora.org> <CABPxzYLu_81h+aWWeNKRyH=CJ=+waB3zmT41BTZ9Mo733PqErQ@mail.gmail.com>
 <acb2bd58-2f95-e09c-9575-b45c0e2aeb70@candelatech.com> <CABPxzY+tPos8ByT76hU1ngoxwYcBHaRpFMCKGQJcc_ssoqGNSw@mail.gmail.com>
 <47c1b1e0-afc4-b9b4-5fc0-4636d8b3b981@candelatech.com> <CABPxzYLD-M5wpWF6r=K=8YTosSfjctmaaBPCyBP72q-mY0PTcw@mail.gmail.com>
 <CABPxzYLOZf9Fu5O3Rt_mVcXeFLuuFAsqyvd7jiCVvJ0x2BN-+g@mail.gmail.com> <dd8cb5db-f164-c235-1f39-cd78ea97f8be@candelatech.com>
In-Reply-To: <dd8cb5db-f164-c235-1f39-cd78ea97f8be@candelatech.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Fri, 21 Aug 2020 01:45:49 +0530
Message-ID: <CABPxzY+uyy_Yc0mHb7sJGxxUE5__Z8SpywodAv2YCM8D89waHw@mail.gmail.com>
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

On Thu, Aug 20, 2020 at 11:23 PM Ben Greear <greearb@candelatech.com> wrote:
>
> On 8/20/20 10:42 AM, Krishna Chaitanya wrote:
> > On Thu, Aug 20, 2020 at 11:11 PM Krishna Chaitanya
> > <chaitanya.mgit@gmail.com> wrote:
> >>
> >> On Thu, Aug 20, 2020 at 10:38 PM Ben Greear <greearb@candelatech.com> wrote:
> >>>
> >>> On 8/20/20 10:00 AM, Krishna Chaitanya wrote:
> >>>> On Thu, Aug 20, 2020 at 10:02 PM Ben Greear <greearb@candelatech.com> wrote:
> >>>>>
> >>>>> On 8/20/20 9:08 AM, Krishna Chaitanya wrote:
> >>>>>> On Thu, Aug 20, 2020 at 8:07 PM Wen Gong <wgong@codeaurora.org> wrote:
> >>>>>>>
> >>>>>>> On 2020-08-20 18:52, Krishna Chaitanya wrote:
> >>>>>>>> On Thu, Aug 20, 2020 at 3:45 PM Wen Gong <wgong@codeaurora.org> wrote:
> >>>>>>>>>
> >>>>>>>>> On 2020-08-20 17:19, Krishna Chaitanya wrote:
> >>>>>>> ...
> >>>>>>>>>>> I'm not really convinced that this is the right fix, but I'm no NAPI
> >>>>>>>>>>> expert. Can anyone else help?
> >>>>>>>>>> Calling napi_disable() twice can lead to hangs, but moving NAPI from
> >>>>>>>>>> start/stop to
> >>>>>>>>>> the probe isn't the right approach as the datapath is tied to
> >>>>>>>>>> start/stop.
> >>>>>>>>>>
> >>>>>>>>>> Maybe check the state of NAPI before disable?
> >>>>>>>>>>
> >>>>>>>>>>     if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
> >>>>>>>>>>      napi_disable(&ar->napi)
> >>>>>>>>>> or maintain napi_state like this
> >>>>>>>>>> https://patchwork.kernel.org/patch/10249365/
> >>>>>>>>> it is better to use above link's patch.
> >>>>>>>>> napi.state is controlled by napi API, it is better ath10k not know it.
> >>>>>>>> Sure, but IMHO just canceling the async rx work should solve the issue.
> >>>>>>> Oh no, canceling the async rx work will not solve this issue, rx worker
> >>>>>>> ath10k_rx_indication_async_work call napi_schedule, after napi_complete,
> >>>>>>> the NAPI_STATE_SCHED will clear.
> >>>>>>> The issue of this patch is because 2 thread called to hif_stop and
> >>>>>>> NAPI_STATE_SCHED not clear.
> >>>>>> That fix is still valid and good to have.
> >>>>>>
> >>>>>> ndev_stop being called twice is typical scenarios (stop vs rmmod), so
> >>>>>>     just checking the netdev_flags for IFF_UP and returning from hif_Stop
> >>>>>> should suffice, no?
> >>>>>
> >>>>> My approach to fix this problem was to add a boolean in ath10k as to whether
> >>>>> it had napi enabled or not, and then check that before trying to enable/disable
> >>>>> it again.  Seems to work fine, and cleaner in my mind than checking internal
> >>>>> napi flags.
> >>>> A much simpler approach is just to check for IFF_UP and skip NAPI (and others)
> >>>> in the hif_stop no? (provided proper RTNL locking is done if hif_stop
> >>>> is being called
> >>>> internally as well).
> >>>>
> >>>
> >>> I'm not sure, but I think the driver should be internally consistent and not
> >>> spend a lot of time trying to guess about interactions with objects higher
> >>> in the stack.
> >> Fair enough, the network interface state is a basic thing controlled
> >> by the driver,
> >> so, should be okay to use. Anyways, the in-driver approach has more control.
> >>>
> >>> Here is my original patch to fix this, it is not complex.
> >>>
> >>> https://patchwork.kernel.org/patch/10249363/
> >> Sure, I have shared your patch above :).
> > Sent a bit early, any idea why this wasn't upstreamed earlier?
>
> No, one comment from Michal indicated maybe there were more problems lurking
> in this area, but he seemed to be OK with the patch over all.  After that,
> it was just ignored.
>
Now might be a good time to push for it :)
