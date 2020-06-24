Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E838D206FBE
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbgFXJKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 05:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387970AbgFXJKC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 05:10:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2022F206FA;
        Wed, 24 Jun 2020 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592989801;
        bh=ySZRsnelEtYBE9E+FVEs9L8ikqhoNBjiN1Mye2PDBFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KPHh0wDlRKWHLWvJ9N6DUZIoTErg8CqXoedkQvXOW8ZlIDETkMb8fbG+JoUX8pXZt
         FlYHnIbPDwI8fuEotnM2Kw0k2P08t2PnVteZVDjaYgODDiSLeJ++nuM6BrPc2MaIEO
         Sz57wwRDereYAmoA8gz3Hz83fHrNZcvg9ozTq4mc=
Date:   Wed, 24 Jun 2020 11:10:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ajay.Kathat@microchip.com, devel@driverdev.osuosl.org,
        Venkateswara.Kaja@microchip.com, Sripad.Balwadgi@microchip.com,
        linux-wireless@vger.kernel.org, Nicolas.Ferre@microchip.com,
        johannes@sipsolutions.net
Subject: Re: [PATCH v7 00/17] wilc1000: move out of staging
Message-ID: <20200624091000.GD1731290@kroah.com>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
 <87ftaketkw.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftaketkw.fsf@tynnyri.adurom.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 24, 2020 at 11:50:07AM +0300, Kalle Valo wrote:
> <Ajay.Kathat@microchip.com> writes:
> 
> > From: Ajay Singh <ajay.kathat@microchip.com>
> >
> > This patch series is to review and move wilc1000 driver out of staging.
> > Most of the review comments received in [1] & [2] are addressed in the
> > latest code.
> > Please review and provide your inputs.
> >
> > [1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
> > [2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
> >
> > Changes since v6:
> >  - added Reviewed-by tag received for DT binding document patch earlier.
> >    * https://lore.kernel.org/linux-wireless/20200405013235.GA24105@bogus
> >  - merged latest driver and included --base commit as suggested.
> 
> Greg, in preparation for moving the driver to drivers/net/wireless can I
> ask you to not to take wilc1000 patches for the time being? I think that
> way it would be easier to move the driver between trees if there are no
> changes after v5.8-rc1. Or is there a better way handle the move?

The best way is for there to be a series of patches that just adds the
driver to the "real" part of the tree, and when that is merged, let me
know and I will just delete the driver version in the staging tree.

Does that work for you?

thanks,

greg k-h
