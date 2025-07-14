Return-Path: <linux-wireless+bounces-25384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B634B03F30
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 15:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C4E3BACF1
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091924A066;
	Mon, 14 Jul 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vd+xFPjK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E43134A8
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498229; cv=none; b=r/U7Zc0uxvQE9wKSAI22v7XQvszed/y7NfoHXkYCsyBYCdCJzyFFRSCZz7DaocYsFneHOoPrU70wZ+WgaobBpqDJMtoYXoZmU84rfRhoo688Z9GjaYDNeblT4E3SEk21VWWKNyp0cPQgRTSz/TzfPI49Xm3lgpGmHizK9Co0tMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498229; c=relaxed/simple;
	bh=n2DPAvGAF3w1YkEWloVC4Lz5ENl00YSth9cNfqRgLSI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CenbWWBuUjpck0geg0qTbf4VxMEEk1G+0t7QV88Dk4o5pdgH/838gO4Eyk6DOCt8tqKHL+InYpqYvUVSj5gOw6WNZ/a3ZofpsyN2YpJFId8QMEEpSGhBg6rDEOBQNthJXAi8rzvfH+V1U4pRkYLBSzWgQGgN+RnpOn3oQDG5fxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vd+xFPjK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ATB0IC31liTh2Bha9+kP1bFkZU7ZRCrxmWHrvf34tVo=;
	t=1752498228; x=1753707828; b=vd+xFPjK/wjSQJ2t9eRNaMkuO0tisbFbfD/wDGWI1ZgngDt
	hzh7QEKKY0/tv9NQlWbiDBL8wfxbyUNtGIM13PVhJL+p6LWDr7LTj4W/aaL3l2jjUsiqneXB7bG/7
	HNK2znCxx8wiO95OsxzdOsYjJ18dUuyaBLgaMgJYx00nSH2SJc6JYsQMvDm10Nis2HZ7xeWkzEjLj
	Nt6Pe9NrimKz8O3tg2NvCyE9hWgLvbg1kY+bGqc/3Y0qZx37JZ2LA2N7KDxvz2qMrZLPmN90bsgPB
	2PbpZDalCMw7rUFOyuQv/mn6r6EtszHr3o8zZ4kKQEsOJ4vHbVCRBsDaRxvvJq0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubIqP-000000046CE-0qlM;
	Mon, 14 Jul 2025 15:03:45 +0200
Message-ID: <3bf402034b4a975a603e22b8acf9c8974c47c237.camel@sipsolutions.net>
Subject: Re: [RFC 2/5] wifi: mac80211: support initialising an S1G short
 beaconing BSS
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Mon, 14 Jul 2025 15:03:44 +0200
In-Reply-To: <20250714051403.597090-3-lachlan.hodges@morsemicro.com> (sfid-20250714_071452_254485_0C545169)
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
	 <20250714051403.597090-3-lachlan.hodges@morsemicro.com>
	 (sfid-20250714_071452_254485_0C545169)
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
> @@ -758,6 +760,16 @@ struct ieee80211_parsed_tpe {
>   *	be updated to 1, even if bss_param_ch_cnt didn't change. This allows
>   *	the link to know that it heard the latest value from its own beacon
>   *	(as opposed to hearing its value from another link's beacon).
> + * @s1g_short_beaconing: determines if short beaconing is enabled for an=
 S1G
> + *	BSS.
> + * @s1g_short_beacon_int: short beacon interval in TUs. When short beaco=
ning is
> + *	enabled beacon transmission times are computed using this value as
> + *	opposed to beacon_int as per IEEE80211-2024 11.1.2.1.
> + * @s1g_short_beacon_dtim_period: number of short beacon intervals that =
elapse
> + *	between each beacon with a TIM element whose DTIM count is 0. When
> + *	short beaconing is enabled, this value is used as opposed to
> + *	dtim_period as per IEEE80211-2024 9.4.2.5.1.
> + * @s1g_short_beacon_period: number of short beacons sent per long beaco=
n.
>   */
>  struct ieee80211_bss_conf {
>  	struct ieee80211_vif *vif;
> @@ -857,6 +869,11 @@ struct ieee80211_bss_conf {
> =20
>  	u8 bss_param_ch_cnt;
>  	u8 bss_param_ch_cnt_link_id;
> +
> +	bool s1g_short_beaconing;
> +	u16 s1g_short_beacon_int;
> +	u8 s1g_short_beacon_dtim_period;
> +	u16 s1g_short_beacon_period;

Does the driver even need to know? For hwsim this is just additional
complexity - mac80211 could set the beacon interval to the short beacon
interval, and simply return the long beacon every
"s1g_short_beacon_period" (which perhaps should be called
"s1g_long_beacon_period")?

But depends on how your driver works I guess. Given these parameters
though, you can't really offload it entirely either since there's no way
to get a short beacon template now.


> +		if (params->s1g_short_beacon.short_interval) {
> +			/*
> +			 * IEEE80211-2024 11.1.3.10.2:
> +			 * beacon_int =3D n * short_beacon_int where n is a
> +			 * positive integer and represents the short beacon
> +			 * period which is the number of short beacons
> +			 * transmitted per long beacon.
> +			 */
> +			if (do_div(beacon_interval,
> +				   params->s1g_short_beacon.short_interval)) {

Again not sure I understand the use of do_div, and wouldn't it be enough
for cfg80211 to check?

johannes

