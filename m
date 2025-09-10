Return-Path: <linux-wireless+bounces-27203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE1B51165
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 10:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316971C822E7
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 08:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F74230F558;
	Wed, 10 Sep 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ge842IhJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBBC30FC2A
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493244; cv=none; b=VpNKze2xvUBAhuLfrbbCip+5bBbxYJtTlH4CJdkobqSKzxr1jAzjY3kulG30DrtOuOhA1k7y6MIOqoVjNqd/8dBkIc443jL5c+siBPlQS+DH0PJTTTuRP1oW1b7WLI3kEtM+rw1o0rm1vwQ+BfM0XEARp3MrZm0L1EvFZ/u1+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493244; c=relaxed/simple;
	bh=toOUaxdVoGEs/B7DmV3qAM0y9m2553dykhQBsmjvKOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JLr7BNMlyD+BGTyj5Oveg0fX13FXUMTZCP/NlbfYEJbhqYKSBDPgxsqKNHvg1GPL9CMbOAjIWHFlXWtGYdHSBYfI5CWsE0NWJE637tyf8/u33b/dEQwaB8kZO3Bjy6XkF7Uo5DIpv3WSZ0pc5jtGmSzzUJC7B9aEK0EvQEkZmGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ge842IhJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=toOUaxdVoGEs/B7DmV3qAM0y9m2553dykhQBsmjvKOU=;
	t=1757493242; x=1758702842; b=ge842IhJcUxpwvyVzD0FohYaLzpYeU24XeUUUYlV7mORW6B
	oIGQfDjMAcrZbwb23DjTk8Ns1hWf2I8eKXjXOMVx51AlRtwFI5qU4UWrpxwwMjeDDyD9CUlWswZz+
	1JjTpTLu6FrZavPgiESp1kjkteG5gh/hPHvbu777qiZVFJWPYHX6Ckxy0KGijJKbKET+HC6Hu7BHg
	TArmkKgxor84paQ87hbqjGo0cdxuY1PRNqO1pnqfCqCJ6G38ZEQ3+8uEgCGWU6sYXeSgpVHQ3HObK
	VCg3zqjzMxgK2jFB0MP2vfG1wogmsgAbDYXnoWHUvT1ECZYB1vIh/kaJv8zpP/qg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwGH9-0000000CSys-0CJF;
	Wed, 10 Sep 2025 10:33:59 +0200
Message-ID: <a83d883d0f251c08de7dfe7f2b3e7ab890a9b1df.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: cfg80211: Fix "no buffer space
 available" error in nl80211_get_station() for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Wed, 10 Sep 2025 10:33:58 +0200
In-Reply-To: <20250905124800.1448493-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: 
	<20250905124800.1448493-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-09-05 at 18:18 +0530, Nithyanantham Paramasivam wrote:
> Currently, nl80211_get_station() allocates a fixed buffer size using
> NLMSG_DEFAULT_SIZE. In multi-link scenarios - particularly when the
> number of links exceeds two - this buffer size is often insufficient
> to accommodate complete station statistics, resulting in "no buffer
> space available" errors.
>=20
> To address this, modify nl80211_get_station() to return only
> accumulated station statistics and exclude per link stats.
>=20
> Pass a new flag (link_stats) to nl80211_send_station() to control
> the inclusion of per link statistics. This allows retaining
> detailed output with per link data in dump commands, while
> excluding it from other commands where it is not needed.

I guess I'll apply the patch for now since it makes things _better_, but
I'm really not convinced that it's actually sufficient, and I'm very
tempted to throw in another patch to make it always false for 6.17.
Convince me not to? I'll reason below:

It seems to me that with many links, even for dump you could easily need
more space than the size available for a single dump message just like
with get, since there's no fundamental difference between the two. So it
seems to me that not only should it be opt-in from userspace to retrieve
the data during dump, but also there should be the ability to split the
dump not only on a per-STA basis but also per-link within the STA, which
requires some logic adjustments on both sides (hence the opt-in.)

Especially if we start seeing more links and/or more data for each link,
this will otherwise become an issue even in dumps.

johannes

