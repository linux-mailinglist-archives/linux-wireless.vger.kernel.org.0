Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8AD4ED005
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2019 18:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfKBRne (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Nov 2019 13:43:34 -0400
Received: from fudo.makrotopia.org ([185.142.180.71]:41205 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfKBRne (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Nov 2019 13:43:34 -0400
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.92.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1iQxQs-0003hX-Ml; Sat, 02 Nov 2019 18:43:29 +0100
Date:   Sat, 2 Nov 2019 18:42:27 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
Message-ID: <20191102174227.GA1250@makrotopia.org>
References: <20191028212244.GA2590@makrotopia.org>
 <20191029091857.GB3571@redhat.com>
 <20191029100503.GA1228@makrotopia.org>
 <20191102154639.GA4589@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191102154639.GA4589@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Stanislaw,

On Sat, Nov 02, 2019 at 04:46:40PM +0100, Stanislaw Gruszka wrote:
> On Tue, Oct 29, 2019 at 11:05:03AM +0100, Daniel Golle wrote:
> > > > --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > > +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > > @@ -5839,8 +5839,7 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
> > > >  		rt2800_register_write(rt2x00dev, TX_TXBF_CFG_0, 0x8000fc21);
> > > >  		rt2800_register_write(rt2x00dev, TX_TXBF_CFG_3, 0x00009c40);
> > > >  	} else if (rt2x00_rt(rt2x00dev, RT5390) ||
> > > > -		   rt2x00_rt(rt2x00dev, RT5392) ||
> > > > -		   rt2x00_rt(rt2x00dev, RT6352)) {
> > > > +		   rt2x00_rt(rt2x00dev, RT5392)) {
> > > >  		rt2800_register_write(rt2x00dev, TX_SW_CFG0, 0x00000404);
> > > >  		rt2800_register_write(rt2x00dev, TX_SW_CFG1, 0x00080606);
> > > >  		rt2800_register_write(rt2x00dev, TX_SW_CFG2, 0x00000000);
> > > 
> > > I'm not sure if initialization on different path, is proper for all
> > > variants of RT6352 chipset. Particularly I noticed that configuring
> > > MIMO_PS_CFG can cause problems on wt3020.
> > 
> > That's pretty odd, as this register is also written unconditionally
> > by the vendor driver, see:
> > https://github.com/wuqiong/rt2860v2-for-openwrt-mt7620/blob/master/rt2860v2/chips/rt6352.c#L529
> > https://github.com/wuqiong/rt2860v2-for-openwrt-mt7620/blob/master/rt2860v2/chips/rt6352.c#L696
> 
> Today I had time to debug this a bit more. Problems on WT3020 are not
> caused by MIMO_PS_CFG, but by TX_PIN_CFG setting. On this device we
> should not overwrite TX_PIN_CFG. Presumably this is correct for
> other devices, since code path that set TX_PIN_CFG to 0x00150F0F
> was not used before due to this erroneous 'else if RT6352'.
> 
> Even if setting MMIO_PS_CFG does not cause problems, I think we
> do not need to configure it and can stay with default HW value,
> which is 4.

Ack. This seems to be a mistake in the vendor driver, my datasheet
also states that bit 1:2 have initial value of '2', which results
in a value of 4. Anyway it doesn't matter as long as MIMO_PS isn't
enabled (bit 3), so it's safe to remove it or set the correct default
value.

> 
> Please repost patch with TX_PIN_CFG and MIMO_PS_CFG settings removed.

TX_PIN_CFG is also set in rt2800_config_channel() as well as
rt2800_vco_calibration(), so no need to touch it during init.

> 
> > As only ChipVer >= 2 has been seen in the wild apparently, it seems
> 
> Ok, so we do not need to implement ChipVer 1 support.
> 
> > Roman implemented support for MT7620 along that codepath in the
> > original driver:
> > https://github.com/wuqiong/rt2860v2-for-openwrt-mt7620/blob/master/rt2860v2/chips/rt6352.c#L713
> > 
> > However, now looking at this more, also
> > rt2800_register_write(rt2x00dev, TX_ALC_VGA3, 0x00000000);
> > doesn't match that codepath in the vendor driver which sets 0x06060606.
> 
> This was changed by:
> 
> commit c2e28ef7711ffcb083474ee5f154264c6ec1ec07
> Author: Tomislav Požega <pozega.tomislav@gmail.com>
> Date:   Thu Dec 27 15:05:25 2018 +0100
> 
>     rt2x00: reduce tx power to nominal level on RT6352
> 
> and I think it is correct.

Ah, ok, that's a bit funny, because it means that this change actually
never made any difference, because the codepath wasn't executed.

I'm on my way to post v2.


Cheers


Daniel
