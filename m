Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB19C92037
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 11:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfHSJYR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 05:24:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47341 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfHSJYQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 05:24:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B65278043B; Mon, 19 Aug 2019 11:24:01 +0200 (CEST)
Date:   Mon, 19 Aug 2019 11:24:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>
Subject: Re: wifi on Motorola Droid 4 in 5.3-rc2
Message-ID: <20190819092414.GB21072@amd>
References: <20190818104629.GA27360@amd>
 <CAOf5uwnUx3mtGGHFGqKB30qcb_AMhMEhHLp2pf-4pUdhi7KP7w@mail.gmail.com>
 <20190818114332.GA32205@amd>
 <CAOf5uwncAHQ-nfFzQhv=T+pyXJ+60_QNT4F11VJg+25GjFFkxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <CAOf5uwncAHQ-nfFzQhv=T+pyXJ+60_QNT4F11VJg+25GjFFkxQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > [   13.653778] panel-dsi-cm 58004000.encoder:display: using lookup
> > tables for GPIO lookup
> > [   13.661834] panel-dsi-cm 58004000.encoder:display: No GPIO consumer
> > te found
> > [   14.756622] ------------[ cut here ]------------
> > [   14.761352] WARNING: CPU: 0 PID: 20 at
> > /data/fast/l/k/drivers/net/wireless/ti/wlcore/sdio.c:86
> > wl12xx_sdio_raw_read+0xa8/0x128
> > [   14.772888] Modules linked in:
> > [   14.776062] CPU: 0 PID: 20 Comm: kworker/0:1 Tainted: G        W
> > 5.3.0-rc4-58571-gdbaece1 #85
> > [   14.783630] Hardware name: Generic OMAP4 (Flattened Device Tree)
> > [   14.791381] Workqueue: events request_firmware_work_func
>=20
> You have a timeout here. Can be that your reset sequence of the wifi
> is not optimal because
> is not responding?

I tried delays and printks... WL12XX_REG_FUSE_BD_ADDR_1 read fails,
and retrying does not really help. If you have idea how to debug/fix
this, let me know...

Best regards,
								Pavel

diff --git a/drivers/net/wireless/ti/wl12xx/main.c b/drivers/net/wireless/t=
i/wl12xx/main.c
index 3c9c623..afb294a 100644
--- a/drivers/net/wireless/ti/wl12xx/main.c
+++ b/drivers/net/wireless/ti/wl12xx/main.c
@@ -1505,24 +1505,40 @@ static int wl12xx_get_fuse_mac(struct wl1271 *wl)
 {
 	u32 mac1, mac2;
 	int ret;
-
+=09
+	mdelay(1);
+	printk("get_fuse_mac: %d\n", __LINE__);
 	ret =3D wlcore_set_partition(wl, &wl->ptable[PART_DRPW]);
 	if (ret < 0)
 		goto out;
=20
+	mdelay(1);
+	printk("get_fuse_mac: %d\n", __LINE__);
+	ret =3D wlcore_read32(wl, WL12XX_REG_FUSE_BD_ADDR_1, &mac1);
+	if (ret < 0) {
+	printk("get_fuse_mac: X %d\n", __LINE__);
+	ret =3D wlcore_read32(wl, WL12XX_REG_FUSE_BD_ADDR_1, &mac1);
+	if (ret < 0) {
+	printk("get_fuse_mac: XX %d\n", __LINE__);
 	ret =3D wlcore_read32(wl, WL12XX_REG_FUSE_BD_ADDR_1, &mac1);
 	if (ret < 0)
 		goto out;
+	}
+	}
+=09
=20
+	printk("get_fuse_mac: %d\n", __LINE__);
 	ret =3D wlcore_read32(wl, WL12XX_REG_FUSE_BD_ADDR_2, &mac2);
 	if (ret < 0)
 		goto out;
=20
+	printk("get_fuse_mac: %d\n", __LINE__);
 	/* these are the two parts of the BD_ADDR */
 	wl->fuse_oui_addr =3D ((mac2 & 0xffff) << 8) +
 		((mac1 & 0xff000000) >> 24);
 	wl->fuse_nic_addr =3D mac1 & 0xffffff;
=20
+	printk("get_fuse_mac: %d\n", __LINE__);
 	ret =3D wlcore_set_partition(wl, &wl->ptable[PART_DOWN]);
=20
 out:

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1aar4ACgkQMOfwapXb+vJb9wCdEMS4069vsm0A0Ev1TelvVMac
tEUAoMRMPsW6X4ytZQOHwh1J6znBX4KV
=Zu6g
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
