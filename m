Return-Path: <linux-wireless+bounces-24775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B7AF5EE7
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 18:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FEA163046
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50132F509E;
	Wed,  2 Jul 2025 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w/EFoXlG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E62F5082
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474496; cv=none; b=I9KJR+GFuixSJ1FDzaXcCr77eZXf1NUVBLm7mWaBR/k82fyhrLDWgQbE4O55KLtzvtNVVvJ9JjF54cPAKjNFQbkfHNmtYeHCxWZce5ieRDBLSzxpPpfAsw6k046bVteZlHJLf7xMCLNsWP0nMQMmKDp8lm3yrZDmgiKfqpjxIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474496; c=relaxed/simple;
	bh=+DzFenqY42q8OLM2r5k9J7V5iUmIG3/ZdfkbHqD/WeM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lVsIW7VL0ckEcRuYqdG30BsoOsnQaX74lTumoO4Yu3SMc2XlzCtmz/XdWNGgrHTmYOs+6qHxq5GlOymR1ctFR1KgPla1bQJwidW+4UL3nDAZrkf099PSjZ7r0uXiXYuvcy8CrTEr32co+6ojbI2k3vwDSb7OhF2q/Yd+dN6wv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w/EFoXlG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+DzFenqY42q8OLM2r5k9J7V5iUmIG3/ZdfkbHqD/WeM=;
	t=1751474495; x=1752684095; b=w/EFoXlGbJn/E387ctJXAKaetLXKGoOxrtgtv6D8LKLSF1a
	M60/mMxzEHxSlURSdFXmd1mJbDZVyyHDXln7xZ5PSCQY7SNNlSE0qyFMlVAkBkO9BJVUGCc+dJUHp
	Q1gV1PkjwLqn9jU0KPlfouXXkp0dQxdPQx3a0JX/O4jnttF3ua7SZsmm0YJx0JDUaFOLIajaCEwrg
	cnd5lMT42AKRgPQkisl7VAY4xZ05bwXUMFXuK1nVJsD7R2I9EqjmfzBakI7MTUncTIvKIySrsGH6l
	K/Y7U+pcUoK+fwLDBn0cSEogTtqkW35B66/dLHAzxF4Ps788OIFIHooCDf/gpgJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uX0Wa-00000004GUF-0d8G;
	Wed, 02 Jul 2025 18:41:32 +0200
Message-ID: <c7d5adbc4fe45c0bc55567f9d1b228d169dd9097.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: cfg80211: Nullify freed pointers in
 cfg80211_sinfo_release_content()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Dan Carpenter
 <dan.carpenter@linaro.org>, 
	syzbot+4ba6272678aa468132c8@syzkaller.appspotmail.com
Date: Wed, 02 Jul 2025 18:41:31 +0200
In-Reply-To: <20250702162531.2705566-1-quic_sarishar@quicinc.com>
References: <20250702162531.2705566-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-07-02 at 21:55 +0530, Sarika Sharma wrote:
> Currently, cfg80211_sinfo_release_content() frees dynamically
> allocated memory but does not reset the associated pointers.
> This results in double free issues in nl80211_dump_station(),
> where both link_sinfo and link_sinfo->pertid are released twice,
> once after the send_station() call and again in the error handling path.
>=20
> Hence, to fix accidental dereferencing of dangling pointers, explicitly
> set the freed pointers to NULL.
>=20

Do we have to fix it this way? It feels like perhaps it should rather be
fixed by only having one call to cfg80211_sinfo_release_content() in
each path.

johannes

