Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08BEE850A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 11:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfJ2KFh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 06:05:37 -0400
Received: from fudo.makrotopia.org ([185.142.180.71]:59010 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfJ2KFh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 06:05:37 -0400
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.92.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1iPONW-00017r-Ci; Tue, 29 Oct 2019 11:05:33 +0100
Date:   Tue, 29 Oct 2019 11:05:03 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
Message-ID: <20191029100503.GA1228@makrotopia.org>
References: <20191028212244.GA2590@makrotopia.org>
 <20191029091857.GB3571@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029091857.GB3571@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Stanislaw,

On Tue, Oct 29, 2019 at 10:18:57AM +0100, Stanislaw Gruszka wrote:
> On Mon, Oct 28, 2019 at 10:22:44PM +0100, Daniel Golle wrote:
> > On 2019-10-28 06:07, wbob wrote:
> > > Hello Roman,
> > >
> > > while reading around drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > I stumbled on what I think is an edit of yours made in error in march
> > > 2017:
> > >
> > > https://github.com/torvalds/linux/commit/41977e86#diff-dae5dc10da180f3b055809a48118e18aR5281
> > >
> > > RT6352 in line 5281 should not have been introduced as the "else if"
> > > below line 5291 can then not take effect for a RT6352 device. Another
> > > possibility is for line 5291 to be not for RT6352, but this seems
> > > very unlikely. Are you able to clarify still after this substantial time?
> > >
> > > 5277: static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
> > > ...
> > > 5279:  } else if (rt2x00_rt(rt2x00dev, RT5390) ||
> > > 5280:         rt2x00_rt(rt2x00dev, RT5392) ||
> > > 5281:         rt2x00_rt(rt2x00dev, RT6352)) {
> > > ...
> > > 5291:  } else if (rt2x00_rt(rt2x00dev, RT6352)) {
> > > ...
> > 
> > Hence remove erroneous line 5281 to make the driver actually
> > execute the correct initialization routine for MT7620 chips.
> > 
> > Fixes: 41977e86c984 ("rt2x00: add support for MT7620")
> > Reported-by: wbob <wbob@jify.de>
> > Reported-by: Roman Yeryomin <roman@advem.lv>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > index f1cdcd61c54a..c85456c8c193 100644
> > --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > @@ -5839,8 +5839,7 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
> >  		rt2800_register_write(rt2x00dev, TX_TXBF_CFG_0, 0x8000fc21);
> >  		rt2800_register_write(rt2x00dev, TX_TXBF_CFG_3, 0x00009c40);
> >  	} else if (rt2x00_rt(rt2x00dev, RT5390) ||
> > -		   rt2x00_rt(rt2x00dev, RT5392) ||
> > -		   rt2x00_rt(rt2x00dev, RT6352)) {
> > +		   rt2x00_rt(rt2x00dev, RT5392)) {
> >  		rt2800_register_write(rt2x00dev, TX_SW_CFG0, 0x00000404);
> >  		rt2800_register_write(rt2x00dev, TX_SW_CFG1, 0x00080606);
> >  		rt2800_register_write(rt2x00dev, TX_SW_CFG2, 0x00000000);
> 
> I'm not sure if initialization on different path, is proper for all
> variants of RT6352 chipset. Particularly I noticed that configuring
> MIMO_PS_CFG can cause problems on wt3020.

That's pretty odd, as this register is also written unconditionally
by the vendor driver, see:
https://github.com/wuqiong/rt2860v2-for-openwrt-mt7620/blob/master/rt2860v2/chips/rt6352.c#L529
https://github.com/wuqiong/rt2860v2-for-openwrt-mt7620/blob/master/rt2860v2/chips/rt6352.c#L696

As only ChipVer >= 2 has been seen in the wild apparently, it seems
Roman implemented support for MT7620 along that codepath in the
original driver:
https://github.com/wuqiong/rt2860v2-for-openwrt-mt7620/blob/master/rt2860v2/chips/rt6352.c#L713

However, now looking at this more, also
rt2800_register_write(rt2x00dev, TX_ALC_VGA3, 0x00000000);
doesn't match that codepath in the vendor driver which sets 0x06060606.

Now we could really implement all the codepaths for all pkg, ver, eco
variants of MT7620 using the accessors like I patched here:
https://github.com/openwrt/openwrt/blob/master/target/linux/ramips/patches-4.14/300-mt7620-export-chip-version-and-pkg.patch
(accessor for mt7620_get_eco was already in place as it is used also
by MMC/SD driver afair)

Which MT7620 chip package, version and eco is found inside the wt3020?
(printed early on dmesg)


Cheers


Daniel
