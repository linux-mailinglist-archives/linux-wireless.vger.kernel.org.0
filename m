Return-Path: <linux-wireless+bounces-24794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F8AF7A73
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 17:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2578F17CE9C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520F52EE299;
	Thu,  3 Jul 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uy3ebl3q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952471E9B3D;
	Thu,  3 Jul 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555391; cv=none; b=BBdMKMEITyDlO74embN62UrEELgcWHNt/AFGVNj1p102XYt365Uq6DkA9Hb24zDtZX6G50GY0Ailnl62fn3j/3P/Wfwq3TeuvjwRvI1+T/cEJQVn8KifodXl1h31R2p2U8kgNvGPC1RB5ZwmfBKlndHXiQ74AfZOMtKwusnC0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555391; c=relaxed/simple;
	bh=xUy68UuIxrFAKtXpuKTLBaZL8PxltNg2EI/H2YK9n5g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=emgea5jhLivIw7cttXxrF4wGfJ/bA6SaAqeiX0toweeWV1qtw99b66pNl77G/0NtYreQpl+3L/AfE9CZr3t3i0nSQ5AvJrwDwCgk9bknKq8oF6h1LzD9S/H3jI2thOMriXhimhw8fBSegcy6K/azIomRXob3tRVfL9ft/7K85UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uy3ebl3q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GXuM67p34J7ZSKstZYD6B0wz0ShaFIP2wKz0lCTsjTY=;
	t=1751555389; x=1752764989; b=uy3ebl3qLCjUQu8qQJWfuJcV13qtY9Uyi6xBrjIpFWctJLJ
	WADu5fT8xB1oKtYMLA6hbTYmT/pwx8l/Af1yZRxOTkK8ehOKh5bXmXSOWkSkIrY1PIgsg63krmg71
	IDu1+6A9zBE0OQ2S0q7TieIqJR0mTX00EntSazwXaHD1n+tuu0wMdlwWjMfpYeQr98IcAqJyVDR01
	ZR8lWuqdSgC3okqlgZCe+7FxhDZh2LFTC0FufqCeH1VfJx+z226aDV1V0FDkFRIbt/KM9VXmCUU9I
	82Gk1xH6HdCjrKNvBr56+4BWhUwct2H6LMt2slvbGHOFAQyG0mJ1BfV1EZguKT2w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uXLZK-00000005Sbu-330E;
	Thu, 03 Jul 2025 17:09:46 +0200
Message-ID: <1f13328a55c54fb49d8ca1dd72bc5de23f161ac8.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: reject VHT opmode for
 unsupported channel widths
From: Johannes Berg <johannes@sipsolutions.net>
To: Moonhee Lee <moonhee.lee.ca@gmail.com>, Nicolas Escande
	 <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, 
	syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Date: Thu, 03 Jul 2025 17:09:45 +0200
In-Reply-To: <CAF3JpA7wM4JBdd6OvGS+hmv0UahcW=h4HrPNDwRNhduk8iKsWw@mail.gmail.com> (sfid-20250703_110226_928227_85F0E8E1)
References: <20250702065908.430229-2-moonhee.lee.ca@gmail.com>
	 <DB29OMQH4W9Z.1GPKEZBBIRSTS@gmail.com>
	 <CAF3JpA7wM4JBdd6OvGS+hmv0UahcW=h4HrPNDwRNhduk8iKsWw@mail.gmail.com>
	 (sfid-20250703_110226_928227_85F0E8E1)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-07-03 at 02:02 -0700, Moonhee Lee wrote:
> Hi Nicolas,
>=20
> On Thu, Jul 3, 2025 at 1:12=E2=80=AFAM Nicolas Escande <nico.escande@gmai=
l.com> wrote:
>=20
> > Is this really specific for VHT ? or for HE /EHT as well ?
> >=20
> > > +             switch (width) {
> > > +             case NL80211_CHAN_WIDTH_20_NOHT:
> > Because this seems weird for VHT
> > > +             case NL80211_CHAN_WIDTH_320:
> > And this did not exist for VHT either

Yes, but see below.

>=20
> Thanks for the feedback. The intention was to handle VHT opmode notificat=
ions,
> as noted in the commit message, but the check incorrectly included widths=
 that
> are not valid for VHT, such as 20_NOHT and 320. I will update v2 to rejec=
t any
> invalid widths, not just 5 or 10 MHz, and restrict the check to the valid=
 set
> for VHT: 20, 40, 80, 160, and 80+80.

I'm not entirely sure that'd be correct. 320 MHz can only be used on the
6 GHz band, so clients must be at least HE, but I'm not sure that VHT
opmode notification frames are completely illegal for them, even if
they'd like use OMI instead.

How did syzbot even manage to get a 10 MHz thing running though?

johannes

