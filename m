Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9790A35C64A
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 14:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbhDLMca (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 08:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239061AbhDLMc3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 08:32:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E00E6128C;
        Mon, 12 Apr 2021 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618230731;
        bh=QgS/ftlOM42vMA3Lk92wFn30uMApuYf4HfwR7CkRxqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yMJB6jH1NXKoiY0Br75sEbFA0q6HkMKz27riCmU0PABVyxYF/X452qVlT9MIPyU0g
         3m7Juwl/du0EhmnUeHM6OuSdIx0xZlf9l+ra+63NBIdLhrg1gN2ujq+V3gYT4xZCFK
         79S5LiaY2Ld1lA2oaXJtGxjhNEUQhwwccSiv1ksI=
Date:   Mon, 12 Apr 2021 14:32:09 +0200
From:   "'Greg KH (gregkh@linuxfoundation.org)'" <gregkh@linuxfoundation.org>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Luca Coelho <luca@coelho.fi>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: Re: pull-request: iwlwifi-next 2021-04-12
Message-ID: <YHQ9yQohZyU2J/Na@kroah.com>
References: <ee6d5faebc25c8fa447cf870cbc80b4236178756.camel@coelho.fi>
 <87v98rlod8.fsf@codeaurora.org>
 <SA0PR11MB47522E7EC6ECE33A9D1068BDF2709@SA0PR11MB4752.namprd11.prod.outlook.com>
 <YHQ5sjnH2tj8Jvrg@kroah.com>
 <SA0PR11MB4752E3834B186ADB27F2B75CF2709@SA0PR11MB4752.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR11MB4752E3834B186ADB27F2B75CF2709@SA0PR11MB4752.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 12, 2021 at 12:19:52PM +0000, Grumbach, Emmanuel wrote:
> > 
> > On Mon, Apr 12, 2021 at 11:55:23AM +0000, Grumbach, Emmanuel wrote:
> > > + Greg
> > >
> > > Hi Greg,
> > >
> > > >
> > > > Luca Coelho <luca@coelho.fi> writes:
> > > >
> > > > > Here's the first batch of patches intended for v5.13.  This
> > > > > includes the four last patchsets I sent out for v5.13 with the
> > > > > usual development work.  It also includes Emmanuel's series for
> > > > > adding the iwlmei driver, including one patch by Alexander Usyskin
> > > > > in the misc drivers
> > > > directory.
> > > > > (which Greg asked us to push via our tree).
> > > >
> > > > But no Acked-by from Greg? I would like to have that in the commit log.
> > >
> > > Not sure if you remember, but Tomas sent a patch to you and then asked
> > > to route the patch through the user's tree. So here it is :) Kalle would like to
> > get an ACK from you. This is the latest version of the patch:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.g
> > > it/commit/?id=1b1910e2c82ed5392b90470885d91f3abc1619e2
> > 
> > I do not remember anything like this, do you have a pointer to the
> > lore.kernel.org thread?  Remember I get about 1000 emails a day to do
> > something with (usually ignore...)
> 
> Bah, I forgot to add this link which I had prepared to paste here:
> https://lore.kernel.org/lkml/20210206144325.25682-6-tomas.winkler@intel.com/
> 
> > 
> > And I can't review a random commit on a random webpage, that's not how
> > any of this works, you know better.
> 
> I guess I can resend the patch and CC you to it so that you can review it.

The whole series is needed to be resent as the single patch doesn't make
sense alone.

thanks,

greg k-h
