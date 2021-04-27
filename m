Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D3736C0AC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 10:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhD0INj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 04:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhD0INi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 04:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619511174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SiYctwTe5i2KDXxaksxLTUtLgydwhlO+q4SO9irAoxA=;
        b=DpGb1kGN2yuBRD3FhQEfwj/LrJhis3iJqUt87cwRUje8szTdIn3V3cTJVWMcZ7Le0xBnIA
        sOZKtmaeH0UQrc0RFSf9FmYMuf8BHXsL03ujB4VKQi//9EOUV7qSwPUt/2ZJHy3qvHs3iF
        RBrLzEsIGVOXUvzpJGh80ETVT83/2I8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-aplaVs8rPV-vd2djDuP08A-1; Tue, 27 Apr 2021 04:12:51 -0400
X-MC-Unique: aplaVs8rPV-vd2djDuP08A-1
Received: by mail-ej1-f70.google.com with SMTP id n13-20020a170906b30db029038ec026319aso1561213ejz.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Apr 2021 01:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SiYctwTe5i2KDXxaksxLTUtLgydwhlO+q4SO9irAoxA=;
        b=SP01C4UeEXLEy+9ncOzCeKykftRKI+/Ku+s4qk/NQoCeR4fuzzA6bft425mHT+d2ZE
         hv3c5VWcRZAp5E/L+NpOIABUIo4CfOjd1cuiz7safeGzdrD2lPACyj1AzG8rXQ+4HpP4
         gUHrhxFEd1YgorGNHJV0WD/JcpMrnw5Ht06Ox9rJsfOvRwt0xzjyj929dT9h/pkMrPgu
         5r/YaBVNO1S02b9pzNJ9/2mpql/bXwXIkZKd67D7aGEKtt/BFKvAQKk7S6m4NJRPbYcu
         KHdfv/L744K+qeTTL9zBLf4nBubRf+QMsN8fPcKnm/Tc/tl/TleKArAjN9mHETSZMXJT
         7/VQ==
X-Gm-Message-State: AOAM5311/UoEQyl5ghd/NXQmtQXZ0immijusaKCnKFba322ROars5Pym
        OgluLzZ7LOlq2uRtQbrcTKVzg5+Kt8C5QLzbT7Lcf8rod8szG+XQgeY81bnl+SZU8M5nv3ELL8v
        t2D6ChU3BATlijeMSARCCeR8T6J8=
X-Received: by 2002:a17:906:a017:: with SMTP id p23mr22649645ejy.460.1619511170464;
        Tue, 27 Apr 2021 01:12:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZlfwMstp/CiemD9GPBlDqRtHbbZ+zfzP5hC6bxcB2k6kTlac1UNxQ4XfJLVC58lCcHrhavg==
X-Received: by 2002:a17:906:a017:: with SMTP id p23mr22649633ejy.460.1619511170289;
        Tue, 27 Apr 2021 01:12:50 -0700 (PDT)
Received: from localhost ([151.66.28.185])
        by smtp.gmail.com with ESMTPSA id f3sm12601516eje.45.2021.04.27.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 01:12:49 -0700 (PDT)
Date:   Tue, 27 Apr 2021 10:12:43 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mac80211: minstrel_ht: fix minstrel_aggr_check for encap
 offload
Message-ID: <YIfHe6d5IskhogTX@lore-desk>
References: <d5303cd9935a9a2f44b76070d191e753895da516.1619489753.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="83y9azwuOsjwp1b/"
Content-Disposition: inline
In-Reply-To: <d5303cd9935a9a2f44b76070d191e753895da516.1619489753.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--83y9azwuOsjwp1b/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Avoid checking ieee80211_hdr to support encap offload.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  net/mac80211/rc80211_minstrel_ht.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_mi=
nstrel_ht.c
> index ecad9b10984f..02a6648aba54 100644
> --- a/net/mac80211/rc80211_minstrel_ht.c
> +++ b/net/mac80211/rc80211_minstrel_ht.c
> @@ -1180,20 +1180,19 @@ minstrel_downgrade_rate(struct minstrel_ht_sta *m=
i, u16 *idx, bool primary)
>  static void
>  minstrel_aggr_check(struct ieee80211_sta *pubsta, struct sk_buff *skb)
>  {
> -	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *) skb->data;
>  	struct sta_info *sta =3D container_of(pubsta, struct sta_info, sta);
>  	u16 tid;
> =20
>  	if (skb_get_queue_mapping(skb) =3D=3D IEEE80211_AC_VO)
>  		return;
> =20
> -	if (unlikely(!ieee80211_is_data_qos(hdr->frame_control)))
> +	if (unlikely(!pubsta->wme))

I guess we are changing the behaviour here since the check is done per-pack=
et
and non per-sta

Regards,
Lorenzo

>  		return;
> =20
>  	if (unlikely(skb->protocol =3D=3D cpu_to_be16(ETH_P_PAE)))
>  		return;
> =20
> -	tid =3D ieee80211_get_tid(hdr);
> +	tid =3D skb->priority & IEEE80211_QOS_CTL_TID_MASK;
>  	if (likely(sta->ampdu_mlme.tid_tx[tid]))
>  		return;
> =20
> --=20
> 2.18.0
>=20

--83y9azwuOsjwp1b/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYIfHeAAKCRA6cBh0uS2t
rJ40AP9s6SLk4IcjrZzQrwyK7qXNgfz7YsCNihD0/e/z6jszdgD8CnpJET02ahT0
lLNlUKno+70LFeDa4y8N6vJVnne3YQ4=
=So7w
-----END PGP SIGNATURE-----

--83y9azwuOsjwp1b/--

