Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635D838FB1D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 08:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhEYGor (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 02:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231197AbhEYGoq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 02:44:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3EAF613F9;
        Tue, 25 May 2021 06:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621924997;
        bh=SeNCHGkpDuqd+vKkt1qvz/en9DP7w5H/Z05UvYiBdNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzgQ+hahb5CsVq/6nxMIencVK8TBF49dn8AAHRnwKkS4hC9HlAaI+q26ZjCMvQtVS
         +Cg45bKaT+Efr0kAdAWU+YsaEZQnG4Vr8SkeidGWKLzC87QXUEmVH2oRlys8OxMTsN
         04x2WYo+HGUcAXJJbfrZxDT69WIOIBkMTtWah2PI=
Date:   Tue, 25 May 2021 08:43:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.4 39/52] brcmfmac: properly check for bus
 register errors
Message-ID: <YKycgrI+zh4seh7U@kroah.com>
References: <20210524144903.2498518-1-sashal@kernel.org>
 <20210524144903.2498518-39-sashal@kernel.org>
 <437445ee-a360-597f-f058-3b913984e064@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437445ee-a360-597f-f058-3b913984e064@broadcom.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 25, 2021 at 08:38:34AM +0200, Arend van Spriel wrote:
> On 5/24/2021 4:48 PM, Sasha Levin wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > [ Upstream commit 419b4a142a7ece36cebcd434f8ce2af59ef94b85 ]
> > 
> > The brcmfmac driver ignores any errors on initialization with the
> > different busses by deferring the initialization to a workqueue and
> > ignoring all possible errors that might happen.  Fix up all of this by
> > only allowing the module to load if all bus registering worked properly.
> 
> Hi Greg,
> 
> Saw this one flying by for stable kernel. Actually the first time I saw this
> patch, because I don't follow LKML as much as linux-wireless. The patch is
> fine, but wanted to give some context on the workqueue approach. It was
> there for historic reasons. Back then we had the UMH to provide firmware
> loading and because we request firmware during driver probe we could cause
> kernel boot to show significant delay when driver was built-in. Hence the
> workqueue which allowed kernel boot to proceed and driver probe was running
> in another thread context. These days we have direct firmware loading from
> the kernel and brcmfmac uses the asynchronous firmware loading API so there
> is indeed no longer a need for the workqueue.
> 
> Just for my understanding could you explain the motivation behind this
> change. In the preceding revert patch I saw this remark:
> 
> """
> The original commit here did nothing to actually help if usb_register()
> failed, so it gives a "false sense of security" when there is none.  The
> correct solution is to correctly unwind from this error.
> """
> 
> Does this mean the patch is addressing some security issue. Before your
> patch the module would remain loaded despite a bus register failure. I guess
> there is a story behind this that I am curious about.

The module would remain loaded, yes, but nothing would work, and so no
one would have any idea that something went wrong.  The original commit
was wrong, it did not actually solve anything.

This commit properly propagates any error that happens back to the user,
like any other module being loaded.

thanks,

greg k-h
