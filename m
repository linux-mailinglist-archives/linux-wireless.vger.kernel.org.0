Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67376192BB
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Nov 2022 09:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKDIaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Nov 2022 04:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiKDIaJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Nov 2022 04:30:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D431D26ACC
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 01:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87565B82C3C
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 08:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26B1C433C1;
        Fri,  4 Nov 2022 08:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667550605;
        bh=IN2cjiX2KuA9gGT2Jt5Adbt60ZHudH5BEFpF27utiEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TuzacKW43OCg/d7jQgHsym2e/ZEe0AqtqsoCc5cfETfrXNchJ8wDbakNuapQ4tF/h
         3M61k7VxiM7IsR46OHAtu8caru7s2QfbdDhB5qnpdMBfgjVYdF9x71qj/1rccQG7KX
         ts1X+3JhIw0xNLkj6nLGC6mIFYpxXkiaBISdC6Ph8+q0THgywNKIiXajEbCcIym0XX
         Y+gPCLmpzLt9/0LJ75PsHreWfVT6JEWx7Qct4w+00wGkh+eos0S8IQ/VhAmudNGJJh
         K6dbbMRpaZA6TJGBTDXMWTbb4fIpZc34TOyM6lHvU9NCOLdPrmdb0D4q/WY4OK4a6/
         ksfNdJQPlXcog==
Date:   Fri, 4 Nov 2022 09:30:01 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org, kvalo@kernel.org,
        dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr
Subject: Re: [RFC PATCH] wifi: mt76: Fix potential NULL pointer dereference
 in status work
Message-ID: <Y2TNibghqT9fnR3j@lore-desk>
References: <20221103100556.48288-1-linuxlovemin@yonsei.ac.kr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TuFfe+pg11grwmCE"
Content-Disposition: inline
In-Reply-To: <20221103100556.48288-1-linuxlovemin@yonsei.ac.kr>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--TuFfe+pg11grwmCE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This patch fixes a NULL pointer dereference in mt76 that occurs when a
> status work like mt76u_tx_status_data() queued from mt76u_status_worker()
> is called in worker thread while the device initialization failed.
> Pointers dereferenced in the work that should have been initialized
> during the device registration in mt76_register_device(),
> 'dev->mphy.chandef.chan' in mt76x02_mac_fill_tx_status(), for example,
> may be NULL if the initialization failed. The patch adds a check that
> safely terminates the function if that is the case.
>=20
> Found by a modified version of syzkaller.
>=20
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 98 Comm: kworker/u2:2 Not tainted 5.14.0+ #78
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-=
ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Workqueue: mt76 mt76u_tx_status_data
> RIP: 0010:mt76x02_mac_fill_tx_status.isra.0+0x82c/0x9e0
> Code: c5 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 94 01 00 00 48 b=
8 00 00 00 00 00 fc ff df 4d 8b 34 24 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 84=
 c0 74 08 3c 03 0f 8e 89 01 00 00 41 8b 16 41 0f b7
