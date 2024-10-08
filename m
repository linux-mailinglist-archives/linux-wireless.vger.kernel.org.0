Return-Path: <linux-wireless+bounces-13732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEFC995855
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 22:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2434D289F5F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E3921501D;
	Tue,  8 Oct 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SjVOX5jc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CF5213ED6
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419043; cv=none; b=FAjkAq5Xfd4rEvvrioRxaZd4cPExyEn67Ymcb6fbKQ5NWKay1fnQ17pHxb97rwgaM6/OI0eoLjxVBfWWCkePJAhO65qFO22f+7QJde7UBFnIB3LCmx6qyPSQkWqBnJVDVUaDZpqQ1+NGz4eXO0/VWlc0CSGtIhUlJJj9oqjbKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419043; c=relaxed/simple;
	bh=eyF1S1iLnEAY6Xj8XmjX2I3zJ/C+wjVsREhresDR3l8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mf6IhvmDfn1Eh+OQXTQWtpZgiUwtNDSrDK/x6wG6leBPt1o2KwDVgvBGDein0mqXNi7njx3BtlCfeYghm0mjHZRa48fEU6NEN5YyLH+8RMVBdiyNJC+/xA7vTnQL2g4T0Ij75Q5iH9ikgkgskq6Ige8jfSLth1e9e0CIcFsqvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SjVOX5jc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=D0lsbmdh0d3Y/fnKaiLCG0fEwW3lRhPI6mhwkHn/hP8=;
	t=1728419040; x=1729628640; b=SjVOX5jchR4H8uVEBKRBNKj+BuzOGfxBdBTrCY1rXyIbQol
	Dt8TYSrAYtyyvEs82v6v+NSmD9dN6o8+y8RwI3K/OQ4cC7UhBaGrw9Ed3qP776y2NB/cBwWTlcyP5
	QHhyClljuZu0H5/rejFvt4th60eRiPh3VvOnOYmFa+ZqSusiJXP4W+nfo0YrWTqf3IwqTu/IrfXRB
	agfLMW55SIFWX0Dohl4QDVZ4dBpsUEvag32C9wa8Hh5N2FyZvQG56YicRKNRXM9KBXzM6jUuX1NdN
	FYrbmLYFiD6CkPKurS/6znJc8KvQ2dGo2pIVcn0+wIvYfk02f5TdEhTnmkzcsYnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syGkP-00000004Nf1-2jQT;
	Tue, 08 Oct 2024 22:23:57 +0200
Message-ID: <7167e2cde9e9573944cb1a8c38ee7cf30930a8df.camel@sipsolutions.net>
Subject: Re: [PATCH v4 01/11] wifi: cfg80211: add option for vif allowed
 radios
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Tue, 08 Oct 2024 22:23:56 +0200
In-Reply-To: <5b1da33c10f63ee696fbd53a1552a65faac039bf.1728372192.git-series.nbd@nbd.name>
References: 
	<cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
	 <5b1da33c10f63ee696fbd53a1552a65faac039bf.1728372192.git-series.nbd@nbd.name>
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
> This allows users to prevent a vif from affecting radios other than the
> configured ones. This can be useful in cases where e.g. an AP is running
> on one radio, and triggering a scan on another radio should not disturb i=
t.
>=20
> Changing the allowed radios list for a vif is supported, but only while
> it is down.
>=20
> While it is possible to achieve the same by always explicitly specifying
> a frequency list for scan requests and ensuring that the wrong channel/ba=
nd
> is never accidentally set on an unrelated interface, this change makes
> multi-radio wiphy setups a lot easier to deal with for CLI users.
>=20
> By itself, this patch only enforces the radio mask for scanning requests
> and remain-on-channel. Follow-up changes build on this to limit configure=
d
> frequencies.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  include/net/cfg80211.h       | 12 +++++++-
>  include/uapi/linux/nl80211.h |  5 +++-
>  net/wireless/core.c          |  2 +-
>  net/wireless/nl80211.c       | 60 ++++++++++++++++++++++++++++++++-----
>  net/wireless/scan.c          | 10 ++++--
>  net/wireless/util.c          | 29 ++++++++++++++++++-
>  6 files changed, 107 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 69ec1eb41a09..73df4a8e8cce 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -6223,6 +6223,7 @@ enum ieee80211_ap_reg_power {
>   *	entered.
>   * @links.cac_time_ms: CAC time in ms
>   * @valid_links: bitmap describing what elements of @links are valid
> + * @radio_mask: Bitmask of radios that this interface is allowed to oper=
ate on.
>   */
>  struct wireless_dev {
>  	struct wiphy *wiphy;
> @@ -6335,6 +6336,8 @@ struct wireless_dev {
>  		unsigned int cac_time_ms;
>  	} links[IEEE80211_MLD_MAX_NUM_LINKS];
>  	u16 valid_links;
> +
> +	u32 radio_mask;
>  };
> =20
>  static inline const u8 *wdev_address(struct wireless_dev *wdev)
> @@ -6521,6 +6524,15 @@ bool cfg80211_radio_chandef_valid(const struct wip=
hy_radio *radio,
>  				  const struct cfg80211_chan_def *chandef);
> =20
>  /**
> + * cfg80211_wdev_channel_allowed - Check if the wdev may use the channel
> + *
> + * @wdev: the wireless device
> + * @chan: channel to check
> + */
>=20

need Return: documentation

johannes

