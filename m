Return-Path: <linux-wireless+bounces-8405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E028D7C3A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20A1285288
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3113B297;
	Mon,  3 Jun 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="b+drXQwu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C782943F
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398640; cv=none; b=pBY55lan5ei9jnOQACCiJdTnxEzFk8m/U9FUT1pQhh8grU9rXF/UA3o4TaSw4XmkgPeuKVxc61eY+BC5I4AC2xsW+H3qx/VMOIsaWXp77suSidW2E4DX/EOCgF2OXpiLpIJ928kSPMrnBfJfGrrN/+r3F7Jj/L2u5rFA88MNySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398640; c=relaxed/simple;
	bh=A8olmHpdHVxcJDOhziNdiQwy+oh+3e9tYhXZk0a92zQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZhagY5l+jd2kXlkBs72ey9dO9Jlx5wRbien1xN1r/zXKnTJddwJI+/lRxYRGU3p4ihRPGcYyjOqiR01GRsT8ocUTHKZ4vV54TkGR9EucEhBxCZ4WJXIRMs4JRB+5pRT3n8Xe38fXxSyUDHrlaOT79qaWBpVLCbnmtgxOcULk0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=b+drXQwu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A8olmHpdHVxcJDOhziNdiQwy+oh+3e9tYhXZk0a92zQ=;
	t=1717398622; x=1718608222; b=b+drXQwumYT3oHbeBOsMQK2jjzSuFxsQJfFLPSJkdGihuRR
	yw0gQx/IbL0heBhrg7uYFV8nyTztgEZbLAAK91cecsC3y5IZkSe8Bw+CkvhT6CoO9ugXIoEnIfHde
	K/lsrgUu/72euMicmVbbOfTsR/xw/twtTXsJs2XInXUxQdURuqITLDwZD1QDPojIoKEPMVKTCfYn+
	P0ISVjgcTsEyV48CI6GKzEMIfuU/DIuHLFpqoP7l8iLTsBU2vowEoNZbb3ZQwl3c9NX4do3H4lFdm
	JClownf+VEAOtotoab3LfegxRBGDv4Qket9wQChrYoYy0/ne4ze3Bt3cXnlFB1Bg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sE1pZ-00000009I8v-3Oes;
	Mon, 03 Jun 2024 09:10:10 +0200
Message-ID: <234e631d44001c22368b8ddad916d9a0f13604f6.camel@sipsolutions.net>
Subject: Re: S1G and 6GHz channels in Estonia (and EU)
From: Johannes Berg <johannes@sipsolutions.net>
To: wens@kernel.org, Taavi =?ISO-8859-1?Q?Eom=E4e?= <taavieomae@gmail.com>
Cc: wireless-regdb@lists.infradead.org, linux-wireless
	 <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
Date: Mon, 03 Jun 2024 09:10:08 +0200
In-Reply-To: <CAGb2v66xjwgcMZ2-N9CEg055Q+mLQKm20Nvo9mmHD3LY=C=Vjw@mail.gmail.com>
References: 
	<CALfTr+pXU_=ORh2w3GE+YiU9igh61uWZS-zdG1GyKFb5Qs6fTg@mail.gmail.com>
	 <CAGb2v67-9Gyxwpy8w9X=Gz7wXuVO0DncwXoRPV6_zrpF7MdEsg@mail.gmail.com>
	 <CAGb2v66xjwgcMZ2-N9CEg055Q+mLQKm20Nvo9mmHD3LY=C=Vjw@mail.gmail.com>
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

On Mon, 2024-06-03 at 14:39 +0800, Chen-Yu Tsai wrote:
> (Resend to Kalle's correct email address)
>=20
> On Mon, Jun 3, 2024 at 2:36=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wro=
te:
> >=20
> > (Adding linux-wireless ML, Kalle and Johannes)
> >=20
> > On Mon, Jun 3, 2024 at 1:13=E2=80=AFAM Taavi Eom=C3=A4e <taavieomae@gma=
il.com> wrote:
> > >=20
> > > Hi!
> > >=20
> > > I have a few questions about the current regdb values for Estonia/EE =
and EU:
> > >=20
> > > 1) There are no allowed S1G/HaLow/802.11ah EE (or EU) bands:
> > >=20
> > > Based on resources online and Estonian law
> > > (https://www.riigiteataja.ee/akt/117052024018?leiaKehtiv - Extra 6)
> > > these two additions should be correct:
> > >=20
> > > + (863 - 868 @ 1), (25 mW)
> > > + (915.8 - 919.4 @ 1), (25 mW)
> > >=20
> > > (Note: I don't see a way to define duty-cycle limitations, but that
> > > should be okay?)
> >=20
> > I'm not sure if there are plans to support S1G in Linux. If not then
> > the information would go unused and untested. If it is supported, then
> > patches are more than welcome.

There's some S1G support, but perhaps only in hwsim right now.

johannes

