Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E903F8A3A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbhHZOj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 10:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234615AbhHZOjZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 10:39:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9409261027;
        Thu, 26 Aug 2021 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629988718;
        bh=hENEpileTUK7xnFY44JId6KBZv8d7ZlqXE+OKdAQKDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uijFCrg68CeGFmPoqmagkalMujlkMDFRA5rIEOBYbubddWh0omcHTESLQk7mLOsPK
         yG5fDXYAOaMUJuFlWgtWlrwgceOuAzl65ylnDnLEkExGwia7KsWYBHW8rdW/MIsBo1
         UMCYg0PNujDOHph+l1zianvriMQ2QG4kPyID1OaA=
Date:   Thu, 26 Aug 2021 16:38:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Wren Turkal <wt@penguintechs.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [regression] Re: 5.14 rc6 broken for QCA6390 on Dell XPS 13 9310
Message-ID: <YSenaxWzxRkYkucv@kroah.com>
References: <a8cddf24-ecfc-088e-27f4-98cbbb5fb67c@penguintechs.org>
 <87y28sqq4l.fsf@codeaurora.org>
 <843e7689-fa1e-441b-c49a-ed7291046d5f@freebox.fr>
 <87tujgqcth.fsf@codeaurora.org>
 <87mtp47073.fsf_-_@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtp47073.fsf_-_@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 26, 2021 at 05:25:04PM +0300, Kalle Valo wrote:
> (Adding Linus and Greg)
> 
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
> > (Adding Dave and Jakub to CC)
> >
> > Nicolas Schichan <nschichan@freebox.fr> writes:
> >
> >> On 23/08/2021 14:53, Kalle Valo wrote:
> >>> (adding linux-wireless, regressions and some mhi folks)
> >>> 
> >>> Wren Turkal <wt@penguintechs.org> writes:
> >>> 
> >>>> I have no device for the wifi on my computer. 5.13 worked pretty well.
> >>>> I also found others reporting similar issues:
> >>>> https://forum.manjaro.org/t/kernel5-14-rc6-ath11k-on-qca6390-regression-mhi-probe-failure/79362
> >>>>
> >>>> Here's info about the hardware on my laptop:
> >>>> ➜  ~ sudo dmidecode -s system-product-name
> >>>> XPS 13 9310
> >>>>
> >>>> ➜  ~ sudo dmidecode -s bios-version
> >>>> 3.0.4
> >>> 
> >>> Do you get the same mhi error as in the forum post?
> >>> 
> >>> qcom_mhi_qrtr: probe of mhi0_IPCR failed with error -22
> >>> 
> >>> MHI folks, any ideas? I have XPS 13 9310 myself but I'm not able to test
> >>> v5.14-rc6 kernel right now.
> >>
> >> Hello,
> >>
> >> I have hit the same issue on Linux 5.14-rc7:
> >>
> >> [   14.780566] qcom_mhi_qrtr: probe of mhi0_IPCR failed with error -22
> >>
> >> This looks to be caused by commit:
> >>
> >> ce78ffa3ef16 net: really fix the build...
> >>
> >> Reverting this commit results in ath11k being able to load without errors.
> >
> > Thanks, this helps a lot. Commit ce78ffa3ef16 was introduced in
> > v5.14-rc5 so I assume that's the first release which broke ath11k.
> >
> > Dave, what build issue did you fix with commit ce78ffa3ef16? Could we
> > revert the commit? The problem is that, unless we fix this issue, with
> > v5.14 WLAN will be broken on a quite few newer Dell laptops.
> 
> I did some investiation and I suspect that commit ce78ffa3ef16 ("net:
> really fix the build...")[1] is for handling a conflict between net-next
> and char-misc-next trees related to Loic's commit 0092a1e3f763 ("bus:
> mhi: Add inbound buffers allocation flag"). Greg mentions this in a
> commit[2]:
> 
> commit 813272ed5238b37c81e448b302048e8008570121
> Merge: de0534df9347 36a21d51725a
> Author:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>     Merge 5.14-rc5 into char-misc-next
>     
>     We need the fixes in here as well, and resolves some merge issues with
>     the mhi codebase.
> 
> If my assumption is correct when I propose that we revert commit
> ce78ffa3ef16 for v5.14, AFAICS it's not really needed for v5.14 (commit
> 0092a1e3f763 is in -next, not in Linus' tree yet) and commit
> ce78ffa3ef16 breaks ath11k. And the conflict between net-next and
> char-misc-next can be then later fixed during the merge window.
> 
> Will this work for everyone? If no objections, I'll submit the revert to
> Linus later today. We are getting really close to final v5.14 release so
> not much time left to fix this.
> 
> Just to reiterate why the urgency: commit ce78ffa3ef16 broke ath11k in
> v5.14-rc5, users have reported (and I have confirmed) that at least
> QCA6390 support is broken but I suspect all Qualcomm Wi-Fi 6 devices
> supported by ath11k are currently broken.

No objection from me for reverting that, if it fixes the problems you
are seeing for 5.14-final.

The goal was for the mhi changes to go through the networking tree in
the first place, I don't see how this got out of sync.

If this is reverted, some help on how to resolve the merge issues it
will cause would be appreciated.

thanks,

greg k-h
