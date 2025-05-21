Return-Path: <linux-wireless+bounces-23202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BD0ABECF6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8D73BF477
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 07:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D682367C0;
	Wed, 21 May 2025 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nUwyc9Wk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9123645D
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811829; cv=none; b=tle3jFvSITjWGVD7foHtJz+SBFX8EmKTfPtkRcNsNLWjK8OWljQ7DuK3TpumDg0g6OLEQYYWGmqPo3XrZXMNCw7swiE2pccexEX7OKaBo40yMTqX0pjj8Uc7ulddSuWjMzoLHTDbo9pUokgSfNd6MBvjIpIiZ86tM9SoVoVPtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811829; c=relaxed/simple;
	bh=3VWsDIE/k6SeHPBj+Axdiv1lM5KREhu+sLI50KENhCQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rb5kB9Kcf0dnAyai72V1Ho4XKLDdWhGeT755vgAe0eEBgclrxy1TyN1La3VY7rBjvV2aXTKKc72KleFroyvBxKEfUmMk+0BJwX0va8MWsmUbcqMIBNk/acG4XuRKsr3tVuIP/Vc60FixmRpZcIHqKL0P9+qeh/K/FSkHub2LPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nUwyc9Wk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q4W9GHgRKlVuWbMEM88KOqWXNcxBFxOOGslwklSujHo=;
	t=1747811828; x=1749021428; b=nUwyc9Wkl5OXd/FbSE4WZa0GRXCDrNwNcf0CV7B1aso866n
	zEJo9bUoSVbD56Xp5+VPM0qH0KKGuvM43k6n7zdIETGfR0yjdQcn6nhKCh3uGsmPavLVTEGZeQggb
	lMjgq7pZ9qRbmQUpcNx6NbZZidpmsQVvmWXlTR8lj2XGm8Nak0dj1eNAUPgyyeleNIlVU9HWyL0xO
	YG7Fa9oOxLms/i8vlaJDSNtOS0XWj/SaO3nKqphq9jzpve95adP6tZYRSnDWkI+q3Mkl+5zraFRIX
	Kf35BpZid/aQGAePQSZE3IyzUVw85rzh7EQYJlUiYToZ4Hg+LTjFL7YnhvSGQzrA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHdhI-0000000DwiD-29oY;
	Wed, 21 May 2025 09:17:04 +0200
Message-ID: <accbd6fc15d4a22ec66fc67b4bc8f97c7b24d7fd.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 1/3] wifi: cfg80211: Add Support to Set
 RTS Threshold for each Radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 May 2025 09:17:03 +0200
In-Reply-To: <20250429040048.3356960-2-quic_rdevanat@quicinc.com>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
	 <20250429040048.3356960-2-quic_rdevanat@quicinc.com>
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

On Tue, 2025-04-29 at 09:30 +0530, Roopni Devanathan wrote:
>=20
>  #define NL80211_WIPHY_NAME_MAXLEN		64
> +#define NL80211_WIPHY_RADIO_ID_DEFAULT		-1

I pointed this out before, that doesn't belong to the API.

https://lore.kernel.org/linux-wireless/bef48349364854ba2ec42262e91b74702831=
0a1c.camel@sipsolutions.net/

Please address comments or tell me why you disagree.

> +	if (info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]) {
> +		rts_threshold =3D nla_get_u32(
> +				info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]);
> +		changed |=3D WIPHY_PARAM_RTS_THRESHOLD;
> +	}
> +
> +	if (changed) {
> +		old_rts_threshold =3D rdev->wiphy.radio_cfg[radio_id].rts_threshold;
> +
> +		rdev->wiphy.radio_cfg[radio_id].rts_threshold =3D rts_threshold;
> +
> +		result =3D rdev_set_wiphy_params(rdev, radio_id, changed);
> +		if (result)
> +			rdev->wiphy.radio_cfg[radio_id].rts_threshold =3D old_rts_threshold;
> +	}
> +
> +	return result;

nit: you could invert the "changed" test and save some indentation,
those lines are pretty long. Then you can also not initialize "result=3D0"
and "return 0" for the !changed case, which is more readable.

> +		old_radio_rts_threshold =3D kcalloc(rdev->wiphy.n_radio,
> +						  sizeof(u32),
> +						  GFP_KERNEL);
> +		if (!old_radio_rts_threshold) {
> +			kfree(old_radio_rts_threshold);
> +			return -ENOMEM;

Hmm?

Also doesn't that leak?

johannes

