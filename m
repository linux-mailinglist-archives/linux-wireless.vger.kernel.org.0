Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64794561AB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 18:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhKRRow (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 12:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhKRRov (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 12:44:51 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D54C06173E
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 09:41:50 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so8843122pja.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 09:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ciIRwy+yxvWn2LwEQWDIz+C3VSCgM6erWfnwc1pCQE=;
        b=Po2980MK3nArAg5kgUQyTvOoghzp/so1mpxQqFmgkHfEuiVm8w/dsmqAfsmBEK0PsS
         t8cSYt5UI3z/+ZqDacYoUWritLHHkVDbZ9H8o9dp/O9FE2zwEefIwO2aYxWPBOIDi0K+
         Q6hRyiEXWNyugSaBdzEw/qLSH/sOZJ2SYBgfg+OKWsSQamHGH9lENraxerysU0vcMk+Q
         gndcskSMDwvdRTBfqcZ/DzJsMtzISsqSBCwYI5CaincTsqedpUpjUlPSNAVWCz32JR6l
         sapZEjrhakrT/HOKweuJvuRS6yVR6zqLJ7XwBGb7SQS30043DmQ13cwyhGCRWf9lL4m9
         Y6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ciIRwy+yxvWn2LwEQWDIz+C3VSCgM6erWfnwc1pCQE=;
        b=aM4JdR3rVdNQj+SVjxNP/BXu4RtDLPQlOgsAL0Tm0dP3QIdU9lvRUsqwlqiB3SNFlB
         jM1SIzZ9vC5zLRkf3KUwMeyKjrSZ1wPLnYKdqrVHpHRFR/NMySfpGiFQWKe6FlaU+qmn
         Lzo7QpjnSOkXwxbZ9NzleamBiNHM3yg9lrf4iRltwt5j//wIyL63/ftdskUtJBIFkIux
         EYTIw/kNEbZeRQ1KvafbmpuesWafZTgz3S/nhrVmcZz4hCyRCxJLgn3Fk3Jhl8WY1KbM
         TO/wNYcKFjxVxG/e/ehkLwmQhRXdzxV7sJRgXMhUL3xgALE8uzaJvr/RFsbbeAf5ibYv
         twaw==
X-Gm-Message-State: AOAM53300WJGJBOSW32Og1cckrRvhFnqay4GS0nmeGy2axo/d3NCbcb5
        ULMWA7L1+02LafeQOVfkQVsh
X-Google-Smtp-Source: ABdhPJz4ckUHzppPNRFH93bqoC4QHvF8HTUl6iWPtRcLKk0HfikDz9RyuU6wf05bW3QmHIX+Gogc6A==
X-Received: by 2002:a17:90a:a396:: with SMTP id x22mr12624056pjp.14.1637257310302;
        Thu, 18 Nov 2021 09:41:50 -0800 (PST)
Received: from thinkpad ([117.202.188.63])
        by smtp.gmail.com with ESMTPSA id h6sm271494pfh.82.2021.11.18.09.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 09:41:49 -0800 (PST)
Date:   Thu, 18 Nov 2021 23:11:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        regressions@lists.linux.dev, mhi <mhi@lists.linux.dev>
Subject: Re: [regression] mhi: ath11k resume fails on some devices
Message-ID: <20211118174145.GA31300@thinkpad>
References: <871r5p0x2u.fsf@codeaurora.org>
 <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
 <877df6tlnq.fsf@codeaurora.org>
 <CAMZdPi8P7YZPhPir+WfS3cY_a7He1m2Pq2uqBhczPdEeoNRb0Q@mail.gmail.com>
 <87a6jl9ndo.fsf@codeaurora.org>
 <87ee8hgqni.fsf@codeaurora.org>
 <20211021100305.GD7580@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021100305.GD7580@workstation>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 21, 2021 at 03:33:05PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 19, 2021 at 03:12:01PM +0300, Kalle Valo wrote:
> > Kalle Valo <kvalo@codeaurora.org> writes:
> > 
> > > (adding the new mhi list, yay)
> > >
> > > Hi Loic,
> > >
> > > Loic Poulain <loic.poulain@linaro.org> writes:
> > >
> > >>> Loic Poulain <loic.poulain@linaro.org> writes:
> > >>>
> > >>> > On Thu, 16 Sept 2021 at 10:00, Kalle Valo <kvalo@codeaurora.org> wrote:
> > >>>
> > >>> >> At the moment I'm running my tests with commit 020d3b26c07a reverted and
> > >>> >> everything works without problems. Is there a simple way to fix this? Or
> > >>> >> maybe we should just revert the commit? Commit log and kernel logs from
> > >>> >> a failing case below.
> > >>> >
> > >>> > Do you have log of success case?
> > >>>
> > >>> A log from a successful case in the end of email, using v5.15-rc1 plus
> > >>> revert of commit 020d3b26c07abe27.
> > >>>
> > >>> > To me, the device loses power, that is why MHI resuming is failing.
> > >>> > Normally the device should be properly recovered/reinitialized. Before
> > >>> > that patch the power loss was simply not detected (or handled at
> > >>> > higher stack level).
> > >>>
> > >>> Currently in ath11k we always keep the firmware running when in suspend,
> > >>> this is a workaround due to problems between mac80211 and MHI stack.
> > >>> IIRC the problem was something related MHI creating struct device during
> > >>> resume or something like that.
> > >>
> > >> Could you give a try with the attached patch? It should solve your
> > >> issue without breaking modem support.
> > >
> > > Sorry for taking so long, but I now tested your patch on top of
> > > v5.15-rc3 and, as expected, everything works as before with QCA6390 on
> > > NUC x86 testbox.
> > >
> > > Tested-by: Kalle Valo <kvalo@codeaurora.org>
> > 
> > I doubt we will find enough time to fully debug this mhi issue anytime
> > soon. Can we commit Loic's patch so that this regression is resolved?
> > 
> 
> Sorry no :( Eventhough Loic's patch is working, I want to understand the
> issue properly so that we could add a proper fix or patch the firmware
> if possible.
> 
> Let's try to get the debug logs as I requested.
> 

I'm able to reproduce the issue on my NUC. I'm still investigating on how to
properly fix this issue. Expect a patch soon.

Thanks,
Mani 

> Thanks,
> Mani
> 
> > At the moment I'm doing all my regression testing with commit
> > 020d3b26c07abe27 reverted. That's a risk, I would prefer to do my
> > testing without any hacks.
> > 
> > -- 
> > https://patchwork.kernel.org/project/linux-wireless/list/
> > 
> > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
