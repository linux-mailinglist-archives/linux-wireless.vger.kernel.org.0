Return-Path: <linux-wireless+bounces-32048-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGxvMu8imGlNBgMAu9opvQ
	(envelope-from <linux-wireless+bounces-32048-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 10:01:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62902165FB2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 10:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEFEB300E610
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17803128CF;
	Fri, 20 Feb 2026 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RL2mb5ip"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D533115B1;
	Fri, 20 Feb 2026 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578082; cv=none; b=KCxwhVuqZ4+huSHZjcGKaMQXmV7TDBzFB72mxOnRnJUzQ82OenK5WtfGYe8F9lkbfMieBTrpxMWAIlwzMkvg1buFCWtYZc43j87AojwXdCIiyBgLhVL9hUz4Cxtrh1KSEMXd1hC3NCj0EIA3Cgpxi6z2W49fmLbjNRvVbUOo6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578082; c=relaxed/simple;
	bh=xT43E9Mw/MhVpOUDZdIZqemFKn/S+rp/rN+fbSVYGS0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cB6u1dWZYfz4BR3FzRnlUMsdYvE/rdCSsv4rrj4/yKwzU8RTZJWAQXAYUq7YJQJfSeAVaLlbjHjN5nmWikBYoJCoBXWG5okZZlMSJs3UgazIGBc0N0lG2nmOHvr2W2Y07RVvt9kk/P7UR1UMiaphjotBHppqiOUGWh6KRCxA7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RL2mb5ip; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9JHCDgsaPyKfVh78aF3xe4hH753iI0GW0P5ZJDCxIqo=;
	t=1771578081; x=1772787681; b=RL2mb5ipRUSFHtWE4KMIM9clsZxdZ1GDoOwuDV0UpzxjTbj
	VqqVC78lE6ujttKxolaSSvjrD7M1vRSHc2sGAjbRzZgqwYYtTasuWkRLtZ0k7/V81s36C28ihPPSl
	VvudZdHJ4WweGxvTPMvTgADF1F+28wJRCkLoJQFGp6XX1256wHScY3YK++O8uR581g3BRX4faq6RQ
	+yF/3RyGgvQay6P8Vcd3QD/d0jitN2j48KsH1783UWxdTxdMPcFiXCwNoaauASse4G0Bz9tYmsT5m
	NENsGsXDmQXwUMyJSCp+AAZF3ZJ1px3YD7k3szf3pGQ4f0upH55Q9zDR8rJTAISA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vtMNv-0000000E3s8-1FlF;
	Fri, 20 Feb 2026 10:01:15 +0100
Message-ID: <f7091e036f1694d945e728aa58cb7d55ac07f3e1.camel@sipsolutions.net>
Subject: Re: [PATCH 14/15] wifi: mac80211: Use AES-CMAC library in
 ieee80211_aes_cmac()
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Ard
 Biesheuvel	 <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu	 <herbert@gondor.apana.org.au>,
 linux-arm-kernel@lists.infradead.org, 	linux-cifs@vger.kernel.org,
 linux-wireless@vger.kernel.org
Date: Fri, 20 Feb 2026 10:01:14 +0100
In-Reply-To: <20260219220211.GB32578@quark>
References: <20260218213501.136844-1-ebiggers@kernel.org>
	 <20260218213501.136844-15-ebiggers@kernel.org>
	 <c3b53ea083fa26c863c6a954d13bbd2ef91e1732.camel@sipsolutions.net>
	 <20260219220211.GB32578@quark>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32048-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[sipsolutions.net:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sipsolutions.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62902165FB2
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 14:02 -0800, Eric Biggers wrote:
> > Looks good to me in principle, I suppose we should test it? :)
>=20
> Yes, I don't expect any issues, but testing of this patch would be
> appreciated.  I don't know how to test every kernel subsystem.

Done, works fine. I checked FILS (which is against hostapd userspace
implementation) and validated the MME MIC against wlantest.

> > > +		err =3D aes_cmac_preparekey(&key->u.aes_cmac.key, key_data,
> > > +					  key_len);
> > > +		if (err) {
> > >  			kfree(key);
> > >  			return ERR_PTR(err);
> > >  		}
> >=20
> > Pretty sure that can't fail, per the documentation for
> > aes_prepareenckey() and then aes_cmac_preparekey(), but it doesn't
> > really matter. We can only get here with a key with size checked by
> > cfg80211_validate_key_settings() already.
>=20
> aes_cmac_preparekey() indeed always succeeds when passed a valid key
> length, as documented in its kerneldoc.  But in this case I recommend
> just checking the error code anyway, since ieee80211_key_alloc() can
> already fail for other reasons (i.e., it needs the ability to report
> errors anyway) and the key length isn't a compile-time constant here.

Right, sure.

> > Since you're probably going to send it through the crypto tree:
> >=20
> > Acked-by: Johannes Berg <johannes@sipsolutions.net>
>=20
> For library conversions like this I've usually been taking the library
> itself through libcrypto-next, then sending the subsystem conversions
> afterwards for subsystem maintainers to take in the next release.  But
> I'd also be glad to just take this alongside the library itself.

OK, whichever you prefer. Feel free to take it, this code did change
recently for some additional error checking, but it otherwise almost
never changes, so there shouldn't be conflicts.

johannes

