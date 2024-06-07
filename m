Return-Path: <linux-wireless+bounces-8671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B6D8FFF5C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 11:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAA61F22E0E
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025215B143;
	Fri,  7 Jun 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JDMoPTFT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0215B96F
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752304; cv=none; b=DMh2JJdoAd6iKwCTULnMoYTkueUQVkuXit89VIxhffTIHapSU5Z4Nni1/XVIQPtfLifRD1DkXuGVV+E+ZonasRyG2pLd3JQ0DbZ+Ovx++p7ufJalnpJr1Xj15CFsj9HA3sWt8GSheUuGhlHVyUdTIPBGjwJTHn1nYyG953Xc5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752304; c=relaxed/simple;
	bh=ehiGK0Qfp+UfRhMOBKxeHZPs/mfIl5gdbI2ZGLjPgfY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+0leyh/LXeTlg8JClngaKyJ43h86qSu/XiiaDvat8eCVUfWnekp8vahSLWLQccgvV79RsRwE8unmecWtKPIrDmbdGUInG1sZWrYxRua1CDOVHh9lTuxU0+dI7r/iEHkS935WGG4vBOXxvC+VnAIWmg/Aft+n+CNGW+wRTjMEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JDMoPTFT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7ZJ8Sy1xoeIn97faMJHr6oQebXUpyH/PLOTow55oVOQ=;
	t=1717752301; x=1718961901; b=JDMoPTFT5a4ZUMozAoPxmHzCIbeRlTCGMT2fy8Cz0pAoZmJ
	RQVAfzcefhRY8ZzEK2CkzaLc+MhQJhZmFXLbGqehZHJdTazTB0dwrwuKsi21auaJ9fAW/K/koq3II
	L0UGAt2z2HphizQkkl8xE1Op4PT8E7Snt/x66pK1N3nBRW/6lDr/HAJTiQIxgW4UkFIiCxCIAy1kd
	gl3pxEReX+UR8hSuHWjtPyUOIxQ6okXcIcQ6pqpjDjYxtCaFzkOyh4jqGTEh6YvKzOCSFazauSpJl
	qrCuFIg8adyWlObg43QMjAph5nvOZgtIZBuuLrM/vObmGPXV7iyXAGJKCsdo2OSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFVqD-00000000rRJ-2dic;
	Fri, 07 Jun 2024 11:24:57 +0200
Message-ID: <0ae7869140c8c2537fc638dba14223b25383f3d9.camel@sipsolutions.net>
Subject: Re: [RFC v3 2/8] wifi: cfg80211: add support for advertising
 multiple radios belonging to a wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Fri, 07 Jun 2024 11:24:56 +0200
In-Reply-To: <db7d83ea6d97e118a14029727e9e18d6e47b753d.1717696995.git-series.nbd@nbd.name>
References: 
	<cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
	 <db7d83ea6d97e118a14029727e9e18d6e47b753d.1717696995.git-series.nbd@nbd.name>
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

On Thu, 2024-06-06 at 20:07 +0200, Felix Fietkau wrote:

> The prerequisite for MLO support in cfg80211/mac80211 is that all the lin=
ks
> participating in MLO must be from the same wiphy/ieee80211_hw. To meet th=
is
> expectation, some drivers may need to group multiple discrete hardware ea=
ch
> acting as a link in MLO under single wiphy.

This is of course the motivation now, but I do wonder if this wouldn't
potentially also apply to a single device that's full dual-band capable
in some way? But doesn't really matter now.

But the thing is that it would let userspace differentiate between what
we mostly have today in a single device (multiple channels can be used,
but you have to go to powersave etc.), vs. a fully concurrent device.

IOW, it feels like this could be used to advertise fully concurrent
capabilities?

> + * struct wiphy_radio - This structure describes a physical radio belong=
ing
> + * to a wiphy. It is used to describe concurrent-channel capabilities of=
 the
> + * phy. Only one channel can be active on the radio described by struct
> + * wiphy_radio.

that's a bit long for the 'short description' :P

maybe just say "struct wiphy_radio - physical radio of a wiphy" and move
the full description down.

> + *
> + * @radio: radios belonging to this wiphy
> + * @n_radio: number of radios

Somewhere - either here or above - we should probably say that it's
assumed you only have a single radio (with the properties covered by the
interface combinations in the wiphy itself) if this isn't given at all.

(Which is what we assume today, more or less.)

> +++ b/include/uapi/linux/nl80211.h
> @@ -3401,6 +3401,8 @@ enum nl80211_attrs {
> =20
>  	NL80211_ATTR_ASSOC_SPP_AMSDU,
> =20
> +	NL80211_ATTR_RADIOS,

missing docs

> +/**
> + * enum nl80211_wiphy_radio_attrs - wiphy radio attributes
> + *
> + * @__NL80211_WIPHY_RADIO_ATTR_INVALID: Invalid

maybe if this is WIPHY_RADIO also call it NL80211_ATTR_WIPHY_RADIOS
above?

> + * @NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES: Nested array of frequency rang=
es
> + *	supported by this radio.

Do we really want this complexity? We only have a single range now, do
we expect that to change? Non-contiguous ranges, where a hole in the
middle is supported by another radio?

Not sure I see the value vs. just having min/max freq directly here?

> +	freqs =3D nla_nest_start_noflag(msg, NL80211_WIPHY_RADIO_ATTR_FREQ_RANG=
ES);

Please don't add new _noflag code.

> +	nl_combis =3D nla_nest_start_noflag(msg,
> +					  NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATIONS);

same here

(and yes maybe userspace wants to unify the parsing of this with the
existing interface combinations attribute and pass the attribute ID or
something, but then it can fix the nested flag too.)

johannes

