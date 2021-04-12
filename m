Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06A35C972
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbhDLPJ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 11:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238789AbhDLPJ6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 11:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 021D360C3E;
        Mon, 12 Apr 2021 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618240180;
        bh=OGR65Ysb1boNRc1FvyA0qHgepPCXKOh2glD5vDmHs98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4RBA8XCCfKWfqqbg2RxozU2cZE1GnOIMBBtmB2tCF2M7pA4CyhUqqm8xx3emkRY0
         izSz7PA5BrLrj8MJwhWYbLReESotxnzGOtb7SOsZUZr2iTrCsthON2/kLOQ8IF9+Lr
         KgHTe6719+uIb8iMWGzzue965rfOU04aDhtn/tEY=
Date:   Mon, 12 Apr 2021 17:09:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca@coelho.fi" <luca@coelho.fi>,
        "Beker, Ayala" <ayala.beker@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: Re: [PATCH RESEND 2/3] iwlwifi: mei: add the driver to allow
 cooperation with CSME
Message-ID: <YHRisW9++pJ7Sv3C@kroah.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210412124328.24472-2-emmanuel.grumbach@intel.com>
 <YHRFy3aq/gB7Vde6@kroah.com>
 <SA0PR11MB475215678ADCCE657C6574D6F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
 <YHRWtJqbuFGmR2Sw@kroah.com>
 <SA0PR11MB475228709B9B0B6D74CE07A2F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
 <YHRat4egd/LM8DNJ@kroah.com>
 <SA0PR11MB47522D6E66CAD30CF0A63651F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR11MB47522D6E66CAD30CF0A63651F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 12, 2021 at 02:46:53PM +0000, Grumbach, Emmanuel wrote:
> > On Mon, Apr 12, 2021 at 02:29:45PM +0000, Grumbach, Emmanuel wrote:
> > > >
> > > > On Mon, Apr 12, 2021 at 01:44:58PM +0000, Grumbach, Emmanuel wrote:
> > > > > > > +#define IWL_MEI_DEBUG(c, f, a...)		\
> > > > > > > +	do {					\
> > > > > > > +		CHECK_FOR_NEWLINE(f);		\
> > > > > >
> > > > > > Huh?
> > > > > >
> > > > > > > +		dev_dbg(&(c)->dev, f, ## a);	\
> > > > > >
> > > > > > Just use dev_dbg(), don't be special for a single driver, it
> > > > > > hurts when trying to read different drivers.
> > > > >
> > > > > I took this from iwlwifi. I can change if needed, not a big deal.
> > > >
> > > > Please do.
> > > >
> > > > > > > +module_param_named(defer_start_message,
> > defer_start_message,
> > > > > > bool,
> > > > > > > +0644); MODULE_PARM_DESC(defer_start_message,
> > > > > > > +		 "Defer the start message Tx to CSME (default
> > false)");
> > > > > >
> > > > > > Why do you need this?  Who is going to set it to anything else,
> > > > > > and why would they?  This isn't the 1990's anymore, please do
> > > > > > not add new module parameters.
> > > > >
> > > > > For testing. I need this to be able to force a certain order of
> > > > > initialization
> > > > which is possible (and hence must be tested) but not likely to happen.
> > > > > Another point is tracing. This allows me to load the module but
> > > > > prevent any
> > > > real operation. Then, start tracing. This way, I can see the whole
> > > > flow in tracing, even the very beginning.
> > > >
> > > > Then call this something obvious,
> > > >
> > "kernel_hacker_debuging_testing_only_use_if_you_know_what_you_are_
> > > > doing".
> > > >
> > > > Or better yet, just put it in debugfs to turn it on/off and no
> > > > module parameter is needed at all.
> > > >
> > >
> > > Debugfs is not a replacement for module parameters. Debugfs can be
> > > used only after the driver already ran quite a bit of its
> > > initialization code path. Here I want to be able to catch the very
> > > first messages with tracing.
> > 
> > Then use the proper trace functionality of the kernel, which is not module
> > parameters :(
> 
> I am sorry if I drive you nuts but I don't know any "proper trace
> functionality" in the kernel that the user could enable / disable and
> that would be available immediately at init.

The in-kernel trace facilities do not work for boot code?
Documentation/tracing/boottime-trace.rst seems to disagree :)

> The user needs to
> "activate" the trace points using trace-cmd or whatever other tool. By
> the time the user does so, the driver has already run the code path I
> wish to debug. I can use debug prints, but you didn't seem happy about
> it. So I am happy to use tracing, but then we need to make sure it
> cover all the cases. The way I make it cover all the cases is with
> this module parameter. If you know a better way, I'll be happy to use
> it.

See the above document, there's nothing "special" about a single kernel
driver that should warrant a one-off user/kernel api like this.

thanks,

greg k-h
