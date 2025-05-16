Return-Path: <linux-wireless+bounces-23057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CEBAB96DF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E03118916A6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 07:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED969229B17;
	Fri, 16 May 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cyFgwCSD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67919CC3D;
	Fri, 16 May 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381905; cv=none; b=b6qBCqjwloXiV2YpY7WUzIgjuxayHbPsX96KxksCvhmjGJquHGjU3PmYHZTEiAOAASoYrJZ4hl2qFW0rdK+6l5UYBhIJLrhjQEvM2holmzWvhYGYuHJOqqV4YOJsnTf1TunEjSdaEmHbzA0SC2tejNX7yE4pzkLBybLRjWscTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381905; c=relaxed/simple;
	bh=YSZy/DapjcrWUochZbFfaJ0M2HPmjq6tMOkesB6qzC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2o77JDuADAWiRL//X9P9SAoGyJ1h+KJ1NVuw/7ujWIcwxlXiXasqMy1GymOEyKQcp1w3snd6Ady/GPe7hUyWAHSIiMotE7enAqz4n7WVxgHZUc7CZQOY5eafUi4X6d7Z04TddmdYXC6HXyLHHmkn+ED6oF7NPoIP5hqoShttFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cyFgwCSD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9+v6AMuOkTxxA/OTLJuhBOlW0czaFUlrVQnB15X3z6I=;
	t=1747381904; x=1748591504; b=cyFgwCSDOBwG5kVIq1Vz5Qrm5SGBlEx4XZwd8fTPyoHB2uN
	sRdzfDB9hXHqqiZmD7FYk+qm+89+iCJsBOUXYbcymIfhp8lJzegg0zbNT97BEev52/h1fJTnmuAu6
	FxJw6yI2po2bfAGHeG8q+gHCymI3kmIG9siUPLcrAC44HjXiI9XM40pQjtlYJgBlzimMKgh/uax0W
	qwX42uvjO/527CM+vnAi1tck5lqDb/RgZqQCfqEiE8LMmkDkXGx/DkTumucaxLignTUGvLAVIYexR
	pEyy38cwCnVsGqwNWs2Dhth+t3mbg9WgeknxteXKDdlLqAXVT9E3pmCGjLypQ3Jw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFpr2-0000000E0HJ-1qD6;
	Fri, 16 May 2025 09:51:40 +0200
Message-ID: <37f00d636e1ffb68e383e0784b30e7e5cf48b4dd.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/3] wifi: cfg80211: Add utility API to
 get radio index from channel
From: Johannes Berg <johannes@sipsolutions.net>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Date: Fri, 16 May 2025 09:51:39 +0200
In-Reply-To: <20250514-mlo-dfs-acs-v1-1-74e42a5583c6@quicinc.com>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
	 <20250514-mlo-dfs-acs-v1-1-74e42a5583c6@quicinc.com>
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

On Wed, 2025-05-14 at 16:58 +0530, Raj Kumar Bhagat wrote:
>=20
> +int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
> +				   const struct ieee80211_channel *chan)
> +{
> +	const struct wiphy_radio *radio;
> +	int i, j;
> +	u32 freq;
> +
> +	if (!chan)
> +		return -EINVAL;
> +
> +	freq =3D ieee80211_channel_to_khz(chan);
> +	for (i =3D 0; i < wiphy->n_radio; i++) {
> +		radio =3D &wiphy->radio[i];
> +		for (j =3D 0; j < radio->n_freq_range; j++) {
> +			if (freq >=3D radio->freq_range[j].start_freq &&
> +			    freq <=3D radio->freq_range[j].end_freq)
> +				return i;
>=20

I believe we also discussed this in the past elsewhere, but I don't
think the the >=3D and <=3D can simultaneously be wrong. If the frequency
ranges for radios are adjacent, then the intervals here need to be half
open. I _think_ it should be < instead of <=3D, and therefore a half-open
interval of "[start, end[" (or "[start, end)" depending on your
preferred notation.)

johannes

