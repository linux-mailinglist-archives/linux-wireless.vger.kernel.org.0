Return-Path: <linux-wireless+bounces-32123-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJIqCZTGnGnJKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32123-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 22:28:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D9D17D980
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 22:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BBFC300B45F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 21:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235F378839;
	Mon, 23 Feb 2026 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQTSMin/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2EE33C52A;
	Mon, 23 Feb 2026 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882127; cv=none; b=I0HRYu6uH7/KOdZWnLr8UiDnp6yyYIuOPc30lLe6LnXOaUi7uVe26jye2oGkRAkRiA1T+ktSm8vHACAgX3BLCtFbfKRyPHaCgg7x40VEBe4XhHBcoRD2POrQP/vrFFEcu7LhZHGtRHoL9x4Bcn8D0uCi98GtjRMOEbNuq8hAbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882127; c=relaxed/simple;
	bh=6BWCpxN467P4dyN5eoO5k0IXEao0FX3AzWwouvG6AzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsWFQuQYT2ccErUT4gqVvug6yPkwzkeY5TNc2JL6mZo77wxtCNjsBSW4uC2BmXKUJ7eJyIdUoAwrDb1KkIntlv4AUZhoFpA1IB8xot4OnT3XKI6099XCrY9UxAKx7e7rCglTko9Jc/sVb/RG9reoRZWkxwNYC4lrVuWzrtXGQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQTSMin/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697D0C116C6;
	Mon, 23 Feb 2026 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771882126;
	bh=6BWCpxN467P4dyN5eoO5k0IXEao0FX3AzWwouvG6AzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQTSMin/rySHdNw1qv6QqInzrBz8ugXCsHyGhJzEBHqAJ79ihP31sS9Fh1wTaQf75
	 ktJv7aJ6Z/B306tadSuT1z4nrJD4/AuPh2s0kxtomYtDEHd16vGjEskB14S+sjn0jB
	 2IHv4vsjC+suPCFwtedKZVF0oAeIW/5mtTpwRHCBugAFAwgW1ogJ9ef3IVCAavuJzZ
	 xvXkrheuicxBxL+LLJbvi4nzFJIEEo2Teoe5XTiH2hOwUWQ0ouqZ+lowj3/wFF36s3
	 zm+1gMo+895d78oQljgJJ1zrD8etGyd+Z7wRsp+FbqOA3QR1cBnRxrhwlqdB3D5vPi
	 jivuft6R2UJUQ==
Date: Mon, 23 Feb 2026 13:28:44 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/15] AES-CMAC library
Message-ID: <20260223212844.GA2132@quark>
References: <20260218213501.136844-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218213501.136844-1-ebiggers@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32123-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82D9D17D980
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 01:34:46PM -0800, Eric Biggers wrote:
> This series can also be retrieved from:
> 
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git aes-cmac-v1
> 
> This series adds support for AES CBC-based MACs to the crypto library,
> specifically AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC.  The
> implementation is fully optimized with the existing
> architecture-optimized AES code, either single-block AES en/decryption
> or arm64's neon_aes_mac_update() and ce_aes_mac_update().  As usual,
> optimizations are now enabled by default as well.
> 
> AES-CMAC support will be useful for at least the SMB client and server,
> and the bluetooth and mac80211 drivers.  Patches 8-15 convert these
> users to use the crypto library API instead of crypto_shash, though
> these patches will likely go in via subsystem trees later.  They result
> in some significant simplifications and performance improvements.
> 
> As usual, a KUnit test suite, FIPS self-test, and traditional crypto API
> wrapper algorithms are included as well.
> 
> Note that I'm also planning to add additional AES modes to the library.
> This is just an initial set of AES modes to get things started.
> Notably, with the SMB client and server already using the SHA* and MD5
> libraries, "cmac(aes)" was the only remaining use of crypto_shash there.
> So it makes sense to take care of that.
> 
> Eric Biggers (15):
>   lib/crypto: aes: Add support for CBC-based MACs
>   crypto: aes - Add cmac, xcbc, and cbcmac algorithms using library
>   crypto: arm64/aes - Fix 32-bit aes_mac_update() arg treated as 64-bit
>   lib/crypto: arm64/aes: Move assembly code for AES modes into libaes
>   lib/crypto: arm64/aes: Migrate optimized CBC-based MACs into library
>   lib/crypto: tests: Add KUnit tests for CBC-based MACs
>   lib/crypto: aes: Add FIPS self-test for CMAC
>   smb: client: Use AES-CMAC library for SMB3 signature calculation
>   smb: client: Remove obsolete cmac(aes) allocation
>   smb: client: Make generate_key() return void
>   smb: client: Drop 'allocate_crypto' arg from smb*_calc_signature()
>   ksmbd: Use AES-CMAC library for SMB3 signature calculation
>   Bluetooth: SMP: Use AES-CMAC library API
>   wifi: mac80211: Use AES-CMAC library in ieee80211_aes_cmac()
>   wifi: mac80211: Use AES-CMAC library in aes_s2v()

Applied patches 1-7 and 14-15 to
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

Patches 8-13 (smb client, smb server, and bluetooth) can go in via
subsystem trees later.

I edited "lib/crypto: arm64/aes: Move assembly code for AES modes into
libaes" to update the file comments to remove the file paths.

- Eric

