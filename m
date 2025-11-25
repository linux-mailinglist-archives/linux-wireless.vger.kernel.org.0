Return-Path: <linux-wireless+bounces-29323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEB2C83B38
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 08:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8EB3AC947
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B7C1E5B68;
	Tue, 25 Nov 2025 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YcEcUDoD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10413AA2D
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055482; cv=none; b=kGGuWdEniA2C1xR2ZCCf7+Bc154ykwmxzTix0FA9FIxHYYChgSpwXFmPY1SXqez7iqoJ5YLAYBRQG7FcHMrZs2TaEnB5Z5D0tAV84F/Cr9bD47bqE2Z5JODlnOFAQt0Hp1M90OsiKfJUH/vXYVXRgDxb8YIojnTxLa7/ntTPNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055482; c=relaxed/simple;
	bh=iKjSUcWY5gQjBgPZ/pqFfuHaFBwhMpMQ9B0CDG8ZnEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VD8AICmCfC1vHVfBJioRMpdjp61857NDlBWnuRIWv12hq9emmbQfq/O33USEUu3DBJ5RX+oOCJM00c4Kmm345xtI7oyicgeM0eqxVZclay8Wj/ynDASs9/i+auspGi2RhzwcK5nTr1KGp2Je+uo5pUqMNekFrrcwcHcOZ3jmzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YcEcUDoD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=heLaO/B4OfZdpc8HIhbcwOstn+r0JN6iwVI//nr1sFQ=;
	t=1764055481; x=1765265081; b=YcEcUDoDMkfGccb/CmmNg88iWvsALWyz2LML5q928ky1vfT
	ClSXYG5uUthABKGaSOvzxhHmt1sqS6qMuFqvGTLYVge3QzVBw+3xJWK+BGsmvux/b3Yel6OTdV3Oh
	TIrKLm354U8lANW/xdmzGCQd971+vODuBvhbb8orBkAecFfIWveiQD8MoCW683VAqDWeLXqQD+EK6
	Gg3p1a5FRy/daYofoW1qsxL/lkjVfSjV5I7nerx1rK+p7qoXqXTHjgZGdYQu06U7l5BN8kIul7K07
	WgO5AMj+MCMKRat4hKiqwh6KHTCwFrP3ZzRlc/yHnALncY8/LAq/t87vbnMDZ9EQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vNnPc-0000000BLJg-3YkJ;
	Tue, 25 Nov 2025 08:24:33 +0100
Message-ID: <7a74b6b380ba05e3822eefc8350deb3cbde3419e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211: allow sharing
 identical chanctx for S1G interfaces
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 25 Nov 2025 08:24:31 +0100
In-Reply-To: <xlfvt7pu454mthb7nrowheibslqqlxifawkfx7kltaur2mztdh@laxm3mnd64qf> (sfid-20251125_052707_595491_AD2F2E3B)
References: <20251125025927.245280-1-lachlan.hodges@morsemicro.com>
	 <20251125025927.245280-4-lachlan.hodges@morsemicro.com>
	 <xlfvt7pu454mthb7nrowheibslqqlxifawkfx7kltaur2mztdh@laxm3mnd64qf>
	 (sfid-20251125_052707_595491_AD2F2E3B)
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

On Tue, 2025-11-25 at 15:27 +1100, Lachlan Hodges wrote:
> > =C2=A0	switch (chandef->width) {
> > +	case NL80211_CHAN_WIDTH_1:
> > +	case NL80211_CHAN_WIDTH_2:
> > +	case NL80211_CHAN_WIDTH_4:
> > +	case NL80211_CHAN_WIDTH_8:
> > +	case NL80211_CHAN_WIDTH_16:
> > +		/*
> > +		 * mac80211 currently only supports sharing identical
> > +		 * chanctx's for S1G interfaces.
> > +		 */
> > +		if (ieee80211_chanreq_identical(&ctx_req, chanreq))
> > +			return;
> > +		WARN_ON(1);
>=20
> The robot not happy with this as I forgot a break / fallthrough..=20
>=20
> 	if (ieee80211_chanreq_identical(&ctx_req, chanreq))
> 		return;
> 	WARN_ON(1);
> 	return;
>=20
> The above looks a bit ugly.. did you have a preference here before I
> send a v2?

I guess I'd prefer just

	WARN_ON(!ieee80211_chanreq_identical(&ctx_req, chanreq));
	return;

?

johannes

