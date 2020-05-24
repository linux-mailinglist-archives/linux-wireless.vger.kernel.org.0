Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACAA1E0073
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbgEXQM6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 12:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387416AbgEXQM5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 12:12:57 -0400
Received: from localhost (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23034207CB;
        Sun, 24 May 2020 16:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590336776;
        bh=vm1cE9nQus1bcdctpSlWVH+xm7rEHpf59LVPgpyukus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kz8PwKt65GioESAn7sYkgZvig+2ioBZiwhuDqvSPYyVr8mbo0IwD2iww3dzV0lsls
         tg2GZCv/RsCekx3DJNrbxgoPiFKPRs4IirLNprbKMGjTdStx5sKiLhAK0JkDbtLXdk
         BP+lhF/u48gkbX8Y3zYsZJO84jE5yo53LxfY8434=
Date:   Sun, 24 May 2020 18:13:00 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH] mt76: only iterate over initialized rx queues
Message-ID: <20200524161300.GA3032@localhost.localdomain>
References: <20200524130746.98760-1-nbd@nbd.name>
 <20200524134500.GA33803@localhost.localdomain>
 <a8e42710-0d04-845f-db4b-ab0bf6509a7c@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <a8e42710-0d04-845f-db4b-ab0bf6509a7c@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2020-05-24 15:45, Lorenzo Bianconi wrote:
> >> Fixes the following reported crash:
> >>=20
> >> [    2.361127] BUG: spinlock bad magic on CPU#0, modprobe/456
> >> [    2.361583]  lock: 0xffffa1287525b3b8, .magic: 00000000, .owner: <n=
one>/-1, .owner_cpu: 0
> >> [    2.362250] CPU: 0 PID: 456 Comm: modprobe Not tainted 4.14.177 #5
> >> [    2.362751] Hardware name: HP Meep/Meep, BIOS Google_Meep.11297.75.=
0 06/17/2019
> >> [    2.363343] Call Trace:
> >> [    2.363552]  dump_stack+0x97/0xdb
> >> [    2.363826]  ? spin_bug+0xa6/0xb3
> >> [    2.364096]  do_raw_spin_lock+0x6a/0x9a
> >> [    2.364417]  mt76_dma_rx_fill+0x44/0x1de [mt76]
> >> [    2.364787]  ? mt76_dma_kick_queue+0x18/0x18 [mt76]
> >> [    2.365184]  mt76_dma_init+0x53/0x85 [mt76]
> >> [    2.365532]  mt7615_dma_init+0x3d7/0x546 [mt7615e]
> >> [    2.365928]  mt7615_register_device+0xe6/0x1a0 [mt7615e]
> >> [    2.366364]  mt7615_mmio_probe+0x14b/0x171 [mt7615e]
> >> [    2.366771]  mt7615_pci_probe+0x118/0x13b [mt7615e]
> >> [    2.367169]  pci_device_probe+0xaf/0x13d
> >> [    2.367491]  driver_probe_device+0x284/0x2ca
> >> [    2.367840]  __driver_attach+0x7a/0x9e
> >> [    2.368146]  ? driver_attach+0x1f/0x1f
> >> [    2.368451]  bus_for_each_dev+0xa0/0xdb
> >> [    2.368765]  bus_add_driver+0x132/0x204
> >> [    2.369078]  driver_register+0x8e/0xcd
> >> [    2.369384]  do_one_initcall+0x160/0x257
> >> [    2.369706]  ? 0xffffffffc0240000
> >> [    2.369980]  do_init_module+0x60/0x1bb
> >> [    2.370286]  load_module+0x18c2/0x1a2b
> >> [    2.370596]  ? kernel_read_file+0x141/0x1b9
> >> [    2.370937]  ? kernel_read_file_from_fd+0x46/0x71
> >> [    2.371320]  SyS_finit_module+0xcc/0xf0
> >> [    2.371636]  do_syscall_64+0x6b/0xf7
> >> [    2.371930]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> >> [    2.372344] RIP: 0033:0x7da218ae4199
> >> [    2.372637] RSP: 002b:00007fffd0608398 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000139
> >> [    2.373252] RAX: ffffffffffffffda RBX: 00005a705449df90 RCX: 00007d=
a218ae4199
> >> [    2.373833] RDX: 0000000000000000 RSI: 00005a7052e73bd8 RDI: 000000=
0000000006
> >> [    2.374411] RBP: 00007fffd06083e0 R08: 0000000000000000 R09: 00005a=
705449d540
> >> [    2.374989] R10: 0000000000000006 R11: 0000000000000246 R12: 000000=
0000000000
> >> [    2.375569] R13: 00005a705449def0 R14: 00005a7052e73bd8 R15: 000000=
0000000000
> >>=20
> >> Reported-by: Sean Wang <sean.wang@mediatek.com>
> >> Fixes: d3377b78cec6 ("mt76: add HE phy modes and hardware queue")
> >> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> >=20
> > Just a couple of nitpicks inline, for the rest:
> >=20
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >=20
> >> ---
> >>  drivers/net/wireless/mediatek/mt76/debugfs.c      | 2 +-
> >>  drivers/net/wireless/mediatek/mt76/dma.c          | 4 ++--
> >>  drivers/net/wireless/mediatek/mt76/mt76.h         | 4 ++++
> >>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c   | 3 ++-
> >>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c   | 3 ++-
> >>  drivers/net/wireless/mediatek/mt76/mt7615/pci.c   | 8 +++++---
> >>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 3 ++-
> >>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c   | 3 ++-
> >>  8 files changed, 20 insertions(+), 10 deletions(-)
> >>=20
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/w=
ireless/mediatek/mt76/mt76.h
> >> index afb1ccf61b74..78378dcf430a 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> >> @@ -671,6 +671,10 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
> >>  #define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cle=
anup(&((dev)->mt76), __VA_ARGS__)
> >>  #define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)=
->mt76), __VA_ARGS__)
> >> =20
> >> +#define mt76_for_each_q_rx(dev, i)	\
> >> +	for (i =3D 0; i < ARRAY_SIZE((dev)->q_rx) && \
> >> +		    (dev)->q_rx[i].desc; i++)

