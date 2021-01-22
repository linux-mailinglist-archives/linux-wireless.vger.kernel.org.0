Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1264F300426
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 14:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbhAVN2J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 08:28:09 -0500
Received: from mx4.wp.pl ([212.77.101.12]:19475 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbhAVN1s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 08:27:48 -0500
Received: (wp-smtpd smtp.wp.pl 7307 invoked from network); 22 Jan 2021 14:26:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1611322011; bh=yA9yVqrJ3gaZW+uOgUd/gxZpdCsHjZBcVXElQwFmBG0=;
          h=From:To:Cc:Subject;
          b=c1aP54HkMnCS9qGrAorIcjYZUBD/m9+CJfieHAss5ulDN7KnW/I9TFize1+D7rkqR
           Rf/+eCVm9TvO2MZmOT0PCnYBBBIjr7kVnGdkn/ST0abOqP+OAZujZyQWujvpdZWwKr
           Kz9dvOQuUsOzZWiIwnHu+rN9WXU/JQmkRvvaaY88=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <greg@kroah.com>; 22 Jan 2021 14:26:50 +0100
Date:   Fri, 22 Jan 2021 14:26:50 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Greg KH <greg@kroah.com>
Cc:     linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bernhard <bernhard.gebetsberger@gmx.at>
Subject: Re: [PATCH] usb, xhci, rt2800usb: do not perform Soft Retry
Message-ID: <20210122132650.GA13029@wp.pl>
References: <20210122104342.12451-1-stf_xl@wp.pl>
 <YAq9bt6q9dfk4F+F@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAq9bt6q9dfk4F+F@kroah.com>
X-WP-MailID: 9f445cc3152969504b5d2e7df78eb0bf
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kePk]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 22, 2021 at 12:56:30PM +0100, Greg KH wrote:
> On Fri, Jan 22, 2021 at 11:43:42AM +0100, stf_xl@wp.pl wrote:
> > From: Stanislaw Gruszka <stf_xl@wp.pl>
> > 
> > Since f8f80be501aa ("xhci: Use soft retry to recover faster from transaction
> > errors") on some systems rt2800usb devices are unable to operate. Looks
> > that due to firmware or hardware limitations of those devices, they
> > require full recovery from USB Transaction Errors.
> > 
> > To avoid the problem add URB transfer flag, that restore pre f8f80be501aa
> > xhci behaviour when the flag is set. For now only add it only to rt2800usb
> > driver.
> 
> This feels like a really heavy hammer, to add a xhci flag for a single
> broken device.
> 
> Are you sure this is really needed?

I'm not sure if this is needed, however this particular bug was reported
as regression caused by f8f80be501aa commit on 4.19 -> 4.20 cycle. It
was reported to Mathias Nyman - xhci maintainer and f8f80be501aa commit
author. But since then, regardless of some Mathias work on this on xhci
side, we did not get solution that fixed the problem.

From other side, I can ask why change from f8f80be501aa is need? Taking
it's commit message, the benefit of the change is not obvious. What
I can notice, is that it only broke support for hardware that worked
previously. However I assume that the change is useful and needed,
so I come up with patch that just revert this change only for rt2800usb.

>  What does this device do on other
> operating systems, do they have such a quirk for their host controller
> driver?

I don't know what other OSes do.

> Or is this due to the specific host controller device hardware?  Should
> this be a xhci quirk for a specific pci device instead?

That certainly possible. However taking that the issue is observed
only when usb bus transition error happens, what I think can be
very rare, it's not easy to identify actual culprit of the problem.

> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202541
> > Fixes: f8f80be501aa ("xhci: Use soft retry to recover faster from transaction errors")
> > Reported-and-tested-by: Bernhard <bernhard.gebetsberger@gmx.at>
> > Bisected-by: Bernhard <bernhard.gebetsberger@gmx.at>
> > Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> > ---
> >  drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 3 +++
> >  drivers/usb/core/urb.c                         | 2 +-
> >  drivers/usb/host/xhci-ring.c                   | 3 ++-
> >  include/linux/usb.h                            | 1 +
> >  4 files changed, 7 insertions(+), 2 deletions(-)
[snip]
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -1329,6 +1329,7 @@ extern int usb_disabled(void);
> >  #define URB_ISO_ASAP		0x0002	/* iso-only; use the first unexpired
> >  					 * slot in the schedule */
> >  #define URB_NO_TRANSFER_DMA_MAP	0x0004	/* urb->transfer_dma valid on submit */
> > +#define URB_SOFT_RETRY_NOT_OK	0x0008	/* Avoid XHCI Soft Retry */
> 
> To match other flags here, how about "URB_NO_SOFT_RETRY"?

I named the flag based on existing "URB_SHORT_NOT_OK" flag, but I could
rename it to URB_NO_SOFT_RETRY, no problem with that. 

Stanislaw
