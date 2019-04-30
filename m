Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A77FF09
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 19:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfD3Rmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 13:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfD3Rmh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 13:42:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C4A20835;
        Tue, 30 Apr 2019 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556646156;
        bh=NQTBFW4P4WSPJn2iZTnXZC9gQH8t5vD/aFSeejUncyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyNoo/nKLQtK7Zz7lCY/PGfvcfS4VtVbWnY3XYcZx3W116BHsPznweZQDNFc6qH8o
         DG/xhp3rAu6zHibyUHVkV+bXy+sN++mRXciLVkddDYA0cUPsS0cOaSOYNbubEyvrFw
         FGT6LGq2OfLmz6RPyBH1kEp7oRdfBHMeJ1VHcvJg=
Date:   Tue, 30 Apr 2019 19:42:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>, yhchuang@realtek.com,
        linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        pkshih@realtek.com, tehuang@realtek.com, Larry.Finger@lwfinger.net,
        briannorris@chromium.org
Subject: Re: [PATCH v9 00/14] rtw88: mac80211 driver for Realtek 802.11ac
 wireless network chips
Message-ID: <20190430174234.GA16336@kroah.com>
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
 <87sgtzwtst.fsf@purkki.adurom.net>
 <20190430155808.GA3019@redhat.com>
 <87v9yvo2y6.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9yvo2y6.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 30, 2019 at 07:47:13PM +0300, Kalle Valo wrote:
> Stanislaw Gruszka <sgruszka@redhat.com> writes:
> 
> > On Tue, Apr 30, 2019 at 03:40:02PM +0300, Kalle Valo wrote:
> >> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >> >
> >> > This is a new mac80211 driver for Realtek 802.11ac wireless network chips.
> >> > rtw88 now supports RTL8822BE/RTL8822CE now, with basic station mode
> >> > functionalities. The firmware for both can be found at linux-firmware.
> >> 
> >> This looks very good now. I did a quick review of the driver and had few
> >> netpicks but nothing really blocking applying this. So I have now
> >> combined these patches into one big patch and pushed it to the pending
> >> branch:
> >> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=284d1e4e3311cfe67c1c57ccc275ff0f5666aeea
> >> 
> >> I appreciate if people could do a quick check and make sure that I
> >> didn't do anything stupid when folding the patches.
> >
> > I've build pending branch and done few quick tests on Realtek
> > 8822CE device. Everything works ok.
> 
> Thanks so much for this, I now feel much more comfortable merging it :)
> 
> So this is manually applied to wireless-drivers-next:
> 
> e3037485c68e rtw88: new Realtek 802.11ac driver
> 
> And it should be in tomorrow's linux-next build, let's see what kind of
> reports we get. Greg, feel free to delete the corresponding staging
> driver from your tree (I forgot the name of the driver already).

I'll be glad to do so if someone also tells me what the driver's name is
as well, I don't remember either :)

thanks,

greg k-h
