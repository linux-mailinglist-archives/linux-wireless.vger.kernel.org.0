Return-Path: <linux-wireless+bounces-12209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B04964B10
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 18:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636251C23E59
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CE21B4C5F;
	Thu, 29 Aug 2024 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cKPvJSdX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95461B5303
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947631; cv=none; b=PoFcrzlnOqYtybRZi6uYjT0lJXJTtSu0NR1Jd3ou1PZV4lAzaZJnHc2uaQPTBC2dvuuqT9uvhvCWKioDnz53f1EQ9bEGRbEUfBwMn7JDoy2/aow28VAoWTpR3EvnylYqQieC0nULrjLbT/OogbHMaDHlLX6rfCfIbGtIm0Rm0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947631; c=relaxed/simple;
	bh=VeMypEpo13aJi5L+IYDCsH36moo2dHFwdSk6S/JzW4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AifiCyVV7Q9dgRBi/6mMw2v6qcdOamLSKPnV1QB7Y1tbSR8Ar1LsDBvQYp4hOS0vw3jBhuN4e2MeOkDAmzg4nd5n5smyR3HSzrG/KSkR0Pd4e4Eb/6OJdTyNnHMTscvkvGjXKR9Tpj0wbISt4JDhh2ct8FvuU2SE9AQ31odFRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cKPvJSdX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r+P5GpT2A8cBfiT9sCzDAUyg+nJHB1XIOOa8rIb7FPw=;
	t=1724947629; x=1726157229; b=cKPvJSdXTW77s62/Gtug/SHQ7U3TDDQpp5ajiTzZDMBgvo+
	LMiidz6erkJsZJCLmAAkyro2TM8xPaTc8WRDS7TKxcYbYDjeWJf+qwtbpaJ6WtAEjrSpqTMSAKdPT
	Op+TLhb9qMr3qg839edtmctYwRQA8+or4JHzkV0P87b+Kcgf1N1edZ1Wh//TW1XzcKeyTw0x+Gq0y
	DzNjQd820bhiOq8xwSw3fgl/PeMR2012HzOsdieEOVKV5O6y2IZIz69qg2R/+IVWawSpy0+PiohT0
	5xZpuLjbalm+CjaLcjGDolEwh49A12fcmC+l7POlr63BNkHW+KVU7Y2/tKZkwG3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjhfp-00000009QXP-2M0r;
	Thu, 29 Aug 2024 18:07:01 +0200
Message-ID: <dd8cac71a80e70352f4ce4c4da426721e02ff31d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: wext: Correct spelling in iw_handler.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Simon Horman <horms@kernel.org>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 29 Aug 2024 18:07:00 +0200
In-Reply-To: <20240829-wifi-spell-v1-1-e0a8855482a9@kernel.org>
References: <20240829-wifi-spell-v1-1-e0a8855482a9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-08-29 at 17:03 +0100, Simon Horman wrote:
> Correct spelling in iw_handler.h.
> As reported by codespell.
>=20
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  include/net/iw_handler.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
> index b2cf243ebe44..f7f4c2a79b9e 100644
> --- a/include/net/iw_handler.h
> +++ b/include/net/iw_handler.h
> @@ -23,7 +23,7 @@
>   * to handle wireless statistics.
>   *
>   * The initial APIs served us well and has proven a reasonably good desi=
gn.
> - * However, there is a few shortcommings :
> + * However, there is a few shortcomings :

If we're going to touch it, maybe that should also say "there are a few
shortcomings"? :)

But is it worth it at all? This stuff is totally on the way out, so all
the thing about "proven a reasonably good design", well, didn't really
pan out in practice...

johannes


