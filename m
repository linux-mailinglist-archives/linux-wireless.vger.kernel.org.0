Return-Path: <linux-wireless+bounces-7659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6798C5DDE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 00:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF91282A7E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 22:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8541181D08;
	Tue, 14 May 2024 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="VG/cQyQn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F11DDEE;
	Tue, 14 May 2024 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727112; cv=none; b=jSIM83B+TxB9pNOkSgrEpVzoeIOELXs+Ip9RVkGcXST+943ngo9NS6EOhsPOWx5V651JOnE2R+6kP4OLRB46bIcgX5RFLXxnuA1HK+L3uD/3oBcuU/FYXUqKYFs/fvAzGzda/qbWAQ11UhU711/SEEh5hrywYGp/2cwf5kxv2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727112; c=relaxed/simple;
	bh=uRxlDnelWdvGg7i9x9hTB/zJNxGNpEoVorUMP1xDlGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXXN8SZ6BscD8zSy1MOTH/Z/BpbOBdKXt0oIwz9zc+ApiQdk7rQh5brtBdP5G20mHfSmyKGnfTQgxyoU8kWOmoY01D4p0oXDXme/V+U7vgKcWEMejWt9yAqzLhUKIcND6jBFFtn95Vq70D1dllSPTbezv/96HahB6JhCsYwX3D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=VG/cQyQn; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 2A87A6356CD1;
	Wed, 15 May 2024 00:51:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715727109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/yx0LBa6BWxJcFbM41dPpkzsmx1uZjRYOaKe6bmwRA=;
	b=VG/cQyQnDLqz4Fw5M0R4xhc1in07k4Ww03a7FezDAlyes8JWwfW5sBdVy8dvEoTncQ6VeG
	p+BiQ+Cqvw4BQpgs0wDisTtmgrqbn+eu8S1OBM/qx7xYn3cQMIYZm15hfuCh9buSUMtAtR
	Bsn2gGRXMVYx/EosG8muwRDltjZR8D0=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>,
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Johannes Berg <johannes.berg@intel.com>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
Date: Wed, 15 May 2024 00:51:38 +0200
Message-ID: <2341660.ElGaqSPkdT@natalenko.name>
In-Reply-To: <6061263.lOV4Wx5bFT@natalenko.name>
References: <6061263.lOV4Wx5bFT@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4908084.GXAFRqVoOG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4908084.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
Date: Wed, 15 May 2024 00:51:38 +0200
Message-ID: <2341660.ElGaqSPkdT@natalenko.name>
In-Reply-To: <6061263.lOV4Wx5bFT@natalenko.name>
References: <6061263.lOV4Wx5bFT@natalenko.name>
MIME-Version: 1.0

Also /cc Johannes because of this commit:

6092077ad09ce wifi: mac80211: introduce 'channel request'

On st=C5=99eda 15. kv=C4=9Btna 2024 0:43:40, SEL=C4=8C Oleksandr Natalenko =
wrote:
> Hello Felix, Lorenzo et al.
>=20
> With v6.9 kernel the following card:
>=20
> 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax PCI E=
xpress Wireless Network Adapter [14c3:7915]
>=20
> doesn't work any more. Upon mt7915e module insertion the following splat =
happens:
>=20
> mt7915e 0000:01:00.0: enabling device (0000 -> 0002)
> WARNING: CPU: 3 PID: 1648 at net/mac80211/main.c:794 ieee80211_alloc_hw_n=
m+0x9a3/0x9f0 [mac80211]
> Call Trace:
>  <TASK>
>  mt76_alloc_device+0x24/0x290 [mt76 46e2c4f11be089903469a4d6045c71cb7842b=
4cd]
>  mt7915_mmio_probe+0x33/0x1d0 [mt7915e 9657e1926e619568545a08636674805d5e=
665c85]
>  mt7915_pci_probe+0xe1/0x3a0 [mt7915e 9657e1926e619568545a08636674805d5e6=
65c85]
>  pci_device_probe+0xf0/0x2d0
>  really_probe+0xde/0x3b0
>  __driver_probe_device+0x78/0x110
>  driver_probe_device+0x1f/0x130
>  __driver_attach+0x91/0x1e0
>  bus_for_each_dev+0x105/0x160
>  bus_add_driver+0x137/0x270
>  driver_register+0x72/0xd0
>  mt7915_init+0x44/0xff0 [mt7915e 9657e1926e619568545a08636674805d5e665c85]
>  do_one_initcall+0x5b/0x310
>  do_init_module+0x60/0x220
>  init_module_from_file+0x89/0xe0
>  idempotent_init_module+0x121/0x2b0
>  __x64_sys_finit_module+0x5e/0xb0
>  do_syscall_64+0x82/0x160
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> mt7915e 0000:01:00.0: probe with driver mt7915e failed with error -12
>=20
> and the card stays non-functional. Re-inserting the module triggers the s=
ame behaviour.
>=20
> The following condition is triggered:
>=20
>  794                 if (WARN_ON(!ops->add_chanctx ||
>  795                             !ops->remove_chanctx ||
>  796                             !ops->change_chanctx ||
>  797                             !ops->assign_vif_chanctx ||
>  798                             !ops->unassign_vif_chanctx))
>  799                         return NULL;
>=20
> This worked with v6.8 and earlier just fine.
>=20
> Please help.
>=20
> Thank you.
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4908084.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmZD6voACgkQil/iNcg8
M0slkBAA30d+dHMeOTWd6mWGNfJP06Ntug/dXjfFyRQeTnRqIXhfp5uTamhIDg1Q
1lbgClmG3vBtyw5vyYHemn9c3GjAPGSpVO5FvFAb72vHy/84KTfbrNU2jk9czRsP
kOVx1OxjWnn1wYgK3nJXgV+dVNft6/kphxSUFEtLFfkOR3KBpTCXwram74Dfx2O5
iK+X6damnucy+KB++AeimhjEY0tuLhXmRP/5me1m8SE5HojbCbBazBV8E/xPmPIx
Xy3K+mQIN8DZW3PNtVlgGVxwSwCB2Zeta6yfOrAnyt+ifA8mrIk/JeB+30IKFsUo
wEFc/yapWR1QXUzWK/Q2mi6bYprbHGYPusrrCHh/O3va2PuDvOksClCwaC8B36Lh
6k7ydaHrTeIH5fqwnCBTDk7Y/WRHQfOpZhuEtfmASXRGOR6nOaHwZoUxxUVr/kTk
K4SXM7h3A7kBPokz/EsVjWmV4tWmFmpm2XAIj0zP6S7ll8QCa6gZp31dknlezrHX
/dYvPnVgCf2yZ5ZH6s33lqB9HBj6uxmXKk/UnGSETtY+cEIfpDih6oat9TazyKS1
naiLMD51BfE+1SjAOokQqcZpFQOEB8eh8+DHK/5NaUh6u87pB9F03GFRaR2nEZvp
KWDoYnNLBWaEEoaD4fQzx8pbFOgWO88HcaSavorkESHcsE2EEFs=
=bD45
-----END PGP SIGNATURE-----

--nextPart4908084.GXAFRqVoOG--




