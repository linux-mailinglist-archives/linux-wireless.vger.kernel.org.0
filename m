Return-Path: <linux-wireless+bounces-9197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0303A90D5F1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE122282B76
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EC4154445;
	Tue, 18 Jun 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jIRfvm73"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C91552FD
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721561; cv=none; b=ItamnP6dpfO2mXo3Qbc6NLNYHxAVPcMDhYzlqTFpvIYb0PPVsUUzuNOedBx61Tp+y84ejC7kPswTP1sLIo2dPV4UYtLqUgbxD5uQafFpLPUJQZ6qtrpXdhG3SB6dHquaWZom6GYH9WA+56T3H/tXmuva5DTWmAQb1fc5wlTcvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721561; c=relaxed/simple;
	bh=bkVNbXxmw65nyhBB1LJ8OyDEI1/PJVOgQNG7A35m4WY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtp5++SLJacapbERniVpPLh7NTsxHrhMnUQxJnmhFT5EluIZkbkuaixQsm1RRQWA3mpry8ZuiARy9xY2R7svovj3gFY1/CHAnHPx/7+Jd4lqLOGlsqXzKhiV4zXzBiMpFUgwAqld1YQuCJLWWihdw8PKeXMIeR/QZhWMaKj6C3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jIRfvm73; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ur+m331uguAtiNKjUmDuZMaejiiFWnk5cN4jkRwarYI=;
	t=1718721559; x=1719931159; b=jIRfvm73ZJI6CUeBfNF+OX5sojC1nisVwWH2SJuZfqesbp6
	XN2i+CPiJWJkc/wI1PP+rcb+GPjVtg9ce0TvEuVWrD8TsZeO35kQAB0cUogRZVe0tcTI+VLi5t7HX
	iOsrAcekvLVTmJcBFVB0qXKBlshc7LMelvDqi+EMhtwV1TdhBlgoutnJrBbBjldDoXKA3Ku6GPHl6
	f0JKzzeREjfG6Rq5Q0C/AO8wFGJz8dmMHrurO4sNVVmmXyKnDBAa8I7md9l0EjvVC0FEoFtUW1v+9
	yaFPfpoKclqTposg5hjr4FmYF7NJbgWN+o13s8qxFYbf6pmXh4O2khpPY71LlINA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sJZzP-00000005Ilq-3yPp;
	Tue, 18 Jun 2024 16:39:16 +0200
Message-ID: <db505ce2afd6f4389c20b323cd20d88b4b886f46.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: unencrypted message in 4-way handshake
From: Johannes Berg <johannes@sipsolutions.net>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: "Le Suire, Michael" <Michael.Suire@Softing.com>, "pkshih@realtek.com"
	 <pkshih@realtek.com>
Date: Tue, 18 Jun 2024 16:39:15 +0200
In-Reply-To: <BE1P281MB2420B8A0493568084C9F119FEFCE2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: 
	<BE1P281MB24208AB02DAEACAE9AF4B5C5EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	 <BE1P281MB2420DA2C6AFF94E525306302EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	 <6bdbcae5cfedccc507426bde60fe86e72212ca5a.camel@sipsolutions.net>
	 <BE1P281MB242075CF50BF71257D14F955EFC72@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	 <bf445f8aa320858124368a210b5cb86a9613b44b.camel@sipsolutions.net>
	 <BE1P281MB2420B8A0493568084C9F119FEFCE2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-06-18 at 13:56 +0000, Sperling, Tobias wrote:
> > > >=20
> Looking to the supplicant the problematic code is in the following functi=
on.
> When WPA_DRIVER_FLAGS_CONTROL_PORT is set, during rekeying at the time
> of frame 4/4 the (new) PTK is not yet installed and therefore, leading to=
 the
> frame being unencrypted. The additional check for PTK being installed is =
probably
> to prevent some race conditions. At least that's what I think after readi=
ng the
> commit messages of when control port was introduced.=20
>=20
> int wpa_ether_send(struct wpa_supplicant *wpa_s, const u8 *dest,
> 		   u16 proto, const u8 *buf, size_t len)
> {
> [...]
> 	if (wpa_s->drv_flags & WPA_DRIVER_FLAGS_CONTROL_PORT) {
> 		int encrypt =3D wpa_s->wpa &&
> 			wpa_sm_has_ptk_installed(wpa_s->wpa);

Yeah I think the issue here might have been that this frame is queued up
for transmission, then the key is installed, and then it really is
transmitted - so then it might be encrypted when it shouldn't be.

But tracking whether the *current* PTK is installed is wrong in the
rekey case since the packets should be encrypted with the *old* PTK,
which ... will have the same race?

johannes


