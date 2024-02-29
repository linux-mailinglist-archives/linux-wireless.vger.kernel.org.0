Return-Path: <linux-wireless+bounces-4240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA0086C34D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 09:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFDBB22256
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B938F80;
	Thu, 29 Feb 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TeWhDM3g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E84879E
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194861; cv=none; b=UoAp4W2bQX3iS3fUmPbV46LM3H7mhpVcxS/36YgrOLcO7CBjUpmKzzWiTB8ZFlvbw/WAl+oBMTSdIEptmXg4w1j6lwOGnLSoEYmR61prCUYxnsv1irMNu2V7d343TAIeAfoCypsElP7uC745kcrUZ48KktfEZ6v3gFVmXTBonpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194861; c=relaxed/simple;
	bh=eX6+s3mpvdpSs9F4jSOUi42xtniB6gW6o5TRrTUv0dQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYNK9DnGtHikRw6JWiLTF1+EUzEnLu1mGNul/gyyuQoPWlvhPcLGexBc1aoOB5JkGPEopC8yS0raDC3aDrlk4P3Rzik3aoyjJCdWH9pHhgYWk0my0HULhee3QCgL26qZCAxpFIQhvA6MfWxCzJ/JRPK3S/Yjaj7yIY5Rd66QkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TeWhDM3g; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eX6+s3mpvdpSs9F4jSOUi42xtniB6gW6o5TRrTUv0dQ=;
	t=1709194857; x=1710404457; b=TeWhDM3gQaAaa7PdJDybguBqn1/R4eZgMIXdB4R7+MdKtut
	BG0EIGdg+WMYSiSbQbFvLjC/0uhusZtuVdJCu6SHJHeO2aAa8Zk4XnMmo+O5xnmDNa+/ZRr07dpbz
	ftpjYknOeHiNcqgFz0gfHt0w8ipX0wKgtuJpsFEuY6MidnguSX6YTUVq9IuxtcmRIhxukYBOG4tsT
	zK6DG3YD4D2tCnFhokeVCH7nCpY48ah8i4h4pBAjuooNvTucvCP158O3ZklUEM5Zpz+bfe00bbnMI
	5yfccEzC70wMSLGjXxnOQG4YLDdiemGlDfk4mAcin2AmXkLjTr33+LG618GN6dqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfbet-0000000DQaJ-0DA1;
	Thu, 29 Feb 2024 09:20:51 +0100
Message-ID: <8bf09320299478cc16751a7d3e5d090a6ecad331.camel@sipsolutions.net>
Subject: Re: [v4,2/2] wifi: mac80211: refactor STA CSA parsing flows
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-cy Lee =?UTF-8?Q?=28=E6=9D=8E=E5=B3=BB=E5=AE=87=29?=
	 <Michael-cy.Lee@mediatek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,  "nbd@nbd.name" <nbd@nbd.name>,
 Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?=
 <Evelyn.Tsai@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
 Money Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=AE=89=29?=
 <Money.Wang@mediatek.com>
Date: Thu, 29 Feb 2024 09:20:49 +0100
In-Reply-To: <4e08126a3bed3e2108e76f2a30d9bf470b5fe4db.camel@mediatek.com>
References: <20231222010914.6521-1-michael-cy.lee@mediatek.com>
	 <20231222010914.6521-3-michael-cy.lee@mediatek.com>
	 <b74f21d22a41b2ca635e64f04c06d5db6d38d920.camel@sipsolutions.net>
	 <765fb43a372825f6063894809f204150d87d4d18.camel@mediatek.com>
	 <51cad25c273b27885f5387f995db48ef97df2996.camel@sipsolutions.net>
	 <4e08126a3bed3e2108e76f2a30d9bf470b5fe4db.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

>=20
> https://lore.kernel.org/linux-wireless/3c550ae335a9762a9cbd0c8109b6dd99fa=
eb8f6f.camel@sipsolutions.net/
>=20
> We=E2=80=99re reading this discussion and will give our rely as soon as
> possible.

Great, thanks.

> > Would you be willing/interested in testing any of this code? I'm
> > currently not really able to test it, so not sure if I should push it
> > out.
>=20
> Of course we=E2=80=99re willing to do the test.
> But we=E2=80=99re still working on MLD AP right now, and the critical upd=
ate
> will be the next.
> In other word, to test MLD STA=E2=80=99s behavior we need to first get th=
e MLD
> AP ready.
> If it=E2=80=99s OK, could you give us your changes? Maybe we can test it =
during
> the development.
>=20

I actually posted it to the list yesterday, but it's probably more
useful to have it in combined form, so I've now pushed this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/=
log/?h=3Dcrosslink-csa&cache=3D0

johannes

