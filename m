Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7390D364788
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbhDSPzy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbhDSPzx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 11:55:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE1DC06174A
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 08:55:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id g16so1097599plq.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72VX1h+QEmBOLraT/ylsWP0LF7nl48k7IxZYtxGUkOw=;
        b=FwCkhIJ0qob2Eoe2paokYJQBiKrWnWC+w6OWtv+oAkUZR8g6/Rs9zCHwXlM6EVglfk
         GKrQBzbsMWdzCxstQXKp8pEvvstFb6IQPyvHiQ4+Q5Q0VzL1TM3bgEuxHwfjfy6na3IK
         lN185osi7KA+y4gQJw86JOPMQ0fQpxbUgGlhWoYaMz4w3W0rPOxim+Q88+0OoHEpIRik
         mfAKFwT8HeWF/Ig2KMFSKihqy/gdG6r9wS/Haq61+qyXg2U02Of619PWiH4kDoSHWbzU
         jBKbzwDkJdFx9dB1fnPMOv96DVZIsOTW3UybAaAm03sJhCNNRdJGJkymfjXuN8KI8Inc
         occw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72VX1h+QEmBOLraT/ylsWP0LF7nl48k7IxZYtxGUkOw=;
        b=GmZ0co+z6ZUD9Wunau2fVU6ACrNLrXhlHYTDjgkn5Sj2CxzbpIzQsj5GqepDeXWadq
         eJaMIXfW08vzH5lCsXCjo+chjBKBINdMLo1zt10EJ1BI4LFXkWG0lTVmeqFi67D4KiJp
         PqP/pe5GMmBkplgWSfICO91zKmMwv46MREDwhAeiN9ILv5Zl3kqtzSE4jtt9XkthZMh9
         Ahv7ymX8R/HxPdQ5qLRf2X0qMZxXJh06UJU6PFBXHZxOw5FdaR3C0gNRpO3mXwa5bNdx
         lZKhmuzO8SZ7rGoaQOmr/CvGcUtG5WUcbmKKdyptHq5fk54k3cnDduijqStUMnYpTqtr
         Ofog==
X-Gm-Message-State: AOAM533Kskow8IW8EUVjTJt+IgpBipYA9oYf9jg45uAfR8ACsQA/MiFD
        KxYkgJh/AF5z96F7ikv7LinjI7SiiNNNYpX0aSlmxQ==
X-Google-Smtp-Source: ABdhPJzmeTptVoP68cKZXRAF9F04F/oDNMnUpynJ4aIXeFbEU5DMi8YbekyUkGe2RvPstoofS/JtQ5HlERX7SS1o2x0=
X-Received: by 2002:a17:90a:c091:: with SMTP id o17mr25161444pjs.185.1618847721881;
 Mon, 19 Apr 2021 08:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210323193617.3748164-1-pterjan@google.com> <a69a3d60-71a0-3153-b248-dacc8b95bea8@gmail.com>
In-Reply-To: <a69a3d60-71a0-3153-b248-dacc8b95bea8@gmail.com>
From:   Pascal Terjan <pterjan@google.com>
Date:   Mon, 19 Apr 2021 16:55:05 +0100
Message-ID: <CAANdO=Kn+VeC3ucyOZdctdVoVH5Oc3drLAaipzz4ShL24e3ckg@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: Fix device info for RTL8192EU devices
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 19 Apr 2021 at 12:53, Jes Sorensen <jes.sorensen@gmail.com> wrote:
>
> On 3/23/21 3:36 PM, Pascal Terjan wrote:
> > Based on 2001:3319 and 2357:0109 which I used to test the fix and
> > 0bda:818b and 2357:0108 for which I found efuse dumps online.
> >
> > == 2357:0109 ==
> > === Before ===
> > Vendor: Realtek
> > Product: \x03802.11n NI
> > Serial:
> > === After ===
> > Vendor: Realtek
> > Product: 802.11n NIC
> > Serial not available.
> >
> > == 2001:3319 ==
> > === Before ===
> > Vendor: Realtek
> > Product: Wireless N
> > Serial: no USB Adap
> > === After ===
> > Vendor: Realtek
> > Product: Wireless N Nano USB Adapter
> > Serial not available.
> >
> > Signed-off-by: Pascal Terjan <pterjan@google.com>
> > ---
> >  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 11 ++--
> >  .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 53 ++++++++++++++++---
> >  2 files changed, 50 insertions(+), 14 deletions(-)
>
> This makes sense, you may want to account for the total length of the
> record though, see below.
>
> Some cosmetic nits too.

