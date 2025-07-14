Return-Path: <linux-wireless+bounces-25385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2CB03F3D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 15:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167FE3AEAC1
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A0A246BB7;
	Mon, 14 Jul 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rnqXlD5c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FA4315A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498427; cv=none; b=cePr/NZR2wm/PZJwviCDnckbrUDGqgtUCuFXHaR8BUOcPl6bwG/NCHvSJPRAUc/paQ9n5dMRqzkOS2mK9EqI2sCi9xNsZqkzpwOiiaWz2wHicuBL2TzSvXgCJwNETulyi7BLQY92swKAF386SrlOJHWyPD3xQdrdvRJILBIIUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498427; c=relaxed/simple;
	bh=SnBG9DaKvixnvPPZCxRmzWnQZvJeC+F1ivCh+M+YZYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/KXAIIR0JsURTGLfcadp9Qucu723rbNbDIUUZkauzW3YsfKiEqJiXS5a35/2uN8SRZWaZHmPY9DeONv84AVDbeRS0XvuzlgWnIqhECnW4UvHQ5C27lBeR4UzGNGBgoOqPxvwvMtqzK3HpCwE96OESCCCm94uAINdcTd7FecB8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rnqXlD5c; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cMm7s3Kj+OmXS55qUunr9TGgtG97LaW14wm1SBCkYnw=;
	t=1752498426; x=1753708026; b=rnqXlD5c39XbrRCdScawqaYSgwKOoxkNSk3BZxUZPowutDe
	09DZPonXd9NkCfE0m0lf1jZXpVKj8lSYS1dKuXXNdOciOiWOwoZ3N+Pl3q2dho8f+3n3uBHxSD+RP
	oMu/sw7DXqD9pUjZyv16QLuvVM5OUlGY7oMtS9RqKYMpfdvZOnyYYm1PPBuv/bRvsy36tY9tfiD8i
	ItYllZMusmmSfBYftwJ1vfr6PHIJfRoX2YcaWLtnQZHmDtG8vhKRSo2KFlGXUk6SU4h0+XlUkHnGa
	RE36Sqq2LBfE/Avco5ReSrM/qceVxzsT46qmMt9P7OD2Z3uUpTOrycWUut8gt5Pg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubItc-000000046Ro-03Pq;
	Mon, 14 Jul 2025 15:07:04 +0200
Message-ID: <a5d85b78132c54e5486dcc0356e4d6be2ae9a79a.camel@sipsolutions.net>
Subject: Re: [RFC 3/5] wifi: mac80211: configure power save for an S1G short
 beaconing BSS
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Mon, 14 Jul 2025 15:07:03 +0200
In-Reply-To: <20250714051403.597090-4-lachlan.hodges@morsemicro.com> (sfid-20250714_071512_830959_862C7139)
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
	 <20250714051403.597090-4-lachlan.hodges@morsemicro.com>
	 (sfid-20250714_071512_830959_862C7139)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-07-14 at 15:14 +1000, Lachlan Hodges wrote:
>=20
> +++ b/net/mac80211/tx.c
> @@ -4881,6 +4881,13 @@ static void __ieee80211_beacon_add_tim(struct ieee=
80211_sub_if_data *sdata,
>  	int aid0 =3D 0;
>  	int i, have_bits =3D 0, n1, n2;
>  	struct ieee80211_bss_conf *link_conf =3D link->conf;
> +	/*
> +	 * via IEEE80211-2024 11.1.3.10.2 if we are short beaconing,
> +	 * use dot11ShortBeaconDTIMPeriod, else use dot11DTIMPeriod.
> +	 */
> +	u8 dtim_period =3D link_conf->s1g_short_beaconing ?
> +			      link_conf->s1g_short_beacon_dtim_period :
> +			      link_conf->dtim_period;

Also here I wonder if the complexity is worth it?

If we just say the beacon interval and DTIM period are when we send
_any_ beacon, then none of this is needed and we simply send long
beacons and DTIMs according their own schedule each?

You've certainly thought about this more than I have though :-)

johannes

