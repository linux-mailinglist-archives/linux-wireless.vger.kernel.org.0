Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF20360E28
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 17:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhDOPKy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 11:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234200AbhDOPHr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 11:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADB306113B;
        Thu, 15 Apr 2021 15:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618499244;
        bh=RmiOkE+yEjly6qFzcvN2j3KCw5xw9cltH9i65fwS0Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkIMyvVfpCVy5CA4eJCzBb6gOofXw6KYsMXE2z5vt9qQBlbnDGu4X92pEvoBtT6UE
         XL+thrViMdf/HWGKQNq9Y5LcwtlB0u2UWNtdHo1jyN+/zZ5MgHdGCw6fsTFvljQZ1J
         BCuaRC/6lZj6ggAbIalXoQ25xNTZnwrTDtZo/Pk/D4xdQvXBbrfPIEwHmCJggiHx1F
         Cwg5H2W2pOeCmZcxiiL+GEi3RyjZTpx1iLX0usPjNRRaZSIS/FTfKUx0nuXcBfVDi9
         OwBVaHX9TEBTsgbO2tnefRiFCqVkLQqEhrUvzJtWnZHCG1tOgDqCurtAugRTjCeDlo
         CUVvrXrN3u9vA==
Date:   Thu, 15 Apr 2021 17:07:19 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7921: add debugfs knob for performing wifi
 reset
Message-ID: <YHhWp9nwW3ggZtNC@lore-desk>
References: <YHhFXcgsfziGlCag@lore-desk>
 <1618498409-7155-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="koRfRL7z2HBwFUUM"
Content-Disposition: inline
In-Reply-To: <1618498409-7155-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--koRfRL7z2HBwFUUM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> >> From: Sean Wang <sean.wang@mediatek.com>
> >>
> >> Introduce chip_reset knob in mt7921 debugfs to export a way to users
> >> able to trigger wifi reset.
> >>
> >> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >> ---
> >>  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
> >> b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
> >> index 024524173115..1342a0b645e3 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
> >> @@ -302,6 +302,16 @@ static int mt7921_config(void *data, u64 val)
> >>
> >>  DEFINE_DEBUGFS_ATTRIBUTE(fops_config, NULL, mt7921_config, "%lld\n");
> >>
> >> +static int mt7921_chip_reset(void *data, u64 val) {
> >> +	struct mt7921_dev *dev =3D data;
> >> +
> >> +	mt7921_reset(&dev->mt76);
> >> +
> >> +	return 0;
> >> +}
> >> +DEFINE_DEBUGFS_ATTRIBUTE(fops_reset, NULL, mt7921_chip_reset,
> >> +"%lld\n");
> >
> >can we use chip_config for this?
>=20
> i think we can resue the the knob for chip_reset. i will do it in the nex=
t version.

ack, I agree. Please rename the chip_config in something lile reset or simi=
lar.

Thanks,
Lorenzo

>=20
> >
> >Regards,
> >Lorenzo
> >
> >> +
> >>  int mt7921_init_debugfs(struct mt7921_dev *dev)  {
> >>	struct dentry *dir;
> >> @@ -322,6 +332,7 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
> >>	debugfs_create_file("idle-timeout", 0600, dir, dev,
> >>			    &fops_pm_idle_timeout);
> >>	debugfs_create_file("chip_config", 0600, dir, dev, &fops_config);
> >> +	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
> >>
> >>	return 0;
> >>  }
> >> --
> >> 2.25.1
> >>
> >

--koRfRL7z2HBwFUUM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYHhWpQAKCRA6cBh0uS2t
rIcRAP0bqNspW3EBKaXFKYMxpiP5qAeSRN7IygG6fpZj1jhkggEAlnHQLCAycpzi
+SDATzjZP9EL4s9uhOUop34GaAi/hgI=
=nwD4
-----END PGP SIGNATURE-----

--koRfRL7z2HBwFUUM--
