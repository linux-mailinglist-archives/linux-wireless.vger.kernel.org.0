Return-Path: <linux-wireless+bounces-9771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE1591E105
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 15:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE311C2193F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C030815E5BC;
	Mon,  1 Jul 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VOdSB9nb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232715EFBF
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841386; cv=none; b=T47t6Kk03/hTN6NFwU1vZhhOFdgqHQ8x7ZE+4ei8n7dwb0V4L6QTJln1VT5ly8V25dAAJCWoGepHjCzgn0jSM9zWXwGogWmBzBIE9vgwzgiFQUyw7hciFxNOyCopNO0g5PfIV1W1VjfQqS0rXDE9gRy/KONQfE9NqcyMaKOgeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841386; c=relaxed/simple;
	bh=d6HTRSACoMebHgytE7iQzaW+l02cXZYiJwqZAfEw4W4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9/JDj7Lc3nP+jkR4UUwXDgcKivzaSQBf8wPIiN99dHfg8RgSsKEL7yJn1TcGNuLDSem0SCi2+HtDG5GHEEzOQdawQKm59CMLgaZTvQwKdoQoz86RHflNPBkaM+44QtyZwiVwovzlODXFK0CCB8BxqXYqBxniwGUUqB0bNZv8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VOdSB9nb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GS0gvai3FpUXlWITG0+rNA8YHXwBihMeWS5NcwHHw0Y=;
	t=1719841384; x=1721050984; b=VOdSB9nb8IXfiE4k0lb0yDbk4BgaCIjqCoI/tyTbQVczrTn
	bKKk38V6ccJ9FgCMdnSE40Npyn1S12L5kw7ei8GdR0YNlDGASU8DD4SPDyz8owNl5YbNlAUuPqlIi
	1AryVDr+TpKH5Mm/+skFwEPn5HAHZt4hTbT5s5bx/W1p6k5FNGng9qNrfLVs97ESveXR4834AzP6Z
	y5qRkH/7dHcsNF9gkysIEvCpN2C42Gz3O+/qyEPIdkP7P4aMUvmrHa0fEdi1dpCAkuI+U5wY3KXHj
	l1TUZyjP6BnJVjaJoiw/1xRl/iT8WJ4Lcz6dVRb2UNld2g/h+8gzS2QA6grgsaiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOHJ6-00000002Hju-2UP2;
	Mon, 01 Jul 2024 15:43:00 +0200
Message-ID: <b5d1ea21c5cbbceac0e5a4f94a68ee9e2c182e3b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 10/10] wifi: mac80211_hwsim: add support for
 multi-radio wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Mon, 01 Jul 2024 15:42:59 +0200
In-Reply-To: <816345bafb43d5ef5078f94ca309d5d3da2619e7.1719733819.git-series.nbd@nbd.name>
References: 
	<cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
	 <816345bafb43d5ef5078f94ca309d5d3da2619e7.1719733819.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2024-06-30 at 09:50 +0200, Felix Fietkau wrote:
> This registers one wiphy radio per supported band. Number of different
> channels is set per radio.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 78 +++++++++++++++++---
>  drivers/net/wireless/virtual/mac80211_hwsim.h |  4 +-
>  2 files changed, 71 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/=
wireless/virtual/mac80211_hwsim.c
> index 8491eb32f760..50aa2f838e9e 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -69,6 +69,9 @@ static bool mlo;
>  module_param(mlo, bool, 0444);
>  MODULE_PARM_DESC(mlo, "Support MLO");
> =20
> +static bool multi_radio;
> +module_param(multi_radio, bool, 0444);
> +MODULE_PARM_DESC(mlo, "Support Multiple Radios per wiphy");
>  /**

nit: keep a blank line

> @@ -5423,8 +5442,41 @@ static int mac80211_hwsim_new_radio(struct genl_in=
fo *info,
>  		mac80211_hwsim_sband_capab(sband);
> =20
>  		hw->wiphy->bands[band] =3D sband;
> +
> +		if (!param->multi_radio)
> +			continue;
> +
> +		if (WARN_ON_ONCE(n_bands >=3D ARRAY_SIZE(data->radio))) {

Not sure you should WARN_ON for userspace stuff; it's hwsim, but syzbot
will complain. Could use GENL_SET_ERR_MSG() though.

johannes

