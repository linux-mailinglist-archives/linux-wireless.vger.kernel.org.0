Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE43AC41F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 08:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhFRGr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 02:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhFRGr3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 02:47:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C26BC061574
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 23:45:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so5303813pjn.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=okAyK8M7Z6Ptw0beX4Y2yCnZuEPisK0I1+muMAhoiXg=;
        b=zvf795snOW2u51TXtNSz7v4xK9goLJUViwWj0aEGNbsut7dP75ADSDlQh6oE7mcJ2S
         KQxOAl4vPgYZpTfVuyt6MAnzP/7BgRrJu2/GVYEyZJwUT5IRHxkdr7Isvudt85dQ9zzh
         xHAjB4fCPwghogU+JREfrotPHVsyLiXqyXfaCgPnWBYoF6vwyzckE1Odm7FiE+eEXMzO
         TlsmJskTiSwW8U36LJKco/Ex63OSmZa/KZ5/IVsFNdhIdsGZdtLBTPaWEuUmPlyrW4Gc
         X9XjDC3nw93l03ofs0zegJI5k8Wc2bWf1ivyX0i4zRjgUB7CVKGOqekAYHqlj3hFr3NL
         PlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=okAyK8M7Z6Ptw0beX4Y2yCnZuEPisK0I1+muMAhoiXg=;
        b=BkLF35B5UJRcROayUtIJBVtIdoZCLUPa6pLinB1aHvbVmgUzyM9Tt2hBdXGlXeeZ7R
         d84pakMgEh1RRn7XPieWQE7kHz3cbbEg/hXB0wHZUQ8fMwAPcQn791Dp64xNb9y4dlAG
         L0Gc+mkKd+izLJZFJa26bNYSn8PE7l9EZLvS84y1EyLqoa6vwB13Q7WfeQ8aKYwJWCCn
         bYmnke4moTwG+fb2+o1w41+0Fxolh6Wauski/YAGW01Binmg3iQpMRIWoq5xvXkncygt
         cntqixQf7fh2DHUFM3ylZXKyijN3ZUyRe0Y4rYZZVlD4mUFOs1HAQtS+/2OzSjnYurSc
         pBwA==
X-Gm-Message-State: AOAM533DvY8q9vaNOn4zmeB9aAuubj1IHl6n8ilL1K9mzjD5JjYPCAo+
        pZPYZYqnMgGyiU4Hy9jTeYqM
X-Google-Smtp-Source: ABdhPJw7hiGjytMs5xdZLxzGMXIBTPSrji65dpHP37DcFsR16C6/rcqV4IZNtVQLqLewkCrdfqATzw==
X-Received: by 2002:a17:902:b188:b029:11b:1549:da31 with SMTP id s8-20020a170902b188b029011b1549da31mr3431833plr.7.1623998719794;
        Thu, 17 Jun 2021 23:45:19 -0700 (PDT)
Received: from workstation ([120.138.13.11])
        by smtp.gmail.com with ESMTPSA id b18sm7026451pfb.131.2021.06.17.23.45.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jun 2021 23:45:19 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:15:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        bbhatt=codeaurora.org@codeaurora.org, lilic@codeaurora.org,
        kangxu@codeaurora.org
Subject: Re: [PATCH v4 4/6] ath11k: set register access length for MHI driver
Message-ID: <20210618064514.GM3682@workstation>
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
 <1620330705-40192-5-git-send-email-bbhatt@codeaurora.org>
 <20210521135152.GL70095@thinkpad>
 <87h7i0juxt.fsf@codeaurora.org>
 <37184e28dcc952ba9ad5ed0dc2c1a6da@codeaurora.org>
 <6ed9fe90f40e5f8151d3a028abf0acd1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed9fe90f40e5f8151d3a028abf0acd1@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 16, 2021 at 10:38:01AM -0700, Bhaumik Bhatt wrote:
> Hi Kalle/Mani,
> 
> On 2021-06-14 10:49 AM, Bhaumik Bhatt wrote:
> > Hi Kalle,
> > 
> > On 2021-06-14 09:02 AM, Kalle Valo wrote:
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> > > 
> > > > On Thu, May 06, 2021 at 12:51:43PM -0700, Bhaumik Bhatt wrote:
> > > > > MHI driver requires register space length to add range checks and
> > > > > prevent memory region accesses outside of that for MMIO space.
> > > > > Set it before registering the MHI controller.
> > > > > 
> > > > > Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > > > > Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> > > > 
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > Kalle, should we do immutable branch for this patch or I can
> > > > pick it up via MHI
> > > > tree (if there are no other patches expected from ath11k for
> > > > this controller)?
> > > 
> > > I'm not expecting any conflicts with this, and if there are, they
> > > should
> > > be easy for Stephen or Linus to fix. So it's easiest to route this via
> > > your tree. But I'm not giving my ack yet, see below.
> > > 
> > > I'm worried that this patchset breaks bisect. Every patch in the
> > > patchset should not break existing functionality, what if only patches
> > > 1-3 are included in the tree but not patch 4? Wouldn't ath11k be
> > > broken
> > > then? I didn't review the whole patchset, but I suspect the fix is to
> > > include the ath11k change in the actual mhi patch which changes the
> > > functionality. So that way we would not have a separate ath11k patch
> > > at
> > > all.
> > > 
> > > Also I'm not able to test this patchset at the moment. Can someone
> > > else
> > > help and do a quick test with QCA6390 to verify these doesn't break
> > > ath11k?
> > 
> > I have requested someone to try and test this patch series with QCA6390.
> > 
> > I or the testers will get back to you with the test results when they
> > are
> > available.
> > 
> > As far as your concerns go, you can choose to pick patches 1-3 and that
> > would
> > be just fine.
> > 
> > Things will break if patchset 4 is _not_ in place with patchset 6 being
> > part of
> > the tree.
> > 
> > It would, however, be nice to pick the whole series instead and ensure
> > that
> > the functionality MHI introduces for boot-up sanity is in place for any
> > controllers such as ath11k.
> > 
> > Thanks,
> > Bhaumik
> > ---
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> > Forum,
> > a Linux Foundation Collaborative Project
> 
> Just got confirmation that the whole patch series was tested for functional
> sanity on
> Dell E7590 + QCA6390 with Ubuntu18.04 and patch 4/6 is also good to go.
> 
> Can you please ACK and pick up this series?
> 

I can pick the series but I need an Ack from Kalle since it contains
ath11k changes. Kalle, can you please Ack this patch?

I'm planning to send the PR by this weekend.

Thanks,
Mani

> Thanks,
> Bhaumik
> ---
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
