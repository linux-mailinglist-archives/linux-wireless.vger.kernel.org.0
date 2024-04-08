Return-Path: <linux-wireless+bounces-5976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A2A89CBAC
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 20:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2251F250DF
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF014387B;
	Mon,  8 Apr 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TUOcW3Rb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497625753
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600744; cv=none; b=C7PTgOZ/ObYPaB6VTH4xOTjmb/dadKfa/4D6DIVw1v/1ISUQzVQTZcpgJsHzFdpAnZcLUN3jrE2mhJqr/JAYQpv5G0OKYSd5F5YaqIk9ZE2/u0e/PcUmPQSh7gGXxH4rNCMbc6obOZtKhmugCyj4CkjLPTyZgdnKwEFUafFLTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600744; c=relaxed/simple;
	bh=Q5m5h3quhuSrxH08rhRroOZt0p0cTu5ndrZDFbeUdoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MbUDPztm66uwMR5qlBIolzzLAZwQLmqsxVM6KeO8NPTXk0wUxdVBbZ7RcsWiabyeeAO1Nivd9Cam70jCDzYNtcChRYlKx7jvikIwv97pXRePcUdXoNKgpAOniUGYsIH2pDckzqAFM0ruqC1Fs+UHJXnB6+YnAz2dCUy+zVafoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TUOcW3Rb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=k2upalmWZ47sm344cEgbc/l4mZiDYCyFPZzcpJM614Q=;
	t=1712600741; x=1713810341; b=TUOcW3Rb+dlbs0r52eNhT3cH4w6nsonZqeVKOxMX+Cq2AAV
	yXWnAfbRVI/Gp5bwl25iBi01AiK8btVwLuCYlHZe9z+GttnhN4GGFUtvnBcGNUZAPLR13AM2XNZ6D
	ySVyXcLAN8FRi/Ueq9n7vCy2Py+XryYh0EOMrGvsJfD0sgCfW9Irqc3JKFyzNqksW0F/qMxK/HUVe
	U5OzM9APZq8o0tDt6kAtSFgVakGXsAXayccVdq4XO9jt7zpbr8njzQ83+u3ajHykkWXIzSKEPrUKK
	I5ly63Gqdmgh9RJYfNb/CTig6it14sFxk6te5IDaIOwxp4pqCxjthNTzwp112XkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rttgX-0000000GQAW-0OdJ;
	Mon, 08 Apr 2024 20:25:37 +0200
Message-ID: <bae1e71edcc13e73e8ef7f24d30140a4a6aefb98.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: handle sdata->u.ap.active flag with MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 08 Apr 2024 20:25:36 +0200
In-Reply-To: <20240326151141.3824454-1-quic_adisi@quicinc.com>
References: <20240326151141.3824454-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-26 at 20:41 +0530, Aditya Kumar Singh wrote:

> @@ -1232,7 +1256,9 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_dat=
a *sdata,
>  	}
> =20
>  	rcu_assign_pointer(link->u.ap.beacon, new);
> -	sdata->u.ap.active =3D true;
> +
> +	if (ieee80211_num_beaconing_links(sdata) <=3D 1)
> +		sdata->u.ap.active =3D true;

I don't understand this change. Neither the <=3D 1 really, nor the fact
that you actually _make_ this change.

> @@ -1486,7 +1488,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy,=
 struct net_device *dev,
>  		if (old)
>  			kfree_rcu(old, rcu_head);
>  		RCU_INIT_POINTER(link->u.ap.beacon, NULL);
> -		sdata->u.ap.active =3D false;
> +
> +		if (!ieee80211_num_beaconing_links(sdata))
> +			sdata->u.ap.active =3D false;

=3D=3D 0 maybe?

Or maybe we should just save/restore the value instead?

>  	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
>  		netif_carrier_off(vlan->dev);
> =20
> -	if (ieee80211_num_beaconing_links(sdata) <=3D 1)

Unrelated, but it looks like the VLAN netif_carrier_off() handling above
is also wrong and should really go into this if block as well.

johannes

