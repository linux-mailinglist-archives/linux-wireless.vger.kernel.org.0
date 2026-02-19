Return-Path: <linux-wireless+bounces-32008-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JxBJcXWlmmdpAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32008-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:24:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B215D58A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87F173023335
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6A338932;
	Thu, 19 Feb 2026 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0S7PTc1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67533468F;
	Thu, 19 Feb 2026 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493054; cv=none; b=Mo/y5qUra7CUhsIBXLxs/EhUT153OrB71bsUNoi6vhrIcWiOYb9JH+dvrjXwI/rejl93jM+0a4YVINfyOrejkbtBhJdpqXmrtFdh7t2vcMvm5DEOg/l/nhfw9XbJl4jS75Uqn3uZG/Luo3SictxecwuVT+vHSylSMP2TTK5pJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493054; c=relaxed/simple;
	bh=7x4iJcrAJx0s0mdhi4aA1VWX8cBG3QA4CqCnflf0TaM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QXJfBvTKjr8T5WAT5qHAYQDrlibWTbxlkjr1DefYMZSH7O1IpfMcuZTgDcrV7bgDxM/UTSX/FdAE1StLpCaa0ZcZ+aPZBC5bM7OBQFZFs3sRHrcAmvOgJpTPLkaQ2bdZpC9dFSYQh5q0bYql/mq+QAxzVDck2YK1h3EcEiFdgiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0S7PTc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F6EC19421;
	Thu, 19 Feb 2026 09:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771493054;
	bh=7x4iJcrAJx0s0mdhi4aA1VWX8cBG3QA4CqCnflf0TaM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=j0S7PTc1AYTKclJM4VrrVU73y39Gm+g1r0n/WB7xvc3rog9V/88uQNpd+8q1TlVcn
	 ra6uE9LnD/79O8wcOlmXwu9frhVyscQZnWG7kWrQyn5qTxRmOwzunDbtYSczvigdQD
	 ZTOcAwGOMbTeUY5sIy2E0enw9aRm1Ng6Umu2gKZYUQpRgZOvFBBhAltlarDgN7p+Am
	 E0al+pDRVghpOIouVejND5QjFktE9G1S02hbhwv+/9rtqDBy/gcqZBd1NiTsHyaFpV
	 +6gY/TUDkPL2SMODbqJt2GntC0KvwUsViOAurmArgOX/BI9R0uw3X/Lmlj/xuJOY7E
	 2JDwQhG8WBF3w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 67629F40069;
	Thu, 19 Feb 2026 04:24:12 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 19 Feb 2026 04:24:12 -0500
X-ME-Sender: <xms:vNaWabUcj4Aqx9nItrl4czIWPhn8_OResdeqA8wQhJn4x4rLxaDZIg>
    <xme:vNaWaeaqJJmsesaxFxUUxAR6N5U-1Wdl2OF-dWkCWD10w_KDLVGV_mXTUlpaGtL_Z
    pp9Z8OOU3O17BfqmwyW7PKa2ydBlWTKAdgMpAbYFtP-MWeUgLQw6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeejudffheffueetveelgfeiueetgfegffelueetfeevkeeiueetieejkeef
    ueeiudenucffohhmrghinheprggvshdqmhhouggvshdrshgsnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusg
    eppehkvghrnhgvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthht
    ohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvrhgsvghrthesghhonh
    guohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegvsghighhgvghrsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlih
    hsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghrhihpth
    hosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfihirh
    gvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrshhonhesiiigvdgtge
    drtghomh
X-ME-Proxy: <xmx:vNaWaS64zKkRvQhaNM4wCXInrk7mBmRvcZy3O0-GJa4-wT3LisAR5A>
    <xmx:vNaWaXyS8N5sSvspaCM7is8CG3TqLDxl3wmtkBthmQen6O9hfbZ2yQ>
    <xmx:vNaWaefhJHLJmMJBEgL7DuqFOar2e3PCt75BVdSotqPSZEe5b9PsAg>
    <xmx:vNaWaUAkzwzwun1XhrdCGxSumha3ZtmudVayj7zyOqUPz8l0hnV-fg>
    <xmx:vNaWaa4oFUIZH8U2AHQhIKYPHtakE0NUwPusoA5Ny-wiou4_xJBzfBPs>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 44524700065; Thu, 19 Feb 2026 04:24:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlW4kGf5pqho
Date: Thu, 19 Feb 2026 10:23:39 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-wireless@vger.kernel.org, stable@vger.kernel.org
Message-Id: <21d30582-9cb2-4e7a-9aa8-36e16aa45ff9@app.fastmail.com>
In-Reply-To: <20260218213501.136844-4-ebiggers@kernel.org>
References: <20260218213501.136844-1-ebiggers@kernel.org>
 <20260218213501.136844-4-ebiggers@kernel.org>
Subject: Re: [PATCH 03/15] crypto: arm64/aes - Fix 32-bit aes_mac_update() arg treated
 as 64-bit
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32008-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 579B215D58A
X-Rspamd-Action: no action



On Wed, 18 Feb 2026, at 22:34, Eric Biggers wrote:
> Since the 'enc_after' argument to neon_aes_mac_update() and
> ce_aes_mac_update() has type 'int', it needs to be accessed using the
> corresponding 32-bit register, not the 64-bit register.  The upper half
> of the corresponding 64-bit register may contain garbage.
>

How could that happen? Setting the 32-bit alias of a GPR clears the upper half.

> Fixes: 4860620da7e5 ("crypto: arm64/aes - add NEON/Crypto Extensions 
> CBCMAC/CMAC/XCBC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Agree with the change but I don't think this needs a cc:stable (or a fixes tag)

> ---
>  arch/arm64/crypto/aes-modes.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
> index 0e834a2c062c..e793478f37c1 100644
> --- a/arch/arm64/crypto/aes-modes.S
> +++ b/arch/arm64/crypto/aes-modes.S
> @@ -836,11 +836,11 @@ AES_FUNC_START(aes_mac_update)
>  	encrypt_block	v0, w2, x1, x7, w8
>  	eor		v0.16b, v0.16b, v3.16b
>  	encrypt_block	v0, w2, x1, x7, w8
>  	eor		v0.16b, v0.16b, v4.16b
>  	cmp		w3, wzr
> -	csinv		x5, x6, xzr, eq
> +	csinv		w5, w6, wzr, eq
>  	cbz		w5, .Lmacout
>  	encrypt_block	v0, w2, x1, x7, w8
>  	st1		{v0.16b}, [x4]			/* return dg */
>  	cond_yield	.Lmacout, x7, x8
>  	b		.Lmacloop4x
> @@ -850,11 +850,11 @@ AES_FUNC_START(aes_mac_update)
>  	cbz		w3, .Lmacout
>  	ld1		{v1.16b}, [x0], #16		/* get next pt block */
>  	eor		v0.16b, v0.16b, v1.16b		/* ..and xor with dg */
> 
>  	subs		w3, w3, #1
> -	csinv		x5, x6, xzr, eq
> +	csinv		w5, w6, wzr, eq
>  	cbz		w5, .Lmacout
> 
>  .Lmacenc:
>  	encrypt_block	v0, w2, x1, x7, w8
>  	b		.Lmacloop
> -- 
> 2.53.0

