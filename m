Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07FF477E83
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 22:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhLPVNt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 16:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhLPVNt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 16:13:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04F6C061574
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 13:13:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACA7FB82471
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 21:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C0BC36AE2;
        Thu, 16 Dec 2021 21:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639689226;
        bh=MS5FF1VG4IZiTLDz/nnBsePZTzIr2R/HGLdh82hp7Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHTULAiOiNPdaVndChiufNR3O16WLnlntyAURgw+xy2RE7teQfWtXzU5sEqY0qslt
         hda5ucWwWlc5FXlxfC0sln614R4NXl8xMEuXVLm0g+m/xZ0Io1JkyYAcWCoFNl0cAS
         BawLfVz/yzc0vlQ0hGG5nle+tj6mLFXr4jHOzZYvnCmLpMIQrPEx7XeAPjunykGw1E
         p3rCZOpKSnGF2uZU8P76Bp5aS0oXh5QJXmJ/0UlPNCWcUeCkXdBZr2H8qwdUbsvaJx
         FAGoqKNeoWfcftxAXgdyk0qj2an8OyhVOi1xgop225GmkYbWdWNNrsJvfj/sfDGBxU
         uuYGlfPfri19Q==
Date:   Thu, 16 Dec 2021 22:13:41 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com, nbd@nbd.name,
        jf@simonwunderlich.de, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Deren Wu <deren.wu@mediatek.com>
Subject: Re: mt76: MT7921K monitor mode not working
Message-ID: <YbusBazb4GAC6YQl@lore-desk>
References: <YapTmM3EztojTS9F@lore-desk--annotate>
 <1638579304-17794-1-git-send-email-sean.wang@mediatek.com>
 <12706913.cppxkphV4n@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sDTqb8Ng6mZDpRDO"
Content-Disposition: inline
In-Reply-To: <12706913.cppxkphV4n@ripper>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--sDTqb8Ng6mZDpRDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Saturday, 4 December 2021 01:55:04 CET sean.wang@mediatek.com wrote:
> > >ack, I agree, but I guess the point here is what is the difference (fr=
om the fw pov) if you disable runtime-pm/deep-sleep before/after the vif is=
 added. I guess it is supposed to be the same, right?
> >=20
> > yes, it is supposed to be the same.
>=20
> Two things which were noticed too:
>=20
> First finding: If I run `iw dev mon0 del` after a non-working tcpdump dum=
p=20
> session then I get following error messages before my complete system fre=
ezes:
>=20
>     [  492.812050] mt7921e 0000:04:00.0: Message 40000002 (seq 14) timeout
>     [  492.818587] mt7921e 0000:04:00.0: chip reset
>     [  495.883934] mt7921e 0000:04:00.0: Message 00000046 (seq 15) timeout
>=20
> Second one: We cannot see beacons on 2.4Ghz and 5GHz when runtime-pm + de=
ep-
> sleep is set to 0.
>=20
>=20
>=20
> Regarding the initial problem: following works (when ignoring the missing=
=20
> beacons for now):
>=20
>     echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/runtime-pm
>     echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/deep-sleep
>     iw dev wlp4s0 del
>     iw phy0 interface add mon0 type monitor
>     ip link set up dev mon0
>     iw dev mon0 set channel 11
>     tcpdump -ni mon0
>=20
>=20
> What is often not working:
>=20
>     iw dev wlp4s0 del
>     iw phy0 interface add mon0 type monitor
>     ip link set up dev mon0
>     iw dev mon0 set channel 11
>     tcpdump -ni mon0 &
>     sleep 10
>     echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/runtime-pm
>     sleep 5
>     echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/deep-sleep
>=20
>=20
> What I have seem to break sometimes (but cannot reproduce reliably):
>=20
>     iw dev wlp4s0 del
>     iw phy0 interface add mon0 type monitor
>     ip link set up dev mon0
>     iw dev mon0 set channel 11
>     echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/runtime-pm
>     echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/deep-sleep
>     tcpdump -ni mon0
>=20
>=20
> The channel 11 is rather busy. It is for example also used for our commun=
ity=20
> mesh network in the city center - so is rather easy for me to see that it=
 is=20
> able to sniff traffic or not.

Hi Sven,

can you please try the patch below to see if it fixes the crash/hang in mon=
itor
mode?

Regards,
Lorenzo

=46rom 2502ead5ba1f580d63bbc65165acb0139dc94ed8 Mon Sep 17 00:00:00 2001
Message-Id: <2502ead5ba1f580d63bbc65165acb0139dc94ed8.1639689141.git.lorenz=
o@kernel.org>
=46rom: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Dec 2021 20:40:16 +0100
Subject: [PATCH] mt76: mt7921: fix a possible race enabling/disabling
 runtime-pm

Fix a possible race enabling/disabling runtime-pm between mt7921_pm_set
and mt7921_poll_rx().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 3 ---
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c  | 6 ++++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers=
/net/wireless/mediatek/mt76/mt76_connac_mac.c
index af43bcb54578..306e9eaea917 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -7,9 +7,6 @@ int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_c=
onnac_pm *pm)
 {
 	struct mt76_dev *dev =3D phy->dev;
=20
-	if (!pm->enable)
-		return 0;
-
 	if (mt76_is_usb(dev))
 		return 0;
=20
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/debugfs.c
index 7cdfdf83529f..59b047dceca0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -276,7 +276,7 @@ mt7921_pm_set(void *data, u64 val)
 	struct mt7921_dev *dev =3D data;
 	struct mt76_connac_pm *pm =3D &dev->pm;
=20
-	mt7921_mutex_acquire(dev);
+	mutex_lock(&dev->mt76.mutex);
=20
 	if (val =3D=3D pm->enable)
 		goto out;
@@ -286,6 +286,7 @@ mt7921_pm_set(void *data, u64 val)
 		pm->stats.last_doze_event =3D jiffies;
 	}
 	pm->enable =3D val;
+	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
=20
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -293,8 +294,9 @@ mt7921_pm_set(void *data, u64 val)
=20
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
=20
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 out:
-	mt7921_mutex_release(dev);
+	mutex_unlock(&dev->mt76.mutex);
=20
 	return 0;
 }
--=20
2.33.1


>=20
> Kind regards,
> 	Sven



--sDTqb8Ng6mZDpRDO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYbusBQAKCRA6cBh0uS2t
rNWVAQCEmO1XHjFoyizzH/sjQVWmUZXszwI88O0/evoQltqvygEAoyCESogs6xmS
LwnmXFArFt/1PwRaguhO2fu6NSD6xwo=
=AvsP
-----END PGP SIGNATURE-----

--sDTqb8Ng6mZDpRDO--
