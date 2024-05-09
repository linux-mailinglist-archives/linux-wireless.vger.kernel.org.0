Return-Path: <linux-wireless+bounces-7386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E971C8C0DF4
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082481C20F08
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2514AD1C;
	Thu,  9 May 2024 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6gVxXAC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328114A4FF;
	Thu,  9 May 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715249099; cv=none; b=BWgE2ujv32Gm4fT/93xXbHBhPwuO5bNFekVJXVDIpwotOAj17p1zXbbfhRg2l392/xyLrASFMVNnuuGvaBNnZmVU3syf7FYB/pcFMpJAv4Q09IeExvSeFQz0buqjPspVpKLd8LHRrUJlh94XgZ8Qa8B5U2sistyg7BuHvJRV5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715249099; c=relaxed/simple;
	bh=IfMoDQWY48qsrBKQhlHUTl/fNsBkkkR7LISA/6xuS9Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3s4uEgaDW1YWhuJ/PSeoHkAN0MV4B7C7bgiQW3KxZw/FLe6IRTx2wBZQhkQ6hUOCm77TY4Q53oliRc38yd37UgmdHlH/o8MCa5jou/KIV1Y/Pn29jbrGemVoLlPIxyJNkkRNpmDpfjQ912b/tUO7bBr/TFYKnIUoffhXBKn0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6gVxXAC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41fc2f7fbb5so3479025e9.1;
        Thu, 09 May 2024 03:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715249096; x=1715853896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G8bJUHKzT4cckh7Csum6u92RyLMuy6+Rog15X/qkuuw=;
        b=X6gVxXACmXmIGNA5MU0Qjgto5bPsC7uaHpIVufD6aLoSsAvitJO1ANgiEx5YgwE3BO
         ghTLEin1Q7L46wYeX9igkgajuNbgEhpufCSw6FapKiz0uSXjleIO34+X5W6xQzJTfL02
         2Gw43uK5J9PkT1d7m8f4/OCV/xomxLAhmTqWPf7GHN14xtLCsI1HiaNUegU7a5nkw1+Z
         aGM8xDIjlU1W77bzAi6p3sps3tDbKKxoM2RzAxXChRkTPRiw9lkM9uQ+p7tBOUhHX/z8
         PNTfEXkP0E3TknQeUrT2BgrnCQNT7xxIUoergiTIFJer/qiw6MqlR2e/pNGk340uca9t
         RgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715249096; x=1715853896;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8bJUHKzT4cckh7Csum6u92RyLMuy6+Rog15X/qkuuw=;
        b=Jo7zOpe6uKrBl+/JQosN/TVfMFUdXFMlpc34JodmrTWrGVKbBHc86+JILOICBZbFm0
         TToHn5iGGdMJHycA8pjeYRK9xWgVLr3TqbQXcF1D7Mm1IW8d5X3R4gBfNwRAQb9cYLSy
         zOHUWAOZsDYXs+YmOo5FrqmzW7gMp5NAhnhIXATaNiWpIhI9+QuNd436bpXw33pchyDF
         1UF55ZfzVSnoX5tQHXTYp9meXIm1XTG871eXXW2B9QhhUI0M9OCzhWVdykfFnonQCNIr
         7S8DPsUgnh3BoKbDOmsrRKJz6hoMkm+Oy6EN8msgWZpVOXHAsmZfS3xzyEFqHDnqGJTP
         NqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXACXNvnX0NXY0s4qNs5puWYsR91kkdlSiQ0UczpTy6d18OLargj0skwW0IuWBxxV5iy1MFG6fouAMxqkAb1X40VCVAN0u1OEL+M5q8iNA6XMHo5RCZZ8TC7d3PSpQ6sVJXnU9Yq+c5QlIQ+/nzR/VTpzbs0BKLjjtFDIzGIXIjgmcztvc=
X-Gm-Message-State: AOJu0Yzxw+v72XAYkmK2mXM3ULkN6vRI/LMud8iDYT6saQqxIJI6XpcL
	0TWdJ/eOHAe5fGRyfe1fT4wAZd9Abm6W0wMnOSBXiF7JiCtI3k7L
X-Google-Smtp-Source: AGHT+IFubYDzH/R/sEBcBaXb48wBShYfqFDm0AmdYNsLwjhe/Po/fGXZsk9mxd+Mubhfnib/ltG3/A==
X-Received: by 2002:a05:600c:3103:b0:41b:f43b:e263 with SMTP id 5b1f17b1804b1-41fbc12bdcbmr18994445e9.0.1715249095619;
        Thu, 09 May 2024 03:04:55 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe100csm20295685e9.40.2024.05.09.03.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:04:55 -0700 (PDT)
