Return-Path: <linux-wireless+bounces-9983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2F492727D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040281F2176B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B3A14A4C7;
	Thu,  4 Jul 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IMc9RdlG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A51AC431
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083515; cv=none; b=WMCBwS9kGv86qpCZ0QygX1/MtMNiH+axtxHfgDthIXCv8Mhr9jEptHCB7EfEL6ClGn/C+FRlW8Ppys7v83UTBAcLxCGicItKV+ZHycxOw29zboEYYeMezvz7s8HiYq7kKbDaUp4tBW38LAuFfoDZbbtOkwNCX03XSK95urS5oQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083515; c=relaxed/simple;
	bh=CWFR5sn/M0D4+LpWRzhLqvMTj2hVARr/UD3MWoNH+HU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DJTD84eExlW9xmHfAfVB43f+3UyBgJr1ErcsobLxCorT3FfbbDy8y2VVaAN52HJqzqDveiSYKjJwNSSvRZizjxJ3P9Lzge49VWuXqOl0zV5l5Y4tFUaE1b0hhw93FGG5Hj+DYT0tpADgCy/ZkKdPFXs2rOLiAwoI7TyME8HpdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IMc9RdlG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ex5oIpyIFZZrzAsDmlFcKQORyCDJB0R29R0R+JGMPrA=;
	t=1720083512; x=1721293112; b=IMc9RdlG6s3dJJsVG+FnCqRX6p8a4wY9Vx/EDCylGikqLcR
	8QNd4LG9VuF5eC5oXjxYvn/JnO/YAjnFgLHz91lOcz+7ZU3cNu3zJK4sCloM7VCG6WwCP8jff+owO
	tkbZSwVCHHysFqZLt1i9iFwHIGHMhN+lnEQnfv+REjlPJjQHQYz7qfAh13mZTEM5at/W0nzNVLM0x
	wxaTfB7LI6Xn+ORWVqilaMKxFQSUlBG8CwQYdPNp5GKpJPqlVZjKSk7fHX+po0hVcFpCT+0StyY4C
	yeF0dfM4nqhYF8Eev38qUAiU956CH9+5KbYmbnayhv5pC5QgfufelhImF0V+W+gg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPIIN-0000000CGXa-254N;
	Thu, 04 Jul 2024 10:58:29 +0200
Message-ID: <2f955c9cb8828c78845dbfb6ffb7838f8a75c7ea.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: allow MBSSID Tx VAP bringup without
 MBSSID IEs
From: Johannes Berg <johannes@sipsolutions.net>
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Thu, 04 Jul 2024 10:58:26 +0200
In-Reply-To: <ad821e08-b6d7-1355-6665-e96af668bd2e@quicinc.com>
References: <20240621074038.3938005-1-quic_ssreeela@quicinc.com>
	 <dc5f37a389d05881f2b2120e0ccbb60aa64c6490.camel@sipsolutions.net>
	 <ad821e08-b6d7-1355-6665-e96af668bd2e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-07-04 at 13:01 +0530, Sowmiya Sree Elavalagan wrote:
>=20
> I agree, but based on the current hostapd implementation, this flag NL802=
11_MBSSID_CONFIG_ATTR_EMA is set only when num_bss > 1. This flag will not =
be set when we do not have any non Tx BSS.
>=20

Sure, but "based on the current hostapd implementation" isn't really
enough for the kernel to protect itself from userspace doing weird
things that it isn't prepared to handle :-)

It is, however, an argument for simply prohibiting it, I guess? If no
userspace is going to do it anyway?

> Even if this NL80211_MBSSID_CONFIG_ATTR_EMA is set when no TX BSS is pres=
ent, can just fill beacon template in 0th index of ieee80211_ema_beacons st=
ructure, if mbssid_ies are not present. =20
> Shall we handle this in mac80211 layer in ieee80211_beacon_get_ap_ema_lis=
t function like below
> =20
> ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
>                                  struct ieee80211_chanctx_conf *chanctx_c=
onf)
> {
>          ...
>=20
> -       if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt)
> -               return NULL;
> -
> -       ema =3D kzalloc(struct_size(ema, bcn, beacon->mbssid_ies->cnt),
> +       if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt) {
> +               ema =3D kzalloc(struct_size(ema, bcn, 1), GFP_ATOMIC);
> +               total_beacons =3D 1;
> +
> +       } else {
> +               ema =3D kzalloc(struct_size(ema, bcn, beacon->mbssid_ies-=
>cnt),
>                       GFP_ATOMIC);
> +               total_beacons =3D beacon->mbssid_ies->cnt;
> +       }
> +
>         if (!ema)
>                 return NULL;
> =20
> -       for (ema->cnt =3D 0; ema->cnt < beacon->mbssid_ies->cnt; ema->cnt=
++) {
> +       for (ema->cnt =3D 0; ema->cnt < total_beacons; ema->cnt++) {
>            .....
>=20

I don't know, is that really the only place? I didn't audit _all_ of it,
just looked at the first plausible code path that might be broken ...

Why can't we just prohibit it?

johannes

