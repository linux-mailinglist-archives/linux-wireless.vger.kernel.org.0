Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC9C30D5C6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Feb 2021 10:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhBCJDk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Feb 2021 04:03:40 -0500
Received: from mx3.wp.pl ([212.77.101.9]:53732 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232590AbhBCJD1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Feb 2021 04:03:27 -0500
Received: (wp-smtpd smtp.wp.pl 23666 invoked from network); 3 Feb 2021 10:02:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1612342945; bh=xJEmtkbgnpO4iwxpKMIMG3v2iyfIjI19TW5I9F6WVJ4=;
          h=From:To:Cc:Subject;
          b=TQUdRzS4CtMQnjMJjyogZhgeMCLOv4II7mNYhq2dUyimfhgZeXhbA6o+SIWEM3OtW
           iOWJP3/TurgUb0nhpa7Aq1N4s7cIevDAncb7hmlfFnP3i29OVEyoPWIPHP4WlWwBwL
           EuorPAvP32/1BxS2JqL1LquygbU9FieZPx0n2vW0=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <mathias.nyman@linux.intel.com>; 3 Feb 2021 10:02:25 +0100
Date:   Wed, 3 Feb 2021 10:02:24 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bernhard <bernhard.gebetsberger@gmx.at>
Subject: Re: [PATCH] usb, xhci, rt2800usb: do not perform Soft Retry
Message-ID: <20210203090224.GA155452@wp.pl>
References: <20210122104342.12451-1-stf_xl@wp.pl>
 <YAq9bt6q9dfk4F+F@kroah.com>
 <20210122132650.GA13029@wp.pl>
 <eb37b28d-5046-f0cd-92ee-55af0e350802@linux.intel.com>
 <20210123101418.GA16688@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123101418.GA16688@wp.pl>
X-WP-MailID: 93bb557ca9907e5b670e86f2459fd40b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IWPk]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Jan 23, 2021 at 11:14:19AM +0100, Stanislaw Gruszka wrote:
> On Fri, Jan 22, 2021 at 05:00:21PM +0200, Mathias Nyman wrote:
> > >> Or is this due to the specific host controller device hardware?  Should
> > >> this be a xhci quirk for a specific pci device instead?
> > 
> > Exactly, this should be checked.
> > Stanislaw, weren't there a few users already that saw this issue?
> 
> There are 30+ users cc-ed in the bugzilla report. However I think some
> of them are not affected by issue originally reported by Bernhard.
> They just saw "WARN Set TR Deq Ptr cmd failed due to incorrect slot
> or ep state" message caused by different problem and added comment
> to this particular bug report.
> 
> > Do we know what xHCI controllers they were using?
> 
> What I can tell issue was reported mostly on ASMedia and AMD
> controllers. We can ask for exact vendor and device IDs and
> just add xhci->quirks flag.
> 
> However I'm not entirely sure that xHCI hardware misbehave
> is actual root cause. I think equally probable is that
> connected device do not handle soft retry correctly. In that
> case disabling Soft Retry per device would be actually
> "lightest hammer" since other devices connected to the
> xHCI host could benefit from faster recovery.
> 
> Is there way to debug/identify which side: host or device
> hardware misbehave when Soft Retry is performed ?

So I think we do not have such possibility. If xhci quirk is
something that can be accepted I'll precede with such patch.
I'm going to ask bug reporters about xHCI conntroler PCI-id's ...

Stanislaw 
