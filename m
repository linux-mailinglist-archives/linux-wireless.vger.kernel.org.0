Return-Path: <linux-wireless+bounces-32047-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CQcFb8fmGn0AgMAu9opvQ
	(envelope-from <linux-wireless+bounces-32047-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 09:47:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6211F165E7D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3F793007B01
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955D30FF20;
	Fri, 20 Feb 2026 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NdlKUvs9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576630C36C;
	Fri, 20 Feb 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771577271; cv=none; b=jmv4kEtyIS53IWFCYGoAoEWs6nBZywjAVlh3ODyihhw0HtCCPw1Ue1S1dxf3auOi2qF8Rg8XDvkW2ZU4s1+/xF8yL6JL6FxQzv9OTtZUgVsQGnNY6td64Gpou3M3Imk8/O4uKJSuUL0UKJpP3yw45YKcY2ErCQTmoCtnzdgy6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771577271; c=relaxed/simple;
	bh=KCTOcmjLjZEUBbNQus6mck2Zq0MUoWGOaoue6reUXOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SoFJAgVywEUHwTqhj6KWGcKkVqNpQiFtAEtU22DgO0yL/aoHrvFcIQSndzpJT7JzM9X3c+Ku5BdxtSAz8haVy3RtPAdM8/hW2qarpiIvVJAYsJ1vIBWfdk1pBmFPaPru92iLv5ZiDAWlCYhX9id1If/9zbmJ4sS1jEN/WE/iuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NdlKUvs9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qoU/4x8R6qlfBpKUL3kf+2mK3W6ZQH9KLxd9zBZ2Oeg=;
	t=1771577270; x=1772786870; b=NdlKUvs9I1KJvXbg2nYBAmVBzcO3/QGk3fRwysrrOjVXrlU
	sTaSQjWiLu4TTy81nBHp2ATXNL6gIYU7Iss+QrK4QnGBhQsg0o2XerdXWaVEXMwV+kbD9alhut1QU
	fo/etbtkjaCrm/j2QHJQk61xfUYLkAFJF3FrrM4a6h13iFYwBPA6rGoJnQ3R3n4jQx/sBbGTe9z12
	V4scnbcVTzn36zjMLp4Y9/wZUk06A+vu2AKBYrPEwSnQeOGjxE/sMqzbKwHMG4TwVuap1EjnRdo21
	0Q2iAEmwdErn++s2k6WWfo1FpakJaOsukjb6xr1pQLS0pVmPpU1W1n++gUyOpxFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vtMAo-0000000E3WL-3Adh;
	Fri, 20 Feb 2026 09:47:42 +0100
Message-ID: <6f14c73b7d513de1da06431d0e421e4792a43655.camel@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: mac80211: Use AES-CMAC library in aes_s2v()
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Ard
 Biesheuvel	 <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu	 <herbert@gondor.apana.org.au>,
 linux-arm-kernel@lists.infradead.org, 	linux-cifs@vger.kernel.org,
 linux-wireless@vger.kernel.org
Date: Fri, 20 Feb 2026 09:47:41 +0100
In-Reply-To: <20260219221527.GC32578@quark>
References: <20260218213501.136844-1-ebiggers@kernel.org>
	 <20260218213501.136844-16-ebiggers@kernel.org>
	 <c62915b1956ee4c5d4bad9315f2bc44aeddbb9bc.camel@sipsolutions.net>
	 <20260219221527.GC32578@quark>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32047-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6211F165E7D
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 14:15 -0800, Eric Biggers wrote:
> > > -static int aes_s2v(struct crypto_shash *tfm,
> > > +static int aes_s2v(const u8 *in_key, size_t key_len,
> > >  		   size_t num_elem, const u8 *addr[], size_t len[], u8 *v)
> > >  {
> > >  	u8 d[AES_BLOCK_SIZE], tmp[AES_BLOCK_SIZE] =3D {};
> > > -	SHASH_DESC_ON_STACK(desc, tfm);
> > > +	struct aes_cmac_key key;
> > > +	struct aes_cmac_ctx ctx;
> > >  	size_t i;
> > > +	int res;
> > > =20
> > > -	desc->tfm =3D tfm;
> > > +	res =3D aes_cmac_preparekey(&key, in_key, key_len);
> > > +	if (res)
> > > +		return res;
> >=20
> > Same here, maybe, technically, but also doesn't matter.
> >=20
> > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> >=20
> > johannes
>=20
> In this case aes_s2v() wouldn't otherwise be able to fail, so ignoring
> the aes_cmac_preparekey() return value would indeed be a simplification.

Right.

> However, since the key length isn't a compile-time constant here, we'd
> have to rely on non-local validation, which isn't ideal.

That's true.

> To ignore the return value entirely I'd prefer a static_assert that the
> length is equal to one of AES_KEYSIZE_*, which isn't possible here.

Indeed.

> It's actually not clear to me where the length validation happens before
> here.  nl80211_associate() for example just copies the length from
> userspace without validating it.  ieee80211_mgd_assoc() only checks that
> the length is at most FILS_MAX_KEK_LEN (64).

Oh, right, I forgot this was FILS and mixed it up with the previous
patch. We probably _should_ check it earlier there, but it won't be
local here either way, and we have the error paths already so that's
fine.

johannes

