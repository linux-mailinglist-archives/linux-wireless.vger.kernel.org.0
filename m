Return-Path: <linux-wireless+bounces-8835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE38904CED
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40941C243F8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 07:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CBE7404F;
	Wed, 12 Jun 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="NicLXKnr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91754FB5
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178021; cv=none; b=QUuBZyduWNKA3trDIrut0fXO0LV7IinRKVBIptznk9NM+8x+2Mu9dkFiyHO6yI6W7XUmNClijQ98rJ5imdaoKTyON0nxtYPBgw+Yk8gCNwrTR3LW/hNtjThXMGoygaBml9nxyPwugMxnFkJsxM2ERjK9pdrjscc9jOzDN97EAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178021; c=relaxed/simple;
	bh=Qve+f6XbziNzjwRexrA3qk4bcg6fKQaWazULkSCehuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNTlTWw60Zh3LaQ1e8VM7LLPAkjGTFCclzIxWBj8AFM86kbSn6e/bS2KSAlp/f02AxQGVerdifuj1FwXWpPfLaR7eZbjTU6arnPgRVo3n4GE5shZAzFkr0lzZl7lVmP9Zp7SiugJNrc3cPKaSZHgycMyo83EMcrjoNc17bTADDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=NicLXKnr; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sHIae-0009nj-2x;
	Wed, 12 Jun 2024 09:40:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YE9uqXBznaEaj2rlnAdKhQBdxcwiopNdKqHN8yp/Mxg=; b=NicLXKnr3hVSvtoGqd/kuSRKY6
	lq/AnW9M8vyhfa4VPACh69oF6ikRNK4TJNAou1OzDmaJQKMgzbtSqfjrzgUNzK3Kdr4SS7/3rLNk/
	NLXmLHBf7SQWds6DszmLY/YLSAJGm6g+33HMG3V/SvNsCbbfBs6SsSf+r3NNhdVa+b0bl/k73kWiR
	D8AjWskaS1EewzdIHRM9nO/Y4wBIM4gZwLLlGjIuufg94GAmHOJiljZoQERCBmxNZuJ2/kT/i7z+b
	/Y3OTzO/EKl7IG0TJYNVBcGzp8vrck+yv2NdlhvzaN2oxWiQ74mbPm1tk3NFNxrxHXm54752tmZxJ
	vcJQ14DA==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sHIaa-0033Ry-1R;
	Wed, 12 Jun 2024 09:40:13 +0200
Date: Wed, 12 Jun 2024 09:40:11 +0200
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
Message-ID: <20240612094011.311c2421@aktux>
In-Reply-To: <PA4PR04MB9638D1FD47BFBFDDB096C778D1C02@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240605160013.6bea8d4d@aktux>
	<_pNnwoI9WHlb2EY635KdIv6t_goU-ZYp9Vav31jkFOCf9fCE9EeKdyCea2m-L8pgfsKIQvODlnQLhQqmWSYip9e6FFZwaJHL5-u5rdOS_kY=@protonmail.ch>
	<20240605174709.5043af8f@akair>
	<20240606101839.GA76158@francesco-nb>
	<PA4PR04MB9638D1FD47BFBFDDB096C778D1C02@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 02:17:46 +0000
David Lin <yu-hao.lin@nxp.com> wrote:

> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Thursday, June 6, 2024 6:19 PM
> > To: Andreas Kemnade <andreas@kemnade.info>; David Lin
> > <yu-hao.lin@nxp.com>; Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> > Cc: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>; linux-firmware@kernel=
.org;
> > briannorris@chromium.org; francesco@dolcini.it;
> > linux-wireless@vger.kernel.org; lukas@wunner.de
> > Subject: [EXT] Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in t=
he
> > firmware git
> >=20
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> >=20
> >=20
> > +Neeraj
> >=20
> > Hello David, hello Neeraj
> >=20
> > On Wed, Jun 05, 2024 at 05:47:09PM +0200, Andreas Kemnade wrote: =20
> > > But that is all legalese and I am not a lawyer... Best is of course
> > > something officially added from NXP. No idea if it can be done
> > > otherwise. How to make NXP add something? =20
> >=20
> > Would it be possible for you to get these firmware files added to the o=
fficial
> > linux-firmware git repo?
> >=20
> > I am not using sd8987 myself, from what I read in the thread probably s=
ome
> > file name would need to be corrected (I would say in the mwifiex driver=
).
> >=20
> > Thanks,
> > Francesco =20
>=20
> I am not responsible for firmware release.
>=20
> You can get updated firmware from https://github.com/nxp-imx/imx-firmware=
/.
>=20
> Normally the firmware will be merged to NXP Yocto project.
>=20
yes, I think most of us are aware of this.
So what is the problem: E.g. I have bought a new device, ported a linux dis=
tro
to it, ok, for my personal use, I can just download the firmware from
mentioned link. So now I want to pave the road for others so that wifi
"just works" So the question is about redistributing the firmware:

Citing License:
"(b)     to copy and distribute as needed, solely in connection with an
Authorized System and for use in combination with a NXP Product,
non-confidential NXP information provided as part of the Licensed Software =
for
the purpose of maintaining and supporting Authorized Systems with which the
Licensed Software is integrated."

to me it looks like the firmware might not allowed to be part of a linux
distribution if that linux distribution is not just for one device.
So an official permission to do so is really helpful. The most clearest
thing would be an addition of the files to the official linux firmware
repo (git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware=
.git)
by some NXP people.

Regards,
Andreas

