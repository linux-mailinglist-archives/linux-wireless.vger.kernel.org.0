Return-Path: <linux-wireless+bounces-34517-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NepCqsE1mnbAQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34517-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 09:32:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BACA33B8406
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 09:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1CD830621DB
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D486037F8A2;
	Wed,  8 Apr 2026 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PvP9sar0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8C33987;
	Wed,  8 Apr 2026 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633294; cv=none; b=Tlw7G0uzlbsMQyJXZAsON3B4BqR9aTsnjwQQFZ0ld/B6OkAxzScMTFrtgo7GK0vMpzfYxnH19f3AtF2jo2q5uejhGxEziXjzo5SjkBGECkX1DRECsgw8Z9vBfp/oqL2jKTEEIHe4ZfcY//HSoSoJrLT8TGd+YZamLw/EqsXTTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633294; c=relaxed/simple;
	bh=lO6Q+OOGXZ3NnrvZnKZzoHiyVE4EbXb7A+U70s9zza8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e4IYamL8t2+BBbqnNil4mZZpUZ9fcdqyERFQz/wDcMKAalq7112HW/fvHbBI9DuNXEwb0YEUhvFzKo2+U9rVT19Rly/FYaeUVtuT8HOVBrbY9e7eMeU49r6igt1nBet37ij0ln3vSAsMElzq/EtLzE7vPiC8dEyQzdECDalQ6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PvP9sar0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OTO3GfwSPFxFuPEaKyiSyGBlJanpijRNbTF2J9u7oUk=;
	t=1775633293; x=1776842893; b=PvP9sar0C0qUC7PTxreddPJviD8p/NyTRcE9Lzrlj0hEUOv
	MVVXvQhH8NJXufbGeWXkXgEiR0bpY7X0YsDHm+IHK+VFE3EdyIzvpmeN+6gWOMlxWIvysV5Z/le8u
	OC/zM4HAIUKBoaAvqGL15imVgaqsLE5Vde7ncoTloUwNRj+VHD9brJyHNpPW94kHjGsJSlEK+8VL5
	zFLhdzRKQOQiEtNOchz4GUEMeC35cIhV1p+P2cj8yjJyQOm2usdB+uBYOt9lur/VGsjurVT6ynt7o
	J2tJwanhb4tlCPmPaXXXZSurzk/1fL519rK5s73xuHCCY/6GviYt8l5ezBohdArw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wANKc-0000000E6Pw-0UJK;
	Wed, 08 Apr 2026 09:28:10 +0200
Message-ID: <12181d5540b99b4dac83fc5b602f2256f6bb62c5.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 0/6] Consolidate Michael MIC code into
 cfg80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 08 Apr 2026 09:28:09 +0200
In-Reply-To: <20260408071323.GA157920@sol>
References: <20260408030651.80336-1-ebiggers@kernel.org>
	 <56798292be29f3e76e88c837d41eff0cb9f8b36a.camel@sipsolutions.net>
	 <20260408071323.GA157920@sol>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34517-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: BACA33B8406
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-08 at 00:13 -0700, Eric Biggers wrote:
> On Wed, Apr 08, 2026 at 08:32:12AM +0200, Johannes Berg wrote:
> > So five out of six patches are wireless, should I apply the crypto one
> > too?
>=20
> It doesn't conflict with anything in linux-next, so it would be possible
> to take it too.  Maybe wait a day or two and see if Herbert acks it.

Sounds good. I've picked up the other 5 now already, but for me that
actually made the CRYPTO_MICHAEL_MIC Kconfig symbol show up as a prompt,
which is a bit unfortunate perhaps. But should be gone soon either way
:)

Thanks!

johannes

