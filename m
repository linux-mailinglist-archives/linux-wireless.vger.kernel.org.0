Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146A8211D00
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 09:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgGBHaA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 03:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGBHaA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 03:30:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853AC2089D;
        Thu,  2 Jul 2020 07:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593675000;
        bh=5KpG7Rmmj2kBiuJ1Yme87Hw2VHqvA6xqs+1sx9ftQoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wHQC0d+CCM/LJMpYfxGoKCynT4fkvYbws9pLSwiDwoLePgAk95lcRjEP54J82jRpe
         SNVOosMJamFaj6xamkTLeL7MwCV8HR6uP3ymQhTNAEFzmaW5XFW8MPKzQXXM6zcrvS
         PNcC73dRyFy48DJuqAmeZzg8ZjmCfiJjUKwYsCGU=
Date:   Thu, 2 Jul 2020 09:30:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay.Kathat@microchip.com
Cc:     kvalo@codeaurora.org, devel@driverdev.osuosl.org,
        Venkateswara.Kaja@microchip.com, Sripad.Balwadgi@microchip.com,
        linux-wireless@vger.kernel.org, Nicolas.Ferre@microchip.com,
        johannes@sipsolutions.net
Subject: Re: [PATCH] wilc1000: move wilc driver out of staging
Message-ID: <20200702073003.GA1073011@kroah.com>
References: <20200625123712.14156-1-ajay.kathat@microchip.com>
 <875zb6e6zr.fsf@tynnyri.adurom.net>
 <20200702071523.GB961982@kroah.com>
 <cb2299ce-c315-1748-b475-8798165d4111@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2299ce-c315-1748-b475-8798165d4111@microchip.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 02, 2020 at 07:24:34AM +0000, Ajay.Kathat@microchip.com wrote:
> 
> 
> On 02/07/20 12:45 pm, Greg KH wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, Jul 02, 2020 at 10:00:40AM +0300, Kalle Valo wrote:
> >> <Ajay.Kathat@microchip.com> writes:
> >>
> >>> From: Ajay Singh <ajay.kathat@microchip.com>
> >>>
> >>> WILC1000 is an IEEE 802.11 b/g/n IoT link controller module. The
> >>> WILC1000 connects to Microchip AVR/SMART MCUs, SMART MPUs, and other
> >>> processors with minimal resource requirements with a simple
> >>> SPI/SDIO-to-Wi-Fi interface.
> >>>
> >>> WILC1000 driver has been part of staging for few years. With
> >>> contributions from the community, it has improved significantly. Full
> >>> driver review has helped in achieving the current state.
> >>> The details for those reviews are captured in 1 & 2.
> >>>
> >>> [1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
> >>> [2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
> >>>
> >>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> >>> ---
> >>>
> >>> As suggested, keeping all the changes in single commit with file rename
> >>> so it's easy to move out of staging [3].
> >>>
> >>> Please choose whichever option you prefer between the git mv or patch series
> >>> sent last Tuesday. The resulting driver is the same as no patch has been
> >>> queued in between.
> >>>
> >>> [3]. https://lore.kernel.org/linux-wireless/20200623110000.31559-1-ajay.kathat@microchip.com/
> >>
> >> As discussed with Greg I created an immutable branch for this and merged
> >> the branch to wireless-drivers-next:
> >>
> >> 5625f965d764 wilc1000: move wilc driver out of staging
> >>
> >> Greg, here's the location of the immutable branch:
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git wilc1000-move-out-of-staging
> > 
> > Looks good, I've pulled it into my staging tree as well, but there's
> > still a TODO file left in drivers/staging/wilc1000, right?
> > 
> > I'll just add a patch to my tree to remove that last file.
> > 
> 
> Yes, TODO file needs to be removed after the driver movement.

Now gone from my tree.

> Thanks Greg for all your support to move driver out of staging.

Glad to see it move out, thanks to you all for all of your work!

greg k-h
