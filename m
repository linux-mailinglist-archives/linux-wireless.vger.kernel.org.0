Return-Path: <linux-wireless+bounces-26024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7850B12494
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 21:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915093AFCFC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6862571CD;
	Fri, 25 Jul 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="QFoQcRq2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAA242D8B;
	Fri, 25 Jul 2025 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470351; cv=none; b=qRBnYasamxWG5WfLvWfEMApZTPGTVwcApgp6mToD2iXt6T2WqyXERliAAxCP/zOLkCxLbAFr1C7iArv2XmxdESz52s0v3E0YOyUHaGPYz58+O7fT9TtMrJbDfL5tZyZP+MClma7PREoryBTWSscAtv4JjQ7vcfwSArp0AWTxQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470351; c=relaxed/simple;
	bh=mELrDtWGMI1QG93gjCIPHgENUspiCmDd8aU++jDSiTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA00brlG377Ln273LYJB+4ev+Oz3u9ot8+wOApZVfIZi1/2GiSPPKvL1XxFMHcNk9NyUiW6DlSbLQXa+51chC7tnpkDp9YUb8XoMUepLcDHsFSRzT147JGvO8ETLPxvzMQnkVql0CUQnpmAJjYdAbmb234RyOK4t0sOsMG4lwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=QFoQcRq2; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3ABAA1C00BE; Fri, 25 Jul 2025 21:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753470339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZp/qEMObXUYLMGlCigrDo0ItwQbn1PmLGaupHV3qjI=;
	b=QFoQcRq2Js10wMhwWRp3uNsPd4UFFlI2SejV8t4oIKRVzuO4bRePabMMJ5senQgpk0vM9I
	/cbJb4xhuXguIPU3QqL/80c/+OzQhrehH2K9j+yXqmVrLc1ouRcbxOly4uRokS8XGn0jjc
	nG6zfZlsYEqn+wGbSx1xdBRA3yOjQes=
Date: Fri, 25 Jul 2025 21:05:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <llong@redhat.com>,
	kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, peterz@infradead.org, will@kernel.org,
	miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>, John Ogness <jogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Tejun Heo <tj@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
Message-ID: <aIPVghzeOTawpTeT@duo.ucw.cz>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz>
 <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz>
 <874iv2stk3.ffs@tglx>
 <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <dd50a074-0988-4a4d-a78f-7862e87dbab0@redhat.com>
 <877bzxqo39.ffs@tglx>
 <87v7ngpa43.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5ZViAcPiKIAYIsP"
Content-Disposition: inline
In-Reply-To: <87v7ngpa43.ffs@tglx>


--O5ZViAcPiKIAYIsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Enable framebuffer and framebuffer console. Add console=3Dtty0 to the
> kernel command line.
>=20
> Log into FB console and do
>=20
> #  echo -e '\033[?17;0;64c'
>=20
> which enables the software cursor, which in turn enables the above
> conditional invocation of fbcon_del_cursor_work(). Then force a printk
>=20
> # echo h >/proc/sysrq-trigger
>=20
> and watch the show.

Heh, fun. Yes, long, long time ago I enabled software cursor. I
don't normally use the console these days, but I switched to console
for debugging the wireless problem -- hoping I would catch some kind
of backtrace on the console.

Best regards,
								Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--O5ZViAcPiKIAYIsP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIPVggAKCRAw5/Bqldv6
8uTTAJ9Ldr9q7FUaylsnXpqczYVGRjRQHgCgrHnzq+tSSm5J4hfZN2Nkc1plxnQ=
=geVZ
-----END PGP SIGNATURE-----

--O5ZViAcPiKIAYIsP--