Message-ID: <663c9fc7.050a0220.5fb3a.4e87@mx.google.com>
X-Google-Original-Message-ID: <ZjyfxNXUfButVfN7@Ansuel-XPS.>
Date: Thu, 9 May 2024 12:04:52 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Sebastian Gottschall <s.gottschall@dd-wrt.com>,
	Steve deRosier <derosier@cal-sierra.com>,
	Stefan Lippers-Hollmann <s.l-h@gmx.de>
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
 <878rcjbaqs.fsf@kernel.org>
 <648cdebb.5d0a0220.be7f8.a096@mx.google.com>
 <648ded2a.df0a0220.b78de.4603@mx.google.com>
 <CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
 <87v83nlhb3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v83nlhb3.fsf@kernel.org>

On Thu, May 09, 2024 at 07:50:40AM +0300, Kalle Valo wrote:
> Ansuel Smith <ansuelsmth@gmail.com> writes:
> 
> > Il giorno sab 17 giu 2023 alle ore 19:28 Christian Marangi
> > <ansuelsmth@gmail.com> ha scritto:
> >
> >>
> >> On Fri, Jun 16, 2023 at 01:35:04PM +0200, Christian Marangi wrote:
> >> > On Fri, Jun 16, 2023 at 08:03:23PM +0300, Kalle Valo wrote:
> >> > > Christian Marangi <ansuelsmth@gmail.com> writes:
> >> > >
> >> > > > From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> >> > > >
> >> > > > Adds LED and GPIO Control support for 988x, 9887, 9888, 99x0, 9984
> >> > > > based chipsets with on chipset connected led's using WMI Firmware API.
> >> > > > The LED device will get available named as "ath10k-phyX" at sysfs and
> >> > > > can be controlled with various triggers.
> >> > > > Adds also debugfs interface for gpio control.
> >> > > >
> >> > > > Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> >> > > > Reviewed-by: Steve deRosier <derosier@cal-sierra.com>
> >> > > > [kvalo: major reorg and cleanup]
> >> > > > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> >> > > > [ansuel: rebase and small cleanup]
> >> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >> > > > Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> >> > > > ---
> >> > > >
> >> > > > Hi,
> >> > > > this is a very old patch from 2018 that somehow was talked till 2020
> >> > > > with Kavlo asked to rebase and resubmit and nobody did.
> >> > > > So here we are in 2023 with me trying to finally have this upstream.
> >> > > >
> >> > > > A summarize of the situation.
> >> > > > - The patch is from years in OpenWRT. Used by anything that has ath10k
> >> > > >   card and a LED connected.
> >> > > > - This patch is also used by the fw variant from Candela Tech with no
> >> > > >   problem reported.
> >> > > > - It was pointed out that this caused some problem with ipq4019 SoC
> >> > > >   but the problem was actually caused by a different bug related to
> >> > > >   interrupts.
> >> > > >
> >> > > > I honestly hope we can have this feature merged since it's really
> >> > > > funny to have something that was so near merge and jet still not
> >> > > > present and with devices not supporting this simple but useful
> >> > > > feature.
> >> > >
> >> > > Indeed, we should finally get this in. Thanks for working on it.
> >> > >
> >> > > I did some minor changes to the patch, they are in my pending branch:
> >> > >
> >> > > https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=686464864538158f22842dc49eddea6fa50e59c1
> >> > >
> >> > > My comments below, please review my changes. No need to resend because
> >> > > of these.
> >> > >
> >> >
> >> > Hi,
> >> > very happy this is going further.
> >> >
> >> > > > --- a/drivers/net/wireless/ath/ath10k/Kconfig
> >> > > > +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> >> > > > @@ -67,6 +67,23 @@ config ATH10K_DEBUGFS
> >> > > >
> >> > > >     If unsure, say Y to make it easier to debug problems.
> >> > > >
> >> > > > +config ATH10K_LEDS
> >> > > > + bool "Atheros ath10k LED support"
> >> > > > + depends on ATH10K
> >> > > > + select MAC80211_LEDS
> >> > > > + select LEDS_CLASS
> >> > > > + select NEW_LEDS
> >> > > > + default y
> >> > > > + help
> >> > > > +   This option enables LEDs support for chipset LED pins.
> >> > > > +   Each pin is connected via GPIO and can be controlled using
> >> > > > +   WMI Firmware API.
> >> > > > +
> >> > > > +   The LED device will get available named as "ath10k-phyX" at sysfs and
> >> > > > +           can be controlled with various triggers.
> >> > > > +
> >> > > > +   Say Y, if you have LED pins connected to the ath10k wireless card.
> >> > >
> >> > > I'm not sure anymore if we should ask anything from the user, better to
> >> > > enable automatically if LED support is enabled in the kernel. So I
> >> > > simplified this to:
> >> > >
> >> > > config ATH10K_LEDS
> >> > >     bool
> >> > >     depends on ATH10K
> >> > >     depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
> >> > >     default y
> >> > >
> >> > > This follows what mt76 does:
> >> > >
> >> > > config MT76_LEDS
> >> > >     bool
> >> > >     depends on MT76_CORE
> >> > >     depends on LEDS_CLASS=y || MT76_CORE=LEDS_CLASS
> >> > >     default y
> >> > >
> >> >
> >> > I remember there was the same discussion in a previous series. OK for me
> >> > for making this by default, only concern is any buildbot error (if any)
> >> >
> >> > Anyway OK for the change.
> >> >
> >> > > > @@ -65,6 +66,7 @@ static const struct ath10k_hw_params
> >> > > > ath10k_hw_params_list[] = {
> >> > > >           .dev_id = QCA988X_2_0_DEVICE_ID,
> >> > > >           .bus = ATH10K_BUS_PCI,
> >> > > >           .name = "qca988x hw2.0",
> >> > > > +         .led_pin = 1,
> >> > > >           .patch_load_addr = QCA988X_HW_2_0_PATCH_LOAD_ADDR,
> >> > > >           .uart_pin = 7,
> >> > > >           .cc_wraparound_type = ATH10K_HW_CC_WRAP_SHIFTED_ALL,
> >> > >
> >> > > I prefer following the field order from struct ath10k_hw_params
> >> > > declaration and also setting fields explicitly to zero (even though
> >> > > there are gaps still) so I changed that for every entry.
> >> > >
> >> >
> >> > Thanks for the change, np for me.
> >> >
> >> > > > +int ath10k_leds_register(struct ath10k *ar)
> >> > > > +{
> >> > > > + int ret;
> >> > > > +
> >> > > > + if (ar->hw_params.led_pin == 0)
> >> > > > +         /* leds not supported */
> >> > > > +         return 0;
> >> > > > +
> >> > > > + snprintf(ar->leds.label, sizeof(ar->leds.label), "ath10k-%s",
> >> > > > +          wiphy_name(ar->hw->wiphy));
> >> > > > + ar->leds.wifi_led.active_low = 1;
> >> > > > + ar->leds.wifi_led.gpio = ar->hw_params.led_pin;
> >> > > > + ar->leds.wifi_led.name = ar->leds.label;
> >> > > > + ar->leds.wifi_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
> >> > > > +
> >> > > > + ar->leds.cdev.name = ar->leds.label;
> >> > > > + ar->leds.cdev.brightness_set_blocking = ath10k_leds_set_brightness_blocking;
> >> > > > +
> >> > > > + /* FIXME: this assignment doesn't make sense as it's NULL, remove it? */
> >> > > > + ar->leds.cdev.default_trigger = ar->leds.wifi_led.default_trigger;
> >> > >
> >> > > But what to do with this FIXME?
> >> > >
> >> >
> >> > It was pushed by you in v13.
> >> >
> >> > I could be wrong but your idea was to prepare for future support of
> >> > other patch that would set the default_trigger to the mac80211 tpt.
> >> >
> >> > We might got both confused by default_trigger and default_state.
> >> > default_trigger is actually never set and is NULL (actually it's 0)
> >> >
> >> > We have other 2 patch that adds tpt rates for the mac80211 LED trigger
> >> > and set this trigger as the default one but honestly I would chose a
> >> > different implementation than hardcoding everything.
> >> >
> >> > If it's ok for you, I would drop the comment and the default_trigger and
> >> > I will send a follow-up patch to this adding DT support by using
> >> > led_classdev_register_ext and defining init_data.
> >> > (and this indirectly would permit better LED naming and defining of
> >> > default-trigger in DT)
> >> >
> >> > Also ideally I will also send a patch for default_state following
> >> > standard LED implementation. (to set default_state in DT)
> >> >
> >> > I would prefer this approach as the LED patch already took way too much
> >> > time and I think it's better to merge this initial version and then
> >> > improve it.
> >>
> >> If you want to check out I attached the 2 patch (one dt-bindings and the
> >> one for the code) that I will submit when this will be merged (the
> >> change is with the assumption that the FIXME line is dropped)
> >>
> >> Tested and works correctly with my use case of wifi card attached with
> >> pcie. This implementation permits to declare the default trigger in DT
> >> instead of hardcoding.
> >>
> >
> > Any news with this? Did I notice the LEDs patch are still in pending...
> 
> Sorry for the delay but finally I looked at this again. I decided to
> just remove the fixme and otherwise it looks good for me. Please check
> my changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a
>

All ok for me, Just I notice the ATH10K_LEDS is not exposed anymore? Is
that intended?

Aside from this very happy that we are finally finishing with this long
lasting feature!

-- 
	Ansuel

