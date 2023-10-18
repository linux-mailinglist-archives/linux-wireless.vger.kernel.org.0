Return-Path: <linux-wireless+bounces-692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED04B80E7F7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 10:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2811F1C21269
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCDA58AA6;
	Tue, 12 Dec 2023 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZZDaECK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42140433DE
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 09:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12753C433C8;
	Tue, 12 Dec 2023 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702374173;
	bh=muw+Ud0YjfawGe9Cq2DB3pHB3fHCLByUAzvENR+KUes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZZDaECK3qYLvq+KzWWIGu/tekcFSES+1JnM7EEKKVENT3sxhN5vJdU17UqdlLvU7
	 LmDhRg8bQP8EBl+ppzA+4IH6LqqHZDzrgnVNsyL2Hyi6nBV2dRZtr0KxawXrv5godC
	 Nl7g2BCzCHmLWdndiQbrwn+8NAcUvMZxMQAT2LQB4KkylKPJ5jT218UbZxOqF1ylUM
	 hHLXKkjR6kjTEFM7MvOjrqQCaJQITRvM9EvIQl7TYlOdMzBNr0f5t21Kx2+VFsWtii
	 KrNHpXrGSV9JYkUreY1d8xDzyQwc95ivuQuE7bnxrebWzaNonWf9CSKY2T2JUSyV9i
	 rSJSizzbKr24Q==
Date: Wed, 18 Oct 2023 10:09:10 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Soul Huang <Soul.Huang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>,
	Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
	KM Lin <km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>,
	CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
	Stella Chang <Stella.Chang@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [next v2] wifi: mt76: mt7921: fix kernel panic by accessing
 invalid 6GHz channel info
Message-ID: <ZS+Spsy/1H+GUz2C@lore-rh-laptop>
References: <cf77a58a60d81c77a28388bc8d312b87ffb48434.1697603002.git.deren.wu@mediatek.com>
 <871qds31rw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oyYY5ye5rkYVGNeM"
Content-Disposition: inline
In-Reply-To: <871qds31rw.fsf@kernel.org>


