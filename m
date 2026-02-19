Return-Path: <linux-wireless+bounces-32027-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DLHFLrtlmmxrAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32027-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 12:02:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C94FE15E1EC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 12:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9758304E710
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5133D6C1;
	Thu, 19 Feb 2026 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cpId1vPc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51A33D507;
	Thu, 19 Feb 2026 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771498883; cv=none; b=s+P9/ig5ml93IIBMzZ4pPXiLKAbjnMhf7BARg+BypZH2f+Sr1sZ4QVo/8bGs52kbZCt47SUFwW79QFnoCbLb4i6fdasmeUJiVDU6o75tUak4MVfGwTHp/75YoBXis4oFgs2O5vHlYkRJNUMuQXcl7fEoaV2QgvtDJgeXegf/74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771498883; c=relaxed/simple;
	bh=HoS2BTuNAHoMAcUY7XZu+2qmK3OILI+y5z/xFBzDr/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FzYqSr/2xZgSmVnGlo8o1nOkDI/KogzUMNgRBgV93zn+qwJFkXcMnpn447G9W8O9uS5kkimvPfooJlWAou9dI9xrl6WWwLUfajC6H5AhDjKW5QBWqA8C0HnaQJLmRMVB54D/Byvrn49xSaIEsBebTRq1uvSro+6d6qCTWCtHbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cpId1vPc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2zzN+9tLqwjQ+bn8xHkDPkcRVE1Cb1c3LsD64ID6TjU=;
	t=1771498882; x=1772708482; b=cpId1vPcINH6jMlDTul5mtNRP9ul08Xv80KcJ46o6/2Osut
	SJsBzOz69E/NZbxATz/ypB+8HDqSaNmvGVa1hc4XkRNoacywqW6DpRgBy4Pe+PGKlG04pPlgrfO0P
	9KpLlDllBpMMF58CrvkvmKs1SzKhoqBgUBznWfqUMo4XJXWhs9iGH/DkYDvmDUSG6mFkG/RFUcwsn
	fs6YtKg/IKEc39tC/u+kVeZy6CA1TQcaUz6z0yza/aTW3mzHw95BqvP9UJSRu7E3jqqqzKMACOTcl
	lP5BgQME2t5j+pwxccZaeSusgCBiufT64bkKKSX8Q9YzmW9QKhk9GOu/pUvv30qg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vt1mV-0000000D9fX-31Ja;
	Thu, 19 Feb 2026 12:01:15 +0100
Message-ID: <c62915b1956ee4c5d4bad9315f2bc44aeddbb9bc.camel@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: mac80211: Use AES-CMAC library in aes_s2v()
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A
 . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Date: Thu, 19 Feb 2026 12:01:14 +0100
In-Reply-To: <20260218213501.136844-16-ebiggers@kernel.org>
References: <20260218213501.136844-1-ebiggers@kernel.org>
	 <20260218213501.136844-16-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32027-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim,sipsolutions.net:email]
X-Rspamd-Queue-Id: C94FE15E1EC
X-Rspamd-Action: no action

On Wed, 2026-02-18 at 13:35 -0800, Eric Biggers wrote:
> Now that AES-CMAC has a library API, convert aes_s2v() to use it instead
> of a "cmac(aes)" crypto_shash.  The result is faster and simpler code.
>=20
> It's also more reliable, since with the library the only step that can
> fail is preparing the key.  In contrast, crypto_shash_digest(),
> crypto_shash_init(), crypto_shash_update(), and crypto_shash_final()
> could all fail and return an errno value.  aes_s2v() ignored these
> errors, which was a bug.  So that bug is fixed as well.
>=20
> As part of this, change the prototype of aes_s2v() to take the raw key
> directly instead of a prepared key.  Its only two callers prepare a key
> for each call, so it might as well be done directly in aes_s2v().
>=20
> Since this removes the last dependency on the "cmac(aes)" crypto_shash
> from mac80211, also remove the 'select CRYPTO_CMAC'.
>=20



> -static int aes_s2v(struct crypto_shash *tfm,
> +static int aes_s2v(const u8 *in_key, size_t key_len,
>  		   size_t num_elem, const u8 *addr[], size_t len[], u8 *v)
>  {
>  	u8 d[AES_BLOCK_SIZE], tmp[AES_BLOCK_SIZE] =3D {};
> -	SHASH_DESC_ON_STACK(desc, tfm);
> +	struct aes_cmac_key key;
> +	struct aes_cmac_ctx ctx;
>  	size_t i;
> +	int res;
> =20
> -	desc->tfm =3D tfm;
> +	res =3D aes_cmac_preparekey(&key, in_key, key_len);
> +	if (res)
> +		return res;

Same here, maybe, technically, but also doesn't matter.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

