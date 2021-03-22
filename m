Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210BE34408C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 13:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhCVMNS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 08:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhCVMMz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 08:12:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A62FF6196F;
        Mon, 22 Mar 2021 12:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616415174;
        bh=nJ6Y0t09uPWWuWf7AN+eLehX+a2M1PUYG+ikHrZ1keM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KcKOq3hnx1wa45MK4b7+gfmZU/FDeRoithsKVCA3AAH9xDis0Ns2cZ9gPb6Fq76IJ
         M+QzWVsLqyrfw0kPho8eP1kYzSUgYk0Ji5w2KP4AfVmxy0b1tZMKDGzpsYK4XcxFD4
         yt4EVuL4wnvRsNo7reD91k5GSHEpFMQ2VDlwmrZ7LdFVqKZnD9NEmWqubGWQhJxOne
         dRmoL7Jw7ZzEEn/3RqCDkN7tRUllAy9yY8Ww9TH8WfzdfQgHJ2W8emNFZiWcNWKNyF
         J8b3BdvbNl+K7/sqCwmTjNmRg2vHlOoA6epI4NAEkihFuPhTjOA9TaOGt1jFpCfPum
         s1Qv0seAMiXUA==
Date:   Mon, 22 Mar 2021 13:12:51 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
cc:     Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_enqueue_hcmd()
In-Reply-To: <c1681fa49280189c48ecf9f86fe54b81d662dc07.camel@coelho.fi>
Message-ID: <nycvar.YFH.7.76.2103221311560.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm>  <nycvar.YFH.7.76.2103080925230.12405@cbobk.fhfr.pm>  <nycvar.YFH.7.76.2103130242460.12405@cbobk.fhfr.pm>  <87h7lfbowr.fsf@tynnyri.adurom.net>  <nycvar.YFH.7.76.2103131642290.12405@cbobk.fhfr.pm>
  <f103b4a29b7c1942f091bd7b90d7a927d72c20a2.camel@coelho.fi>  <87zgz7t246.fsf@codeaurora.org> <c1681fa49280189c48ecf9f86fe54b81d662dc07.camel@coelho.fi>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 13 Mar 2021, Luca Coelho wrote:

> > > > > > > > It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs 
> > > > > > > > disabled (e.g. from LED core). We can't enable BHs in such a situation.
> > > > > > > > 
> > > > > > > > Turn the unconditional BH-enable/BH-disable code into 
> > > > > > > > hardirq-disable/conditional-enable.
> > > > > > > > 
> > > > > > > > This fixes the warning below.
> > > > > > > 
> > > > > > > Hi,
> > > > > > > 
> > > > > > > friendly ping on this one ... 
> > > > > > 
> > > > > > Luca,
> > > > > > 
> > > > > > Johannes is telling me that he merged this patch internally, but I have no 
> > > > > > idea what is happening to it ... ?
> > > > > > 
> > > > > > The reported splat is a clear bug, so it should be fixed one way or the 
> > > > > > other.
> > > > > 
> > > > > Should I take this to wireless-drivers?
> > > > 
> > > > I can't speak for the maintainers, but as far as I am concerned, it 
> > > > definitely is a 5.12 material, as it fixes real scheduling bug.
> > > 
> > > Yes, please take this to w-d.  We have a similar patch internally, but
> > > there's a backlog and it will take me some time to get to it.  I'll
> > > resolve eventual conflicts when time comes.
> > 
> > Ok, can I have your ack for patchwork?
> 
> Sorry, forgot that.
> 
> Acked-by: Luca Coelho <luciano.coelho@intel.com>

Sorry for sounding like broken record :) but this fix is still not in any 
tree as far as I can tell. And it's fixing real scheduling in atomic bug.

Thanks,

-- 
Jiri Kosina
SUSE Labs

