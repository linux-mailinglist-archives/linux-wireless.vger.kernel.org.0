Return-Path: <linux-wireless+bounces-15208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E39C5C13
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A6C2812DF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1848201266;
	Tue, 12 Nov 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n+25dFhC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7F1FEFA8;
	Tue, 12 Nov 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425994; cv=none; b=WWQkbWaWc1fjU3NvqUBhYJePTCWGppcqbRE/dnseAFnXslOX9KuhQTMFEwgNZwxEe+sc4CIC+zcIzHBHrunSN7ZPAmhEcxFXAaBck0AL8qPUYGdt35hAHkxeOWEv6VXdIIDc2DZWHa86qYAYqsrbDHnE5LUALHgTgNfTYZxnF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425994; c=relaxed/simple;
	bh=fvrNxzwDp2P3iPosrFRowJKvdfK7Cu3AryWdKt0N3Ls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eiCp7cBwobU3vo5wU7Oz8Wk7qNMvBr63xuPwkwFsyC6GpfjFpFMBexEh696PyvIkbHydEzLqKyIhE+PpfByQPTPwmBcI2BIlM33k0fpxO/t3xH4pwGq9+SJ1+ZNOIvbvIlYF4NRowj3MtxIHnFrj4UjYcqEDG/3KRPODh+vyd6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n+25dFhC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yC4PgO0iUg1E/9QX5QiVdbAl0FhMlHnWwAy+hx8zLyU=;
	t=1731425993; x=1732635593; b=n+25dFhCEMsvZSJ+77KWS4+QeyK3HpzmWVj3lDZbVhXkBVK
	iw9POVHy/1O36NwC8m1YrTkNw3NHwxlqSP4OnvNlw1HVcJrhFevAeT1Zzw0BH9QJCIARISV+Mpfc4
	MXLu/wyejOcVmwSzslUW3HyOeo2xwD920oTB+yRrnbU3e8DALso3CO/h62kbtIoE19sMz88YsiMwu
	GrMRaMlywOCenNPEtD8R76dNEr9QyRTPe4dsCq0HfLImkZgdwpwDnnl/5Z9GgdAwrhxuo9Z3EsHku
	RzmrbxbfjTCFOtw5f059uYS4yw7gpTSYHLSMD6Epp+51Y+YKGO9IdivU7Wk7wpIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tAszb-000000031hp-0UTN;
	Tue, 12 Nov 2024 16:39:47 +0100
Message-ID: <59b318b2d6719a009189e10949df35f855790d63.camel@sipsolutions.net>
Subject: Re: [PATCH v5 09/17] wifi: cc33xx: Add main.c
From: Johannes Berg <johannes@sipsolutions.net>
To: "Nemanov, Michael" <michael.nemanov@ti.com>, Kalle Valo
 <kvalo@kernel.org>,  "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sabeeh Khan <sabeeh-khan@ti.com>
Date: Tue, 12 Nov 2024 16:39:45 +0100
In-Reply-To: <2dbf1cba-0b16-413b-947e-dacf32c85687@ti.com>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
	 <20241107125209.1736277-10-michael.nemanov@ti.com>
	 <685d782d68bfc664c4fcc594dff96546ffc30e5f.camel@sipsolutions.net>
	 <2dbf1cba-0b16-413b-947e-dacf32c85687@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-11-12 at 17:34 +0200, Nemanov, Michael wrote:
>=20
> > > +static int parse_control_message(struct cc33xx *cc,
> > > +				 const u8 *buffer, size_t buffer_length)
> > > +{
> > > +	u8 *const end_of_payload =3D (u8 *const)buffer + buffer_length;
> > > +	u8 *const start_of_payload =3D (u8 *const)buffer;
> >=20
> > I don't think the "u8 *const" is useful here, and the cast is awkward.
> > If anything you'd want "const u8 *const" (which should make it not need
> > the cast), but the const you have adds no value... do you even know wha=
t
> > it means? ;-)
> >=20
>=20
> My intent was to express that start and end pointers are fixed and will=
=20
> not change in the loop below. When reading this again I agree this hurts=
=20
> more than it helps, I'll drop it.

Well, I don't even mind the const so much rather than the cast, I'd
probably not have commented on it if it were

	const u8 *const end_of_payload =3D buffer + buffer_length;
	const u8 *const start_of_payload =3D buffer;

I'd still think the second const (for the variable) isn't all that
useful, but really the lack of first const (for the object pointed to)
makes the casts necessary and (IMHO) that's what hurts.

> const u8 *buffer in the prototype illustrates that parse_control_message=
=20
> will not change the data so I'll keep it if there a re no objections.

Sure.

> > > +	struct NAB_header *nab_header;
> >=20
> > surely checkpatch complained about CamelCase or so with the struct name
> > like that?
> >=20
>=20
> Double-checked, no warnings from checkpatch:

Hah, ok :) I'm surprised because it complained about _Generic in my
patch, and that's something you really can't even change since it's C11
standard ...

johannes

