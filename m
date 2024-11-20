Return-Path: <linux-wireless+bounces-15527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C39D3624
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 09:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3922839ED
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF4178368;
	Wed, 20 Nov 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UemcjZ7j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8370176FB6;
	Wed, 20 Nov 2024 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093184; cv=none; b=XUviOoMLNygsASlAhgYNMho1Kho1E5AJ/zAb/+T9XHLsgHsIX/blBK8thMns+Eo8JWy6qGLsIo4PILqQkeGiur3EF6wQ2HmKbfCMqbPj0YiYBLQ5WsFt7uLgL9j460EEmfCTlp9qLhg0Bi4PicnsMYS1erngdKJbAfAUaqE+IL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093184; c=relaxed/simple;
	bh=aLc8Kf492MgjE+zyg6gQJeLIBhn15j3FbQt2OvLg/AI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c80Rlt1Lq7pEMg7+Gj6P0nsrPeXxJkNCgTwlH2sEkzFRtYW8Em3BfawXsfd8IGbF+9jJHYnB4DueZvV7VmS1G+yXxgJHfMMEcze/WMLNN6AajjX1MXSaDiCMUbsnKHOaTntOcWzRcsQWsrHANYXt5s7PNWBlcT9Iap4Dai563P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UemcjZ7j; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bRFNEAGI0aekibeSDFr0Rp1D2DibBePt8ql2pp92DS4=;
	t=1732093182; x=1733302782; b=UemcjZ7jR8/SxTdF75h78lEcsScsawZS02ySMuUOrkLag7j
	3WwNVRIiL0/aVulPd58lECTnQwF7Y7+jEEbfuvOWHJPIS1GoP/zuY5rUGMt2pAYpVgx/UaiNj5gj9
	RrgK9cBbDH/vylntzjPY6zNObzangltTWOQyxBdO/s6TjRu0m1b7t44slZpfJw6tgsSw50LcBYIcM
	egXB7ObY4K2PKX/RjIprfE90FWaifDW5x+aC/opE8Wv8rZk0z0TshBIvof6emaQ0yKwW88oWhatQW
	of/ex4u/kqePDZurUME0fuivcnX/LTqXuD4hZEpTl5GT5MTiccR0Jow3By2TjWWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tDgYl-00000009eTs-2lW2;
	Wed, 20 Nov 2024 09:59:39 +0100
Message-ID: <b28eb973d42b680db268eda1868b672264ab12be.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: fix WARN_ON during CAC cancelling
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 20 Nov 2024 09:59:38 +0100
In-Reply-To: <a074905b-34c5-4cc3-a38f-a2c4bc281e5d@quicinc.com>
References: <20241113-mlo_dfs_fix-v1-1-e4326736347b@quicinc.com>
	 <d0eb18d4a302e4be5251106fbfa8f5e10dd36477.camel@sipsolutions.net>
	 <383a616d-50c7-4538-9e94-fc8526405c94@quicinc.com>
	 <6b59e7a5f90b85dfc9146fa2cbdfe56c0a307a3e.camel@sipsolutions.net>
	 <f383c25d-fb76-4e3e-b900-7156f608bef0@quicinc.com>
	 <c30bde94d07e4984c02e0e329df7032f95b00a4a.camel@sipsolutions.net>
	 <a074905b-34c5-4cc3-a38f-a2c4bc281e5d@quicinc.com>
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

On Tue, 2024-11-19 at 11:23 +0530, Aditya Kumar Singh wrote:
>=20
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -5046,10 +5046,11 @@ static void ieee80211_del_intf_link(struct wiphy=
=20
> *wiphy,
>                                      unsigned int link_id)
>   {
>          struct ieee80211_sub_if_data *sdata =3D=20
> IEEE80211_WDEV_TO_SUB_IF(wdev);
> +       u16 new_links =3D wdev->valid_links & ~BIT(link_id);
>=20
>          lockdep_assert_wiphy(sdata->local->hw.wiphy);
>=20
> -       ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
> +       ieee80211_vif_set_links(sdata, new_links, 0);
>   }

Needing this part is sort of clear then, but maybe not entirely obvious?
Should probably be accompanied by some documentation updates.

> So I will submit this as patch then?

Seems reasonable.

> > There's necessarily going to be some temporary inconsistency here, I'm
> > not sure it matters too much if it isn't very visible?
> >=20
>=20
> Any particular case you suspect and want me to test?

No, not really.

> I'm more inclining towards the first suggestion you gave - clearing the=
=20
> bitmap later. What's your suggestion?
>=20

Sure.

johannes

