Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93853A8B29
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 23:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOVht (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 17:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229782AbhFOVhs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 17:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623792943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9wuHb9IfYcLah8//k4SEZ+j3tQFnhifehV6A6sLGIeU=;
        b=M8GtaSHzMkHFhwiPjoP54xaY5hXDeYGViTy8lZPp787vOUWvZNdu/3itO3r0WOSvNH0Ztf
        mViGksmD/mJC85R0xd9Tgyo0e9Tzn2FZG1MH5FRdRhiBY3psAfaA4PvelMxOfQ+5N8GXB9
        u2Hv0gbgBQURGRnR+r02qYv6+jw+3sI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-aUnjtaJRO1mQmYpBQnoE_Q-1; Tue, 15 Jun 2021 17:35:41 -0400
X-MC-Unique: aUnjtaJRO1mQmYpBQnoE_Q-1
Received: by mail-ed1-f71.google.com with SMTP id ch5-20020a0564021bc5b029039389929f28so15346273edb.16
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jun 2021 14:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9wuHb9IfYcLah8//k4SEZ+j3tQFnhifehV6A6sLGIeU=;
        b=JtRrxtF3ANU/HbtgXoGHxBuGgeG5wSMWSfX7JBSt0gicDxQXCy+9xTzyX6s6HLTLQ8
         dyx72DvxKDlbUAIOX/uEYG+jNbSzdMxW+R76XrmW+zi4ZazNpA1Sx/hrkn9Gf0QIsd1Q
         APSoW52QlzGyMgDvOemfJ30i24u/Tc4Ygsmy3bafnp14hA2qSWAYg5VyEsxcWA/O7SeR
         8m0cA0v3A9cO/88rdkIaEK3sHLWAqBCEYGInJtEVXPztIAcwg/xW48jvHfk6CcEOIWmm
         zbBw1T1RFdSH2vwPLpJL09Wq7i3xYgaaVhuFjIB9P6pCKISTE7wW+kDF6TDsnOvkEtDb
         aSZg==
X-Gm-Message-State: AOAM5315S4CYFrjNaQQsHQPD8av3al5/ek4sb7HqgN2QQZIPjoAmZ8n5
        vGNE10Isb9loRQ9NLJBtEefAsd40DUe/sqYPRft1hZnUswvogrk7ZlENKtct49D8Ox0JVFWOXRU
        v03fiHE//r8Adn7yVg7vulEGwCgo=
X-Received: by 2002:aa7:de18:: with SMTP id h24mr231005edv.23.1623792940212;
        Tue, 15 Jun 2021 14:35:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT2P9jMqiw3WRG5vp744Zd1Y1P/0X7KxlcRSUkz5sesb2eX4H1Pe+BWQJLadvwkTkRjHvJ+w==
X-Received: by 2002:aa7:de18:: with SMTP id h24mr230995edv.23.1623792940026;
        Tue, 15 Jun 2021 14:35:40 -0700 (PDT)
Received: from localhost (net-130-25-105-72.cust.vodafonedsl.it. [130.25.105.72])
        by smtp.gmail.com with ESMTPSA id gz25sm129498ejb.0.2021.06.15.14.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:35:39 -0700 (PDT)
Date:   Tue, 15 Jun 2021 23:35:36 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: fix kernel warning when reset on vif is
 not sta
Message-ID: <YMkdKFpia2XqdqrX@lore-desk>
References: <f2fd5eab61a26c43d668cfc06d943f7bf514db36.1623792576.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="foRc1a6SDuOUPmU+"
Content-Disposition: inline
In-Reply-To: <f2fd5eab61a26c43d668cfc06d943f7bf514db36.1623792576.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--foRc1a6SDuOUPmU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> ieee80211_disconnect is only called for the staton mode.
>=20
> [  714.050429] WARNING: CPU: 1 PID: 382 at net/mac80211/mlme.c:2787
> ieee80211_disconnect+0x108/0x118 [mac80211]
> [  714.116704] Hardware name: MediaTek Asurada rev1 board (DT)
> [  714.122303] Workqueue: mt76 mt7921_mac_reset_work [mt7921e]
> [  714.127877] pstate: 20c00009 (nzCv daif +PAN +UAO)
> [  714.132761] pc : ieee80211_disconnect+0x108/0x118 [mac80211]
> [  714.138430] lr : mt7921_vif_connect_iter+0x28/0x54 [mt7921e]
> [  714.144083] sp : ffffffc0107cbbd0
> [  714.147394] x29: ffffffc0107cbbd0 x28: ffffffb26c9cb928
> [  714.152706] x27: ffffffb26c9cbd98 x26: 0000000000000000
> [  714.158017] x25: 0000000000000003 x24: ffffffb26c9c9c38
> [  714.163328] x23: ffffffb26c9c9c38 x22: ffffffb26c9c8860
> [  714.168639] x21: ffffffb23b940000 x20: ffffffb26c9c8860
> [  714.173950] x19: 0000000000000001 x18: 000000000000b67e
> [  714.179261] x17: 00000000064dd409 x16: ffffffd739cb28f0
> [  714.184571] x15: 0000000000000000 x14: 0000000000000227
> [  714.189881] x13: 0000000000000400 x12: ffffffd73a4eb060
> [  714.195191] x11: 0000000000000000 x10: 0000000000000000
> [  714.200502] x9 : ffffffd703a0a000 x8 : 0000000000000006
> [  714.205812] x7 : 2828282828282828 x6 : ffffffb200440396
> [  714.211122] x5 : 0000000000000000 x4 : 0000000000000004
> [  714.216432] x3 : 0000000000000000 x2 : ffffffb23b940c90
> [  714.221743] x1 : 0000000000000001 x0 : ffffffb23b940c90
> [  714.227054] Call trace:
> [  714.229594]  ieee80211_disconnect+0x108/0x118 [mac80211]
> [  714.234913]  mt7921_vif_connect_iter+0x28/0x54 [mt7921e]
> [  714.240313]  __iterate_interfaces+0xc4/0xdc [mac80211]
> [  714.245541]  ieee80211_iterate_interfaces+0x4c/0x68 [mac80211]
> [  714.251381]  mt7921_mac_reset_work+0x410/0x468 [mt7921e]
> [  714.256696]  process_one_work+0x208/0x3c8
> [  714.260706]  worker_thread+0x23c/0x3e8
> [  714.264456]  kthread+0x140/0x17c
> [  714.267685]  ret_from_fork+0x10/0x18
>=20
> Fixes: 0c1ce9884607 ("mt76: mt7921: add wifi reset support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

I am fine with this patch but I guess you are not using an update tree since
mt7921 supports just sta mode so far.

Regards,
Lorenzo

> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index fb4de73df701..0a2df295596a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -1269,7 +1269,8 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
>  	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
>  	struct mt7921_dev *dev =3D mvif->phy->dev;
> =20
> -	ieee80211_disconnect(vif, true);
> +	if (vif->type =3D=3D NL80211_IFTYPE_STATION)
> +		ieee80211_disconnect(vif, true);
> =20
>  	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, true);
>  	mt7921_mcu_set_tx(dev, vif);
> --=20
> 2.25.1
>=20

--foRc1a6SDuOUPmU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYMkdJAAKCRA6cBh0uS2t
rPqYAP9ZpwqChdsNQ57Mv1s+QFWyR2OtH2EpUjIASWK0veAwwgEA5Psk9BM2z6oE
UIWN41JaCtI16amahQxEh8MV9LNvuAo=
=X5lS
-----END PGP SIGNATURE-----

--foRc1a6SDuOUPmU+--

