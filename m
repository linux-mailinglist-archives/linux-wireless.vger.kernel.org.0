Return-Path: <linux-wireless+bounces-29331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 034FEC843DB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 10:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CACE44E46CA
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4BC220698;
	Tue, 25 Nov 2025 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XBUNVRUk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D21DF75A
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063200; cv=none; b=AnQ4hoTYC3E4zh6clBZKUwiLWSDr6fu47id9uN5GQBjBB1xaGywiKr+jCi2EwiTZnHvTkr4bkatcFhNACYczj1UqfSmZjw08+7squC3/h+4eWPFqwYl5iaKnX0HbuFEdcxlLsAQgnXjRAkEG6bW0qoIhXNjyXE20U3gicfnMfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063200; c=relaxed/simple;
	bh=k5/dpedIT82Su8r6zUMfqVY/+hsYmvzxUj3Y2KGPWBA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IseKDnwCwpmVlW+zFpcV0chvzX2Yro84SelInc+zbed3LBWDa/TT0LYWj9en4nu+25Xq/lF3TmFNTx90DumYrsZKR2iPAGEhkfg7q3aOGDkZ31PUzNZhNlfh5MtrNNxJEhvrrtL2CaKnc26CWaT3jJ9ZgL1jZEmzjKnCfFa4lfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XBUNVRUk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UuS75gvqFxUg0ANscb9MmlWDAETxQJYikYB0ALuu0qI=;
	t=1764063198; x=1765272798; b=XBUNVRUkTTkMv3lnZsgwzNqNJ5UfPwdCVL4bhlTpwGsMaTv
	xg+flfI/pzuqFO0f/SVMHWFUlBusMqJxDdYl/TLAPGUJ8JULbX5uCIVhMnfQ67N8xIm+qi3Lxp6Gx
	dBlpKamTj09qumJtxC2ME7F2u6U8pUcUV8qNLY35AxOj24VvAHiKFjT+0bwjv3OUmubSdumA29jVN
	98e07mMVCAgvsK8vZOIufXalyGbCje9KdBuz7ceCg3Qjs37lQg8ZGYyTSJBzVl5HrZHs9U2g8oX2m
	RbelsRzsQ9chuMU+nlQK3/vpoL6tv/xoiReXnuaeko3Wkv92pA7Nj3NR+IY9eJQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vNpQC-0000000BeOl-1StP;
	Tue, 25 Nov 2025 10:33:16 +0100
Message-ID: <ad24261fdeaa16eca068f534a0e093a731cf66ef.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211: allow sharing
 identical chanctx for S1G interfaces
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 25 Nov 2025 10:33:12 +0100
In-Reply-To: <20251125025927.245280-4-lachlan.hodges@morsemicro.com> (sfid-20251125_040002_858284_A06E220C)
References: <20251125025927.245280-1-lachlan.hodges@morsemicro.com>
	 <20251125025927.245280-4-lachlan.hodges@morsemicro.com>
	 (sfid-20251125_040002_858284_A06E220C)
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

FWIW, I applied patches 1 and 2.


> -	/* don't downgrade for 5 and 10 MHz channels, though. */
> +	/* don't downgrade for 5/10/S1G MHz channels, though. */
>  	if (chanreq.oper.width =3D=3D NL80211_CHAN_WIDTH_5 ||
> -	    chanreq.oper.width =3D=3D NL80211_CHAN_WIDTH_10)
> +	    chanreq.oper.width =3D=3D NL80211_CHAN_WIDTH_10 ||
> +	    chanreq.oper.width =3D=3D NL80211_CHAN_WIDTH_1 ||
> +	    chanreq.oper.width =3D=3D NL80211_CHAN_WIDTH_2 ||
> +	    chanreq.oper.width =3D=3D NL80211_CHAN_WIDTH_4 ||
> +	    chanreq.oper.width =3D=3D NL80211_CHAN_WIDTH_8 ||
> +	    chanreq.oper.width =3D=3D NL80211_CHAN_WIDTH_16)
>  		return ret;


Maybe that'd also be nicer to write as

	if (width =3D=3D 5 ||
	    width =3D=3D 10 ||
	    cfg80211_chandef_is_s1g(&chanreq.oper))

?

johannes

