Return-Path: <linux-wireless+bounces-18770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3502A30CDA
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 14:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EA5165406
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3E221DAE;
	Tue, 11 Feb 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LxuX1XTC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5F320F;
	Tue, 11 Feb 2025 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739280557; cv=none; b=jqMy6Y6SLWXLZe/cl3q4t2Bpazj1WySwTOrjTMq3h3sxbR5rsbnnK7zVUTvmnWmAPT6YX1BZ49XBrvxzYe07/F1+NVs9Am0jdfkXUipOL3MlaLTsONw0SOpvS2hJOsxVZAZkSpuaAHIjS173X5BcNyefBSLvvxJwtFTgovnVUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739280557; c=relaxed/simple;
	bh=AFVZAd/ddvUjCgHFZxtyxRNV27S+PVT95AasPOAKy7g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rNAyx1nL8oBT/kXCZ7G6mr6obb1NcEnzfzJcO52/8aObFrb7uJhbZeTTSKnvF//m07eDfwclYfka5mFskHW3JR7NJBfTNuGm/2L6ADSw3DR+zYTMWtWjLImRzhFCOl792m7BIpMakAKAK/+NtH/bNQNkZa0Ss5SY1UBaE5v7jhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LxuX1XTC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6+yOY2Zcd5H8ImhxXn/x0q0FyqvbZA4MovSW5t3XSPg=;
	t=1739280555; x=1740490155; b=LxuX1XTCNF9bGbr6qYHAEaGQOkkptNSTxm5l6qgQsXq/D3q
	pgDzQvXyZtDxl1sbwYPPF5tx++OJ/biuXdrg9vETzYN1wW2hievlL8NQs54FRw3RFXVlsddKJR7bb
	m2MIAGn75WFqr6AyDGuJNbaBIUDD1n6IGOVbSRRLGFPG13KXuMpFezj2ytEEWHeXm3fNLKHF7YTqU
	J9psdN4cDdgI0cY/RIUvZzj0FAjsAWKYHpeWNCU6BsOBQoPZXON2Fdmf8sE4aGftaSZ67MDbqmH0w
	FG81hLazokIm8fM1x7dUj1vBqezDkKIWSMYiZNKFFBc1sAzSo6+wmE6ufzOXLIxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1thqK8-0000000B0iC-0njg;
	Tue, 11 Feb 2025 14:29:12 +0100
Message-ID: <56a9253a801757c03320cfe0000c5ac68dacac14.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: mac80211: fix integer overflow in
 hwmp_route_info_get()
From: Johannes Berg <johannes@sipsolutions.net>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: Julan Hsu <julanhsu@google.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	 <lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>
Date: Tue, 11 Feb 2025 14:29:11 +0100
In-Reply-To: <20250116084948.3933834-1-Ilia.Gavrilov@infotecs.ru>
References: <20250116084948.3933834-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-01-16 at 08:49 +0000, Gavrilov Ilia wrote:
> Since the new_metric and last_hop_metric variables can reach
> the MAX_METRIC(0xffffffff) value, an integer overflow may occur
> when multiplying them by 10/9. It can lead to incorrect behavior.
>=20
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
>=20
> Fixes: a8d418d9ac25 ("mac80211: mesh: only switch path when new metric is=
 at least 10% better")
> Cc: stable@vger.kernel.org

Seems a bit overblown for stable, but also don't really care...

> +static inline bool is_metric_better(u32 x, u32 y, u32 percent)
> +{

You shouldn't put inline here, in general.

Also that function probably wants a comment, and the 'percent' argument
is hardcoded to 10, so you don't need it. Let's keep this stuff simple,
*especially* if it's for stable too ...

> +	if (check_add_overflow(x, a, &e)) {
> +		if (x > y - a)
> +			return false;

seems simpler as "return x > y - a;" or so?

johannes


