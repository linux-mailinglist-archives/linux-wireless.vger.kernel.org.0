Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38C8330ADA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Mar 2021 11:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhCHKJX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Mar 2021 05:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231734AbhCHKJF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Mar 2021 05:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615198145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CzOMJxvMZUZvupDgYdFflYW7Y6Oequ28iaQXfd8r/v0=;
        b=Hrw/dB8y4vuse3/XL1rjCWTiLuRZOxk7IFh/lgSbA+0AX12TRSDJUeDI4i96ndDfHzXAmL
        /qy2UN2Ft20guJX7Ao6ldc2vTGNwtfJR1seBdtwv8GFFvWpO3KuvIiLhVPeJZdmGmw+Az+
        8/xNySSNu4geihJf1sQMakFZJsrPG/Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-SR44KcFeNICOCrngCFfjtA-1; Mon, 08 Mar 2021 05:09:00 -0500
X-MC-Unique: SR44KcFeNICOCrngCFfjtA-1
Received: by mail-wr1-f70.google.com with SMTP id 75so4572851wrl.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Mar 2021 02:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CzOMJxvMZUZvupDgYdFflYW7Y6Oequ28iaQXfd8r/v0=;
        b=MfwKy/unOSO3h/eSbVQwJQDMSmLy+ZblwIXe7Zg2GC/pwmcx89Y+9U4GyUa10jxYzY
         vggoNcrooiKvR8HB6/sYpxZQTwbkZXFVYrnncuEq4tb7NPUebWDk9geo8d03x9ncPYUt
         aJmLtj1JZ7DeuZ1h5iCuRFPsNjjX6+jkpRvPE5d0EtEh+uLZDqLTkq7RmYf0dRp+58V9
         Xbv+RiTMtkTD4UjTNKD4WX3TN73nKNMHcuZsAuVUmL9Qvmr+pgfeZhJuULFQdLCGeZPE
         1oSMvyWv5Mv1vdgDFTjCMd44W5BPbWojryAmej4wGB1Q6asy4Butzcx/POvY0B80fmIz
         6roQ==
X-Gm-Message-State: AOAM533mhIFtQ6uz9GtDSiWi1kG9epKmArfwLCwVbg3JOHnDUWM+mBTJ
        7jKFV97KB6GVoBEcWYDKEiWEZLDkyg4JqlyMG0A2H5vLWcTd+Mgn2PcsGX/C8vAWgt5VnDkaIBx
        YcZi3VyDDx0gs58kQUSp/JIc3v7s=
X-Received: by 2002:a5d:42d2:: with SMTP id t18mr21910440wrr.258.1615198139233;
        Mon, 08 Mar 2021 02:08:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFn43udCC5lQnzUscCYyNOG4YuVIWnndma7/6OBBNshN7k2AOdhd+SOkOD5rq09YdIDdAWFA==
X-Received: by 2002:a5d:42d2:: with SMTP id t18mr21910429wrr.258.1615198139090;
        Mon, 08 Mar 2021 02:08:59 -0800 (PST)
Received: from localhost ([151.66.54.126])
        by smtp.gmail.com with ESMTPSA id h6sm13479717wmi.6.2021.03.08.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:08:58 -0800 (PST)
Date:   Mon, 8 Mar 2021 11:08:55 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: mt7915: simplify mt7915_mac_sta_poll routine
Message-ID: <YEX3t9lVlYhi4fYj@lore-desk>
References: <db48916a553fee715fc9c0c1f83f363a01218dff.1615139832.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gFeNC2H+kRt15nxS"
Content-Disposition: inline
In-Reply-To: <db48916a553fee715fc9c0c1f83f363a01218dff.1615139832.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--gFeNC2H+kRt15nxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Drop unnecessary lock around sta_poll_list list in mt7915_mac_sta_poll
> routine.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Felix,

please let's drop this patch, as we discussed, there is a race on
list_del_init(&msta->poll_list).

Regards,
Lorenzo

> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index b3168dd3baed..cde98b86e2bb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -117,23 +117,15 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *=
dev)
> =20
>  	rcu_read_lock();
> =20
> -	while (true) {
> +	while (!list_empty(&sta_poll_list)) {
>  		bool clear =3D false;
>  		u32 addr;
> -		u16 idx;
> =20
> -		spin_lock_bh(&dev->sta_poll_lock);
> -		if (list_empty(&sta_poll_list)) {
> -			spin_unlock_bh(&dev->sta_poll_lock);
> -			break;
> -		}
>  		msta =3D list_first_entry(&sta_poll_list,
>  					struct mt7915_sta, poll_list);
>  		list_del_init(&msta->poll_list);
> -		spin_unlock_bh(&dev->sta_poll_lock);
> =20
> -		idx =3D msta->wcid.idx;
> -		addr =3D mt7915_mac_wtbl_lmac_addr(dev, idx) + 20 * 4;
> +		addr =3D mt7915_mac_wtbl_lmac_addr(dev, msta->wcid.idx) + 20 * 4;
> =20
>  		for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
>  			u32 tx_last =3D msta->airtime_ac[i];
> @@ -152,7 +144,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *de=
v)
>  		}
> =20
>  		if (clear) {
> -			mt7915_mac_wtbl_update(dev, idx,
> +			mt7915_mac_wtbl_update(dev, msta->wcid.idx,
>  					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
>  			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
>  		}
> --=20
> 2.29.2
>=20

--gFeNC2H+kRt15nxS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYEX3tQAKCRA6cBh0uS2t
rPUgAP9mTwXac/abC9K5xi4U9DfnyEvyI9YQIdK7iauSKJdXMQEAyV0k9Q0xI6/9
ZBbr2D2u0i7QYAYtnnZhR75hpGvwwgI=
=SWNr
-----END PGP SIGNATURE-----

--gFeNC2H+kRt15nxS--

