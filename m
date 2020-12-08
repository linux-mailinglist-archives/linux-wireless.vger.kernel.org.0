Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9E2D3067
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 18:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgLHRAQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 12:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgLHRAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 12:00:16 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC33C06179C
        for <linux-wireless@vger.kernel.org>; Tue,  8 Dec 2020 08:59:36 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t7so14431632pfh.7
        for <linux-wireless@vger.kernel.org>; Tue, 08 Dec 2020 08:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/TxV5YiOQURGPp9N72E4jbrpfGvnOvNp2x+RiNLZp0o=;
        b=ee00sPjLZGb4/3Znq+WhjPen+uAH8pMT7MGko1Ak9g/s6NOZbkfgBXpKMT9wHxq9nN
         cKVtyuqSPlq3QHvTG5SKhEe22LDBKelCGpiSWl1BfdFpCnXIlLQacwzEGGMYufVv86yG
         /oBXcvlOz1DogTLD+5UssqfrRjQUMi8IxJBcDa/aa/RqDj6XFIXlT4YHm0xujKSEKTwi
         jzK6WGAA+/F6vkhwTynqYw5+V8wG5WTZOQxDelmM5CLk3MmeXF0DBloK83nNJGai7XlG
         OMAb4TEAzgheJ2aOrVgFo3AiseO+WmljbZgKSAcXg+z775Vgtt5/zdXdXJXsF0JjKNtM
         b2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/TxV5YiOQURGPp9N72E4jbrpfGvnOvNp2x+RiNLZp0o=;
        b=joEYnYbN3uC8taOR8mcwNgC9yc9ofEJvyQGa+RI7UHe/+uGL4NvZzNUOs6GfmPx9rD
         iNYPIMZfLNi5qKjjrz3TU5Lu6B8wbYz/Gqmw9McH/1JlL/RUIMrTVW9D0+prCjOabkkj
         m2TmAud3HmeeuLiM9vY8sMng8Q07PSFsTd43H9F/sWEjz3OJtECtTHcuQfGZI90SvoND
         vLCdqGoW/9DDCAfdnl1/Vg9vj0FmvsdN9foZzKLkVK6jsz2XaKQXK3idU1KRCYO/PiJA
         h1/l8BhvaquTVKwNeayFC1yesXQFWtYvJxVNmmqnKPNGMU3mHitdW3XbxgxHYPfsr9zL
         WdWQ==
X-Gm-Message-State: AOAM5318H1K6Jx87t9FW9GXAklGRVRvKRLqi4haCUiXDcnXNTSdKEtqu
        AvkMW2ofqBp47buUaBLfnxnp
X-Google-Smtp-Source: ABdhPJxHzFE61aPBh+3a/ynge8AsyscNyy/LZVdpYJcTnMZTM09u/LLGnqb0xouDGy8q62WU7tjhEQ==
X-Received: by 2002:a63:d741:: with SMTP id w1mr23187514pgi.131.1607446775584;
        Tue, 08 Dec 2020 08:59:35 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id k15sm10597940pfh.40.2020.12.08.08.59.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Dec 2020 08:59:34 -0800 (PST)
Date:   Tue, 8 Dec 2020 22:29:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v13 0/4] userspace MHI client interface driver
Message-ID: <20201208165927.GE9925@work>
References: <1606533966-22821-1-git-send-email-hemantk@codeaurora.org>
 <20201201112901.7f13e26c@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <c6359962-a378-ed03-0fab-c2f6c8a1b8eb@codeaurora.org>
 <20201201120302.474d4c9b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <817a4346-efb7-cfe5-0678-d1b60d06627d@codeaurora.org>
 <20201201185506.77c4b3df@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <f22eaead-fd25-8b20-7ca1-ae3f535347d4@codeaurora.org>
 <20201206083302.GA691268@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206083302.GA691268@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Dec 06, 2020 at 10:33:02AM +0200, Leon Romanovsky wrote:
> On Tue, Dec 01, 2020 at 09:59:53PM -0700, Jeffrey Hugo wrote:
> > On 12/1/2020 7:55 PM, Jakub Kicinski wrote:
> > > On Tue, 1 Dec 2020 13:48:36 -0700 Jeffrey Hugo wrote:
> > > > On 12/1/2020 1:03 PM, Jakub Kicinski wrote:
> > > > > On Tue, 1 Dec 2020 12:40:50 -0700 Jeffrey Hugo wrote:
> > > > > > On 12/1/2020 12:29 PM, Jakub Kicinski wrote:
> > > > > > > On Fri, 27 Nov 2020 19:26:02 -0800 Hemant Kumar wrote:
> > > > > > > > This patch series adds support for UCI driver. UCI driver enables userspace
> > > > > > > > clients to communicate to external MHI devices like modem and WLAN. UCI driver
> > > > > > > > probe creates standard character device file nodes for userspace clients to
> > > > > > > > perform open, read, write, poll and release file operations. These file
> > > > > > > > operations call MHI core layer APIs to perform data transfer using MHI bus
> > > > > > > > to communicate with MHI device. Patch is tested using arm64 based platform.
> > > > > > >
> > > > > > > Wait, I thought this was for modems.
> > > > > > >

[...]

> Like it or not, but Jakub is absolutely right with his claim that
> providing user-visible interfaces without any standardization is proven
> as wrong.
> 

Everybody agrees with standardizing things but the problem is, the
standardization will only happen when more than one person implements the
same functionality.

The primary discussion is around the usage of chardev nodes for WLAN but
we made it clear that WLAN doesn't need this chardev node for working at
all. I agree that the commit message is a bit misleading and I hope that
Hemant will fix it in next revision.

Thanks,
Mani

> Thanks
> 
> >
> > --
> > Jeffrey Hugo
> > Qualcomm Technologies, Inc. is a member of the
> > Code Aurora Forum, a Linux Foundation Collaborative Project.
