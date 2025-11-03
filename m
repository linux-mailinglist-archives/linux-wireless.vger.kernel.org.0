Return-Path: <linux-wireless+bounces-28491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365FFC2B428
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9613F1891832
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16912F261D;
	Mon,  3 Nov 2025 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="Kle2F8Z6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30544EEB3
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168365; cv=none; b=ly49bPrTTh6WO3I0z6HNuZJE/YOCjKnoMN0vEreWAIGR8kSTey3lsiGPGPMLcWzJqkKruw3GxwPYUP3guw7l7vFhJWl000q+BUOZ5ghy12gGvgM8Lk0M9mOgjESCxfMZLsfs0VzulD9Xztbb3Z7eqfFFx3lOFTgJHcf5DkmYifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168365; c=relaxed/simple;
	bh=fkEDjGsJqxsdwoZPvpOjU7Ns7KwIuhxIQuE6ZFlU2Pc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kibMjXTi/z2lQKQNNwo5Q7sT3Asb1Bk+dma7EemaqLwOKmAPGJ5bg13TIIcVb7G5deo/xAcH4xTjFU8KKuJFDDBaniQO4dN1CzpN43/n2KIVbG983jyG/g35mgVrn2BUS6jmPDOalYkcYSMZYpnBsDM4K67geQIv06nym93cXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=Kle2F8Z6; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id D61255A0002;
	Mon,  3 Nov 2025 12:12:38 +0100 (CET)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Vc3ZpOPFuXx; Mon,  3 Nov 2025 12:12:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1762168357;
	bh=fkEDjGsJqxsdwoZPvpOjU7Ns7KwIuhxIQuE6ZFlU2Pc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Kle2F8Z6QfSoxfdGekYSwtN5EqamhBpdAqI5VtWi+v1wvtLwIKY94N0iEgr4FM8dM
	 b/eWh7aCJMWaAiYe0iCgZYJspXoO2uRftUfy9aO7boN6DFXlTUfbP2sEyc7w8u8Q4k
	 dXC4nddseReGbi2YwFM62l3ZxRJKYuw2Z9mXVpADyM1QGkToC8iuD9U1oYK3XLt/ny
	 JYVeERPOMQ/tAEWMXHYJbMwSvKRmyOrdzb4Uihy9gpOJilnmoxpQ2244gQbzfoBduT
	 WLsvh+cZM/osu305fXt3Lt+5bSMjD/Lza6G+f/Duo15MOr7L9thUlrG57rGRkIgb7F
	 QiaSNOVypt6zQ==
Received: from [10.6.32.204] (unknown [185.12.128.224])
	by mail.codelabs.ch (Postfix) with ESMTPSA id CB8215A0001;
	Mon,  3 Nov 2025 12:12:37 +0100 (CET)
Message-ID: <d2cbf9d01d80e8b42afb162e30f7ab6c72605f46.camel@strongswan.org>
Subject: Re: [PATCH wireless] wifi: mac80211_hwsim: Limit destroy_on_close
 radio removal to netgroup
From: Martin Willi <martin@strongswan.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 03 Nov 2025 12:12:37 +0100
In-Reply-To: <e0027a727707215c279626548bd3bb2101ffd8a8.camel@sipsolutions.net>
References: <20251103082436.30483-1-martin@strongswan.org>
	 <e0027a727707215c279626548bd3bb2101ffd8a8.camel@sipsolutions.net>