reviewing the patch I guess this will not work for usb code since we do not
allocate q_rx[].desc pointer there. I guess we can use q_rx[].ndesc instead

> >> +
> >>  struct mt76_dev *mt76_alloc_device(struct device *pdev, unsigned int =
size,
> >>  				   const struct ieee80211_ops *ops,
> >>  				   const struct mt76_driver_ops *drv_ops);
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers=
/net/wireless/mediatek/mt76/mt7603/mac.c
> >> index 0f205ffe4905..8060c1514396 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> >> @@ -1438,8 +1438,9 @@ static void mt7603_mac_watchdog_reset(struct mt7=
603_dev *dev)
> >>  	for (i =3D 0; i < __MT_TXQ_MAX; i++)
> >>  		mt76_queue_tx_cleanup(dev, i, true);
> >> =20
> >> -	for (i =3D 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
> >> +	mt76_for_each_q_rx(&dev->mt76, i) {
> >>  		mt76_queue_rx_reset(dev, i);
> >> +	}
> >=20
> > you can drop braces here
> I thought about it as well, but decided to keep them, because it's a
> custom iterator function and without the braces it might look to the
> untrained eye like a function call with missing ; and wrong indentation
> in the next line.
> I thought this might help a bit with code clarity.

ack, fine


Regards,
Lorenzo

>=20
> - Felix

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXsqdCgAKCRA6cBh0uS2t
rLgaAP9LYV8UPLIkdxdd2OF8B1QcXxvaivwH/GYaZVD41QhR0QD+JkgWBfpqKNrr
ng+jPdqfu5i+lF9Nu1D0lfQR5aL7hgM=
=w55M
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
