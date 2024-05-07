Return-Path: <linux-wireless+bounces-7280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34908BE01B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 12:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889FE1F23227
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151C11514D4;
	Tue,  7 May 2024 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JOGXTRwM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BDF14F100;
	Tue,  7 May 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078821; cv=none; b=SIaAf1U9Wr8Nf+9UVNK9i7G3U+mXWgvSjesIvFUteq54+pDnLcjHVwG8vBIm2hKiRLpUnsUqxHPj+jHMap+KRD6ylx16/5GQpNlm3MFWYzm4WNFG7k8HS2BVFbt2gt3ZsQXbnE09HYl0+JMt7/5oEU3kx2Pu7wzPgmKW5B85/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078821; c=relaxed/simple;
	bh=E25vMthg3vqCpG+5zSE+AGNII/5x83tzP1t01yygGhw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jJQdez2qLdZpKSlPM5uIaCEfNqzAY5UFYVenHUM5fL0lxPhhlquQevjdGRyyFDg3gD6HDV6pwwcB7r20C8iDQlOZaxn7p+KHvd+rXohd6yvHs7TIlN8AtX7P7dmIcuhuWUJ1sGCw21FgSvdens2uVsQ1P0eXpFF/t7mAAKdgtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JOGXTRwM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=E25vMthg3vqCpG+5zSE+AGNII/5x83tzP1t01yygGhw=;
	t=1715078817; x=1716288417; b=JOGXTRwMyMWrvYnvWFxB5FrsebDM2UbKoW5UJ1/M+IS5FKx
	SLAtQ+ggip1Fle+eQsaZGwmw6Ggar32LEIIlQufAIrZFIKZqohzdNs0SUHQgZz1j2QMfXdvLubk2V
	4ujasEp/Vpcd8u/W1F8oIT5DzdleY/tjgM5GALv38xw2yU6hWAQZcJpK0X2rP+r3XYehY7eZOfNNZ
	ufQkVb77+w8ebBBRwJG22HR6LY2GAYOHWvHjlmwOmHAi7czzE/ANT/qjGGqineI3bs+TSoIQvJr8W
	FhnPvAVCJl7o8OYJkWLSiYkN5SYvOb+gk7E9wMvCK6d5vc6ALOv4jAgglQK5yVmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s4ILQ-00000009X6J-0VJr;
	Tue, 07 May 2024 12:46:48 +0200
Message-ID: <10256004963b6e1a1813c6f07c5d21abfc843070.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: Avoid address calculations via out of
 bounds array indexing
From: Johannes Berg <johannes@sipsolutions.net>
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>,  linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Date: Tue, 07 May 2024 12:46:46 +0200
In-Reply-To: <20240425181342.GA657080@dev-arch.thelio-3990X>
References: <20240424220057.work.819-kees@kernel.org>
	 <20240425181342.GA657080@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-04-25 at 11:13 -0700, Nathan Chancellor wrote:
> On Wed, Apr 24, 2024 at 03:01:01PM -0700, Kees Cook wrote:
> > Before request->channels[] can be used, request->n_channels must be set=
.
> > Additionally, address calculations for memory after the "channels" arra=
y
> > need to be calculated from the allocation base ("request") rather than
> > via the first "out of bounds" index of "channels", otherwise run-time
> > bounds checking will throw a warning.
> >=20
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_req=
uest with __counted_by")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>=20
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>=20

How do you get this tested? We have the same, and more, bugs in
cfg80211_scan_6ghz() which I'm fixing right now, but no idea how to
actually get the checks done?

johannes

