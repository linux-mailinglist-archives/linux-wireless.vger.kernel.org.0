Return-Path: <linux-wireless+bounces-15421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432B9D0107
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 22:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DCAB22F62
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3848198E90;
	Sat, 16 Nov 2024 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Bk1faLMm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6D15E97
	for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793300; cv=none; b=t+lEASpIw/tq3uTYj/QXDGA66BwuzC2fAUjRsHRAywRh04TK4axAtlE2UqPXZD0iUBho5BX+Y0bZbAet9BugqvzhiTCuI31Y10BBSTCDISaFO8y+YqIDBJRvRe0ajFPAHk32awlBMhJLrA/6RaFjR7rJLKOgATf1gWU90JgNk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793300; c=relaxed/simple;
	bh=q4O05SJN3aOBLjXdxxOorTYju8mPNYTc4Lu3hJuqspk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbriIUab5uBSUWyU49BI+DXermfzvYRhT/Nifv0ZlR7iW4kzNRE0LBPB6ujDVJa8Qai2WPe8ENMSKub/AEgWZrDSjVmnQcAgdqz/zpmQV0QrbCamrIYkoJXazreVYvsFzmZtg4VzMS3zvrYA3mvEtVoiPFTxEkKgpgXdN21o+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Bk1faLMm; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=q4O05SJN3aOBLjXdxxOorTYju8mPNYTc4Lu3hJuqspk=; b=Bk1faLMmat0pZjSdnYBOOX9lTv
	+cGJYlox36URofaiddldbi82O8y12rdqe5UyEowzWPgOcDNtjqXPutkgmjOfdgJNkBWJalFVjDNkM
	Hq4xrNvKJ3MVrcpL7T0ERjr+OxGMPB4M4Upha367X+FgYAUABPMWeicB+hENAnGBvirxibl603LiX
	JVWDd1ajyq2G3qU73QkxYkyP7tqxkAmUpAAxVw7ICiYXART+5zz7x4wpBIcA5QrqZk7Ife7xQV731
	oHHngxgaWdf9t/aWbm6XXRO6qPms/j5xVIBGIOcrW7ROyKHYo0IW30Zpj0fUCqdOkVGIZXkUPHva6
	PwY+HCUw==;
Date: Sat, 16 Nov 2024 22:41:27 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Neeraj Sanjay Kale
 <neeraj.sanjaykale@nxp.com>, =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?=
 <tszucs@protonmail.ch>, "linux-firmware@kernel.org"
 <linux-firmware@kernel.org>, "briannorris@chromium.org"
 <briannorris@chromium.org>, "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [EXT] Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in
 the firmware git
Message-ID: <20241116224127.63efde40@akair>
In-Reply-To: <PA4PR04MB96381A69AD86ED9C9E4AD9CDD1CD2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240605160013.6bea8d4d@aktux>
	<_pNnwoI9WHlb2EY635KdIv6t_goU-ZYp9Vav31jkFOCf9fCE9EeKdyCea2m-L8pgfsKIQvODlnQLhQqmWSYip9e6FFZwaJHL5-u5rdOS_kY=@protonmail.ch>
	<20240605174709.5043af8f@akair>
	<20240606101839.GA76158@francesco-nb>
	<PA4PR04MB9638D1FD47BFBFDDB096C778D1C02@PA4PR04MB9638.eurprd04.prod.outlook.com>
	<ZmlEny2W0nArOf1T@gaggiata.pivistrello.it>
	<PA4PR04MB96381A69AD86ED9C9E4AD9CDD1CD2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am Mon, 17 Jun 2024 02:13:22 +0000
schrieb David Lin <yu-hao.lin@nxp.com>:

> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Wednesday, June 12, 2024 2:48 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: Francesco Dolcini <francesco@dolcini.it>; Andreas Kemnade
> > <andreas@kemnade.info>; Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>;
> > Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>; linux-firmware@kernel.org;
> > briannorris@chromium.org; linux-wireless@vger.kernel.org; lukas@wunner.=
de
> > Subject: Re: [EXT] Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing =
in the
> > firmware git
> >
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> >
> >
> > Hello David,
> >
> > On Wed, Jun 12, 2024 at 02:17:46AM +0000, David Lin wrote: =20
> > > > From: Francesco Dolcini <francesco@dolcini.it> On Wed, Jun 05, 2024
> > > > at 05:47:09PM +0200, Andreas Kemnade wrote: =20
> > > > > But that is all legalese and I am not a lawyer... Best is of
> > > > > course something officially added from NXP. No idea if it can be
> > > > > done otherwise. How to make NXP add something? =20
> > > >
> > > > Would it be possible for you to get these firmware files added to
> > > > the official linux-firmware git repo?
> > > >
> > > > I am not using sd8987 myself, from what I read in the thread
> > > > probably some file name would need to be corrected (I would say in =
the =20
> > mwifiex driver). =20
> > >
> > > I am not responsible for firmware release.
> > > You can get updated firmware from =20
> > https://github.co/
> > m%2Fnxp-imx%2Fimx-firmware%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.co
> > m%7C10acf638ebf04b0979ed08dc8aab99d5%7C686ea1d3bc2b4c6fa92cd99c5
> > c301635%7C0%7C0%7C638537716818815780%7CUnknown%7CTWFpbGZsb3d
> > 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > D%7C0%7C%7C%7C&sdata=3DZrU82HbKZ%2Ff87IG2tgInfq7kbyCuV8PcksxvTWiM
> > HtQ%3D&reserved=3D0.
> > Yes, I am aware of both, and most of the people in this thread is aware=
 of the
> > second.
> >
> > I was wondering if you could facilitate within NXP having these firmwar=
e files
> > added to the linux firmware git repository, where they should be for va=
rious
> > reasons. To whom should I write such a request? Can you help in any way?
> >
> > Francesco =20
>=20
> I reported this issue just like Neeraj did.
>=20
any update on this topic?

Regards,
Andreas

