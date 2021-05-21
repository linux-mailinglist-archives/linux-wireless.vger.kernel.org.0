Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A015538BDC8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 07:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhEUFNg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 May 2021 01:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhEUFNf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 May 2021 01:13:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF625611AB;
        Fri, 21 May 2021 05:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621573932;
        bh=nDpPIcqQ7tMYokIoZEH1bwudVSb8GzAQ6uewYkXjeYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxDQgUlC2Rp5mlqnkYJA6djdfSNQA7S11Zmi9Y6dzNSa3plE8YrC7+vhwYdsDZfHm
         4ik08XmAb4RB4dDIdIzUR0xy+VA16c56OODn6+27bil2zm0WeBmfy6/o7rZ1xLkofM
         98JJbRXPM0XIHsYx3yX44dU2Ej4z9H25QGdNOXJA=
Date:   Fri, 21 May 2021 07:12:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeff Johnson <jjohnson@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Chao Yu <chao@kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2] b43: don't save dentries for debugfs
Message-ID: <YKdBJxWSXPM161hg@kroah.com>
References: <20210518163304.3702015-1-gregkh@linuxfoundation.org>
 <891f28e4c1f3c24ed1b257de83cbb3a0@codeaurora.org>
 <f539277054c06e1719832b9e99cbf7f1@codeaurora.org>
 <YKScfFKhxtVqfRkt@kroah.com>
 <2eb3af43025436c0832c8f61fbf519ad@codeaurora.org>
 <YKUyAoBq/cepglmk@kroah.com>
 <48aea7ae33faaafab388e24c3b8eb199@codeaurora.org>
 <YKU2vMoDO0Ch1Lyg@kroah.com>
 <36d75173b785819a4792ccceb5bf26b8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d75173b785819a4792ccceb5bf26b8@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 20, 2021 at 03:16:35PM -0700, Jeff Johnson wrote:
> On 2021-05-19 09:03, Greg Kroah-Hartman wrote:
> > On Wed, May 19, 2021 at 08:57:00AM -0700, Jeff Johnson wrote:
> > > Unless debugfs is disabled, like on Android, which is the real
> > > problem I'm
> > > trying to solve.
> > 
> > Then use some other filesystem to place your relay file in.  A relay
> > file is not a file that userspace should rely on for normal operation,
> > so why do you need it at all?
> > 
> > What tools/operation requires access to this file that systems without
> > debugfs support is causing problems on?
> 
> (trimmed some lists)
> 
> For the ath drivers (as well as the out-of-tree Android driver) it is being
> used for RF spectral scan which produces a large amount of data that is
> processed by a userspace analysis application.

And that application requires root access in order to be able to read
from the debugfs file today?  That feels risky.  And doesn't work for
Android systems today, right?

So what's wrong with just leaving it as-is, debugfs isn't going away on
debug Android kernels, which is when you need to run this type of thing,
only on the "user builds".

And if it's really an issue, take that up with Google, it's their
security policy that is driving this, not the community's requirements :)

And note, moving files out of debugfs to elsewhere in the system
circumvents the reasons that Google is not allowing debugfs anymore,
which defeats the purpose entirely of that decision.  Are you _sure_
that's a good idea for your users?

> I've been looking for an alternate filesystem to use, but am not finding
> anything where it appears easy to get a parent dentry, so any clues for the
> clueless (me) would be appreciated.

I'm not going to tell you how to abuse other filesystems in the kernel,
but it shouldn't be all that hard if you really want to do it...

good luck!

greg k-h
