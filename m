Return-Path: <linux-wireless+bounces-12786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036E6974EBD
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 11:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3649E1C219F5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFCC18130D;
	Wed, 11 Sep 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Kn9fg7N3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4517E01B
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047385; cv=none; b=BxwPNQS3AmRofy8zG7zs9ebvYJwHKLkDwqUH/Y828pjcnTcRD2sJtziSbY0QXTGh3AJZz8We+b8diCUG7z5yHTb4LaBJvo3dB7Q11XralzdBYdXtfWWVjZy0XEiRe2Ea5qcvN/Yk2voGNMmPxgPNY2eR56GUapQb/eFqhS3BSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047385; c=relaxed/simple;
	bh=pzcAO6HQJB1UMK1grjaah2OdQ+aD+PWAQ/tgmt6Y2uk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFImGLYZs/xa0JLhXb1xDXE2OhlS6zQvxREIo1J5oif2FSzd23STXHLXN37ftH1P42164k7FztizMNN4O1khs9n84iCM3J2bK70wtDz1Wt+T/hS8OT8UY9JsWTuZxK8hkjM3hb7fFLR+hGRxdOvnVESFVWn6bPFU0QKjQpeBlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Kn9fg7N3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EoFRXDbK6GhG8Qk1hnWIkPRfjQhnmr/+iN7iXiWDfSw=;
	t=1726047383; x=1727256983; b=Kn9fg7N3iTKElh+KpXdXNY0dD+2+cVqyO8luv6w5BZtEEb9
	yI5K96xU6Y6zqYd/lD7qiGxXAP6iO8JOcFiOykA2W+JkXNArvpGAQ79yAmEThK7BsBTP29R3E7Vc+
	jR7Bzlal7SeqoXMMmcrn0E68VWJenK2VSecBo+b9sWmN5orYZIFuD6SAKUhwNbY6ZeA99LgAjckPI
	tMkRCsR6u+yrGzfUbsXkLtIYkYy+6VFKrRt413liaZfZ+9+juERhyj9RY2R/3CFN0fL2CTE8ASrjS
	4F4/INdd8Ao5+at+5fDV7kbP4ROJkNX8Wigg3fN6c9Z6XrBRXYDeUuFi0gyvojzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1soJlm-00000008bQt-2z8X;
	Wed, 11 Sep 2024 11:36:14 +0200
Message-ID: <5673aab17fa4e6bbba5b286f29b0558726305155.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: nl80211: add link id of transmitted profile
 for MLO MBSSID
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>, Aloka Dixit <quic_alokad@quicinc.com>
Date: Wed, 11 Sep 2024 11:36:13 +0200
In-Reply-To: <20240910204538.4077640-2-quic_msinada@quicinc.com>
References: <20240910204538.4077640-1-quic_msinada@quicinc.com>
	 <20240910204538.4077640-2-quic_msinada@quicinc.com>
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

On Tue, 2024-09-10 at 13:45 -0700, Muna Sinada wrote:
>=20
> For MLO MBSSID, if the transmitted profile if part of an MLD, then the
> transmitted profile is a specific link of that MLD. Utilizing only Tx
> index is no longer sufficient to identify transmitted profile for MLO.

"Tx index"? Did you mean "interface index" or something?

> Add a new attribute to specify link id of the transmitted profile of
> MBSSID group if the profile is part of an MLD. It is required to map
> the nontransmitted link with corresponding transmitted link.

s/with/to/ or something?

>   * @tx_wdev: pointer to the transmitted interface in the MBSSID set
> + * @tx_link_id: link ID of the transmitted interface if it is part of an=
 MLD.

document the value for non-MLO?

>   * @index: index of this AP in the multi bssid group.
>   * @ema: set to true if the beacons should be sent out in EMA mode.
>   */
>  struct cfg80211_mbssid_config {
>  	struct wireless_dev *tx_wdev;
> +	int tx_link_id;
>  	u8 index;
>  	bool ema;
>  };
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index f97f5adc8d51..6bd46b4998c9 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -7987,6 +7987,10 @@ enum nl80211_sar_specs_attrs {
>   *	Setting this flag is permitted only if the driver advertises EMA supp=
ort
>   *	by setting wiphy->ema_max_profile_periodicity to non-zero.
>   *
> + * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Mandatory parameter for a non=
-transmitted
> + *	profile which provides the link ID (u8) of the transmitted profile wh=
en the latter
> + *	is part of an MLD.

It's probably better to rewrite this, the qualification of the first
word ("mandatory") comes at the very end of the sentence. German
speakers are probably used to that, but otherwise it seems a bit hard to
understand? ;)

> +	[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID] =3D
> +				NLA_POLICY_MAX(NLA_U8, IEEE80211_MLD_MAX_NUM_LINKS),

why not just indent one tab?

> @@ -5477,6 +5479,8 @@ static int nl80211_parse_mbssid_config(struct wiphy=
 *wiphy,
>  				       u8 num_elems)
>  {
>  	struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
> +	struct net_device *tx_netdev =3D NULL;
> +	int err =3D -EINVAL;

I don't much like this pattern of initializing the error first, can't
you initialize it in every place? I even wondered looking at the below
if it was correct everywhere.

>  	if (!wiphy->mbssid_max_interfaces)
>  		return -EOPNOTSUPP;
> @@ -5509,9 +5513,7 @@ static int nl80211_parse_mbssid_config(struct wiphy=
 *wiphy,
>  			return -EINVAL;
> =20
>  		if (tx_ifindex !=3D dev->ifindex) {
> -			struct net_device *tx_netdev =3D
> -				dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
> -
> +			tx_netdev =3D dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
>  			if (!tx_netdev || !tx_netdev->ieee80211_ptr ||
>  			    tx_netdev->ieee80211_ptr->wiphy !=3D wiphy ||
>  			    tx_netdev->ieee80211_ptr->iftype !=3D
> @@ -5530,7 +5532,28 @@ static int nl80211_parse_mbssid_config(struct wiph=
y *wiphy,
>  		return -EINVAL;
>  	}
> =20
> +	config->tx_link_id =3D 0;
> +	if (config->tx_wdev->valid_links) {
> +		if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
> +			goto err;
> +
> +		config->tx_link_id =3D nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LIN=
K_ID]);
> +		if (!(config->tx_wdev->valid_links & BIT(config->tx_link_id))) {
> +			err =3D -ENOLINK;
> +			goto err;
> +		}
> +	} else if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]) {
> +		goto err;
> +	}
> +
>  	return 0;
> +
> +err:
> +	if (tx_netdev) {
> +		config->tx_wdev =3D NULL;
> +		dev_put(tx_netdev);
> +	}

Why not use config->tx_wdev and avoid changes around tx_netdev?

There's also an existing error path that does dev_put(), so you should
unify that.

johannes

