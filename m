Return-Path: <linux-wireless+bounces-36665-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCooGgeNDGr0iwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36665-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 18:17:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2955821DA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 18:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2F08308394B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA83F4DCB;
	Tue, 19 May 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b="LuMs4EzT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.bues.ch (bues.ch [116.203.120.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344412EA172;
	Tue, 19 May 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.120.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206875; cv=none; b=Y78AHwMsGwLYZPCD3qcwHRlxWJH52P2Q6RI8haVThWzanr6wwGrCR8l2PJ4QMxX1BCewWN8mH1TNXC0RKUG8543SRI5oPV8kd/vR7pobuwoWyBDUIfSuVpMQe9FmDh+lZKXkNfxaoJC3WEZ9FAiG651uv4xmsxyrzG4FYz0kZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206875; c=relaxed/simple;
	bh=gmmxCAiLa9RKpKtpxr1PCqZbzxMqycJObXXxT0r1iUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAof6HAggU0+aVflkSN5Da/u/nZg2MyEmWIP2GmWs7jFu8vPda/yDkTEHMrTGn0PewVxVPdqtweQE+qazKKQHhjTkWR4/qtgZinfa+EFfJ68kQGABt6snxI3Gl8+OaHo2Yyy6U4nxdcdn5s+rlLBtvROJrebdjIFLuIOiYP7Q2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b=LuMs4EzT; arc=none smtp.client-ip=116.203.120.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Date: Tue, 19 May 2026 17:58:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bues.ch; s=main;
	t=1779206344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xE0V16Qzx0fWvzNYJfiW2x7In3WXb/DTgVC+7eyRuMo=;
	b=LuMs4EzTp2RCzqW+4FV/HckoNzNEjb+XS2PJIN0b8V7Yet9WC72M8FDEg6Wj10dw74EGmW
	HdNbtDs9q8cn0/VTqSGyoGoKlpfi3tERp1ey/v7cwCV7mLFHzHokRUzItBoEJmMq4O8iaf
	XRvQYjOZniabAiB+OP6SEENSpniskU0o2z0hVoKDkU/f8ALMNHD1lUtvBMFZZobtLR/IDM
	w9/iwUM0/9Fyvc8d6tWp2H2RRpEKNGrKPHzOmsLLCCJOUyvmEc9cCwGaxUDo9YHhGIhriB
	GPM8gsf/PodiZ82200aKRb+fjjS2gqMTLwy7+VnicheNejqY9m1FjVeDA4N6Xg==
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alessio Ferri <alessio.ferri@mythread.it>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 kvalo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
Message-ID: <20260519175812.7ce97ba1@barney>
In-Reply-To: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d7_qXgZoj9=FyKV8KR5Ts30";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bues.ch,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[bues.ch:s=main];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bues.ch:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m@bues.ch,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36665-lists,linux-wireless=lfdr.de];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bues.ch:url,bues.ch:dkim]
X-Rspamd-Queue-Id: DF2955821DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Sig_/d7_qXgZoj9=FyKV8KR5Ts30
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 03:49:33 +0200
Alessio Ferri <alessio.ferri@mythread.it> wrote:

> This series completes b43 support for the Broadcom N-PHY revision 8
> paired with radio 2057 revision 8. b43 already supports the surrounding
> PHY family - N-PHY rev 8 with radio 2057 rev 5 and rev 7 are handled,
> and rev 16 with radio 2057 rev 9 is handled - but the rev 8 + rev 8
> combination falls through four dispatcher gaps:

> Alessio Ferri (6):
>   b43: add d11 core revision 0x16 to id table
>   b43: route d11 corerev 22 to 24-bit indirect radio access
>   b43: support radio 2057 rev 8
>   b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
>   b43: add channel info table for N-PHY r8 + radio 2057 r8
>   b43: add RF power offset for N-PHY r8 + radio 2057 r8


In general this looks Ok.
=46rom the style I assume that this is AI generated, right?
If so, can you tell us a bit more about the inputs used for the AI?
What information is this implementation based on?

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/d7_qXgZoj9=FyKV8KR5Ts30
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmoMiJQACgkQ9TK+HZCN
iw4hHw//b+g96CuQX/r2P1RmZcVjZ6Z1G/3rC/9guZpIDSkoEYNM8Zguz3cus75T
aLCxnlR4F/Q7hTDfk97crBfNiCZ2EiZDRGZ1fpsAC99RTiJ2VNg3y5ibZ116Snjh
Zkv0otxcB5MwGOazvB2trImsYq1DxJ9mBLrksyZsrJX2+C/zYzz7JoQePBrk2dEi
z25rR59cQw050paTUVYIy4SJr0u1GqWJcaQ9zvRWgD5gYmNEnb1qd0TWOD+TBQ4K
KT56uJlklefIG8HzmP489/ILc+d21o2hJ13kuk/rIeomRUiec7Y09cqEI8VrO/kR
fd0Wo2qFhI5kNC60acKfmWCIO2yjfUY2B36owZHxi0I7CZaE4QlYcGAbaYA2POTp
1ftv7NfFSWnFSYVEkc+B7VEz2jAjVcKqVOXlXIqGeM4oKrUtvOWSptRaii8G5Jin
lFQCI0GssX6j0vGG3q067s0OTa0LGoELVjJ3Kn2VLw7iN6iQ5Dh344R2rDVY+l/d
Y5TzsNfS0wxJMQuo9CMIdNuy1eMTLKJrQTWsspz+2rgVXlf+N5wa0YcJBlZeoIxk
tOj7UsgwCFJOYNMX0EGO5XXxtJp4rcrnfuVhb0nZs8c53r1KmMBu7XmI0JFXYBRm
h+NQ5vUWSUuIkHlkops4sCnINawn4SDx2vYafNU/rpAX+X6iQOY=
=2SkM
-----END PGP SIGNATURE-----

--Sig_/d7_qXgZoj9=FyKV8KR5Ts30--

