Return-Path: <linux-wireless+bounces-25536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49058B0751F
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 13:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E70C5834F3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6ED2F4302;
	Wed, 16 Jul 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YZZempSc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293C2F3648;
	Wed, 16 Jul 2025 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666905; cv=none; b=MkP4z3qU120dzmpJ0g9h/6/N7g/uV13N5/jDGwZf6TqyOT9bkBMBuFqhUJmkutd+RRXV4CvCPOjNZ6QgQ2/WT8rveOibOOL785RRND/0TLuaRSiC3DIW8T8nIOzpdZ5rZbX3izxI6LkEdr2O4MbbDSgXAAiBvr1kdPntoKrMFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666905; c=relaxed/simple;
	bh=6hS1hhCet8VVQXPHSWs+K0hLedykf6nuOOJw4zP3+e0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQLAWdpNs6xAsEP99bdztkmarJXiAZsmzhKRvjsuJywaVUDwsMnWMYCuUvRP5cz+VbBsV024wgX6OawG+xrKoxpGIoA6h1hhgbE0y3m1GdTVIJWFWuZo1b0hPhT+Phu0q2GXt4Xu6Pi8jQPG0AKeYA0Owpsx029fMC9sh3OeT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YZZempSc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1752666782;
	bh=6hS1hhCet8VVQXPHSWs+K0hLedykf6nuOOJw4zP3+e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YZZempScizbqdERacBRcuYeDs1eVRwwcxVnT/NOSAaqf2Q5JZTAtJmrNxTQolCgoq
	 Cet+Fwyq3zOILB5SquCcwX9uKeqdUQCE4tWhLeyX+Hvd6t6lJFQy4AuDuul81U/q6q
	 h2h+TOvzqG4ptu0fkTm9YqPfo3k9uYBB/S50iIjPYURQr62X1/R8klylL1wrhvZ7oQ
	 RxhCaWXE/ABG4kiriM4DFrAKSIGySgth+k+y9FR+9tZVUUeT3fc1KxdubeFMCKgjji
	 7Y96U6qZviUVWcm7x+qNM3RSEKxlImIy6NKdZhmQkcCCmG/YLfRW1MOg8jw/UW5TKb
	 MK49OPPgl7VTQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bhvZQ4Nkzz4x11;
	Wed, 16 Jul 2025 21:53:02 +1000 (AEST)
Date: Wed, 16 Jul 2025 21:54:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>, Wireless
 <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List	
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List	
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Pagadala Yesu Anjaneyulu
 <pagadala.yesu.anjaneyulu@intel.com>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20250716215456.764d3eb1@canb.auug.org.au>
In-Reply-To: <4ee6758a49e6f01c5e42b2f7c27aff905ac07dfa.camel@sipsolutions.net>
References: <20250716135252.51125baa@canb.auug.org.au>
	<4ee6758a49e6f01c5e42b2f7c27aff905ac07dfa.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qWyPK7U0zwDAqBtVDW=jkFv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qWyPK7U0zwDAqBtVDW=jkFv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Wed, 16 Jul 2025 10:59:31 +0200 Johannes Berg <johannes@sipsolutions.net=
> wrote:
>
> I also just noticed that you're still sending this to Kalle - he stepped
> down as maintainer earlier this year, so you should probably change the
> contact for the wireless/wireless-next trees to just me.

Fixed. Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/qWyPK7U0zwDAqBtVDW=jkFv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmh3kxAACgkQAVBC80lX
0GxKAgf+KOOETHP2duwnjrfK85tRxjFnz3TlplRbq7hWXxmbVke3ddL4/ZPQuZri
/oU5wLVNeMo0kHqehrZLYyumx/JN3c6ZYCCmG0yADI57ElS9cP1KvamfRFQmOX+A
GSGneSU2U3upPAvQBRjJLjyWcaG67VzJeCQlU65/aW8v/DQWYAOZM4+fISraUC8e
vI2bAy8rGC264WF5oxG1Lw3IX6oZdPW1ADjrtL7756BAF3pioK0jHBI7xPvF0k1N
bkOId7rLFWGrhN6BoOhq5xdMssVChoOA9QMRyra2cAcvb8MtcsqKNZsSNDEDedTX
w6b6m7unydD5SuOJB6Kq+aOoCLM3rw==
=poFu
-----END PGP SIGNATURE-----

--Sig_/qWyPK7U0zwDAqBtVDW=jkFv--

