Return-Path: <linux-wireless+bounces-7371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467C58C0AAE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 06:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BBFB225A9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 04:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BE1148FF9;
	Thu,  9 May 2024 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvxKDsfN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBF148858;
	Thu,  9 May 2024 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715230245; cv=none; b=MtnzE7pt6ah2haATxJa7bjhmLBazxUHepsEXTOPKvze7Q2oIpsWMyz3c17T68Hw/8FHbRFCFRGad20BWUN94lZjkoCtes0AdbAzF5dTABoch5m216qigAfA5TkEMumBnzTrbNNZNP+UQMCvh8/AhuJUMqUlkALKeQwV7gGxUfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715230245; c=relaxed/simple;
	bh=wFESnTy0F2sgYYS9+vYDpTJInEkSFXUMZ76AJIzXpvY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GQ4s6TDILWv2QJlrdKU4gZnDyntPa0KY28otlI8xBS2RCYTsVjhIEsA0exm0qr/oLLh7gLL9wmK8EMSWaHedirj02RrJgG2tSB0fMIRtXWCaEubOG/tM11G9PfWOju3KNSB3+6w+LvXf/1yCVCBT/9n4JBrF7G3FK3SqU2fVz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvxKDsfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4A7C116B1;
	Thu,  9 May 2024 04:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715230245;
	bh=wFESnTy0F2sgYYS9+vYDpTJInEkSFXUMZ76AJIzXpvY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NvxKDsfN6UImjQWlzi7xAxnJQIZpvXG1BWLQ66KpVcU9fYTfdB84eob+wsavsVwa+
	 mF1ANfm6ObO7OdPopGGCc6dLAEhVkzmy8M56l6QtjD8RBgCTX8ohO7htkQD5bVQUsF
	 qmWjx6J5rUXdRmK06+lsKB1XSXjjdIHwsiFYfzEGjOhos1TH0wqjqKAwYA5B1ZJvPU
	 6PqImjBBNUzlKmWN+vQF+Vox5PEf1Hx1amtJxz8a8IWiIMwtLA5nH3HQp6/9gR7Z15
	 EUz8W/2WN8d0jueRfdBn299hPu2aL7ZjJxSARsavTRdDgjdg4YKs6NyfZTFW+NGrFe
	 ZmYrcvccwtbJg==
From: Kalle Valo <kvalo@kernel.org>
To: Ansuel Smith <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  linux-kernel@vger.kernel.org,
  ath10k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  Sebastian Gottschall <s.gottschall@dd-wrt.com>,
  Steve deRosier <derosier@cal-sierra.com>,  Stefan Lippers-Hollmann
 <s.l-h@gmx.de>
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
	<878rcjbaqs.fsf@kernel.org>
	<648cdebb.5d0a0220.be7f8.a096@mx.google.com>
	<648ded2a.df0a0220.b78de.4603@mx.google.com>
	<CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
