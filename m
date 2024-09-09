Return-Path: <linux-wireless+bounces-12706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD6D972404
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 22:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7691C21E42
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 20:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46F18A948;
	Mon,  9 Sep 2024 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="qzrb3Bc0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EEA18A937;
	Mon,  9 Sep 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915336; cv=none; b=Od6jutp+Uuz1urfpS6DP94p3lb2FH+d9jowgEfXf4NF9rzMEWODAMTcOdH7uE7B1EKyJKViPn93cCd9dxDHBHNCJ0j+aMWDdCymZFNcOxCPbhtVUpvKbikqfxaaCO8hc+/1U3YCZnt9zO3Y0XNo3aUnKJuGfWqfDq7+m7vNB+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915336; c=relaxed/simple;
	bh=VeBte4Hk/bSsPKA+NLFx686zngoHrq/S/DH0gseidn0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QVcbZ9ettkNTNaw96Qv5lRnyVkBx6JkGSx0PS17Lkm0SaBTR5D/e7d0J6n6R8QTEqsBbUgfdudqWnP5yBMpEfcoQVbEGlDuW35XISa0q9L2B0pTRgqfS53Bb7EMtfJj08XgxYAh0hAiBZFhwaIAge5rb033sgpI4PcKCiSWwsiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=qzrb3Bc0; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from [127.0.0.1] (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1EFBA1F9CA;
	Mon,  9 Sep 2024 22:55:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725915329;
	bh=ha+UjDZ4cSJCf/e8Vp6EQ5ssSEtu7b+FJNVTZqCXUqM=; h=From:To:Subject;
	b=qzrb3Bc0qXYqaiFv9IL1EwHsC01fNlIEm/uPBFRxGV+9KrzEDnrcadQDZmPjquvWO
	 +xTJjzs0Kt7xDCNJtA/EgmiN9jPTZZx6PekGezEaFb6V6M+Q0fBMoGEwWGCOV+jeqg
	 bw1u2iV64+FjxQzkn5pBzz86RRF6Ir/zUUNrn6aKQRTtDUDpVkrfF/Kv88s+8wuVTI
	 ZYJTU5mznOvZc4v9hd5NsiU9Fx1iwdI3hyqXi2UFQMkAHjRyO9mah9rE8UOk4LRDf8
	 3xDd47HJ6lxPA3GGC+BKhbKxQKdoSDzv1k31+Eh/NZv2jpd8N+gq/H+3n/nD7FJycs
	 44rs4NLSXegrg==
Date: Mon, 09 Sep 2024 22:55:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_11/12=5D_wifi=3A_mwifiex=3A_mov?=
 =?US-ASCII?Q?e_common_settings_out_of_switch/case?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Zt9Y1fe-Q9cHY_s5@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de> <20240826-mwifiex-cleanup-1-v1-11-56e6f8e056ec@pengutronix.de> <Zt8rv-nOERIac4T9@gaggiata.pivistrello.it> <Zt9Y1fe-Q9cHY_s5@pengutronix.de>
Message-ID: <A4592F41-FC96-4F0A-B6B3-911683773833@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Il 9 settembre 2024 22:21:41 CEST, Sascha Hauer <s=2Ehauer@pengutronix=2Ede=
> ha scritto:
>On Mon, Sep 09, 2024 at 07:09:19PM +0200, Francesco Dolcini wrote:
>> On Mon, Aug 26, 2024 at 01:01:32PM +0200, Sascha Hauer wrote:
>> > In mwifiex_add_virtual_intf() several settings done in a switch/case
>> > are the same in all cases=2E Move them out of the switch/case to
>> > deduplicate the code=2E
>> >=20
>> > Signed-off-by: Sascha Hauer <s=2Ehauer@pengutronix=2Ede>
>> > ---
>> >  drivers/net/wireless/marvell/mwifiex/cfg80211=2Ec | 16 +++++--------=
---
>> >  1 file changed, 5 insertions(+), 11 deletions(-)
>> >=20
>> > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211=2Ec b/driv=
ers/net/wireless/marvell/mwifiex/cfg80211=2Ec
>> > index 8746943c17788=2E=2E2ce54a3fc32f8 100644
>> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211=2Ec
>> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211=2Ec
>> > @@ -3005,7 +3005,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(s=
truct wiphy *wiphy,
>> >  			return ERR_PTR(-EFAULT);
>> >  		}
>> > =20
>> > -		priv->wdev=2Ewiphy =3D wiphy;
>> >  		priv->wdev=2Eiftype =3D NL80211_IFTYPE_STATION;
>> > =20
>> >  		if (type =3D=3D NL80211_IFTYPE_UNSPECIFIED)
>> > @@ -3014,8 +3013,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(s=
truct wiphy *wiphy,
>> >  			priv->bss_mode =3D type;
>> > =20
>> >  		priv->bss_type =3D MWIFIEX_BSS_TYPE_STA;
>> > -		priv->frame_type =3D MWIFIEX_DATA_FRAME_TYPE_ETH_II;
>> > -		priv->bss_priority =3D 0;
>> >  		priv->bss_role =3D MWIFIEX_BSS_ROLE_STA;
>> > =20
>> >  		break;
>> > @@ -3035,14 +3032,10 @@ struct wireless_dev *mwifiex_add_virtual_intf=
(struct wiphy *wiphy,
>> >  			return ERR_PTR(-EFAULT);
>> >  		}
>> > =20
>> > -		priv->wdev=2Ewiphy =3D wiphy;
>> >  		priv->wdev=2Eiftype =3D NL80211_IFTYPE_AP;
>> > =20
>> >  		priv->bss_type =3D MWIFIEX_BSS_TYPE_UAP;
>> > -		priv->frame_type =3D MWIFIEX_DATA_FRAME_TYPE_ETH_II;
>> > -		priv->bss_priority =3D 0;
>> >  		priv->bss_role =3D MWIFIEX_BSS_ROLE_UAP;
>> > -		priv->bss_started =3D 0;
>> >  		priv->bss_mode =3D type;
>> > =20
>> >  		break;
>> > @@ -3062,7 +3055,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(s=
truct wiphy *wiphy,
>> >  			return ERR_PTR(-EFAULT);
>> >  		}
>> > =20
>> > -		priv->wdev=2Ewiphy =3D wiphy;
>> >  		/* At start-up, wpa_supplicant tries to change the interface
>> >  		 * to NL80211_IFTYPE_STATION if it is not managed mode=2E
>> >  		 */
>> > @@ -3075,10 +3067,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(=
struct wiphy *wiphy,
>> >  		 */
>> >  		priv->bss_type =3D MWIFIEX_BSS_TYPE_P2P;
>> > =20
>> > -		priv->frame_type =3D MWIFIEX_DATA_FRAME_TYPE_ETH_II;
>> > -		priv->bss_priority =3D 0;
>> >  		priv->bss_role =3D MWIFIEX_BSS_ROLE_STA;
>> > -		priv->bss_started =3D 0;
>> > =20
>> >  		if (mwifiex_cfg80211_init_p2p_client(priv)) {
>> >  			memset(&priv->wdev, 0, sizeof(priv->wdev));
>> > @@ -3092,6 +3081,11 @@ struct wireless_dev *mwifiex_add_virtual_intf(=
struct wiphy *wiphy,
>> >  		return ERR_PTR(-EINVAL);
>> >  	}
>> > =20
>> > +	priv->wdev=2Ewiphy =3D wiphy;
>> > +	priv->bss_priority =3D 0;
>> > +	priv->bss_started =3D 0;
>>=20
>> This was not set before in all the 3 cases=2E Irrelevant? Worth checkin=
g and/or
>> mentioning in the commit message?
>
>bss_started is only used in AP mode, its value is irrelevant in station
>or adhoc mode=2E I'll add that to the commit message=2E

ack=2E

With this clarified in the commit message adds my reviewed-by



