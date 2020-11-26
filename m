Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAAA2C4F6D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 08:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbgKZH11 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 02:27:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbgKZH11 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 02:27:27 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3A421D81;
        Thu, 26 Nov 2020 07:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606375646;
        bh=Jhy6nXSwlJkOlHBD5C6ynntz3eKzwcrAp3/DgIorPoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S79InGQMVvFh4rAkwAFhZj7M3WPxwS7zPptn4W+G6tsAN5RBwIUWFuSUSBLt5lCCj
         rOFlvP2p+A4ZzyPGfFt7uqwadTGggoR4AuCl41i3ols3iz9Dbzg1y1rvdNzynUQCCA
         X8Fx72750pIXo9IB0pMKWzBe9jL9PDpiP0jaC7wo=
Date:   Thu, 26 Nov 2020 08:28:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Brian O'Keefe <bokeefe@alum.wpi.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH 1/2] mmc: sdio: Move SDIO IDs from rtl8723bs, driver to
 common include file
Message-ID: <X79ZH+COJbxqd+eJ@kroah.com>
References: <16529bfd-0308-5da9-f7ce-4ffa9f77b4d0@alum.wpi.edu>
 <a646a587-25ae-2395-a169-3742ba7f9723@alum.wpi.edu>
 <X76svnTHv34FJaHI@kroah.com>
 <1760357a038.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760357a038.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 26, 2020 at 07:57:23AM +0100, Arend Van Spriel wrote:
> On November 25, 2020 8:13:07 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Nov 25, 2020 at 01:33:00PM -0500, Brian O'Keefe wrote:
> > > Macro names were derived from the Windows driver, as that was the best
> > > available source.
> > 
> > Why move these?  What does this help with?
> 
> Hi Greg,
> 
> Most if not all SDIO-based (wifi) drivers in mainline have their venid and
> devid definitions in that header file. So seems like a good idea to me, but
> maybe not so for a staging driver?

If the driver ever gets moved out, maybe do it then as part of that
effort.  I haven't seen that happening, so I would recommend just
leaving this alone for now.

thanks,

greg k-h
