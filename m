Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5161B20761D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403998AbgFXOw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 10:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389818AbgFXOw4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 10:52:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70DC320768;
        Wed, 24 Jun 2020 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593010375;
        bh=hKmGmSC9xKTCf7lKHaapRGzqdChdaLEB6DXAWD8Qde8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=18rDFvSPwlbcr568/S5o0ulxaiBng2umL68WZE7Gn3lPelYVsylFSO6HBMbl8OJ5y
         kOAPshUeLYFDRilCyMNQ+cyFgyDaSTqyRpqAtnry/ccNY1YA6SnQQ60+TXOAq7sETn
         Q7riK6XjUUvKv7diy3O+vZ/RRe2MIztTSWv4jNio=
Date:   Wed, 24 Jun 2020 16:52:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ajay.Kathat@microchip.com, devel@driverdev.osuosl.org,
        Venkateswara.Kaja@microchip.com, Sripad.Balwadgi@microchip.com,
        linux-wireless@vger.kernel.org, Nicolas.Ferre@microchip.com,
        johannes@sipsolutions.net
Subject: Re: [PATCH v7 00/17] wilc1000: move out of staging
Message-ID: <20200624145254.GA1876138@kroah.com>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
 <87ftaketkw.fsf@tynnyri.adurom.net>
 <20200624091000.GD1731290@kroah.com>
 <87366kztcr.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87366kztcr.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 24, 2020 at 12:49:24PM +0300, Kalle Valo wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Wed, Jun 24, 2020 at 11:50:07AM +0300, Kalle Valo wrote:
> >> <Ajay.Kathat@microchip.com> writes:
> >> 
> >> > From: Ajay Singh <ajay.kathat@microchip.com>
> >> >
> >> > This patch series is to review and move wilc1000 driver out of staging.
> >> > Most of the review comments received in [1] & [2] are addressed in the
> >> > latest code.
> >> > Please review and provide your inputs.
> >> >
> >> > [1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
> >> > [2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
> >> >
> >> > Changes since v6:
> >> >  - added Reviewed-by tag received for DT binding document patch earlier.
> >> >    * https://lore.kernel.org/linux-wireless/20200405013235.GA24105@bogus
> >> >  - merged latest driver and included --base commit as suggested.
> >> 
> >> Greg, in preparation for moving the driver to drivers/net/wireless can I
> >> ask you to not to take wilc1000 patches for the time being? I think that
> >> way it would be easier to move the driver between trees if there are no
> >> changes after v5.8-rc1. Or is there a better way handle the move?
> >
> > The best way is for there to be a series of patches that just adds the
> > driver to the "real" part of the tree, and when that is merged, let me
> > know and I will just delete the driver version in the staging tree.
> >
> > Does that work for you?
> 
> It would be fine for me but won't that approach break the build (eg.
> allyesconfig) due to two duplicate versions of the same driver in
> wireless-drivers-next?

For maybe one day, yes, but that's all.

> What I was thinking that Ajay would create a patch moving the driver
> from drivers/staging/wilc1000 to
> drivers/net/wireless/microchip/wilc1000. Using 'git mv' and 'git
> format-patch --find-renames' the patch should be really small, mostly
> just renames and small changes to Kconfig, Makefile and MAINTAINERS
> files. But this of course would require that there are no wilc1000
> patches in your tree until you get the driver move commit during the
> next merge window, otherwise we would see conflicts between staging-next
> and wireless-drivers-next.
> 
> But I don't have any strong opinions, whatever is easiest for everyone :)

It's kind of hard to review patches that do moves, but if you all want
to do that, that's fine with me.

Note, I can't guarantee that I'll not take any wilc1000 patches, I'll
probably forget, but git mv will handle all of that just fine.

thanks,

greg k-h
