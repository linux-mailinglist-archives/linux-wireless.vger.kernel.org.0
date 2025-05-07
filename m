Return-Path: <linux-wireless+bounces-22711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB80AADFCE
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B0D189836E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822A42135D0;
	Wed,  7 May 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Wi2eWqhK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE9280039
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622440; cv=none; b=RJVrDgxFn5jGfaFuHHlkJGSrAWBJHgSNKyawBKD5/XlUa+mPvdQuZbHKOWrHajwoFQj9/tGvtsrNjovQ/cgWrYddzTr2TbsYWvObXRu//S+99wsfq29tPSpf9wDeSBkmPjN8cHOgquWLjZhJjdjYhtuvkJMYNdeWSb0iMHZPsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622440; c=relaxed/simple;
	bh=2uBdlAuiQFGYBxN477lLsk0HFJ/23ki1g7ojODscQgY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bc2CkI1GC2ibYmJKYeCBfagRjHIe7UzCTUXK+5vkRht2k1VcFIZ6eFr7DjeJkZyIOM6Rn9yTqdvaUhqTm/naWdll8CYQL+FDkr54OyBU6j4b7dX5XHM9OhoV5eEAAwULGzzK8vKuHDGC0EBz4S1ERXTeIV6ffWacUpUGWuM7igM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Wi2eWqhK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nCM0zn1bPdJfzzhpyr7v4Sf6krKEi1+lo0ezOjNApXA=;
	t=1746622439; x=1747832039; b=Wi2eWqhKiFSx4dUGgXXbCp/eJFbc0DiFC9gSQCRf1nTKf3v
	puN2Bw/NVJX2SnaSdY1Rb9qIqLum+CBSnuyutAXwoV4VhXqm6gMoPzjP+Z48ew7htZlQINp4KyUpA
	R0giuFmNCRHmw9rBMS41Ldy0ZInmK9Yzrwvm5s6Eg5BQTA1XKmlCFTPbuxssV/uSj4cbUvW+4D3yh
	YZhr8vIuntrPF1NK+MZZ8ivtASGr8Pd1rzCFxgKFQfWCpp5DDMLGSFDVdCT4jWZ39EHotEGpY+9ER
	YRSIOjNoHioQ+wb4yUnUnOd4AIiuWivAKaTXJtRQ1Gk2dWdNmz1CgfGYWgWU/mJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCeHb-00000007yqL-2PSL;
	Wed, 07 May 2025 14:53:55 +0200
Message-ID: <e647806c45cd9ef846fa693253e60e45edfa7786.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 05/11] wifi: cfg80211: extend
 statistics for link level in sinfo
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 07 May 2025 14:53:54 +0200
In-Reply-To: <20250415042030.1246187-6-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
	 <20250415042030.1246187-6-quic_sarishar@quicinc.com>
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

On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>=20
> The statistics will be embedded into NL message as below:
> For MLO:
> cmd ->
>     NL80211_ATTR_IFINDEX
>     NL80211_ATTR_MAC
>     NL80211_ATTR_GENERATION
>     .......etc
>     NL80211_ATTR_STA_INFO | nested
>         NL80211_STA_INFO_CONNECTED_TIME,
>         NL80211_STA_INFO_STA_FLAGS,
>         ........etc                              // <--- here
>     NL80211_ATTR_MLO_LINK_ID,
>     NL80211_ATTR_MLD_ADDR,
>     NL80211_ATTR_MLO_LINKS | nested
>         link_id-1 | nested
>             NL80211_ATTR_MLO_LINK_ID,
>             NL80211_ATTR_MAC,
>             NL80211_ATTR_STA_INFO | nested
>                 NL80211_STA_INFO_RX_BYTES,
>                 NL80211_STA_INFO_TX_BYTES,
>                ..........etc.
>         link_id-2 | nested
>             NL80211_ATTR_MLO_LINK_ID,
>             NL80211_ATTR_MAC,
>             NL80211_ATTR_STA_INFO | nested
>                 NL80211_STA_INFO_RX_BYTES,
>                 NL80211_STA_INFO_TX_BYTES,
>                 .........etc

FWIW, this seems fine to me. Maybe at least we can quickly agree on the
API here.

I think NL80211_STA_INFO_CONNECTED_TIME might make sense for individual
links as well, if we track that, since we can use multi-link
reconfiguration to add links later after the connection. So might be
interesting to have that per link in that scenario.

You also add later the accumulated statistics where I put the "here"
marker.

johannes

