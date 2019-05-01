Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3724110606
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 10:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfEAITi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 04:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfEAITi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 04:19:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9CF2081C;
        Wed,  1 May 2019 08:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556698777;
        bh=bWC0LcAlJPC8jN9zMpAc0d6AxArlEvJmC4Zb0WiW6us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xOBW9UhbPxikNfyVN6+izKRkYpxdlAVJvvL+KUwE99THg7zTb69Lcq/FmxljmIccs
         zRI72RHYOWRWeXoLV9HllMw6zGySx5rVQHj0G04tZzvpVbnCV4wkDD5i4005CyTlub
         d7oQmUQnp6osH2uXjhirBSnc7iUwglKVStqjeGwA=
Date:   Wed, 1 May 2019 10:19:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>, yhchuang@realtek.com,
        linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        pkshih@realtek.com, tehuang@realtek.com, Larry.Finger@lwfinger.net,
        briannorris@chromium.org
Subject: Re: [PATCH v9 00/14] rtw88: mac80211 driver for Realtek 802.11ac
 wireless network chips
Message-ID: <20190501081935.GB15425@kroah.com>
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
 <87sgtzwtst.fsf@purkki.adurom.net>
 <20190430155808.GA3019@redhat.com>
 <87v9yvo2y6.fsf@kamboji.qca.qualcomm.com>
 <20190430174234.GA16336@kroah.com>
 <87muk6odld.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muk6odld.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 01, 2019 at 10:09:34AM +0300, Kalle Valo wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Apr 30, 2019 at 07:47:13PM +0300, Kalle Valo wrote:
> >> Stanislaw Gruszka <sgruszka@redhat.com> writes:
> >> 
> >> > On Tue, Apr 30, 2019 at 03:40:02PM +0300, Kalle Valo wrote:
> >> >> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >> >> >
> >> >> > This is a new mac80211 driver for Realtek 802.11ac wireless network chips.
> >> >> > rtw88 now supports RTL8822BE/RTL8822CE now, with basic station mode
> >> >> > functionalities. The firmware for both can be found at linux-firmware.
> >> >> 
> >> >> This looks very good now. I did a quick review of the driver and had few
> >> >> netpicks but nothing really blocking applying this. So I have now
> >> >> combined these patches into one big patch and pushed it to the pending
> >> >> branch:
> >> >> 
> >> >> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=284d1e4e3311cfe67c1c57ccc275ff0f5666aeea
> >> >> 
> >> >> I appreciate if people could do a quick check and make sure that I
> >> >> didn't do anything stupid when folding the patches.
> >> >
> >> > I've build pending branch and done few quick tests on Realtek
> >> > 8822CE device. Everything works ok.
> >> 
> >> Thanks so much for this, I now feel much more comfortable merging it :)
> >> 
> >> So this is manually applied to wireless-drivers-next:
> >> 
> >> e3037485c68e rtw88: new Realtek 802.11ac driver
> >> 
> >> And it should be in tomorrow's linux-next build, let's see what kind of
> >> reports we get. Greg, feel free to delete the corresponding staging
> >> driver from your tree (I forgot the name of the driver already).
> >
> > I'll be glad to do so if someone also tells me what the driver's name is
> > as well, I don't remember either :)
> 
> I checked it now, the directory is drivers/staging/rtlwifi. Here's the
> commit adding the upstream driver, in case you need that in the commit
> log:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id=e3037485c68ec1a299ff41160d8fedbd4abc29b9

Thanks for this, now dropped from my tree (with the exception of 2 .h
files which a different driver used, and I'll clean that up as well with
a later patch.)

Note, the diffstat involved here shows that a "proper" Linux driver that
is merged into the kernel tree follows the rule-of-thumb that I have
consistently seen over time.  An in-tree driver that has been reviewed
properly is 33% of the size of an "out of tree" driver.  It's always
nice to see users benefit from properly developed drivers like this.

thanks,

greg k-h