Date: Thu, 09 May 2024 07:50:40 +0300
In-Reply-To: <CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
	(Ansuel Smith's message of "Mon, 21 Aug 2023 12:46:00 +0200")
Message-ID: <87v83nlhb3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ansuel Smith <ansuelsmth@gmail.com> writes:

> Il giorno sab 17 giu 2023 alle ore 19:28 Christian Marangi
> <ansuelsmth@gmail.com> ha scritto:
>
>>
>> On Fri, Jun 16, 2023 at 01:35:04PM +0200, Christian Marangi wrote:
>> > On Fri, Jun 16, 2023 at 08:03:23PM +0300, Kalle Valo wrote:
>> > > Christian Marangi <ansuelsmth@gmail.com> writes:
>> > >
>> > > > From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>> > > >
>> > > > Adds LED and GPIO Control support for 988x, 9887, 9888, 99x0, 9984
>> > > > based chipsets with on chipset connected led's using WMI Firmware API.
>> > > > The LED device will get available named as "ath10k-phyX" at sysfs and
>> > > > can be controlled with various triggers.
>> > > > Adds also debugfs interface for gpio control.
>> > > >
>> > > > Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>> > > > Reviewed-by: Steve deRosier <derosier@cal-sierra.com>
>> > > > [kvalo: major reorg and cleanup]
>> > > > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>> > > > [ansuel: rebase and small cleanup]
>> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>> > > > Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
>> > > > ---
>> > > >
>> > > > Hi,
>> > > > this is a very old patch from 2018 that somehow was talked till 2020
>> > > > with Kavlo asked to rebase and resubmit and nobody did.
>> > > > So here we are in 2023 with me trying to finally have this upstream.
>> > > >
>> > > > A summarize of the situation.
>> > > > - The patch is from years in OpenWRT. Used by anything that has ath10k
>> > > >   card and a LED connected.
>> > > > - This patch is also used by the fw variant from Candela Tech with no
>> > > >   problem reported.
>> > > > - It was pointed out that this caused some problem with ipq4019 SoC
>> > > >   but the problem was actually caused by a different bug related to
>> > > >   interrupts.
>> > > >
>> > > > I honestly hope we can have this feature merged since it's really
>> > > > funny to have something that was so near merge and jet still not
>> > > > present and with devices not supporting this simple but useful
>> > > > feature.
>> > >
>> > > Indeed, we should finally get this in. Thanks for working on it.
>> > >
>> > > I did some minor changes to the patch, they are in my pending branch:
>> > >
>> > > https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=686464864538158f22842dc49eddea6fa50e59c1
>> > >
>> > > My comments below, please review my changes. No need to resend because
>> > > of these.
>> > >
>> >
>> > Hi,
>> > very happy this is going further.
>> >
>> > > > --- a/drivers/net/wireless/ath/ath10k/Kconfig
>> > > > +++ b/drivers/net/wireless/ath/ath10k/Kconfig
>> > > > @@ -67,6 +67,23 @@ config ATH10K_DEBUGFS
>> > > >
>> > > >     If unsure, say Y to make it easier to debug problems.
>> > > >
>> > > > +config ATH10K_LEDS
>> > > > + bool "Atheros ath10k LED support"
>> > > > + depends on ATH10K
>> > > > + select MAC80211_LEDS
>> > > > + select LEDS_CLASS
>> > > > + select NEW_LEDS
>> > > > + default y
>> > > > + help
>> > > > +   This option enables LEDs support for chipset LED pins.
>> > > > +   Each pin is connected via GPIO and can be controlled using
>> > > > +   WMI Firmware API.
>> > > > +
>> > > > +   The LED device will get available named as "ath10k-phyX" at sysfs and
>> > > > +           can be controlled with various triggers.
>> > > > +
>> > > > +   Say Y, if you have LED pins connected to the ath10k wireless card.
>> > >
>> > > I'm not sure anymore if we should ask anything from the user, better to
>> > > enable automatically if LED support is enabled in the kernel. So I
>> > > simplified this to:
>> > >
>> > > config ATH10K_LEDS
>> > >     bool
>> > >     depends on ATH10K
>> > >     depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
>> > >     default y
>> > >
>> > > This follows what mt76 does:
>> > >
>> > > config MT76_LEDS
>> > >     bool
>> > >     depends on MT76_CORE
>> > >     depends on LEDS_CLASS=y || MT76_CORE=LEDS_CLASS
>> > >     default y
>> > >
>> >
>> > I remember there was the same discussion in a previous series. OK for me
>> > for making this by default, only concern is any buildbot error (if any)
>> >
>> > Anyway OK for the change.
>> >
>> > > > @@ -65,6 +66,7 @@ static const struct ath10k_hw_params
>> > > > ath10k_hw_params_list[] = {
>> > > >           .dev_id = QCA988X_2_0_DEVICE_ID,
>> > > >           .bus = ATH10K_BUS_PCI,
>> > > >           .name = "qca988x hw2.0",
>> > > > +         .led_pin = 1,
>> > > >           .patch_load_addr = QCA988X_HW_2_0_PATCH_LOAD_ADDR,
>> > > >           .uart_pin = 7,
>> > > >           .cc_wraparound_type = ATH10K_HW_CC_WRAP_SHIFTED_ALL,
>> > >
>> > > I prefer following the field order from struct ath10k_hw_params
>> > > declaration and also setting fields explicitly to zero (even though
>> > > there are gaps still) so I changed that for every entry.
>> > >
>> >
>> > Thanks for the change, np for me.
>> >
>> > > > +int ath10k_leds_register(struct ath10k *ar)
>> > > > +{
>> > > > + int ret;
>> > > > +
>> > > > + if (ar->hw_params.led_pin == 0)
>> > > > +         /* leds not supported */
>> > > > +         return 0;
>> > > > +
>> > > > + snprintf(ar->leds.label, sizeof(ar->leds.label), "ath10k-%s",
>> > > > +          wiphy_name(ar->hw->wiphy));
>> > > > + ar->leds.wifi_led.active_low = 1;
>> > > > + ar->leds.wifi_led.gpio = ar->hw_params.led_pin;
>> > > > + ar->leds.wifi_led.name = ar->leds.label;
>> > > > + ar->leds.wifi_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
>> > > > +
>> > > > + ar->leds.cdev.name = ar->leds.label;
>> > > > + ar->leds.cdev.brightness_set_blocking = ath10k_leds_set_brightness_blocking;
>> > > > +
>> > > > + /* FIXME: this assignment doesn't make sense as it's NULL, remove it? */
>> > > > + ar->leds.cdev.default_trigger = ar->leds.wifi_led.default_trigger;
>> > >
>> > > But what to do with this FIXME?
>> > >
>> >
>> > It was pushed by you in v13.
>> >
>> > I could be wrong but your idea was to prepare for future support of
>> > other patch that would set the default_trigger to the mac80211 tpt.
>> >
>> > We might got both confused by default_trigger and default_state.
>> > default_trigger is actually never set and is NULL (actually it's 0)
>> >
>> > We have other 2 patch that adds tpt rates for the mac80211 LED trigger
>> > and set this trigger as the default one but honestly I would chose a
>> > different implementation than hardcoding everything.
>> >
>> > If it's ok for you, I would drop the comment and the default_trigger and
>> > I will send a follow-up patch to this adding DT support by using
>> > led_classdev_register_ext and defining init_data.
>> > (and this indirectly would permit better LED naming and defining of
>> > default-trigger in DT)
>> >
>> > Also ideally I will also send a patch for default_state following
>> > standard LED implementation. (to set default_state in DT)
>> >
>> > I would prefer this approach as the LED patch already took way too much
>> > time and I think it's better to merge this initial version and then
>> > improve it.
>>
>> If you want to check out I attached the 2 patch (one dt-bindings and the
>> one for the code) that I will submit when this will be merged (the
>> change is with the assumption that the FIXME line is dropped)
>>
>> Tested and works correctly with my use case of wifi card attached with
>> pcie. This implementation permits to declare the default trigger in DT
>> instead of hardcoding.
>>
>
> Any news with this? Did I notice the LEDs patch are still in pending...

Sorry for the delay but finally I looked at this again. I decided to
just remove the fixme and otherwise it looks good for me. Please check
my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

