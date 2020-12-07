Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CC12D1404
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgLGOtw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 09:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgLGOtv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 09:49:51 -0500
Date:   Mon, 7 Dec 2020 15:49:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607352550;
        bh=asaQYHSFTdvDGtme2G+Ksw/0ZSJz4zjlN1KU5uUFWMM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/TmSZgIA7r3YXrRBEcS9q1J/qsOtOjWi8l9tH+HktZKCydCdwQsTsQTdTyoJ8Hts
         +GS5hHNqmLCS8GSg4IbtTtltH5/4ovvJIkeqVa83ZB7rEuI1Z2/ops77omiq0Ytcgj
         +q5l+Q5fanoOczWRtdsCpiNLZb0GbgV1TnGJdEjPQPj2l6tez+wyEbfdGr2r4vvOpg
         c8Z7IB7rY+gkCByHwt9vq2864ybsWgCBv3lDJ0PK1s1F/vK3rC2uy1Uf7LCdMurQdq
         AfPRpc5BHTNWw840VmK8fzyJMJNbwRTqYo0YVK9m+vR/mkzGCA+5g03A6Hy5dTCXIz
         ZykXoOjUlIlaw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2020-12-04 v2
Message-ID: <20201207144905.GA292338@lore-desk>
References: <f42bcdc1-2cd4-9f44-2889-bbb9e10e038a@nbd.name>
 <20201207102432.AD525C433C6@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20201207102432.AD525C433C6@smtp.codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Felix Fietkau <nbd@nbd.name> wrote:
>=20
> > Hi Kalle,
> >=20
> > sorry about the last one. Here's the updated PR with the missing=20
> > S-o-b fixed.
> >=20
> > - Felix
> >=20
> > The following changes since commit 9eb597c74483ad5c230a884449069adfb682=
85ea:
> >=20
> >   Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kva=
lo/ath.git (2020-12-02 21:46:55 +0200)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-12-04
> >=20
> > for you to fetch changes up to f12758f6f929dbcd37abdb1d91d245539eca48f8:
> >=20
> >   mt76: mt7615: Fix fall-through warnings for Clang (2020-12-04 22:24:5=
4 +0100)
> >=20
> > ----------------------------------------------------------------
> > mt76 patches for 5.11
> >=20
> > * mt7915 fixes
> > * mt7615 fixes
> > * support for more sta interfaces on mt7615/mt7915
> > * mt7915 encap offload
> > * performance improvements
> > * channel noise report on mt7915
> > * usb/sdio support improvements
> > * mt7915 testmode support
> > * mt7915 DBDC support
> > * warning fixes
> >=20
> > ----------------------------------------------------------------
>=20
> This conflicted with commit 807982017730 ("mt76: usb: fix crash on device
> removal") from wireless-drivers. I fixed with a diff below and pushed it =
to the
> pending branch:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-ne=
xt.git/commit/?h=3Dpending&id=3Df4a243bfdb0d9afc850d35755dc0bae0b980b4ac
>=20
> Please double check my resolution. Also I wonder should the usb.status_wo=
rker
> have a similar fix as tx_worker had? If yes, someone please send a follow=
up
> patch for that.

Hi Kalle,

the patch seems fine to me, probably we can move
mt76_worker_{disable,enable}(&dev->usb.status_worker) inside the if (!ret)
block as originally done by Stanislaw. Something like:

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireles=
s/mediatek/mt76/usb.c
index dc850109de22..18444f26103e 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -1039,8 +1039,6 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 {
 	int ret;
=20
-	mt76_worker_disable(&dev->usb.status_worker);
-
 	ret =3D wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(&dev->phy),
 				 HZ / 5);
 	if (!ret) {
@@ -1059,6 +1057,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 				usb_kill_urb(q->entry[j].urb);
 		}
=20
+		mt76_worker_disable(&dev->usb.status_worker);
 		mt76_worker_disable(&dev->tx_worker);
=20
 		/* On device removal we maight queue skb's, but mt76u_tx_kick()
@@ -1077,13 +1076,12 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 		}
=20
 		mt76_worker_enable(&dev->tx_worker);
+		mt76_worker_enable(&dev->usb.status_worker);
 	}
=20
 	cancel_work_sync(&dev->usb.stat_work);
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
=20
-	mt76_worker_enable(&dev->usb.status_worker);
-
 	mt76_tx_status_check(dev, NULL, true);
 }
 EXPORT_SYMBOL_GPL(mt76u_stop_tx);

Regards,
Lorenzo

>=20
> diff --cc drivers/net/wireless/mediatek/mt76/usb.c
> index f1ae9ff835b2,81393788f98e..000000000000
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@@ -1020,6 -1039,9 +1039,8 @@@ void mt76u_stop_tx(struct mt76_dev *dev
>   {
>         int ret;
>  =20
>  -      mt76_worker_disable(&dev->tx_worker);
> +       mt76_worker_disable(&dev->usb.status_worker);
> +=20
>         ret =3D wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(&de=
v->phy),
>                                  HZ / 5);
>         if (!ret) {
> @@@ -1061,6 -1078,9 +1082,8 @@@
>         cancel_work_sync(&dev->usb.stat_work);
>         clear_bit(MT76_READING_STATS, &dev->phy.state);
>  =20
>  -      mt76_worker_enable(&dev->tx_worker);
> +       mt76_worker_enable(&dev->usb.status_worker);
> +=20
>         mt76_tx_status_check(dev, NULL, true);
>   }
>   EXPORT_SYMBOL_GPL(mt76u_stop_tx);
>=20
>=20
>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/patch/f42bcdc1-2cd4-9=
f44-2889-bbb9e10e038a@nbd.name/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX85A3wAKCRA6cBh0uS2t
rBZWAP4i8puwUZ58HN86KO/JSyVf/Gy5QhNdW0ewyh0ul1y5oQEAr2N/CXhv7NGt
5xnSXonv5RyAFDKgI/cf0d7pB3hCyQs=
=HnCm
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
