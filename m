Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B735C8D9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 16:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbhDLOf5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 10:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238739AbhDLOf4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 10:35:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1EC26134F;
        Mon, 12 Apr 2021 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618238138;
        bh=T30vEBWqcoh2kQVp3zE3oboaUNm5iCI2SbonBwIdZHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vgVIrUA7w7Rt9C1U8DeL+tqLEAKh23DLQQ7H0C8c+T7Wp1I++3wSMqdnRvf8x605f
         HJsp4ODyV9CO3hMbjs0DfmyvVAIS0GYH5T0UnmiczB2AT5IBKFNezVzzgeQ7KnW+7B
         8E/oGj8qdRNSMAHUqglxty472DhnW7/OmJrSKs7o=
Date:   Mon, 12 Apr 2021 16:35:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca@coelho.fi" <luca@coelho.fi>,
        "Beker, Ayala" <ayala.beker@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: Re: [PATCH RESEND 2/3] iwlwifi: mei: add the driver to allow
 cooperation with CSME
Message-ID: <YHRat4egd/LM8DNJ@kroah.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210412124328.24472-2-emmanuel.grumbach@intel.com>
 <YHRFy3aq/gB7Vde6@kroah.com>
 <SA0PR11MB475215678ADCCE657C6574D6F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
 <YHRWtJqbuFGmR2Sw@kroah.com>
 <SA0PR11MB475228709B9B0B6D74CE07A2F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR11MB475228709B9B0B6D74CE07A2F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 12, 2021 at 02:29:45PM +0000, Grumbach, Emmanuel wrote:
> > 
> > On Mon, Apr 12, 2021 at 01:44:58PM +0000, Grumbach, Emmanuel wrote:
> > > > > +#define IWL_MEI_DEBUG(c, f, a...)		\
> > > > > +	do {					\
> > > > > +		CHECK_FOR_NEWLINE(f);		\
> > > >
> > > > Huh?
> > > >
> > > > > +		dev_dbg(&(c)->dev, f, ## a);	\
> > > >
> > > > Just use dev_dbg(), don't be special for a single driver, it hurts
> > > > when trying to read different drivers.
> > >
> > > I took this from iwlwifi. I can change if needed, not a big deal.
> > 
> > Please do.
> > 
> > > > > +module_param_named(defer_start_message, defer_start_message,
> > > > bool,
> > > > > +0644); MODULE_PARM_DESC(defer_start_message,
> > > > > +		 "Defer the start message Tx to CSME (default false)");
> > > >
> > > > Why do you need this?  Who is going to set it to anything else, and
> > > > why would they?  This isn't the 1990's anymore, please do not add
> > > > new module parameters.
> > >
> > > For testing. I need this to be able to force a certain order of initialization
> > which is possible (and hence must be tested) but not likely to happen.
> > > Another point is tracing. This allows me to load the module but prevent any
> > real operation. Then, start tracing. This way, I can see the whole flow in
> > tracing, even the very beginning.
> > 
> > Then call this something obvious,
> > "kernel_hacker_debuging_testing_only_use_if_you_know_what_you_are_
> > doing".
> > 
> > Or better yet, just put it in debugfs to turn it on/off and no module
> > parameter is needed at all.
> > 
> 
> Debugfs is not a replacement for module parameters. Debugfs can be
> used only after the driver already ran quite a bit of its
> initialization code path. Here I want to be able to catch the very
> first messages with tracing.

Then use the proper trace functionality of the kernel, which is not
module parameters :(

> I'll print an error then. I still didn't understand what's the difference between BUG_ON and WARN_ON in your eyes.

Neither should be used in new code unless the kernel is so messed up
that the only way out is to reboot the machine, as both of them cause
that to happen.

thanks,

greg k-h
