Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5D416FD0
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 12:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245488AbhIXKCM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245440AbhIXKCL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 06:02:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE8EC061756
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 03:00:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q23so8428650pfs.9
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4vMQMisBtZM7XcTiorQkl1JxcgLI/TRL5gZOHXdOV3E=;
        b=qwydP1VOrJxnox75F1D8NMnpDrI8ksfDG0NgGcSOEDnix9AeVUWkcNqI/P1xHLHJqm
         A3L3ZJEAL8hLM6RT6jq0O1LQrlUSKPr8qpQJhHJo+p6teiulFYwv2AEj7E8dOJeNvuXW
         UVL0mbY/xitJd8g5epDHcI4GZXBMAgBKZdXQBZUUOBCm8J1S+ACZ5AWWAAGJvpT/kkL/
         nkxzXhsKbshQlRe5QjvxZ6F8XYpFh/ivjtOQAvAPEVtiPlurfMXMSxaXYnLnXooR2W2w
         H0lVDyhkXtQHBca4+9uU9D3WidYSQoOwuw7lzeVLENHJdzd8BVzfS1HsRl/cvtRnohLc
         p6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4vMQMisBtZM7XcTiorQkl1JxcgLI/TRL5gZOHXdOV3E=;
        b=OOmpZ4NPRUNztRUNfly3LqwVn7C3SLjRaDL5ja7Hj260I2+BncZWBEZybuhIeLvC8G
         dpZoyCCPjBkmN40cNT52dOyvJ1NL5YsgCKsVJt20jJXr4oytBpbjfzRqoEnWecErnvgM
         tvUjKECdWcwSJWKESXWWTFy1HoflU8WjjpNvNiM28tlxJ24kPec52yYLiBGy9J3re/iu
         si6KsMQPEzrCXE/Mb6WOZYqR3x/0D4Dd/bCkn4lLd8SZgE2WW3av/MGhHPKCFIXqTpjc
         qUJfobAn6PQkRnAfO+/Eay96/Vf1lHMCB5ZT10A05YBuSV3NQ9oOlXidL8NtFd3utpDD
         npEA==
X-Gm-Message-State: AOAM531Q3nC/o6daABOosQ6DnfFN++tKIUJj9sF5baNhKGe7xag/42J2
        jWgRUS8wsbayfKwjM1Z2z8fa
X-Google-Smtp-Source: ABdhPJwhSmGRcYlTGqj1+MU++RDDBntBGaII2yLpDeqa1IaBUCnpQs290DoxEcaPsYRdSIkCDfHREw==
X-Received: by 2002:a63:5252:: with SMTP id s18mr3048353pgl.94.1632477637829;
        Fri, 24 Sep 2021 03:00:37 -0700 (PDT)
Received: from workstation ([120.138.12.62])
        by smtp.gmail.com with ESMTPSA id f144sm8399311pfa.24.2021.09.24.03.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Sep 2021 03:00:37 -0700 (PDT)
Date:   Fri, 24 Sep 2021 15:30:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        regressions@lists.linux.dev
Subject: Re: [regression] mhi: ath11k resume fails on some devices
Message-ID: <20210924100034.GC19050@workstation>
References: <871r5p0x2u.fsf@codeaurora.org>
 <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
 <877df6tlnq.fsf@codeaurora.org>
 <CAMZdPi8P7YZPhPir+WfS3cY_a7He1m2Pq2uqBhczPdEeoNRb0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZdPi8P7YZPhPir+WfS3cY_a7He1m2Pq2uqBhczPdEeoNRb0Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 24, 2021 at 11:43:55AM +0200, Loic Poulain wrote:
> Hi Kalle,
> 
> On Fri, 24 Sept 2021 at 10:36, Kalle Valo <kvalo@codeaurora.org> wrote:
> >
> > Loic Poulain <loic.poulain@linaro.org> writes:
> >
> > > Hi Kalle,
> > >
> > > On Thu, 16 Sept 2021 at 10:00, Kalle Valo <kvalo@codeaurora.org> wrote:
> > >>
> > >> Hi Loic and Mani,
> > >>
> > >> I hate to be the bearer of bad news again :)
> > >>
> > >> I noticed already a while ago that commit 020d3b26c07a ("bus: mhi: Early
> > >> MHI resume failure in non M3 state"), introduced in v5.13-rc1, broke
> > >> ath11k resume on my NUC x86 testbox using QCA6390. Interestingly enough
> > >> Dell XPS 13 9310 laptop (with QCA6390 as well) does not have this
> > >> problem, I only see the problem on the NUC. I do not know what's causing
> > >> this difference.
> > >
> > > I suppose the NUC is current PCI-Express power during suspend while
> > > the laptop maintains PCIe/M2 power.
> >
> > Sorry, I'm not able to parse that sentence. Can you elaborate more?
> 
> Ouch, yes, I wanted to say that the NUC does not maintain the power of
> PCI express during suspend (leading to PCI D3cold state), whereas the
> laptop maintains the power of the M2 card... well, not sure now I see
> your logs.
> 
> >
> > >> At the moment I'm running my tests with commit 020d3b26c07a reverted and
> > >> everything works without problems. Is there a simple way to fix this? Or
> > >> maybe we should just revert the commit? Commit log and kernel logs from
> > >> a failing case below.
> > >
> > > Do you have log of success case?
> >
> > A log from a successful case in the end of email, using v5.15-rc1 plus
> > revert of commit 020d3b26c07abe27.
> >
> > > To me, the device loses power, that is why MHI resuming is failing.
> > > Normally the device should be properly recovered/reinitialized. Before
> > > that patch the power loss was simply not detected (or handled at
> > > higher stack level).
> >
> > Currently in ath11k we always keep the firmware running when in suspend,
> > this is a workaround due to problems between mac80211 and MHI stack.
> > IIRC the problem was something related MHI creating struct device during
> > resume or something like that.
> 
> Could you give a try with the attached patch? It should solve your
> issue without breaking modem support.
> 

It will... But we should first try to see what is causing the device to
be in MHI RESET state. We can't add a force resume case without knowing
the rootcause.

And for workaround, we can proceed resume if device is in RESET state
adding a comment on why. But let's first get the MHI debug logs.

> Regards,
> Loic