Autocrypt: addr=martin@strongswan.org; prefer-encrypt=mutual;
 keydata=mQENBEhbeIwBCADbKW4rqhkBsvQumeWTAfy+Q+YciIbbqLvxwRZPKpxz19nxJQPbWF7pG
 oiPb3TWLK3TitWVKKZuNILStsKTGiR4RqLUs8n3sESPoz5HmRqsijm6yJDzzPAE3/B7IWHBeAOssV
 TWS7b9ROz4iFI+fNLnqMqE22zMEItC2r9zi6GpDmi/QP3CcxHFzPMF5iQkMPp6QJMwOdPvYR9kBb1
 x1ubDOjsfWqI41neJTGlv3EVFc5nkv0s7PfoYxMkf8/VStd29pMe4csKJUaPDkLqenLl8Omq8Z3F+
 sbjdo+hcim4i3EsROYh59kA4/UuMFfI0hxaIaoW6UAb6gyqOHkS6vC+VABEBAAG0Jk1hcnRpbiBXa
 WxsaSA8bWFydGluLndpbGxpQHJldm9zZWMuY2g+iQE4BBMBAgAiBQJRsHoSAhsvBgsJCAcDAgYVCA
 IJCgsEFgIDAQIeAQIXgAAKCRAQGu6ewTL0wxf8B/9EThZXuVqNTK2nH2QuRi2zQntFXkK2QbU11sv
 zkfZV8xDfWKHdq67LLako/FOE1dXN6iurWFChgMexs0bSMzaftCmHGSSgGaQhBhANSObKu8M+UyHd
 bes88zNpQKdwVd9guIo6oRrX33IYkb63ifZReChcBffu6cjXQky7/79kpnl6f3qlP5ZluyNGX9Iwe
 z1EpmG2zHkJlc+3oPQbsQbFKjUOdR1hfyKbcVVQHs1ddv830Z0cpM6QbcknR81VsCQ7FYBrH5Hw3N
 AKhrfbIaZMvwBgQfXIgc7mwPZFg2oONZMzauzX6EpZ29Z+kCsy3AArnZssVAwxk+ydRJhUWlZmtCR
 NYXJ0aW4gV2lsbGkgPG1hcnRpbkBzdHJvbmdzd2FuLm9yZz6JATYEEwECACAFAkhbeIwCGy8GCwkI
 BwMCBBUCCAMEFgIDAQIeAQIXgAAKCRAQGu6ewTL0w9ruCADDGN0JgrImHOPGgsJwdP2nKwBytO8mM
 Z/Z/folgH20zqiMqyNR4lOZW9L3DF4rz83fKXQFbP7nCf6GZ/tmjmrImiTZBkKwr37ZsaBRaCz3i9
 rYITY94njenYp7jy6roMcvlBMhNjSI04AvLjaA/hcPuSexqqso+qoNTa7+VplF7OpikB8vKPt+fMp
 XuGP8TF/q8v9TrY+gcVv0c8ZOrGDnI5vJt1Fp0PvoH/vXFx3Jy90g+hRUYFbLW2S76geiGVML9AeK
 IQKjEpp2bxsd+JYGo91MeKBqjlllonxZ17eKNtlA+X+iluwcDJZzdabB19EQG7ZEf0jAy6Sy09au6
 MYFtCBNYXJ0aW4gV2lsbGkgPG1hcnRpbkByZXZvc2VjLmNoPokBNgQTAQIAIAUCSzjspgIbLwYLCQ
 gHAwIEFQIIAwQWAgMBAh4BAheAAAoJEBAa7p7BMvTDaP4IALJRUmUEagBRrdAi1SrxxcsgPDr5vo8
 1UrPADXKnMdf6KXPqfPMN4hIeS4zbFyC/FA9cg0T9680pVk8hLmcD3iCRMMnL9d38hOQmMxw2TYnd
 7rth1LuoDRhIwI1bfADw3EJGEMsTy49zVtVl1KwmqBZDDk3PGHvukHYawleOrTRVitOEvavg0vfgg
 CgqvSeSBy3tkX2EIlagC/5eXpYLguj1iI84xG01M4bZ9PU+PuzZADaHL+a9iPelBvk0uNjwKvKjPx
 OPDfaxsmEgjNG7M9gZjBkjSjvclRUlLMpe+3qHhGEYf2yKsv72hCLYy8my5jRnu59eZq72lX9YWVs
 jlXU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


> > As the portid is not unique across network
> > namespaces, closing a socket in one namespace may remove radios in
> > another if it has the destroy_on_close flag set.
>=20
> How did you find that? :)

A test-case for our hwsim API runs in a container with PID namespaces,
so portid is usually the same. Concurrent CI-runs of this test failed
quite often...

> And then, how did you find it in hwsim only, there are surely other
> places in wifi, see nl80211_netlink_notify, that have the same issue?

Hm, I assumed it was just a shortcoming in my commit referenced in the
Fixes tag :-/.=C2=A0

Shall I send a patch for nl80211_netlink_notify(), skipping radios not
in the netns of the closing socket?=C2=A0

What about regulatory_netlink_notify(), skip it if netns !=3D init_net?

Treewide, {nfqnl,nfulnl,nft}_rcv_nl_event() look fine, as they operate
on per-net data. nfc_genl_rcv_nl_event() might need a fix as well.

Martin