Thanks for the review, I'll send a v2

> > diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> > index d6d1be4169e5..acb6b0cd3667 100644
> > --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> > +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> > @@ -853,15 +853,10 @@ struct rtl8192eu_efuse {
> >       u8 usb_optional_function;
> >       u8 res9[2];
> >       u8 mac_addr[ETH_ALEN];          /* 0xd7 */
> > -     u8 res10[2];
> > -     u8 vendor_name[7];
> > -     u8 res11[2];
> > -     u8 device_name[0x0b];           /* 0xe8 */
> > -     u8 res12[2];
> > -     u8 serial[0x0b];                /* 0xf5 */
> > -     u8 res13[0x30];
> > +     u8 device_info[80];
> > +     u8 res11[3];
> >       u8 unknown[0x0d];               /* 0x130 */
> > -     u8 res14[0xc3];
> > +     u8 res12[0xc3];
> >  };
> >
> >  struct rtl8xxxu_reg8val {
> > diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
> > index cfe2dfdae928..9c5fad49ed2a 100644
> > --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
> > +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
> > @@ -554,9 +554,39 @@ rtl8192e_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
> >       }
> >  }
> >
> > +static void rtl8192eu_log_device_info(struct rtl8xxxu_priv *priv,
> > +                                   char *record_name,
> > +                                   char **record)
> > +{
> > +     /* A record is [ total length | 0x03 | value ] */
> > +     unsigned char l = (*record)[0];
>
> These parenthesis make no sense.
>
> > +
> > +     /* The whole section seems to be 80 characters so a record should not
> > +      * be able to be that large.
> > +      */
>
> Please respect the comment formatting of the driver, ie
> /*
>  * Foo
>  */

I blame checkpatch telling me "WARNING: networking block comments
don't use an empty /* line, use /* Comment..." (and myself for not
checking the driver again when fixing it :) )

> > +     if (l > 80) {
> > +             dev_warn(&priv->udev->dev,
> > +                      "invalid record length %d while parsing \"%s\".\n",
> > +                      l, record_name);
> > +             return;
> > +     }
>
> The 80 check is only valid for the first entry, consecutive entries are
> already advanced. Maybe switch it over to use an index to address into
> the record keep an index and just pass in efuse->device_info instead.
>
> > +
> > +     if (l >= 2) {
> > +             char value[80];
> > +
> > +             memcpy(value, &(*record)[2], l - 2);
> > +             value[l - 2] = '\0';
> > +             dev_info(&priv->udev->dev, "%s: %s\n", record_name, value);
> > +             *record = *record + l;
> > +     } else {
> > +             dev_info(&priv->udev->dev, "%s not available.\n", record_name);
> > +     }
> > +}
> > +
> >  static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
> >  {
> >       struct rtl8192eu_efuse *efuse = &priv->efuse_wifi.efuse8192eu;
> > +     char *record = efuse->device_info;
> >       int i;
> >
> >       if (efuse->rtl_id != cpu_to_le16(0x8129))
> > @@ -604,12 +634,23 @@ static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
> >       priv->has_xtalk = 1;
> >       priv->xtalk = priv->efuse_wifi.efuse8192eu.xtal_k & 0x3f;
> >
> > -     dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
> > -     dev_info(&priv->udev->dev, "Product: %.11s\n", efuse->device_name);
> > -     if (memchr_inv(efuse->serial, 0xff, 11))
> > -             dev_info(&priv->udev->dev, "Serial: %.11s\n", efuse->serial);
> > -     else
> > -             dev_info(&priv->udev->dev, "Serial not available.\n");
> > +     /* device_info section seems to be laid out as records
> > +      * [ total length | 0x03 | value ] so:
> > +      * - vendor length + 2
> > +      * - 0x03
> > +      * - vendor string (not null terminated)
> > +      * - product length + 2
> > +      * - 0x03
> > +      * - product string (not null terminated)
> > +      * Then there is one or 2 0x00 on all the 4 devices I own or found
> > +      * dumped online.
> > +      * As previous version of the code handled an optional serial
> > +      * string, I now assume there may be a third record if the
> > +      * length is not 0.
> > +      */
> > +     rtl8192eu_log_device_info(priv, "Vendor", &record);
> > +     rtl8192eu_log_device_info(priv, "Product", &record);
> > +     rtl8192eu_log_device_info(priv, "Serial", &record);
> >
> >       if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE) {
> >               unsigned char *raw = priv->efuse_wifi.raw;
> >
>
