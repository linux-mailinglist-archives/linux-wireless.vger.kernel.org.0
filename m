Return-Path: <linux-wireless+bounces-32026-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKJzO0ztlmngrAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32026-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 12:00:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0622E15E180
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 12:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 493AE3004077
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 11:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD48336EFF;
	Thu, 19 Feb 2026 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mXM0BgV/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FFE31B108;
	Thu, 19 Feb 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771498818; cv=none; b=j6QoMrgFdiKXDuTZZE6tAm8TZFlBXPHflskfAL+0JZuN1cD7WscSYSGlfIQNdJy2gEUbmerl6gEUidkfN/neUjJXLKKB0Ef3QdENlLS8aQCw9y68LO79kBaIU1SS5NgTslebsFrNGgcv/PPpxQmfxm45lqtppQvZGRcdCEYMBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771498818; c=relaxed/simple;
	bh=OHhNV9ZD6mIkgbO3UEHcYfm5EC7IsTkm2YA7My5GXQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hSsLL6z5MVSIc1U7lXpbO4AU9QGQcGurjWDEtPTYJxsf8M+R1Z0v6JqbCgFViLR6Cwgo7gB9C4Fk1nO4oQItbPVTTcR85VOMa/6ESYukZx72M3paJ9+BYaeNCyPOD2ZCOm5jeLCWVEwXQD5tofdjehgUOfC8PwzfI1tsXn5V0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mXM0BgV/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xGEXhCb/JrKgOHDO/XlMyvu/gxAXdGksPJCwEvSJR/Y=;
	t=1771498817; x=1772708417; b=mXM0BgV/q+sgazS5Ljv7cKcKgGYt6LUmiLLhFSCLyaCmuIY
	EWuec4bAUHwn6kXVLAoTM4+8L5481pTJcJjxdSPksaXQAPBlYTccmfvsASGTq4vk8Mrmp0oNdjPAY
	BCINsc+3nOWqbsBQ2TYlK7U6Bye7QTmzZ/LkLeGeALFNpaF90dWdsbX0MD5tlAIaZXckOUXJs8ymb
	hUDxMoYXgD03If3eI7SG85JqPBEw0elQp0gwICN21gw+dlVvV7P+TgyQfjFNjM57JoiYOCMJ4Vojf
	hMmC5CZ9/Ukym+BTllKtToDc9Pxm9boX/qHx9sUIM+iF8vexjB76fAG6yDBgP4pA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vt1lM-0000000D9d0-0Tcr;
	Thu, 19 Feb 2026 12:00:04 +0100
Message-ID: <c3b53ea083fa26c863c6a954d13bbd2ef91e1732.camel@sipsolutions.net>
Subject: Re: [PATCH 14/15] wifi: mac80211: Use AES-CMAC library in
 ieee80211_aes_cmac()
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A
 . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Date: Thu, 19 Feb 2026 12:00:03 +0100
In-Reply-To: <20260218213501.136844-15-ebiggers@kernel.org>
References: <20260218213501.136844-1-ebiggers@kernel.org>
	 <20260218213501.136844-15-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-32026-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sipsolutions.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0622E15E180
X-Rspamd-Action: no action

On Wed, 2026-02-18 at 13:35 -0800, Eric Biggers wrote:
> Now that AES-CMAC has a library API, convert the mac80211 AES-CMAC
> packet authentication code to use it instead of a "cmac(aes)"
> crypto_shash.  This has multiple benefits, such as:
>=20
> - It's faster.  The AES-CMAC code is now called directly, without
>   unnecessary overhead such as indirect calls.
>=20
> - MAC calculation can no longer fail.
>=20
> - The AES-CMAC key struct is now a fixed size, allowing it to be
>   embedded directly into 'struct ieee80211_key' rather than using a
>   separate allocation.  Note that although this increases the size of
>   the 'u.cmac' field of 'struct ieee80211_key', it doesn't cause it to
>   exceed the size of the largest variant of the union 'u'.  Therefore,
>   the size of 'struct ieee80211_key' itself is unchanged.
>=20

Looks good to me in principle, I suppose we should test it? :)

> +		err =3D aes_cmac_preparekey(&key->u.aes_cmac.key, key_data,
> +					  key_len);
> +		if (err) {
>  			kfree(key);
>  			return ERR_PTR(err);
>  		}

Pretty sure that can't fail, per the documentation for
aes_prepareenckey() and then aes_cmac_preparekey(), but it doesn't
really matter. We can only get here with a key with size checked by
cfg80211_validate_key_settings() already.


Since you're probably going to send it through the crypto tree:

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

