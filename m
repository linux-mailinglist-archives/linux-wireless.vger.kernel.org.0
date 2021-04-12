Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7421535C882
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 16:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbhDLOSy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 10:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240729AbhDLOSu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 10:18:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F8716134F;
        Mon, 12 Apr 2021 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618237111;
        bh=pNWZoIpmu2rp7M8xDOZcqOLiDQibig4dR0i3CfgfT4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yWI2u6JjQIOdwVqhkUNDt68KlLKtVv8pzGTfzt3BPEiui+Q2YrRarLUOc4UeD1fn8
         9mZj9oJd5G3AKUDFpFMjxtU4UwwrUvDbM+L78DJqfveyGdV7LeMUSBYY7hh2GMSMGS
         7U1cPJsG1WRu7I9ZkOioijj9T/0TvIuNSNLfE+4s=
Date:   Mon, 12 Apr 2021 16:18:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca@coelho.fi" <luca@coelho.fi>,
        "Beker, Ayala" <ayala.beker@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: Re: [PATCH RESEND 2/3] iwlwifi: mei: add the driver to allow
 cooperation with CSME
Message-ID: <YHRWtJqbuFGmR2Sw@kroah.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210412124328.24472-2-emmanuel.grumbach@intel.com>
 <YHRFy3aq/gB7Vde6@kroah.com>
 <SA0PR11MB475215678ADCCE657C6574D6F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR11MB475215678ADCCE657C6574D6F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 12, 2021 at 01:44:58PM +0000, Grumbach, Emmanuel wrote:
> > > +#define IWL_MEI_DEBUG(c, f, a...)		\
> > > +	do {					\
> > > +		CHECK_FOR_NEWLINE(f);		\
> > 
> > Huh?
> > 
> > > +		dev_dbg(&(c)->dev, f, ## a);	\
> > 
> > Just use dev_dbg(), don't be special for a single driver, it hurts when trying to
> > read different drivers.
> 
> I took this from iwlwifi. I can change if needed, not a big deal.

Please do.

> > > +module_param_named(defer_start_message, defer_start_message,
> > bool,
> > > +0644); MODULE_PARM_DESC(defer_start_message,
> > > +		 "Defer the start message Tx to CSME (default false)");
> > 
> > Why do you need this?  Who is going to set it to anything else, and why
> > would they?  This isn't the 1990's anymore, please do not add new module
> > parameters.
> 
> For testing. I need this to be able to force a certain order of initialization which is possible (and hence must be tested) but not likely to happen.
> Another point is tracing. This allows me to load the module but prevent any real operation. Then, start tracing. This way, I can see the whole flow in tracing, even the very beginning.

Then call this something obvious,
"kernel_hacker_debuging_testing_only_use_if_you_know_what_you_are_doing".

Or better yet, just put it in debugfs to turn it on/off and no module
parameter is needed at all.

> > > +	if (WARN_ON(rd > q_sz || wr > q_sz))
> > > +		return -EINVAL;
> > 
> > If any of the WARN_ON() things in this driver can ever trigger, just handle
> > them normally and do NOT call WARN_ON() as you just rebooted the box for
> > a simple thing that you could have recovered from.
> 
> My understanding is that WARN_ON does not reboot the box which is why it was invented when we already had BUG_ON. This can't be triggered by the user space, but can be triggered by the CSME firmware that runs on the chipset.

when panic_on_warn is enabled, the box will reboot.

If firmware can cause this, then properly handle the issue and continue
on, don't reboot machines.

> > Some of these WARN_ON() in the code feel very lazy as you control the
> > caller so you "know" that this will never happen.  So don't leave them in, it's
> > debugging code that you can now remove.
> 
> I can transform them in error prints, but again, my understanding is / was that WARN_ON is ok to use and won't reboot the box since it differs from BUG_ON.

Again, panic_on_warn.

> > > +
> > > +	IWL_MEI_DEBUG(cldev, "Got CSME filters\n");
> > 
> > ftrace is your friend, remove these pointless "the code got here!"
> > lines.  You have loads of them...
> 
> This is debug. Won't appear unless you want it.
> I have extensive tracing support.

Again, use ftrace for tracing, don't use debug print messages.

> > > +static void iwl_mei_handle_rx_host_own_req(struct mei_cl_device
> > *cldev,
> > > +					   const struct iwl_sap_msg_dw *dw)
> > {
> > > +	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
> > > +
> > > +	IWL_MEI_DEBUG(cldev, "Got ownership req response: %d\n", dw-
> > >val);
> > 
> > Code got here!  :(
> 
> Same, this is protected by a dynamic debug knob.
> I can see tons of those in mei bus driver .
> $ git grep _dbg\( -- drivers/misc/mei | wc -l
> 228

mei should be fixed as well.

> > > +
> > > +	if (!dw->val) {
> > > +		IWL_MEI_INFO(cldev, "Ownership req denied\n");
> > 
> > why?????
> > 
> > > +		return;
> > 
> > No error returned?
> 
> This is not an error. This means that the CSME firmware is not allowing the host to use the WLAN device.

Ok, and what can a user do about this?

> > > +	if (!netdev) {
> > > +		IWL_MEI_INFO(cldev, "No netdevice, dropping the Tx
> > packet\n");
> > 
> > quiet!!!
> 
> This is actually not a usual path. A race is happening here...

"race" implies "error" which is not "dev_info()" material.

> > Or at the least, make this an error so that a user can handle it properly.  They
> > can do something about this, right?  If not, why did you just tell them this
> > happened?
> 
> There isn't much I can do here. The CSME firmware is sending a packet
> to iwlmei to send on the WLAN link, but the link isn't valid anymore.

Then report an error.

> > > +		if (le16_to_cpu(hdr.type) != SAP_MSG_DATA_PACKET) {
> > > +			IWL_MEI_INFO(cldev, "Unsupported message: type
> > %d, len %d\n",
> > > +				     le16_to_cpu(hdr.type), len);
> > 
> > So userspace can spam the kernel log?
> 
> This is not userspace, this is the CSME firmware.

Then make it an error, not an informational message.  Someone needs to
see it to fix the firmware, right?

> > Please revisit _ALL_ of your messages you are printing out here, it feels way
> > way way too noisy, like you got the code up and working with the debug lines
> > in it and forgot to remove it.
> 
> [   12.665966] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: Got a valid SAP_ME_MSG_START_OK from CSME firmware
> 
> That's the only line I am printing by default. I can remove it. I can't do better than 0 printing.

0 printing would be good.

> > > +}
> > > +
> > > +#else
> > > +
> > > +static void iwl_mei_dbgfs_register(struct iwl_mei *mei) {} static
> > > +void iwl_mei_dbgfs_unregister(struct iwl_mei *mei) {}
> > 
> > This type of thing goes in a .h file, you know better.
> 
> A header file only for less a handful of functions?

You already have .h files for this code, why not put it in there?

thanks,

greg k-h
