Return-Path: <linux-wireless+bounces-23064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2D3AB9781
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD84F1890CA5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED56221D98;
	Fri, 16 May 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gqB8t9VH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59921FECB1
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383997; cv=none; b=tkjK9O+qlOrLr4jG4Ypiav8X4/hOR8YREnh+70o+t2xSfiX+nD5pczNTWx00WeFWaVbXAAadHw2PIcrLipF+r6qB9P/3RV6uUC1WV5X4HSNogqrMdKwQDwQymlaCBLsVsQdF3TxKXMAI85nFxREOwjxKl/lDOEBR20PHRXo+YOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383997; c=relaxed/simple;
	bh=Vqk4oEVinCOlFI/uJi49DuXA/NTBNXt8lD6a8yPWOgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSTiWw02wlCJWI2fKM9WDWyx9ZCOOBGY9yaYGA1sWJyvuj8MO5EbLcOhx0J5wcUH2riOhqknejALeT7TVn5eNK5xTAV3arvSoDpPu97kwzd/+1Jo+jQba6OAKGAYDvqtkli/bmOkrrA2z58mnDNJCNPQie3PKkdiCqi3KEqTewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gqB8t9VH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Vqk4oEVinCOlFI/uJi49DuXA/NTBNXt8lD6a8yPWOgI=;
	t=1747383996; x=1748593596; b=gqB8t9VHSldtTG7as+BUd5LYPf78zsBVHBNK4RSUU2I48VW
	9pleZ135zNHaS9JULZi4EBdWPsRySQEJs0hgQHw+tCaxHJA/he2pKGM7kIYJ3Ot37xwWg9ExLqD5U
	R1JlubkmGfzJ23UE18dimu/XGCct2LwTHDa6XHABE3zioDcJH7FxwJSS9hshDXQ1OGg4qd5T6Shpg
	dxM7NeuIxhcsGYrstdUPmmIcMB9uOjuAuvb+n+5e850u5OncqXoigek+1g21IZqRNmo0ENsXnVLpu
	ezSOkPnZGNWmrkSvYG+UZ++2pNip38zSrQZu352fPiQmeV7WdkieLBMsmtSaHmXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFqOm-0000000E5Zb-2UWt;
	Fri, 16 May 2025 10:26:32 +0200
Message-ID: <e709c160b9a8eae55c5678fd222f1239657dfa29.camel@sipsolutions.net>
Subject: Re: wireless-regdb: Wrong ETSI tranmit power without TPC
From: Johannes Berg <johannes@sipsolutions.net>
To: wens@kernel.org, Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Date: Fri, 16 May 2025 10:26:30 +0200
In-Reply-To: <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
References: <aBoK6p1+F5ve1rC6@FUE-ALEWI-WINX>
	 <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
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

On Fri, 2025-05-16 at 16:15 +0800, Chen-Yu Tsai wrote:
> The conversions don't always produce round numbers, and since we can't le=
t
> the system exceed the _actual_ limit, the values can only be rounded down=
.
> For example, 500 mW converts to roughly 26.9897 dBm. We can't use 27 dBm,
> since if the system outputs at 26.999 dBm, it would be in violation of
> the rules.

While technically true, I'd think it's probably hard to even measure
that accurately, 27 dBm is 501.187 mW?

> Or, if we understand 3 dBm reduction to be halving the power,

That's fairly precise, a factor of 0.501.

> we could
> fix up any rules that "have their base limit in mW and were converted to
> dBm to apply the reduction" be rewritten in mW with the numbers halved.
> That would require someone to go through the entries though. But if
> the rules are already written in mW, and what you observe is the kernel
> rounding down the numbers, then perhaps the kernel may need to support
> both units.

I don't think _drivers_ (or firmware) would support both units, so
that'd just shift the rounding issue elsewhere?

Though I think in some places we use "mBm" instead of dBm? But then we
also just convert to dBm in many places so that'd likely not make it any
better.

johannes

