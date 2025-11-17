Return-Path: <linux-wireless+bounces-29062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FCEC65E3E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 20:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73BC14E368D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7E1DF261;
	Mon, 17 Nov 2025 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbfKPNYD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B4239E7D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406680; cv=none; b=jBi5ICWWJpB8l12ULAuda1uOPqM9DuuL1UzEl/hhAwFWM/4QgzNd8dAcOH+IEIogkbk9E9qze8cK5++ZJOJ2GrrpFKLW5ArBfl80qaInW5iks/COqZltbBpUbT9VBKyNURz7HVK++A8gzuJ7IoBgyCa/2RCGzZoIBUCP/HLPJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406680; c=relaxed/simple;
	bh=+rX+4+Y/UYmfttnvY147KvCQS+CIClwXcCJQmf7r60A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iACAYo3ruIuTKt6oNG2WjkDjvluv5HHhqz218yk3A2PPocMEndluX/DTGmOacV3v/A2dSrutAPEXBUJZKBoTD2HeGikn2EifkELcsqeeKYuy0c1C7PKp9/MSszeoiUlj0jtyZecH5pw7nLQR0+ac8tWAauRDQCUU8KHxWiFSsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbfKPNYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A073C113D0;
	Mon, 17 Nov 2025 19:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763406679;
	bh=+rX+4+Y/UYmfttnvY147KvCQS+CIClwXcCJQmf7r60A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pbfKPNYDvyJQyAiQBEA3Uom6DZYUe5gg9ZRlCppkHTDH6oIyYYDj6fBducjm6cPWZ
	 lXD5N/ExtJWXLAUykSf+8iWTF0hXqTVMuG3/kqv/cgJlxWW5hi0esdEYESxL9CA+Pp
	 qhXMbaVoWUZZH2ZOzIejg5tww8NhLAXW8Y++h7i+IM/jGTzMBdwcPkc0KM+rOj8x21
	 5M5Ue0hdRoxFLIsuv7sKAog+ixk3jH8qjq/R+eOFgFhAjQvriDZzt9T5Mv7p8qAaLa
	 ZvuhaXotQnb4NU93axZlOBm5LKNHdhyA1EbBWmRlDxAnqImxMNmgroTKyhSWgBkrPY
	 tuYCe3dgO7LBw==
Date: Mon, 17 Nov 2025 20:11:15 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH mt76] wifi: mt76: mt7996: Do not run
 ieee80211_iter_keys() for scanning links in mt7996_vif_link_remove()
Message-ID: <aRtzU_8PSsvc3dVE@lore-desk>
References: <20251115-mt7996-key-iter-link-remove-fix-v1-1-4f3f4e1eaa78@kernel.org>
 <49fdf52b-32cb-427e-ab95-a81856840a1e@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Uin0oc3GASko8h7f"
Content-Disposition: inline
In-Reply-To: <49fdf52b-32cb-427e-ab95-a81856840a1e@candelatech.com>


--Uin0oc3GASko8h7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 11/15/25 2:41 AM, Lorenzo Bianconi wrote:
> > mt7996_vif_link_remove routine is executed by mt76_scan_complete()
> > without holding the wiphy mutex triggering the following lockdep warnin=
g.
>=20
> Hello Lorenzo,
>=20
> Thank you for the patch.  This appears to fix the lockdep splats I was
> seeing, and kernel is stable in at least initial testing.

thx Ben for testing the patch. Are you ok with adding your Tested-by tag?

Regards,
Lorenzo

>=20
> Thanks,
> Ben
>=20
> >=20
> >   WARNING: CPU: 0 PID: 72 at net/mac80211/key.c:1029 ieee80211_iter_key=
s+0xe4/0x1a0 [mac80211]
> >   CPU: 0 UID: 0 PID: 72 Comm: kworker/u32:2 Tainted: G S               =
   6.18.0-rc5+ #27 PREEMPT(full)
