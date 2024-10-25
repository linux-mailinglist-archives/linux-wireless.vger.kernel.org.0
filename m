Return-Path: <linux-wireless+bounces-14563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C79B110D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 22:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03824283FB2
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 20:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D30217456;
	Fri, 25 Oct 2024 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Lqg1jn7U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DF7215C42;
	Fri, 25 Oct 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889318; cv=none; b=pMPJSI4rgy4TNhy0afgp4/RPBlWmUivz6rWYGuNhkPtCBsMlEXp6vKZhDV+FOb3oZBPMtF03xRWwZoYFj+hyWvRLIxErHMA8V8j/Rlhw4TxZv71at07QNZDtNNi0wZ42BNvxerW5qa2xkG+Q53AYgepwIuDR9XRx7st6DzpUFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889318; c=relaxed/simple;
	bh=1XU8+0H9J169DLx55vJAv3LxdU26AFcY8jQpKgZIkSo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5/nRj6DtGIAj0N6/OrT8+RlWcqG0V/SjhA1mvAcwcAGAvA5bxpfyYJMW19Qxfjo46ggNbI7mxWvU3PsrMnGYuk1/EhfqUctCPFbX06+6ZSNPkc/dg0bjGnAcYRoZBq9AGRh7Gtkw0sDmF4LzKrYhpDUvEoaDgBILeROQZ2pcfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Lqg1jn7U; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1XU8+0H9J169DLx55vJAv3LxdU26AFcY8jQpKgZIkSo=;
	t=1729889316; x=1731098916; b=Lqg1jn7UpW3LuFnBc0dVC3JBllFeQk+/afm0v0PAOrjlQBm
	NvmYhcLkyY6Hhu6f22FGiTVzCg66lfdjIFYAJprhWEoW87MPrfEjLve8vWGEiIlp5Yk1c82OsMQ5c
	J13Qj9m1OmDm092uaBClInw8afPHRhtdg0Rs+1vDonkaJE7of+Bx/hFGLSGbBhOBGN53OZubYSa5/
	ZNdCU1NaIoPR7adpJjPAIa6U8HXhOeUNVf+y27vWT1E4Xwr7/G0YMGEnlttQnANlyqsrUKdQK6GTs
	8f1rHto/WQTf9Iq9v4gaFCUgtRxU5N07R+47lT2tb2kUxXqyS7fPIKgBDGaJLH2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4REV-00000004hPm-1b1i;
	Fri, 25 Oct 2024 22:48:32 +0200
Message-ID: <192eb05afffd37bd13ff9bc1fc9b044b347b5dc4.camel@sipsolutions.net>
Subject: Re: [PATCH][next] wifi: mac80211: ieee80211_i: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva"
	 <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 25 Oct 2024 22:48:30 +0200
In-Reply-To: <8152a551-1813-4d44-a203-45d30f2ac671@embeddedor.com>
References: <Zxv7KtPEy1kvnTPM@kspp>
	 <c90c3c9825e3837bf7c47979acd0075b102576ce.camel@sipsolutions.net>
	 <3471e59f-a414-479f-8fb0-aa1a26aecf16@embeddedor.com>
	 <5c48b4529bf552d5c16b4dcc951c653f37b6a68e.camel@sipsolutions.net>
	 <8152a551-1813-4d44-a203-45d30f2ac671@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-10-25 at 14:36 -0600, Gustavo A. R. Silva wrote:
> > >=20
> > > Yeah, I was actually going to mention this commit, as it's the one th=
at introduced
> > > that `bool radar_detected` to the flex struct. However, it wasn't obv=
ious to me
> > > how `struct ieee80211_chanctx_conf conf` could overwrite `radar_detec=
ted` as I didn't
> > > see `conf->drv_priv` being accessed through `struct struct ieee80211_=
chanctx_conf`.
> >=20
> > You have to look at the drivers, see hwsim_clear_chanctx_magic() for
> > example; I wonder why hwsim_check_chanctx_magic() never caught this.
>=20
> Sorry, I actually meant through `struct ieee80211_chanctx`. Something lik=
e:
>=20
> struct ieee80211_chanctx *foo;
> ...
>=20
> foo->conf.drv_priv[i] =3D something;
>=20
> or
>=20
> struct bar *ptr =3D (void *)foo->conf->drv_priv;
> then write something into *ptr...
>=20
> In the above cases the code will indeed overwrite `radar_detected`.

Right, that's what it does though, no? Except it doesn't have, in the
driver, "foo->conf." because mac80211 only gives it a pointer to conf,
so it's only "conf->drv_priv" (and it's the "struct bar" example.)

So yeah, pretty sure it will overwrite that, and I do wonder why it
wasn't caught. I guess no radar detection tests with MLO yet.

johannes

