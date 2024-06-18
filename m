Return-Path: <linux-wireless+bounces-9196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0307D90D5E1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A58A1C22399
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFB613AA51;
	Tue, 18 Jun 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="t4g0hXlJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFE1C2A8
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721260; cv=none; b=dVlsBQYMFKaVAipHlq9f5cxvziRcLPOEPDWgi0hQciqSxAMw6xJXHQFFuus0n+v6rMkxWQVnuQtVGg7hRcfv474Ggesx0yCvkn0gIk9imzQv090O/yNXsX/wxjMqGITSqV8Vo8j5O3go8yDbA/0LovTqomJfvNsOVLfJ17ZBGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721260; c=relaxed/simple;
	bh=mImgMnclwauk03h/yyY+/vk7U6wTzr8k8F1eJ3bQyJU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJPcKt5FQ58DmxsUxge7Ba6rSCM+vKfJiPyiSveDeAo+1u2d+dLUvGzdpmSVBxCRXnAvI3p46RgS4bP8tsRkMkhL8hf+pA5BHkSok7qF9gqvEMp5syS0iLlRdiQUSiysFRidMs23bwEcoCwcw71bbuWlDPK/NhJJU0d1rsAtV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=t4g0hXlJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=m6oxJS4bwQ7oJbqr2zrB+YUY8zIr1r4WhUyUcxBm+ec=;
	t=1718721257; x=1719930857; b=t4g0hXlJIc0jARgKJMLoOVGOio01GpEgbmvlMQuCVRPBx7h
	U+8MSlu4OfAE3vNSFNCAWS7s1R3yG1d5Ob8yw76aX2CBHgF/hqe2jrioNPAWj7j/oDLANYLnzVubs
	qtXzH0mR3oaJ+3n+5bOmfSyeHzDphXkyrGfThTMIo04L3DAdDFcqE629oPi9Qm23g6sxqD0PfFcuB
	UxhJhLewyY9cN3rxWoLwnLbJ81k0FB8hvikcS7vZFXi35+PalVPC/jo7AfU5VxFZbOnVsQEHT3sVS
	gdfL5FkrnEBHD5Cl+RXQ7FEaxyzcpHz0N7jo2lS8wz1g8LvFv1/6YyldeBUOl0Rg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sJZuX-00000005IR5-3rWZ;
	Tue, 18 Jun 2024 16:34:14 +0200
Message-ID: <d74ede1a96a1cb615dcbfc445b526b48da40ffc8.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: unencrypted message in 4-way handshake
From: Johannes Berg <johannes@sipsolutions.net>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: "Le Suire, Michael" <Michael.Suire@Softing.com>, "pkshih@realtek.com"
	 <pkshih@realtek.com>
Date: Tue, 18 Jun 2024 16:34:13 +0200
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
> I guess you were on the right track. For now we disabled the control_port=
 via
> driver option in the supplicant conf, because the wpa_s logs were pointin=
g to
> that and now the 4/4 frame of the 4-way handshake is encrypted as expecte=
d.

OK.

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
>=20
> 		return wpa_drv_tx_control_port(wpa_s, dest, proto, buf, len,
> 					       !encrypt);
> 	}
>=20
> 	if (wpa_s->l2) {
> 		return l2_packet_send(wpa_s->l2, dest, proto, buf, len);
> 	}
>=20
> 	return -1;
> }

I don't know, you should take all this to the hostap list then.

> Currently I don't really get the relation of PTK of the 4-way handshake a=
nd the
> PEAP session key of the TLS handshake. Latter encryption should be applie=
d
> independently of the PTK being installed or not or am I wrong? Searching =
in
> the IEEE802.11 standard didn't help me to find an answer to that question=
.


The PEAP session is completely transparent to wifi as a transort - as
far as the kernel stack is concerned, the TLS handshake packets are just
data to either be encrypted with the TK (PTK) or not (depending on the
flag), but the inner encryption is totally up to the higher layer.

> So I'd assume there's a bug in the wpa_supplicant or what's your impressi=
on?

Sounds like.

> Or is disabling of control_port already considered as a proper solution?

No.

johannes