> >   Tainted: [S]=3DCPU_OUT_OF_SPEC
> >   Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/=
2023
> >   Workqueue: phy3 mt76_scan_work [mt76]
> >   RIP: 0010:ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
> >   Code: 4c 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 47 48 be =
ff ff ff ff 48 8d 78 68 e8 b4 eb 1e e1 85 c0 0f 85 49
> > ff ff ff 4c 8b ab 90 1a 00 00 48 8d 83 90
> >   RSP: 0018:ffffc900002f7cb0 EFLAGS: 00010246
> >   RAX: 0000000000000000 RBX: ffff888127e00ee0 RCX: 0000000000000000
> >   RDX: 0000000000000000 RSI: ffff888127e00788 RDI: ffff88811132b5c8
> >   RBP: ffffffffa0ddf400 R08: 0000000000000001 R09: 000000009dcc1dac
> >   R10: 0000000000000001 R11: ffff88811132b5a0 R12: ffffc900002f7d00
> >   R13: ffff8882581e6a80 R14: ffff888127e0afc8 R15: ffff888158832038
> >   FS:  0000000000000000(0000) GS:ffff8884da486000(0000) knlGS:000000000=
0000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 0000000030a0fd90 CR3: 0000000002c52004 CR4: 00000000003706f0
> >   Call Trace:
> >    <TASK>
> >    ? lock_acquire+0xc2/0x2c0
> >    mt7996_vif_link_remove+0x64/0x2b0 [mt7996e]
> >    mt76_put_vif_phy_link+0x41/0x50 [mt76]
> >    mt76_scan_complete+0x77/0x100 [mt76]
> >    mt76_scan_work+0x2eb/0x3f0 [mt76]
> >    ? process_one_work+0x1e5/0x6d0
> >    process_one_work+0x221/0x6d0
> >    worker_thread+0x19a/0x340
> >    ? rescuer_thread+0x450/0x450
> >    kthread+0x108/0x220
> >    ? kthreads_online_cpu+0x110/0x110
> >    ret_from_fork+0x1c6/0x220
> >    ? kthreads_online_cpu+0x110/0x110
> >    ret_from_fork_asm+0x11/0x20
> >    </TASK>
> >   irq event stamp: 45471
> >   hardirqs last  enabled at (45477): [<ffffffff813d446e>] __up_console_=
sem+0x5e/0x70
> >   hardirqs last disabled at (45482): [<ffffffff813d4453>] __up_console_=
sem+0x43/0x70
> >   softirqs last  enabled at (44500): [<ffffffff81f2ae0c>] napi_pp_put_p=
age+0xac/0xd0
> >   softirqs last disabled at (44498): [<ffffffff81fa32a0>] page_pool_put=
_unrefed_netmem+0x290/0x3d0
> >   ---[ end trace 0000000000000000 ]---
> >=20
> > Fix the issue skipping ieee80211_iter_keys() for scanning links in
> > mt7996_vif_link_remove routine since we have not uploaded any hw keys
> > for these links.
> >=20
> > Fixes: 04414d7bba78 ("wifi: mt76: mt7996: delete vif keys when requeste=
d")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/net/wireless/mediatek/mt76/mt7996/main.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers=
/net/wireless/mediatek/mt76/mt7996/main.c
> > index 2a45db398fd597180c0b2bfc12e019b514f24fd6..beed795edb24c67e1b7b44f=
e87fd5de125a21d94 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > @@ -392,7 +392,8 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, =
struct ieee80211_vif *vif,
> >   	};
> >   	int idx =3D msta_link->wcid.idx;
> > -	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
> > +	if (!mlink->wcid->offchannel)
> > +		ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
> >   	mt7996_mcu_add_sta(dev, link_conf, NULL, link, NULL,
> >   			   CONN_STATE_DISCONNECT, false);
> >=20
> > ---
> > base-commit: 09600421ffe2acc1a00ec466b25485f11b6bb957
> > change-id: 20251115-mt7996-key-iter-link-remove-fix-7cf4d529c5a0
> >=20
> > Best regards,
>=20
>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com

--Uin0oc3GASko8h7f
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaRtzUwAKCRA6cBh0uS2t
rEGDAPsF3978G7hXm9Sh22HIutdAkykhwDgwB1vbyCpqOy2XpwD+PWGKCiRKFt+R
QbxUcunxxqxIUVw/ZxlhghkME2yHtQI=
=JDmD
-----END PGP SIGNATURE-----

--Uin0oc3GASko8h7f--

