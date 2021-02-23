Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0063223DC
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 02:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBWBuk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 20:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhBWBuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 20:50:24 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5FFC061797
        for <linux-wireless@vger.kernel.org>; Mon, 22 Feb 2021 17:49:44 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id o1so5779148ila.11
        for <linux-wireless@vger.kernel.org>; Mon, 22 Feb 2021 17:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :user-agent:mime-version:content-transfer-encoding;
        bh=ci8wXYipwJxE08+8GGgtfGeb5THSWd2nDZuv3Vzoi94=;
        b=HQE0Y/p440CXqcb2wD8vR0LqTtyDCtZ0u3UB0iHuYceaaF7mdnEBSQ4FVAekIS2LqA
         +8h+vCQxLOpjXzujSHkFdVfA/t+purJjaQoZwBYYU84FoPv8AqF1pWAZibGbYvyqI2Ok
         11a7kUydL8pd2iE2JTT6VK6nUAFOvy4PWjpDW6nVV933eez+GHgElHRqoNIuek+Cyt7E
         xgQt2bEvRCRn30ngni1kYCJI5XHPECWWJbO+c5SZ2WEMzSFlMiWBsjDxsu5bGZ8+JjLs
         q77yf9v5QA4IVOYIRf1kk30veTjg3RyzWk9G0qj7A3yaKPkr5f0+usGII4jnAYTn8Mq4
         YT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ci8wXYipwJxE08+8GGgtfGeb5THSWd2nDZuv3Vzoi94=;
        b=jvW7J8UqoXidAf0983ootZVueKU4GjqIxfNeFYGZv1YwWm+3H9utn8Ag9R80mBNd/R
         gIQJw4s5psInT6DbwD8huX8LKYIyLNYZ1Wo1eP17kgZ+FnR/pdZwRgCDyOdRCxN15sai
         0rROMzCi69eSH4El+0mzKDUrBWe+xC7EGNO1MYzMYffQKbLzDLcU1XpclfPFnCLmjcyQ
         Bmqw1pKK7DEW2EjRtc38FftlQwn0h97yrscKHL9HT5hzxjflGaJwe2Zs8sH6MhKwHz2c
         yqV55h/JORPzIglYy9yM8B7CdUzMXiDtrRZePSE3tTigEcNa6y7xBzU9uhOG19A3CxCk
         y09w==
X-Gm-Message-State: AOAM532xTdN9iywd8x2/Lh76A7Gdd+3hD9nGgOm9688QomTO6gP+Tltg
        cGb6cM3gceTsriVmi0N30QEyYQeuDsIQawU=
X-Google-Smtp-Source: ABdhPJzH5pCMdfTDWcgfa/7RrN3xM6tl3ye4swEiYDEpYI3sW4MmudHk+yCYpfbG5vyX2XiOAO/ThQ==
X-Received: by 2002:a92:d0c3:: with SMTP id y3mr18326488ila.116.1614044984229;
        Mon, 22 Feb 2021 17:49:44 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:a9bd:78af:febf:5008? ([2601:281:8300:4e0:a9bd:78af:febf:5008])
        by smtp.gmail.com with ESMTPSA id w8sm12972663ilu.1.2021.02.22.17.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 17:49:43 -0800 (PST)
Message-ID: <f3e0540462ed8bcc59787f71e3b1b258945a6142.camel@egauge.net>
Subject: Re: wilc1000 driver
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Date:   Mon, 22 Feb 2021 18:49:37 -0700
In-Reply-To: <eb6c6b39-f168-7237-d220-585f99532fd9@microchip.com>
References: <e8ed97f214f6087b7ac59298c8efe2d1144f7d55.camel@egauge.net>
         <eb6c6b39-f168-7237-d220-585f99532fd9@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ajay,

On Mon, 2021-02-22 at 10:01 +0000, Ajay.Kathat@microchip.com wrote:
> 
> On 22/02/21 5:52 am, David Mosberger-Tang wrote:
> > So, I'd like to provide some patches for the wilc driver, but I'm
> > unclear what the most effective way to go about this is.
> 
> To submit the patches for wilc1000 mainlined driver, please send the
> patches to linux-wireless mailing list. Have a look at *submitting
> patch* section in wireless wiki to know about the patch submission process.
> 
> Please refer the below link:
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

OK.

> > The driver in mainline (driver/net/wireless/microchip/wilc1000) only
> > seems to support WILC1000 (not WILC3000) and uses firmware:
> > 
> >   atmel/wilc1000_wifi_firmware-1.bin
> > 
> > whereas the linux-at91 driver (driver/staging/wilc1000) supports both
> > WILC1000 and WILC3000 and uses firmware
> > 
> >   mch/wilc1000_wifi_firmware.bin
> > 
> > (for WILC1000).
> 
> The WILC1000 15.4 firmware(wilc1000_wifi_firmware-1.bin) is available at
> linux-firmware repo.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> 
> Please use this firmware for your testing.

OK, can do.

> > For the hardware I have (embedded system with WILC1000/SPI), the
> > mainline driver doesn't load, whereas the driver from linux-at91 does
> > load and work(mostly).
> 
> What error are you getting during driver loading. Could you please check
> if FW file is available at "atmel/wilc1000_wifi_firmware-1.bin" path.

OK, the first issue was a trivial one: the mainline driver doesn't
appear to support the reset-gpios so, on our platform, the chip
remained in RESET and it never responded to anything.  Was reset-gpios
never supported in the mainline driver or was there a reason to remove
that support?

Anyhow, I worked around the reset issue.  Next problem: from what I can
see, wlan.c:chip_allow_sleep() only support SDIO, not SPI.  To work
around this issue, I just commented out the
chip_wakeup()/chip_allow_sleep() calls in acquire_bus() and
release_bus() for now.

Now the driver loads the firmware and generally seems to be happy.
However, as soon as a packet is received, things go awry.  I'm seeing
this:

WILC_SPI spi1.0 wlan0: ChipID [1003a0] loading firmware
[atmel/wilc1000_wifi_firmware-1.bin]
WILC_SPI spi1.0: Failed cmd response, cmd (ca), resp (09)

On the SPI bus, I see these commands:

 MOSI: 0xC8 0x00 0x00 0x00 0x00 0x00 0x38 (DMA_EXT_READ addr 0 size 56)
 MISO: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xC8 0x88 (command response)
 -----
 MOSI: 0x00
 MISO: 0xF3 (DATA header, last packet in this transaction)
 -----
 MOSI: 0x00*56
 MISO:   xx*56 (56 data bytes that may be a legitimate packet)

So far so good.  I don't know if this matters, but the last 8 bytes of
data all contain 0x09.

The problem from then on is that no matter what command is sent, the
chip always returns only 0x09 bytes.  For example, the first command
after the DMA read is:

 MOSI: 0xca 0x00 0x10 0x6c (SINGLE_READ)

but the MISO line only returns 0x09, hence the above "Failed cmd
response" error.

It's as if the chip wants to send much more than 56 data bytes.  The
byte-order for the DMA size matches that of the working driver though,
so maybe that's not it.

> The mainlined driver only support for WILC1000. WILC3000 chip(Wifi+BT
> combo) support needs to be added. Earlier the wilc driver was part of
> staging so adding new features were not encouraged but now new features
> are welcome.
> We need to port different features to the mainlined driver. Recently we
> have added the support for WMM[1]. Similarly we need to add other
> features(like wilc3000 support) to the mainline driver by following
> kernel development guideline.
> 
> 1. https://www.spinics.net/lists/linux-wireless/msg205899.html

OK, thanks for the background.  That's helpful.

  --david

