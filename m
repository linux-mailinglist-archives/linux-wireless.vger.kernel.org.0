Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE528470799
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbhLJRtN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 12:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240884AbhLJRtN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 12:49:13 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A020AC061746
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 09:45:37 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p65so11282778iof.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 09:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=v1viYl/UudRMttQQe/yHvDpLuNYxVO5SQwK9U9j7Zrg=;
        b=btf5XhZtfHvk6mK7Zl2l3ysyvCmqPeBtZPfPM8rdAQjk/IRgBilLKdchlcrL+kYGX8
         nc/f0xBvKIFxZ4EBoeXJJtBp/STpWpauYxWukpk6H57/MlO8/aqVgPNLGglXu5ugS1V+
         uIto9sdoOAyqgkyUb7KcHsz8FWdJRpVuTiiS/mpafPtigIrWJd7lxfd7MqEc6yGsVU5n
         iVBhWIIJUiNIZq90mhFD0cG2LGlrNAvqwSRFUz0aMoIotGRz7IgAuyhELb/dInlmKkae
         egg8VofmrhQMbJnLRB7Lt/CnTEAXGocaAhkQ3SHg7NXPCEz+xd+2NBsdpZHMAcfmlNtz
         kMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=v1viYl/UudRMttQQe/yHvDpLuNYxVO5SQwK9U9j7Zrg=;
        b=TQ5ysJHSSnhw+5uYL6ACu/ot1EUdPIaMfOGXddHjOLKrI1XKiBZ6fk344pcvvPGkjE
         Q5Dnyi+2/J9vYmKYhnqdDNwvR4FRiqfhBgQiBVJrUducPy4t/yssOZG9eMqXz+gskVPe
         OWLEDeeY5zIB0NbIUXMjGMYCVaFA/gdLZ9vTTfUxwP/cFhFemwbzMqrw2s5YTo0elMIm
         q6Z0/iRn8byG6rDSjrRS1ODhbNlVBxxOWEy6vJZ8xOgrmjgAUlb5bRO56Q3SlCSUj1X5
         fnE6GqLC+PrmXR86Txm8xUQm43+wgoxkvqKFmuGQp6DNSzURX5qWru4G2jJ72LrQ6KRj
         SIlg==
X-Gm-Message-State: AOAM533geOnQ2sYyZ5lgtDWdoRJYl9ZvA+ZJVkA+QzFlYlXETmqpUMha
        71hHBsnWsGKgCymn1rzQMAzLyQoKqrkrknU=
X-Google-Smtp-Source: ABdhPJzjGtvWqslJxIzDiO1Ld6ft1M93VtM8yw4lUlrdt5fFgev+qoaGdcKsCyrtrUsqsqXRqlWOSw==
X-Received: by 2002:a02:a314:: with SMTP id q20mr18806643jai.104.1639158336894;
        Fri, 10 Dec 2021 09:45:36 -0800 (PST)
Received: from bixby.lan (c-73-181-115-211.hsd1.co.comcast.net. [73.181.115.211])
        by smtp.gmail.com with ESMTPSA id i26sm3175244ila.12.2021.12.10.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:45:36 -0800 (PST)
Message-ID: <645c74e6e650de9348859ec95728a27edecf4e1b.camel@egauge.net>
Subject: Re: RFC: wilc1000 module parameter to disable chip sleep
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 10:45:33 -0700
In-Reply-To: <ac53bc89-485c-6f3d-7fbc-38ee8870a713@microchip.com>
References: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
         <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
         <a03e133e46ff305dbad796913b79c994c91581d5.camel@egauge.net>
         <efee7360e8be88d58251e38c848637c8163bdf19.camel@egauge.net>
         <ac53bc89-485c-6f3d-7fbc-38ee8870a713@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-12-10 at 09:05 +0000, Ajay.Kathat@microchip.com wrote:
