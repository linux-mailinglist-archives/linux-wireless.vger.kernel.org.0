Return-Path: <linux-wireless+bounces-13735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A578C995877
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71A91C21963
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517D61E104B;
	Tue,  8 Oct 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TZ814jOX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743A213EFD
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419366; cv=none; b=sESgYbZe4Z2HDEfrMIfvAZ436D3fb7lo36arsU83FzTWjsY+U125NmnfTwDyb9BM/ZWLyJp3/b9vABsXCNz1FSNDEqjWegFHTiYIJifc8RT52TRrq9tlfQnw2LiTlyisNNMm6Z0DLvXFv71C7KSZnIjuwbApyZgdD24NqrpAQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419366; c=relaxed/simple;
	bh=i+JO/EmG66VnBv1U2Lm0P3wQdSmbgQwyD03kFOhEORA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uGhZ0qP7KmPb4hqPgASt0KU1b7fg8hL5KTj2VxL9A/WkseoHBSgmRe4AhxNXN55qCMn1ghfTePRVQvrV0OUdtDqTI9WJeMdPZHO/7iLGLMsTRxPoKNcUkwKjQsZ8hMRDkJIteBBWKz3iMR/PyB1SIZmU4PoFgOlPjDhz+kLJeO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TZ814jOX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GgWslNF1K7B/0lT2k54s8GzzfiBO1uT5pcpGRsQ48NY=;
	t=1728419364; x=1729628964; b=TZ814jOX3AKtCXgGTGcEBnGNozmGGDLuiE/Y07wy3LUjjtR
	3jBsar1TqeGyEoWvM2wL9W96P2OC3RghfmVasP02uGoYw/AiPasdDmgkDzqb3vxikVV4D4aP/T7+I
	Yml8fjtrJ8moMD3ad0x3dwMf8R1FEM3qFv76N4U4It9uA6nwRW/Uo+vDysZG8TEQwv3DK5wCkLK7R
	GlNSKCkX1Zmv8WW72K+sNJjyPSPmFLgjTTqAXTBb3NFi39ZkbG5fVejIvuVnR/md911qcki8HroZF
	EQc3EH2EgHojvejkVoqCzMDF7J3QdtiSg5KFJy6xEXw2XwqthtcpRODwJQk6btpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syGpd-00000004NmP-18fI;
	Tue, 08 Oct 2024 22:29:21 +0200
Message-ID: <ce52ea8d9d53a7920fba024a8a073d907c58ef5a.camel@sipsolutions.net>
Subject: Re: [PATCH v4 04/11] wifi: cfg80211: report per wiphy radio antenna
 mask
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Tue, 08 Oct 2024 22:29:20 +0200
In-Reply-To: <be2cb63f97aa2c05fa358d2eeb8bc1a0f8a46596.1728372192.git-series.nbd@nbd.name>
References: 
	<cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
	 <be2cb63f97aa2c05fa358d2eeb8bc1a0f8a46596.1728372192.git-series.nbd@nbd.name>
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

On Tue, 2024-10-08 at 09:23 +0200, Felix Fietkau wrote:
>=20
> +++ b/net/wireless/nl80211.c
> @@ -2428,7 +2428,9 @@ static int nl80211_put_radio(struct wiphy *wiphy, s=
truct sk_buff *msg, int idx)
>  	if (!radio)
>  		return -ENOBUFS;
> =20
> -	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx))
> +	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx) ||
> +	    nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
> +			r->antenna_mask))
>  		goto nla_put_failure;
>=20

This should probably not be reported if it's 0, because that's nonsense
and just means the driver didn't provide the info.

johannes

