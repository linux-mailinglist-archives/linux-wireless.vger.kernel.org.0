Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2424CECF94
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2019 16:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKBPqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Nov 2019 11:46:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28800 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726440AbfKBPqt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Nov 2019 11:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572709608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOgDbBxNXdjtUorgd9juQVAEV2MMHG9GRq2O6INtr00=;
        b=ReSmn9GaM+Gm8uv0o/HpjKF5AqKzdBl587Q169PMwYKJZ7duKc5Q2qpDNqqBaoU/9y/qHj
        vAXGxrlZO9Z98jnbU7KIQjbsZHJpvfSksUjaGbM7Ml4+srCc4mkx8JuPF8RLLE4brlQEEu
        rXcc2H1PC4HtXPWnAjLan8yc5Yv3MpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-dG7erZx0P0KEWB_SNE6RCQ-1; Sat, 02 Nov 2019 11:46:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E6CF107ACC2;
        Sat,  2 Nov 2019 15:46:44 +0000 (UTC)
Received: from localhost (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0DB860878;
        Sat,  2 Nov 2019 15:46:41 +0000 (UTC)
Date:   Sat, 2 Nov 2019 16:46:40 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
Message-ID: <20191102154639.GA4589@redhat.com>
References: <20191028212244.GA2590@makrotopia.org>
 <20191029091857.GB3571@redhat.com>
 <20191029100503.GA1228@makrotopia.org>
MIME-Version: 1.0
In-Reply-To: <20191029100503.GA1228@makrotopia.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: dG7erZx0P0KEWB_SNE6RCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 29, 2019 at 11:05:03AM +0100, Daniel Golle wrote:
> > > --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > @@ -5839,8 +5839,7 @@ static int rt2800_init_registers(struct rt2x00_=
dev *rt2x00dev)
> > >  =09=09rt2800_register_write(rt2x00dev, TX_TXBF_CFG_0, 0x8000fc21);
> > >  =09=09rt2800_register_write(rt2x00dev, TX_TXBF_CFG_3, 0x00009c40);
> > >  =09} else if (rt2x00_rt(rt2x00dev, RT5390) ||
> > > -=09=09   rt2x00_rt(rt2x00dev, RT5392) ||
> > > -=09=09   rt2x00_rt(rt2x00dev, RT6352)) {
> > > +=09=09   rt2x00_rt(rt2x00dev, RT5392)) {
> > >  =09=09rt2800_register_write(rt2x00dev, TX_SW_CFG0, 0x00000404);
> > >  =09=09rt2800_register_write(rt2x00dev, TX_SW_CFG1, 0x00080606);
> > >  =09=09rt2800_register_write(rt2x00dev, TX_SW_CFG2, 0x00000000);
> >=20
> > I'm not sure if initialization on different path, is proper for all
> > variants of RT6352 chipset. Particularly I noticed that configuring
> > MIMO_PS_CFG can cause problems on wt3020.
>=20
> That's pretty odd, as this register is also written unconditionally
> by the vendor driver, see:
> https://github.com/wuqiong/rt2860v2-for-openwrt-mt7620/blob/master/rt2860=
v2/chips/rt6352.c#L529
> https://github.com/wuqiong/rt2860v2-for-openwrt-mt7620/blob/master/rt2860=
v2/chips/rt6352.c#L696

Today I had time to debug this a bit more. Problems on WT3020 are not
caused by MIMO_PS_CFG, but by TX_PIN_CFG setting. On this device we
should not overwrite TX_PIN_CFG. Presumably this is correct for
other devices, since code path that set TX_PIN_CFG to 0x00150F0F
was not used before due to this erroneous 'else if RT6352'.

Even if setting MMIO_PS_CFG does not cause problems, I think we
do not need to configure it and can stay with default HW value,
which is 4.

Please repost patch with TX_PIN_CFG and MIMO_PS_CFG settings removed.

> As only ChipVer >=3D 2 has been seen in the wild apparently, it seems

Ok, so we do not need to implement ChipVer 1 support.

> Roman implemented support for MT7620 along that codepath in the
> original driver:
> https://github.com/wuqiong/rt2860v2-for-openwrt-mt7620/blob/master/rt2860=
v2/chips/rt6352.c#L713
>=20
> However, now looking at this more, also
> rt2800_register_write(rt2x00dev, TX_ALC_VGA3, 0x00000000);
> doesn't match that codepath in the vendor driver which sets 0x06060606.

This was changed by:

commit c2e28ef7711ffcb083474ee5f154264c6ec1ec07
Author: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>
Date:   Thu Dec 27 15:05:25 2018 +0100

    rt2x00: reduce tx power to nominal level on RT6352

and I think it is correct.

> Now we could really implement all the codepaths for all pkg, ver, eco
> variants of MT7620 using the accessors like I patched here:
> https://github.com/openwrt/openwrt/blob/master/target/linux/ramips/patche=
s-4.14/300-mt7620-export-chip-version-and-pkg.patch
> (accessor for mt7620_get_eco was already in place as it is used also
> by MMC/SD driver afair)
>
> Which MT7620 chip package, version and eco is found inside the wt3020?
> (printed early on dmesg)

chipver 2 eco 6 pkg 0,

Thanks
Stanislaw

