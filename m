Return-Path: <linux-wireless+bounces-10615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC793F33F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 12:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C73C1F229D6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8C6145A05;
	Mon, 29 Jul 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="H6l7e0ng"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAB1448EE;
	Mon, 29 Jul 2024 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250324; cv=none; b=ZGYbOeQvrhP+LTyPgoecbHQuruJaWdkG76Msta5bzxctdDVL+2t9GPlokUXHsrZm2WjzoLn3GEg0TATvSTfPFFQA84MSX+EqnPNXjHoXWEDJuIh9YVpseeIgZzn8WsoAce8xHJU+pRhVEgeIvGg8QsnB2TlBdmWYJ/A7LWDHtk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250324; c=relaxed/simple;
	bh=UKU0+6XQvE45shRp6oaLQnN0VhMCLZCW6ebTfIiQyNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MrL4AfHRNFyTJFExnWkn1eMgIS1cvGIWAd0bvvggpirinLalsu6dozOyLKt4O4HdgJl78IAlisnF5WR3fQkNX892JHpd9eCWQV0mXx5WGMv81YCi9uAdLdvBsLhuMiC7rmXSixgNXTFyisWlsiaSy79o8dr5CRL3rz5kmZdi2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=H6l7e0ng; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722250289; x=1722855089; i=spasswolf@web.de;
	bh=UKU0+6XQvE45shRp6oaLQnN0VhMCLZCW6ebTfIiQyNw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H6l7e0ngedySH2ri9PuAssVZli8MpOzeYijRMGHTjQYYLxQStp0URHKI5hJfgPCJ
	 hhyzVfOaMm9UCwA/gm6rBulgMPT5lqcl7M+ooQ5PgrXwHL5QHfwdmDPFpUbd3pKzJ
	 bHvXh1QDCFS8kWDCIUea00ED0Hq7suGhLZUhG9+2SYMLl0aXt6oiehupHhmCBf/77
	 PdlUQVHQ1sWOklywUpjPMLPU82T7K4Ogj8WUWHYnbmdVx0GPZYjrrLSzaHtj8dj2G
	 qDjFHr42vBsi9poBbkrV44Yx1muycrGtO8fR1eFDmKg4l+2H7EK3+Oal0GNeTZ3Ue
	 YpeLuKA+YR26UtZ2vQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9431-1sATl011fD-011Pg1; Mon, 29
 Jul 2024 12:51:29 +0200
Message-ID: <81a6dad7119069d446a982d1c7da4fff5726d26b.camel@web.de>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix null pointer access in
 mt792x_mac_link_bss_remove
From: Bert Karwatzki <spasswolf@web.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>, 
	sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com, deren.wu@mediatek.com,
 mingyen.hsieh@mediatek.com,  linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Mike Lothian <mike@fireburn.co.uk>,
 spasswolf@web.de
Date: Mon, 29 Jul 2024 12:51:27 +0200
In-Reply-To: <0124ff39-7d63-49f8-bacd-3a40ce37ec4d@leemhuis.info>
References: <20240718234633.12737-1-sean.wang@kernel.org>
	 <0124ff39-7d63-49f8-bacd-3a40ce37ec4d@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j1RMugOP/j6u4SMk77QS9vWWp21YeqQCRRQR5w5sswoDnCS/HGf
 TMRB+c5xM73+mk9qC985oAETAFekn7Y2yYxa6hwcZrEo7TuxR3Mlz6lDdMzmPuVMmt7j1fY
 J++Nb5l8kB9rv1OFTc9GfG/VT9zb4KpjGpjI56i0hZf+uv6FP0JoMHeq6/t0wTJ2J4LKdTf
 fe7ar0YtWt0RpbcG1MRRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U8jKZwb7VWw=;kuRLRAvfIPSTU9UccI3eB9yRjgm
 EAgFfyM//5gc2yiXQ+Nmm9bSootVdj77T5jnNCSJIb0Jv+/U9xb7mcOHWRGXcXQBtcD2nuC6V
 dUXDXpwwyc7cxzklNHyCDOLELs/qeHpya+Jzj+djCi+H2fVSP8Y2n+n6Ot7jItKDhfjU+Q6Ym
 Qm8L/xhq8T0CaHfG3i/wvjLI0FE2XkWXLAzQr/WPaoRhK8WujjZRAc8yTD/nTz5oot7koFave
 y6haNdXpO8CA7aUiwrE3KrEFn2YMxZ4+MHsqzHFIB6k2Ag7bQpdDP//0LybgsXCTKHPks6OIZ
 PdaCvdNsSqcAcTtp1+MxcdMiZCjGKDIkOuuVWt+nWEibLFoXRXWU52s5872x1ZtEAXxJ5sidg
 R7dlQY86JjlnhinVHYsgfhyuqF3lHedZzo56HdH4T5y25Vb5bOLeNca0wb12ola2hK5RvwBaM
 890ZHWfhOFRUq+ZeLG034Idp5n8d8X+kX9mGGcBbc4xIgzJtLPKZskI1Xrfv3sSdcogeRUTH3
 DS/ZchbGQs7WuSMoiV6TjOkwmIVD3exWSkyA1R+M08iAHbzvKbNzZImtFBOFtYlfveECHOrSX
 47sMsVxVCRr0+CBgzVvsJU64SfY6crSH4Pu5VK9JK7dbAbTodsM0R2220xTaZ40x0KFcW2D4M
 b3O76BrC2VvXR1cnyHN5D7wOQG5iX+lVkf92QB4JUhbgH4mTrImmxPyxX+z1qw81ixEEninFJ
 RoGTjaCTIYRlUogJ8gp86HxyZo7HOdSCivzPIiQieNZHh+M+6IyyGGkVc+us7crFUivshQky3
 1+p3zp+i/+KXiR8d8DDR+PFw==

Am Mittwoch, dem 24.07.2024 um 11:36 +0200 schrieb Linux regression tracki=
ng
(Thorsten Leemhuis):
>
> On 19.07.24 01:46, sean.wang@kernel.org wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > Fix null pointer access in mt792x_mac_link_bss_remove.
> >
> > To prevent null pointer access, we should assign the vif to bss_conf i=
n
> > mt7921_add_interface. This ensures that subsequent operations on the B=
SS
> > can properly reference the correct vif.
> >
> > [...]
> > > Fixes: 1541d63c5fe2 ("wifi: mt76: mt7925: add
> mt7925_mac_link_bss_remove to remove per-link BSS")
> > Reported-by: Bert Karwatzki <spasswolf@web.de>
> > Closes: https://lore.kernel.org/linux-wireless/2fee61f8c903d02a900ca31=
88c3742c7effd102e.camel@web.de/#b
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>
> TWIMC, Mike (now CCed) ran into the problem and on bugzilla confirmed
> that this fixes the problem:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219084
> https://lore.kernel.org/all/CAHbf0-HOS-jdRGvJOBmEgaaox3PDbDSTgnnZkZF9pz3=
7Bmh2iw@mail.gmail.com/
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

Unfortunately this NULL pointer dereference made it into linux-6.11-rc1.

Bert Karwatzki

