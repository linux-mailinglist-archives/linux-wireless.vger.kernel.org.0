Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD6345AC8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 10:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCWJZw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 05:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhCWJZU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 05:25:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93CD961984;
        Tue, 23 Mar 2021 09:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616491520;
        bh=agXZtvq6Q8ZPuuNsJqhZhVpGpj8pmEWrHa3JhHpdN9A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=U14EQRosIOb3kEOxTuF6rb2WZnb4my1o0nmWIt03KotoD8Cw2gz+yaJyB3D8y0Gih
         XxliVJc9tSRejjS/owU8aiW3oHDexn7URBkBycmrtRr9ztYu+7dL2ctkOMIGmObpMw
         2uBcCw8WZFmQOX+5N5RUpxSjdnBgm56C7g5bpI0922k21nHh66fPATnhOXMqIjgAq1
         DP6wajk7s1e6zPeAGhZwIdMH2xSNsPbOkAP047npsAujUhxHe3myKGdo4zNl2o3UiW
         70CalNDZS0+M+HeVldCS/JHMOaAG3BVXdSikBZFelIQTrENcC2BSw3C5QozJEio9Fx
         MRJG7FXq7KOWQ==
Date:   Tue, 23 Mar 2021 10:25:16 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
cc:     Luca Coelho <luca@coelho.fi>, Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_enqueue_hcmd()
In-Reply-To: <CA+icZUWNbOpTXEy8SXMSJM=Or82gyVD8GUr10-A62dNtXa_Bnw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2103231024000.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm> <nycvar.YFH.7.76.2103080925230.12405@cbobk.fhfr.pm> <nycvar.YFH.7.76.2103130242460.12405@cbobk.fhfr.pm> <87h7lfbowr.fsf@tynnyri.adurom.net> <nycvar.YFH.7.76.2103131642290.12405@cbobk.fhfr.pm>
 <f103b4a29b7c1942f091bd7b90d7a927d72c20a2.camel@coelho.fi> <87zgz7t246.fsf@codeaurora.org> <c1681fa49280189c48ecf9f86fe54b81d662dc07.camel@coelho.fi> <nycvar.YFH.7.76.2103221311560.12405@cbobk.fhfr.pm>
 <CA+icZUWNbOpTXEy8SXMSJM=Or82gyVD8GUr10-A62dNtXa_Bnw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 23 Mar 2021, Sedat Dilek wrote:

> > > > > > > > Johannes is telling me that he merged this patch internally, but I have no
> > > > > > > > idea what is happening to it ... ?
> > > > > > > >
> > > > > > > > The reported splat is a clear bug, so it should be fixed one way or the
> > > > > > > > other.
> > > > > > >
> > > > > > > Should I take this to wireless-drivers?
> > > > > >
> > > > > > I can't speak for the maintainers, but as far as I am concerned, it
> > > > > > definitely is a 5.12 material, as it fixes real scheduling bug.
> > > > >
> > > > > Yes, please take this to w-d.  We have a similar patch internally, but
> > > > > there's a backlog and it will take me some time to get to it.  I'll
> > > > > resolve eventual conflicts when time comes.
> > > >
> > > > Ok, can I have your ack for patchwork?
> > >
> > > Sorry, forgot that.
> > >
> > > Acked-by: Luca Coelho <luciano.coelho@intel.com>
> >
> > Sorry for sounding like broken record :) but this fix is still not in any
> > tree as far as I can tell. And it's fixing real scheduling in atomic bug.
> >
> > Thanks,
> >
> 
> [ CC Chris Murphy <lists@colorremedies.com> ]
> 
> A week ago Chris sent an email to linux-wireless with pointing to:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=212297
> 
> AFAICS, that is the same bug.

Indeed, it is. Chris, if you want to provide your Tested-by:, the (yet 
unmerged) patch to test can be found here:

	https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm/

-- 
Jiri Kosina
SUSE Labs

