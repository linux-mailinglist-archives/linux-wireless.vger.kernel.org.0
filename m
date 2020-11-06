Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1702A93CA
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgKFKL4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:11:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKFKLz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:11:55 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F64206CB;
        Fri,  6 Nov 2020 10:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604657513;
        bh=R/G/ijGguYtvMgwvXr02M4X5o++iqaSFXauB9Vtk6u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvthmEJOaFI4te9tNvs5dHTWUjbkx3b679VPnPWEhV2zNr5k+DtWYaE0hKHPkolLG
         MTFBPZnVN8Q5v4wez+SlztxcqThl+Hzssh84zEcYs5Aez4WHOCteixm7wVE8wFyDwl
         ln0AETlrE2Gc7aoMU4qOv9esEVrv09UIwExJzPqc=
Date:   Fri, 6 Nov 2020 11:12:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brian O'Keefe <bokeefe@alum.wpi.edu>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Add 024c:0627 to the list of SDIO
 device-ids
Message-ID: <20201106101240.GA2770702@kroah.com>
References: <CABtq2xReyqg1wJM7W1d=KWRNTNN0Q6HCgJMWcQ6DH=SmKcxQRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABtq2xReyqg1wJM7W1d=KWRNTNN0Q6HCgJMWcQ6DH=SmKcxQRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 29, 2020 at 09:52:16AM -0400, Brian O'Keefe wrote:
> Add 024c:0627 to the list of SDIO device-ids, based on hardware found in
> the wild. This hardware exists on at least some Acer SW1-011 tablets.
> 
> Signed-off-by: Brian O'Keefe <bokeefe@alum.wpi.edu>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 5b1392deb0a7..7256d55fcc1b 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -21,6 +21,7 @@ static const struct sdio_device_id sdio_ids[] =
>         { SDIO_DEVICE(0x024c, 0x0525), },
>         { SDIO_DEVICE(0x024c, 0x0623), },
>         { SDIO_DEVICE(0x024c, 0x0626), },
> +       { SDIO_DEVICE(0x024c, 0x0627), },
>         { SDIO_DEVICE(0x024c, 0xb723), },
>         { /* end: all zeroes */                         },
>  };
> --
> 2.25.1

All of the tabs are gone in your email and it's only spaces, making this
patch impossible to apply :(

Can you fix up your email client and resend this and keep Hans's
Reviewed-by on it?

thanks,

greg k-h
