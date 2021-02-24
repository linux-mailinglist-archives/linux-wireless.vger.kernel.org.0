Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9053245B1
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 22:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhBXVUt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 16:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhBXVUp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 16:20:45 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355A3C06178A
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 13:19:35 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u4so4108239ljh.6
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 13:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CnGA5dPETVoqoo5V9RmQYxGLOqYjvP5UErpZ6Y7yE4=;
        b=bNIBZaSb4MTT1WZX/0v81PJWc+tMSat+ez4FgxAqYUOxme3m8oPkkR8S/rPcnEJm6Y
         D8/jDocklHUkQe6yE9xwW/A9mhN58agRtkEYUSNrKQhCH/xcdegBhdmB3UGouk7RI5Bx
         XQIOEekBdmRRIGBhvMNSORufI5N4h6h5TkayAPrivoSjx7V+MGwr/umOOx0ErOjNlo81
         IwXj2dL31dZUUhr7LO2RczDmuZBCRfqX6lZdsMO3+TAMXx1qT3xx82pg+lQCoMlPCeG8
         MtRO0mLUTuXkRQGBl7okdhnvLwuWU/WQRZ80dDV7zDjgy9vgQUN6Ll8drl1u/cws/qG/
         5tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CnGA5dPETVoqoo5V9RmQYxGLOqYjvP5UErpZ6Y7yE4=;
        b=Yw1p+OF3BSOSKb11pefpOqsurnQrJsn9jkavYSrI1Zr3BGB90cgACW+ZTVSE5ccDyg
         +6KMDEhApGETXOp4ZFRL7vDMxh18rAIKzMRRHplUV8ttRGb4P+2iduNhLh28gl6qDTU8
         pAfDxxLxpsBeZOAXebZnIodoCRmfalhwXM+RKcJ5Z4WoF7jaaxFDUEVLWHl2Ge67q+oi
         yAZewOr2TY1hMbQMLwZxw2AHXyfSlxbAnrh4pNnpNKnbt7C2cHLYhwYNthqAveCWItK5
         UeRRWl/JBvquZg1zQk7Mn64iC/SV4NblVbM/eT5JzQ11HSEcKsKcW+GAyOEr2eoNSOB4
         7CYQ==
X-Gm-Message-State: AOAM531b8fYNu3LW6OmkFLOUKLNh7ImwFrZvQrS0ew084yQM4SnSHZbN
        0PGMpamleYM8gNX6mKiMRzj2xhZIrdOek0MzZ74=
X-Google-Smtp-Source: ABdhPJyvtAyxE4lQJhLy205thCCF4tBilxjOckcMTvF/5QU0PMkaHt/xk2mecrGe4RQEeT691s5yNhBhjMtJimK+CEY=
X-Received: by 2002:a2e:87cb:: with SMTP id v11mr3925054ljj.9.1614201573746;
 Wed, 24 Feb 2021 13:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20210224055135.1509200-1-davidm@egauge.net> <20210224055135.1509200-4-davidm@egauge.net>
In-Reply-To: <20210224055135.1509200-4-davidm@egauge.net>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Thu, 25 Feb 2021 08:19:21 +1100
Message-ID: <CAGRGNgUR7wHgprWcqz5orJNuhcxeLMSE1C3WCi1_UH_MCwJ6Cg@mail.gmail.com>
Subject: Re: [PATCH 4/4] wilc1000: Add support for enabling CRC
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     linux-wireless@vger.kernel.org,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi David,

On Wed, Feb 24, 2021 at 6:56 PM David Mosberger-Tang <davidm@egauge.net> wrote:
>
> The driver so far has always disabled CRC protection.  This means any
> data corruption that occurred during the SPI transfers could
> potentially go unnoticed.  This patch adds the macros ENABLE_CRC7 and
> ENABLE_CRC16 to allow compile-time selection of whether or not CRC7
> and CRC16, respectively, should be enabled.
>
> The default configuration remains unchanged, with both CRC7 and CRC16
> off.
>
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> ---
>  .../net/wireless/microchip/wilc1000/Kconfig   |   1 +
>  drivers/net/wireless/microchip/wilc1000/spi.c | 151 +++++++++++++-----
>  2 files changed, 108 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/Kconfig b/drivers/net/wireless/microchip/wilc1000/Kconfig
> index 7f15e42602dd..62cfcdc9aacc 100644
> --- a/drivers/net/wireless/microchip/wilc1000/Kconfig
> +++ b/drivers/net/wireless/microchip/wilc1000/Kconfig
> @@ -27,6 +27,7 @@ config WILC1000_SPI
>         depends on CFG80211 && INET && SPI
>         select WILC1000
>         select CRC7
> +       select CRC_ITU_T
>         help
>           This module adds support for the SPI interface of adapters using
>           WILC1000 chipset. The Atmel WILC1000 has a Serial Peripheral
> diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
> index b0e096a03a28..c745a440d273 100644
> --- a/drivers/net/wireless/microchip/wilc1000/spi.c
> +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
> @@ -7,10 +7,23 @@
>  #include <linux/clk.h>
>  #include <linux/spi/spi.h>
>  #include <linux/crc7.h>
> +#include <linux/crc-itu-t.h>
>
>  #include "netdev.h"
>  #include "cfg80211.h"
>
> +/**
> + * Establish the driver's desired CRC configuration.  CRC7 is used for
> + * command transfers which have no other protection against corruption
> + * during the SPI transfer.  Commands are short so CRC7 is relatively
> + * cheap.  CRC16 is used for data transfers, including network packet
> + * transfers.  Since those transfers can be large, CRC16 is relatively
> + * expensive.  CRC16 is also often redundant as network packets
> + * typically are protected by their own, higher-level checksum.
> + */
> +#define ENABLE_CRC7    0       /* set to 1 to protect SPI commands with CRC7 */
> +#define ENABLE_CRC16   0       /* set to 1 to protect SPI data with CRC16 */

Should these be Kconfig variables instead?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