> On 10/12/21 00:42, David Mosberger-Tang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, 2021-12-09 at 11:15 -0700, David Mosberger-Tang wrote:
> > 
> > > > Did you test by enabling the power-save mode with "wpa_supplicant" or
> > > > using "iw" command. For power consumption measurement, please try by
> > > > disabling the PSM mode.
> > > No, I have not played with power-saving mode.  There are some disconcerting
> > > messages when turning PSM on:
> > > 
> > > [ 1764.070375] wilc1000_spi spi1.0: Failed cmd, cmd (ca), resp (00)
> > > [ 1764.076403] wilc1000_spi spi1.0: Failed cmd, read reg (000013f4)...
> > As far as I can see, chip_wakeup() can trigger this legitimately:
> > 
> >                  do {
> >                          h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
> >                          h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
> >                                           reg | WILC_SPI_WAKEUP_BIT);
> >                          h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
> >                                           reg & ~WILC_SPI_WAKEUP_BIT);
> > 
> >                          do {
> >                                  usleep_range(2000, 2500);
> >                                  wilc_get_chipid(wilc, true);
> >                          } while (wilc_get_chipid(wilc, true) == 0);
> >                  } while (wilc_get_chipid(wilc, true) == 0);
> > 
> > Actually, the above looks rather gross.  wilc_get_chip() reads both WILC_CHIPID
> > and WILC_RF_REVISION_ID and we do this at least three times in a row on each
> > chip_wakeup().  Wow.  Is this really necessary?
> 
> I believe you are using the old driver code so please check with latest 
> code. 'chip_wakeup()' was changed recently so I don't think 
> 'wilc_get_chipid()' call is valid anymore inside this API.
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/microchip/wilc1000?h=v5.15&id=5bb9de8bcb18c38ea089a287b77944ef8ee71abd

Indeed I was.  I switched to 5.15 recently but thought I had backported all
patches, but I was missing a handful.  Yes, the new code is much better, thanks!

> > In any case, for now, the below supresses the error messages:
> > 
> > diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
> > index b778284247f7..516787aa4a23 100644
> > --- a/drivers/net/wireless/microchip/wilc1000/spi.c
> > +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
> > @@ -498,7 +498,7 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
> >          r = (struct wilc_spi_rsp_data *)&rb[cmd_len];
> >          if (r->rsp_cmd_type != cmd) {
> >                  if (!spi_priv->probing_crc)
> > -                       dev_err(&spi->dev,
> > +                       dev_dbg(&spi->dev,
> >                                  "Failed cmd, cmd (%02x), resp (%02x)\n",
> >                                  cmd, r->rsp_cmd_type);
> >                  return -EINVAL;
> > @@ -754,7 +754,8 @@ static int wilc_spi_read_reg(struct wilc *wilc, u32 addr, u32 *data)
> > 
> >          result = wilc_spi_single_read(wilc, cmd, addr, data, clockless);
> >          if (result) {
> > -               dev_err(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
> > +               /* Register reads may fail legitimately, e.g., during chip_wakeup(). */
> > +               dev_dbg(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
> >                  return result;
> >          }
> > 
> > 
> > Maybe a parameter should be added to hif_read_reg() to indicate whether failure is an option?
> 
> I have not observed the failure log specifically during 'chip_wakeup' 
> but if you see them often then we can add the information in comments.

My tree was missing the clockless register fixes as well so perhaps that's what
caused these.  It seems to be good now.

This is actually starting to look quite good!  Here is the current iperf3
throughput I'm getting:

PSM off:
[  4]   0.00-120.00 sec   137 MBytes  9.60 Mbits/sec    7             sender
[  5]   0.00-120.03 sec   281 MBytes  19.6 Mbits/sec                  receiver

PSM on:
[  4]   0.00-120.01 sec   140 MBytes  9.82 Mbits/sec    9             sender
[  5]   0.00-120.69 sec   283 MBytes  19.6 Mbits/sec                  receiver

I'll submit a patch to skip wakeup/allow_sleep if power-save mode is off.

The only remaining issue I'm seeing is that if I turn on power-save mode right
after starting wpa_supplicant, the driver thinks that PSM is on, but power
consumption indicates that it is not actually on (using about 1.5W of power).
When it's in this state, I have to manually use iw to turn PSM off and then on
again to get actual power-savings (power dropping to about 1.1W).

  --david