> RSP: 0018:ffffc900005af988 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffffc900005afae8 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff832fc661 RDI: ffffc900005afc2a
> RBP: ffffc900005afae0 R08: 0000000000000001 R09: fffff520000b5f3c
> R10: 0000000000000003 R11: fffff520000b5f3b R12: ffff88810b6132d8
> R13: 000000000000ffff R14: 0000000000000000 R15: ffffc900005afc28
> FS:  0000000000000000(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa0eda6a000 CR3: 0000000118f17000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  ? do_raw_spin_lock+0x125/0x2e0
>  ? mt76x02_mac_write_txwi+0xdc0/0xdc0
>  ? rwlock_bug.part.0+0x90/0x90
>  ? __dev_printk+0x1d6/0x1fe
>  mt76x02_send_tx_status+0x1d2/0xeb0
>  ? usleep_range+0xb3/0x170
>  ? mt76x02_mac_load_tx_status+0x4b0/0x4b0
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? rcu_read_lock_bh_held+0xb0/0xb0
>  ? mt76u_rr+0x3c/0x50
>  mt76x02_tx_status_data+0x8e/0xd0
>  ? mt76x02_tx_set_txpwr_auto+0x330/0x330
>  mt76u_tx_status_data+0xe1/0x240
>  ? mt76u_read_copy_ext+0x180/0x180
>  ? rcu_read_lock_sched_held+0x81/0xd0
>  ? rcu_read_lock_bh_held+0xb0/0xb0
>  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>  process_one_work+0x92b/0x1460
>  ? pwq_dec_nr_in_flight+0x330/0x330
>  ? rwlock_bug.part.0+0x90/0x90
>  worker_thread+0x95/0xe00
>  ? __kthread_parkme+0x115/0x1e0
>  ? process_one_work+0x1460/0x1460
>  kthread+0x3a1/0x480
>  ? set_kthread_struct+0x120/0x120
>  ret_from_fork+0x1f/0x30
> Modules linked in:
> ---[ end trace 8df5d20fc5040f65 ]---
> RIP: 0010:mt76x02_mac_fill_tx_status.isra.0+0x82c/0x9e0
> Code: c5 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 94 01 00 00 48 b=
8 00 00 00 00 00 fc ff df 4d 8b 34 24 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 84=
 c0 74 08 3c 03 0f 8e 89 01 00 00 41 8b 16 41 0f b7
> RSP: 0018:ffffc900005af988 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffffc900005afae8 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff832fc661 RDI: ffffc900005afc2a
> RBP: ffffc900005afae0 R08: 0000000000000001 R09: fffff520000b5f3c
> R10: 0000000000000003 R11: fffff520000b5f3b R12: ffff88810b6132d8
> R13: 000000000000ffff R14: 0000000000000000 R15: ffffc900005afc28
> FS:  0000000000000000(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa0eda6a000 CR3: 0000000118f17000 CR4: 0000000000750ef0
> PKRU: 55555554
>=20
> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> ---
>=20
> The crash we found occurs when the initialization failed in
> mt76x0u_register_device() and mt76u_stop_tx() is called via
> mt76u_queues_deinit() as an error handling. mt76u_stop_tx()
> enables a kthread with mt76_worker_enable() and this
> make 'dev->mphy.chandef.chan', which is NULL, be dereferenced
> in mt76x02_mac_fill_tx_status(), called in the worker.
>=20
> I think that calling mt76_worker_enable() in mt76u_stop_tx()
> may be a fundamental problem in this crash. What I found
> is that mt76u_stop_tx() is invoked twice by mt76x0u_stop()
> and mt76x0u_cleanup() from mt76x0_disconnect() when
> disconnecting the device. In this situation, enabling
> kthreads in mt76u_stop_tx() after disabling them will prevents
> them from being repeatedly parked, which will return -EBUSY.
>=20
> If invoking mt76u_stop_tx() in both mt76x0u_stop() and
> mt76x0u_cleanup() is unnecessary, and preventing kthreads
> from being continuously parked is the only reason of
> mt76_worker_enable() in mt76u_stop_tx(), I think we can
> make a solution that fundamentally prevent the work from
> being called when initialization is failed, instead of
> checking the state after the work is called.
> ---
>  drivers/net/wireless/mediatek/mt76/sdio.c | 3 ++-
>  drivers/net/wireless/mediatek/mt76/usb.c  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wire=
less/mediatek/mt76/sdio.c
> index 0ec308f99af5..464d1c713554 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio.c
> @@ -499,7 +499,8 @@ static void mt76s_tx_status_data(struct work_struct *=
work)
>  	dev =3D container_of(sdio, struct mt76_dev, sdio);
> =20
>  	while (true) {
> -		if (test_bit(MT76_REMOVED, &dev->phy.state))
> +		if (test_bit(MT76_REMOVED, &dev->phy.state) ||
> +		    !test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
>  			break;
> =20
>  		if (!dev->drv->tx_status_data(dev, &update))
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wirel=
ess/mediatek/mt76/usb.c
> index 4c4033bb1bb3..6cfdaa9d09d1 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -803,7 +803,8 @@ static void mt76u_tx_status_data(struct work_struct *=
work)
>  	dev =3D container_of(usb, struct mt76_dev, usb);
> =20
>  	while (true) {
> -		if (test_bit(MT76_REMOVED, &dev->phy.state))
> +		if (test_bit(MT76_REMOVED, &dev->phy.state) ||
> +		    !test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
>  			break;
> =20
>  		if (!dev->drv->tx_status_data(dev, &update))

Hi,

I have already posted a fix for this issue:
https://patchwork.kernel.org/project/linux-wireless/patch/42b98060e60849f4e=
3116a725004a6396cef08c1.1665687951.git.lorenzo@kernel.org/

Regards,
Lorenzo

> --=20
> 2.25.1
>=20

--TuFfe+pg11grwmCE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY2TNiQAKCRA6cBh0uS2t
rKZAAQC9MuH9aIFuBANVvZTNt0vNYiptnRT18WB5CUkd2jxVGQD+PtxV0w6jkb2V
S1Yt4Ul+isAEc7iJwOXjsMaBuJaIhAI=
=G2Vg
-----END PGP SIGNATURE-----

--TuFfe+pg11grwmCE--
