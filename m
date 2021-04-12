Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C404835C5F7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 14:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbhDLMPD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 08:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237283AbhDLMPC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 08:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35097601FF;
        Mon, 12 Apr 2021 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618229684;
        bh=uPV2cOtYV9HM5o2hvAwEahnks5Y2YTkpzzKReqkeHv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2xjuNsuHdaY7hKkGzNoTE7N+EVPANhqvlvoDjvFrTDJ9da3NExJocX6DrJ+3XS+b
         6qZ80FeuSOZK24lye8EWHnudbPCnMDr3ZsIFq0gu3noIYYfQd3z1+m8d1nWWuHbDCA
         p6qxp7ulYTwPMWYhImkFsNmln1MphPAU/XpvI02U=
Date:   Mon, 12 Apr 2021 14:14:42 +0200
From:   "'Greg KH (gregkh@linuxfoundation.org)'" <gregkh@linuxfoundation.org>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Luca Coelho <luca@coelho.fi>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: Re: pull-request: iwlwifi-next 2021-04-12
Message-ID: <YHQ5sjnH2tj8Jvrg@kroah.com>
References: <ee6d5faebc25c8fa447cf870cbc80b4236178756.camel@coelho.fi>
 <87v98rlod8.fsf@codeaurora.org>
 <SA0PR11MB47522E7EC6ECE33A9D1068BDF2709@SA0PR11MB4752.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR11MB47522E7EC6ECE33A9D1068BDF2709@SA0PR11MB4752.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 12, 2021 at 11:55:23AM +0000, Grumbach, Emmanuel wrote:
> + Greg
> 
> Hi Greg,
> 
> >
> > Luca Coelho <luca@coelho.fi> writes:
> >
> > > Here's the first batch of patches intended for v5.13.  This includes
> > > the four last patchsets I sent out for v5.13 with the usual
> > > development work.  It also includes Emmanuel's series for adding the
> > > iwlmei driver, including one patch by Alexander Usyskin in the misc drivers
> > directory.
> > > (which Greg asked us to push via our tree).
> >
> > But no Acked-by from Greg? I would like to have that in the commit log.
> 
> Not sure if you remember, but Tomas sent a patch to you and then asked to route the patch through the user's tree. So here it is :)
> Kalle would like to get an ACK from you. This is the latest version of the patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/commit/?id=1b1910e2c82ed5392b90470885d91f3abc1619e2

I do not remember anything like this, do you have a pointer to the
lore.kernel.org thread?  Remember I get about 1000 emails a day to do
something with (usually ignore...)

And I can't review a random commit on a random webpage, that's not how
any of this works, you know better.

greg k-h
