Return-Path: <linux-wireless+bounces-19915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14DFA54A57
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 13:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F13188C89B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01E6201022;
	Thu,  6 Mar 2025 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sbL9X7jW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6173520A5C1
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262913; cv=none; b=qfq/wQjelONB97yIDP5t67LZrDzAQJy22jlbha1Kanm6wGIwez2U96fDwIJAMfvHcQRmiZBh70+7Oa/u8tCjNnBbbKWA8SaQ294RRibj3j/O6LLksL3WKAWDWVoVwqKjQdu7+zKAYZE0VApGvT7iNJNfLi8Y6jeHYvur6YWU4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262913; c=relaxed/simple;
	bh=Qinnjm/ii428sH5+cNrjYuipI7Z4f+xid8hxS/hqdlw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nI3eaSBiuDS+wKPWq9Y/Sf60MBvyRSJkUx7oXTBxD2HDWHdFyOtN6Hr2SblyjeRzirsra9Nk+hg1dkL2MM3losNt1frl2WYtbyKgD5QBEuhOJhTidi2R7rHZ1x68XWNgQGIDPbz21tsyTuGmozAuvZP5UTBspF0URs38sUrlndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sbL9X7jW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Qinnjm/ii428sH5+cNrjYuipI7Z4f+xid8hxS/hqdlw=;
	t=1741262912; x=1742472512; b=sbL9X7jW94R5N6sb9eobDWobHL8ZD820kfowr8zjdU98cgs
	RFTlfEhRKG3LEuGQRJ2CwbUqiKv/Hcz9uO8Ka9NpySnCt/J+fqkuu3548UqIxd7ax2xXl61pn1pTn
	WOd+Mw7BvtpM/EAmaOM9xMRQA8nI5eZy12T1y/4VsSbQbH2r0K5ehW30rv8M3F78OQXhoVmjT59Pv
	60mO+fIiOq6U4xbTCt8gRvcZIgv3Qhz7Q2ZiySqepf/iL9GKBiuOaT65OcrtB3o26d6QJGYMU5uHF
	aIWWtpcSKWceTeQuv0yYM61ELf6gIUHufyUllb1fPveKSxWiUh2bkyEn+X/BuZ8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tqA1c-00000002pZ4-2EFo;
	Thu, 06 Mar 2025 13:08:28 +0100
Message-ID: <8456af3fea13b3a6696bbda042f8dea140ab26c7.camel@sipsolutions.net>
Subject: Re: [PATCH v3 07/12] wifi: cfg80211: extend statistics for link
 level in sinfo
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 06 Mar 2025 13:08:27 +0100
In-Reply-To: <e989f3fb-4fa7-4839-9b98-d9a8c7341b1d@quicinc.com>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
	 <20250213171632.1646538-8-quic_sarishar@quicinc.com>
	 <6c6be5e9552d32d0598af6aee55ceae450209f7e.camel@sipsolutions.net>
	 <e989f3fb-4fa7-4839-9b98-d9a8c7341b1d@quicinc.com>
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

On Mon, 2025-03-03 at 21:37 +0530, Sarika Sharma wrote:
> > This looks like it's missing the roll-up to the global counters and
> > timestamps? Why would that not break backward compatibility?
>=20
> For non-MLO it will not effect, for MLO I have added accumulated stats=
=20
> for packets, bytes and signal, rates at mld level.
>=20
> For inactive time, DTIM period, beacon interval can I add least of the=
=20
> values among links ? and add as a separate patch?

I guess some like DTIM period / beacon interval don't really make sense,
but for some others we should have it it?

Not sure why it should be a separate patch but I guess it doesn't matter
_too_ much, hopefully nobody will need to bisect this specific feature
...

But honestly you could almost just add the roll-up support in cfg80211
*before* you even split it in mac80211, it just won't do anything until
mac80211 reports per-link values?

johannes


