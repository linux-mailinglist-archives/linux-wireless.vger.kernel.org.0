Return-Path: <linux-wireless+bounces-14509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2C9AFCCB
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 10:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4F91F21C4C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695971B394D;
	Fri, 25 Oct 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iKzW5SW+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42042192592
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845639; cv=none; b=JlyeKf6JRxa8yq3I1/hKQnxTHAiizKS6IriCz5ZTXZQjvb7BKY4KBA1RAZ4wmgjNWb2zbQnCtMpDgiDB31qwjMglQElsYnjdHGJdZVe6hygHDhd3x0G+NKClWbia7YvcwI3doettUuIOtz7hR4DWnu/jDb3weZ9PZkVr6DQbe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845639; c=relaxed/simple;
	bh=ahEu//eBdMoY4aZf4bHJASQdKkkhTRq6DaQ/Nyitzts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hTzW8urQLGCpLrcuGtNBqOPOHx8dCw0Bi8wguWBDy7gZGhOuRikqW+AJ7y6jwjGYRiiHcsoTiLcZL9gTyiod1oCmeREAfW4eLmqKlWdnVxkfvU/y5VEF05p57/+qFL5kaxKuB6w5PrmlirwSHOODb9pOs5dEzTYqfRaWLRf8yd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iKzW5SW+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nYEuqCRkm9bFWiJqVp5zM2T65JDdtPX5F8GTbMQio50=;
	t=1729845637; x=1731055237; b=iKzW5SW+BfmZ4qP9W7QnqRx+BsxY20s9ucnzR50RY/udULi
	sptIdbgefNk2z3JxWj3jiCZ5yY63W6SlP7A+pGdYNV+XuyZpBZKu0ScD7fcYcASFLGGahjHiaiDh5
	PkNPYiuqxhWCH9CJAXxgsaGmWL2FDRVnVj9nFBCzYrSeCrjlcGNSif9eYa9OXbXpDCB5fOV1MgJP4
	wxty+xD5csQ6io6AkDYLMeJpYnOk2jIH4EeJsYbommYSwZNRVVW3s+7l5MFXqQS1vYi1y1dckxejb
	o8+LbzfmvLp8WGLO9oZu8IEWZgpec/9IW1B52PZg5L443gw1tbkXffk5CcvmCPWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4Fs1-00000004RPv-3P3V;
	Fri, 25 Oct 2024 10:40:33 +0200
Message-ID: <6d6c30a2c033d94f8691e1ac099d7205b897d30b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: nl80211: add link id of transmitted
 profile for MLO MBSSID
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>, Aloka Dixit <quic_alokad@quicinc.com>
Date: Fri, 25 Oct 2024 10:40:32 +0200
In-Reply-To: <20241025013857.2793346-2-quic_msinada@quicinc.com>
References: <20241025013857.2793346-1-quic_msinada@quicinc.com>
	 <20241025013857.2793346-2-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-10-24 at 18:38 -0700, Muna Sinada wrote:
>=20
> + * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Parameter for a non-transmitt=
ed
> + *	profile which provides the link ID (u8) of the transmitted profile wh=
en
> + *	the latter is part of an MLD. This is a mandatory parameter for a
> + *	non-transmitted profile. If transmitted profile is not part of an MLD=
,
> + *	link_id will be set to -1.

The part about it being mandatory/-1 doesn't seem true, according to the
code it needs to be not present? Which sounds like something I'd ask
for, but now I don't really remember :) Please adjust the description.

>  		if (tx_ifindex !=3D dev->ifindex) {
> -			struct net_device *tx_netdev =3D
> -				dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
> -
> -			if (!tx_netdev || !tx_netdev->ieee80211_ptr ||
> -			    tx_netdev->ieee80211_ptr->wiphy !=3D wiphy ||
> -			    tx_netdev->ieee80211_ptr->iftype !=3D
> -							NL80211_IFTYPE_AP) {
> -				dev_put(tx_netdev);
> -				return -EINVAL;
> +			config->tx_wdev =3D
> +			 dev_get_by_index(wiphy_net(wiphy), tx_ifindex)->ieee80211_ptr;
> +			if (!config->tx_wdev ||
> +			    config->tx_wdev->wiphy !=3D wiphy ||
> +			    config->tx_wdev->iftype !=3D NL80211_IFTYPE_AP) {
> +				err =3D -EINVAL;
> +				goto out;
>  			}
> -
> -			config->tx_wdev =3D tx_netdev->ieee80211_ptr;

Not sure why you change this so much? I'd argue the local variable was
used to make the code not indent so badly, it never would've been needed
for the dev_put() here either.

> +	config->tx_link_id =3D 0;
> +	if (config->tx_wdev->valid_links) {
> +		if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
> +			goto out;
> +
> +		config->tx_link_id =3D
> +			  nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]);
> +		if (!(config->tx_wdev->valid_links & BIT(config->tx_link_id))) {
> +			err =3D -ENOLINK;
> +			goto out;
> +		}

Is it valid if the dev=3D=3Dtx_wdev->netdev, but tx_link_id different? I'd
think not? Otherwise need to catch that? Or actually, move this into the
"tx_ifindex !=3D dev->ifindex" part, no?

johannes


