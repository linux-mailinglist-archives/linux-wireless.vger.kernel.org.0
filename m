Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075103F8A65
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 16:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhHZOtm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 10:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231768AbhHZOtj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 10:49:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6830E60EE0;
        Thu, 26 Aug 2021 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629989331;
        bh=crKF8g5sAGpAUYH0aq1QptWRIYpluHI6mSgfoNb6+IU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aKynVOziWPK+xPPb++Z0qRWSKz9U6Li2WJMMCJhCS/3ohkB33I6n8PFP/3mywcG51
         O8mXDQpAus7umJXEIetuEWNKXNxN/uDCf41GOzZn08tL81PXvLnhMQ/171hQNUTsAj
         HkdrVl8OaJY9w7H7QrkdD4qg0V1m1XTwOkSL8uf0TYGcSvYG/e3LLJlnlCoiEYYZtW
         eV1A53DgOVegTejAARli5SCPv4o3+p+UINTIMrkpJ3/xGUCPwh0xv9o5DB4gJIEDDl
         pXQIzQ1OI9ZbgEaejcOMJ05WupkOkJTUuRjkDhYvjnTqXxNHQs4JP2b0Xi21UFHbXB
         3KQ1gQy6jI14g==
Date:   Thu, 26 Aug 2021 07:48:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Wren Turkal <wt@penguintechs.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [regression] Re: 5.14 rc6 broken for QCA6390 on Dell XPS 13
 9310
Message-ID: <20210826074850.16768dee@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <YSenaxWzxRkYkucv@kroah.com>
References: <a8cddf24-ecfc-088e-27f4-98cbbb5fb67c@penguintechs.org>
        <87y28sqq4l.fsf@codeaurora.org>
        <843e7689-fa1e-441b-c49a-ed7291046d5f@freebox.fr>
        <87tujgqcth.fsf@codeaurora.org>
        <87mtp47073.fsf_-_@codeaurora.org>
        <YSenaxWzxRkYkucv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 26 Aug 2021 16:38:35 +0200 Greg Kroah-Hartman wrote:
> > I did some investiation and I suspect that commit ce78ffa3ef16 ("net:
> > really fix the build...")[1] is for handling a conflict between net-next
> > and char-misc-next trees related to Loic's commit 0092a1e3f763 ("bus:
> > mhi: Add inbound buffers allocation flag"). Greg mentions this in a
> > commit[2]:
> > 
> > commit 813272ed5238b37c81e448b302048e8008570121
> > Merge: de0534df9347 36a21d51725a
> > Author:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> >     Merge 5.14-rc5 into char-misc-next
> >     
> >     We need the fixes in here as well, and resolves some merge issues with
> >     the mhi codebase.
> > 
> > If my assumption is correct when I propose that we revert commit
> > ce78ffa3ef16 for v5.14, AFAICS it's not really needed for v5.14 (commit
> > 0092a1e3f763 is in -next, not in Linus' tree yet) and commit
> > ce78ffa3ef16 breaks ath11k. And the conflict between net-next and
> > char-misc-next can be then later fixed during the merge window.
> > 
> > Will this work for everyone? If no objections, I'll submit the revert to
> > Linus later today. We are getting really close to final v5.14 release so
> > not much time left to fix this.
> > 
> > Just to reiterate why the urgency: commit ce78ffa3ef16 broke ath11k in
> > v5.14-rc5, users have reported (and I have confirmed) that at least
> > QCA6390 support is broken but I suspect all Qualcomm Wi-Fi 6 devices
> > supported by ath11k are currently broken.  
> 
> No objection from me for reverting that, if it fixes the problems you
> are seeing for 5.14-final.
> 
> The goal was for the mhi changes to go through the networking tree in
> the first place, I don't see how this got out of sync.
> 
> If this is reverted, some help on how to resolve the merge issues it
> will cause would be appreciated.

Also no objections here. FWIW I'm about to send the last PR for
networking, still waiting on BPF. You can send the revert to netdev, 
or directly to Linus as you prefer. LMK.