--oyYY5ye5rkYVGNeM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Deren Wu <deren.wu@mediatek.com> writes:
>=20
> > From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> >
> > When the chip not support 6GHz capability, the channels of 6GHz informa=
tion
> > should not be updated.
> >
> > May get the stacktrace without this patch.
> > <1>[   19.442078] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000014
> > <1>[   19.457535] Mem abort info:
> > <1>[   19.465329]   ESR =3D 0x0000000096000004
> > <1>[   19.473295]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > <1>[   19.482354]   SET =3D 0, FnV =3D 0
> > <1>[   19.489143]   EA =3D 0, S1PTW =3D 0
> > <1>[   19.495991]   FSC =3D 0x04: level 0 translation fault
> > <1>[   19.504554] Data abort info:
> > <1>[   19.511111]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > <1>[   19.520269]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > <1>[   19.528988]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > <1>[   19.537960] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000102=
7a9000
> > <1>[   19.548014] [0000000000000014] pgd=3D0000000000000000, p4d=3D0000=
00000000
> > <0>[   19.558429] Internal error: Oops: 0000000096000004 [#1] PREEMPT S=
MP
> > <4>[   19.568270] Modules linked in: mt7921e mt7921_common mt792x_lib
> > mt76_connac_lib mt76 mac80211 btusb btintel cfg80211 btmtk snd_sof_ipc_=
msg_
> > btrtl snd_sof_ipc_flood_test btbcm bluetooth snd_sof_mt8195 uvcvideo
> > mtk_adsp_common snd_sof_xtensa_dsp uvc snd_sof_of snd_sof videobuf2_vma=
lloc
> > ecdh_generic ecc snd_sof_utils cros_ec_lid_angle cros_ec_sensors crct10=
dif_
> > cros_ec_sensors_core cros_usbpd_logger crypto_user fuse ip_tables ipv6
> > <4>[   19.614237] CPU: 1 PID: 105 Comm: kworker/1:1 Not tainted
> > 6.6.0-rc6-next-20231017+ #324
> > <4>[   19.625957] Hardware name: Acer Tomato (rev2) board (DT)
> > <4>[   19.634970] Workqueue: events mt7921_init_work [mt7921_common]
> > <4>[   19.644522] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS=
 BTY
> > <4>[   19.655182] pc : mt7921_regd_notifier+0x180/0x290 [mt7921_common]
> > <4>[   19.664983] lr : mt7921_regd_notifier+0xd4/0x290 [mt7921_common]
> > <4>[   19.674679] sp : ffff800080acba80
> > <4>[   19.681649] x29: ffff800080acba80 x28: 0000000000000000 x27: ffff=
4faf
> > <4>[   19.692483] x26: 0000000000000000 x25: 0000000000000000 x24: ffff=
4faf
> > <4>[   19.703294] x23: 00000000ffffe926 x22: ffff4faf16031fa0 x21: 0000=
0000
> > <4>[   19.714108] x20: 000000000000001c x19: ffff4faf16ba6f40 x18: 0000=
0000
> > <4>[   19.724928] x17: 0000000000000000 x16: ffffac6b891c2750 x15: ffff=
8000
> > <4>[   19.735722] x14: 0000000000000180 x13: 0000000000000000 x12: 0000=
0000
> > <4>[   19.746478] x11: 0000000000000002 x10: ffff4faf01c21780 x9 : ffff=
ac6b
> > <4>[   19.757214] x8 : 00000000006c0000 x7 : ffffac6b6b020cf0 x6 : ffff=
ac6b
> > <4>[   19.767945] x5 : ffffac6b6b020d00 x4 : ffffac6b6b020cf8 x3 : ffff=
4faf
> > <4>[   19.778648] x2 : 0000000000000000 x1 : 000000000000001c x0 : 0000=
0000
> > <4>[   19.789366] Call trace:
> > <4>[   19.795381]  mt7921_regd_notifier+0x180/0x290 [mt7921_common]
> > <4>[   19.804675]  wiphy_update_regulatory+0x2bc/0xa08 [cfg80211]
> > <4>[   19.813864]  wiphy_regulatory_register+0x4c/0x88 [cfg80211]
> > <4>[   19.823029]  wiphy_register+0x75c/0x8d0 [cfg80211]
> > <4>[   19.831446]  ieee80211_register_hw+0x70c/0xc10 [mac80211]
> > <4>[   19.840479]  mt76_register_device+0x168/0x2e8 [mt76]
> > <4>[   19.849008]  mt7921_init_work+0xdc/0x250 [mt7921_common]
> > <4>[   19.857817]  process_one_work+0x148/0x3c0
> > <4>[   19.865292]  worker_thread+0x32c/0x450
> > <4>[   19.872489]  kthread+0x11c/0x128
> > <4>[   19.879173]  ret_from_fork+0x10/0x20
> > <0>[   19.886153] Code: f0000041 9100a021 94000aef aa0003f9 (b9401780)
> > <4>[   19.895634] ---[ end trace 0000000000000000 ]---
> >
> > Reported-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > Closes: https://lore.kernel.org/all/927e7d50-826d-4c92-9931-3c59b18c694=
5@collabora.com/
> > Fixes: 09382d8f8641 ("mt7921: update the channel usage when the regd do=
main changed")
> > Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
>=20
> I assumed I should take this directly to net-next so assigned to me on
> patchwork. Felix&Lorenzo, ack?

Fine to me.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--oyYY5ye5rkYVGNeM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZS+SowAKCRA6cBh0uS2t
rGpkAQDZhGGAUcw9Dh76XkrAld+ZUdn5iroV0rrxkzsMCKpJlQEAt0vb6Tqj30h5
7JtqAzP9eyWQ1Xn7KwJV/Zrr6HMgtg4=
=hYdm
-----END PGP SIGNATURE-----

--oyYY5ye5rkYVGNeM--

