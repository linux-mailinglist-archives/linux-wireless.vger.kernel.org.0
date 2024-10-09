Return-Path: <linux-wireless+bounces-13804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE4899658E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F27F1C22305
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053433BB48;
	Wed,  9 Oct 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="t3Y4Hl/V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E018A6DD
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466433; cv=none; b=aO6JVS/oNXz7JKwe/9ZqdUz12W+givbKhQeXISHqDemG+ioy5/xAhba9raFIOB5bnUxYRX4487m2PfiRtzXmROtPQAzsEiL0tJighJ5iZp2csHWNZT12FOqg3psFne3udX5o1xDMIfwsqM6W1/jE49pKbEmaFeNfacTDDwUuV40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466433; c=relaxed/simple;
	bh=2vzkDDouvWOCpgJdPcTrsyYeS0crOoJ/ZMxGW26nt1k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tXnPj4ruJYScT+MEsAT39YhjHkCmKEBD1InKGhQxSIBp3QakKW6rIGPVMJrnfHZL16xg0Ugu0Nuy00bShC4bIVrSt5h+zSwO2fZG92h5qQtd6IDVNQXnqrVo6AMnd9ppwpsGssvB1hSiAVyL1cGGwAxaWwGcRRvqPFGnJ1lVSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=t3Y4Hl/V; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oRsGgSNV4RqhW+Q3MvpQBOQn2z+Uv3OrZlNf2AAYSDQ=;
	t=1728466432; x=1729676032; b=t3Y4Hl/VWNgULNBkRxuzWjnn0WwLpHBiXDj02cqGDwpiuS6
	KhioUy/ntc5fEW/MsZda0y6ObBqslG0uVOuQcaXZ38z9QFijPwJshE5BjO339k6MJkE3uMgU2ZZe4
	MEgoj4q9Ij5yJugmINWf5MyivbuRJpgwO3Hu6D8JzqDB9ZyiJ9G86BEpQxjAp8h8z+uJ3LNNeMS9P
	xfgBuuSUToIH2bj4ozDg2LKd9psRLSEqh8UMsifZlUV+mRzX8uvQTXLXhD/oVNWTwlnBM611xvFTP
	afR3cD/EugnB49YoYlfZvaB354zbsiateGwAgpXFPsyV05c52HhlESMXrSpTwrWg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sySc6-000000054DR-2qay;
	Wed, 09 Oct 2024 11:04:10 +0200
Message-ID: <6a2029dcaf7724b8d4516807097541f09268f828.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: iwlwifi: Report link-id for transmitted
 frames.
From: Johannes Berg <johannes@sipsolutions.net>
To: greearb@candelatech.com, linux-wireless@vger.kernel.org
Date: Wed, 09 Oct 2024 11:04:10 +0200
In-Reply-To: <20241007173851.2207849-1-greearb@candelatech.com>
References: <20241007173851.2207849-1-greearb@candelatech.com>
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

Hi,

So ... I suppose I kind of get it, your product doesn't really need
things upstream and so you don't care all _that_ much, but I'd still
appreciate if you could take a bit more care.

There's always a large amount of friction with patches you send, which
at this point makes me not even want to really look at them, and then I
wonder if I should just fix it up or send it back ... Yes I can and do
fix trivial things, but it really isn't something I feel I should need
to be doing all the time.

And yes, I also understand you want to just throw ideas over the wall,
but really in a v2 patchset I think we're beyond that. I'd also
appreciate not seeing obviously wrong patches (e.g. with a ton of marker
comments or prints left in them) since that just detracts from the
purpose, but that's not relevant to this patchset here.

Anyway ...

Here, the subject should've had "v2", and in the commit message, below a
--- marker, a description of what you changed.

>  		memset(&info->status, 0, sizeof(info->status));
>  		info->flags &=3D ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTER=
ED);
> +		if (link_sta_id !=3D -1)
> +			info->control.flags =3D u32_replace_bits(info->control.flags, link_st=
a_id, IEEE80211_TX_CTRL_MLO_LINK);

That line is clearly too long for no reason at all, and same below.

johannes

