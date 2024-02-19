Return-Path: <linux-wireless+bounces-3771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB8C85A078
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 11:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96499281F36
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 10:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50CD24B5B;
	Mon, 19 Feb 2024 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hU1NXGSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8B2556D
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337054; cv=none; b=dS1D7ExKgX5JRodEhV5I8zErDgvxQXrpRRIqfFdnXvcWeQePEwye7nz7R3WL6r6OIxuG1AqYQ+DWI3CysIteVXepK6dFn4y+8hz+WZ3165k2ZpU3p6rpaHFOJyPjivDp/aldncuWpwrwctnEMLhpLNxSwpEQABIBjkyXHB7dUuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337054; c=relaxed/simple;
	bh=1R0qBqkNubg1ErmgJa4n1LavkTOWaXmYxdVpJl1gkvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dktETRHTq8lv4H0I+8LNZCIuDYD/apjrgsdfv4+UI0IUzbDp3Uy6lr3PKV6t4jXtwgxsfiiSR0VYb/dqph1iw0J7RT4Xm4MB28E1KF5SaKaJnNjMVYZiguzLRVKgvc8gYerFRequdFevxGfPiyyOtjD2yTzfHoHD0l9Y6pshDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hU1NXGSC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1R0qBqkNubg1ErmgJa4n1LavkTOWaXmYxdVpJl1gkvw=;
	t=1708337051; x=1709546651; b=hU1NXGSCO+Hczke42spZcF/I+thALiP+UUfYK2lcIb42+Fd
	ALXrlVgNBM4+iIdHBJM4YGh3zzrSLWhZo8BFiXEBQQisjEr5VhKSo6NGb9L7EXnHpwWWcs26+mOGS
	bvGA423WTp8l/aFxA9QSV1HevbwHKdx8Ss0IW1pgJHY6aSvFEikFSuoEKSkZFC9Q2m+SyJn17qU/e
	Mx3oQ8gb6Xt3rPPjmxuMYz+msOpn9rAVMdupM8Fdo4bNg1YrMBnt2hZJSyrP57W1tLzO8s005wVyp
	ZVVMH5xE+iuZOzDc5x6LKZSSU+KpViU4DfYGc1aFEElkPUPf8lNgfaN4sssiYkbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rc0VF-0000000H1oq-0TB3;
	Mon, 19 Feb 2024 11:04:01 +0100
Message-ID: <f69f27acb8171cea5fdf6ceedb92efbced909300.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: rtlwifi: Fix setting the basic rates
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Bitterblue Smith
	 <rtl8821cerfe2@gmail.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Date: Mon, 19 Feb 2024 11:04:00 +0100
In-Reply-To: <afded3d1768247cca613f55943a013aa@realtek.com>
References: <35165caf-337c-4da0-b55c-c1a7081a1456@gmail.com>
	 <afded3d1768247cca613f55943a013aa@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-02-19 at 07:37 +0000, Ping-Ke Shih wrote:
> >=20
> > I'm not sure if this is enough. Should we also handle
> > BSS_CHANGED_BASIC_RATES? But bss_conf->basic_rates is only 0xf (CCK
> > rates only) and the out-of-tree Realtek drivers want to use the 6, 12,
> > and 24M rates as well. If ieee80211_find_sta() returns NULL, how can we
> > know if OFDM rates are supported?

This whole find_sta is a bit questionable - basic rates are from the BSS
configuration anyway?

> > I'm also not sure if it's okay to set the basic rates later than
> > originally intended, but it's still better than never.
>=20
> bss_conf->basic_rates is from AP beacon basically, and only the supported=
 rates
> with 0x80 bit are basic rates, which is minimum rates requirement to the =
AP.
> Thus, I think it is not suitable to consider basic rates as RTS rate.=20
>=20

But you have to consider them? Control response rates are very precisely
defined in the spec, see 10.6.6.5.2 "Selection of a rate or MCS".

I also have a bunch of explanations about that in the iwlmvm driver in
drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c around line 360.

johannes

