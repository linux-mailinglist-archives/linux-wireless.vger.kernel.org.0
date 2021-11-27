Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB5245FF6C
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Nov 2021 15:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhK0Osw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Nov 2021 09:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233462AbhK0Oqv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Nov 2021 09:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638024216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HYMhhSR1YoRrVgQhjjHCLmb5AD8hUPl6l2sqPb0+yok=;
        b=TXcZZY3yX1M52HqHWB5icy2uRtZxKEA6GPTLKAM1b8yAEPRigDxCOXXcdgOTzVaMzp3rrJ
        /nnbcoSOLNR/6oNgRMm+yzYF1mYatIhfXCQnQoiSJckmzS03zITnC3jMrXolnXHbJjKCEt
        zY1ElyJsDFKQbrG6M1y7/3ThMkS4ElQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-t8VvBSOuOqmPL3boma3TVg-1; Sat, 27 Nov 2021 09:43:35 -0500
X-MC-Unique: t8VvBSOuOqmPL3boma3TVg-1
Received: by mail-ed1-f70.google.com with SMTP id v10-20020aa7d9ca000000b003e7bed57968so10050508eds.23
        for <linux-wireless@vger.kernel.org>; Sat, 27 Nov 2021 06:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HYMhhSR1YoRrVgQhjjHCLmb5AD8hUPl6l2sqPb0+yok=;
        b=HK9hHtUgMsMUFZIuGcgz2Weq/wp02RzOfVi/mBTH7dmPngQb3YGVLduj4CseHxpTrn
         ZK6JH6Mav62LssDz/47iCHoEXyLY6UqRZl3naiFk6g76r5Z+/8i5MWvAfzJvFa4JI5Ga
         1gPiP6YLnCwxYKHtRG6ihT+pW+VNdYv726Ko7pzG1ngN3nRkdK24uzX1f5nhhJOeIEC7
         ce2uS+eqt2jA6FanS19CJNqfcTxPUBP8jJkc0G2VgPxhLoxJfUFe/TPQVQ69ctCdEgzK
         gUNdrY80J1puHVt9UH8ygChGY4QAXE71QfzMG4olOh8OGC/An+heDx8Deual44HyW8KZ
         IBkw==
X-Gm-Message-State: AOAM532xl8DTSVj5pokcHDOokFTrBDlSI4LIjsXPkAE+aor6DVsU/Ans
        /bQLloKU4EQty2wQGSdp+hWsG22Elky4v6g5GgunPSgNuF7Hg2z5a1SSgutXfyu/3BWwLR25JE6
        BnfAlgmu+pCBZfrr6W4aB+ymlM+k=
X-Received: by 2002:a05:6402:270d:: with SMTP id y13mr56792025edd.362.1638024213978;
        Sat, 27 Nov 2021 06:43:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySR0iTOiJpZdNLbJGIwVZczX8xknIU8gOmbM1qovIX9GeVb9xmpttQswURN4QHkgpESYk3BA==
X-Received: by 2002:a05:6402:270d:: with SMTP id y13mr56792003edd.362.1638024213824;
        Sat, 27 Nov 2021 06:43:33 -0800 (PST)
Received: from localhost (net-93-151-197-210.cust.vodafonedsl.it. [93.151.197.210])
        by smtp.gmail.com with ESMTPSA id r3sm4536270ejr.79.2021.11.27.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:43:33 -0800 (PST)
Date:   Sat, 27 Nov 2021 15:43:31 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: use correct iftype data on 6GHz cap init
Message-ID: <YaJEE0gKhZvtBs6n@lore-desk>
References: <20211126165316.1662-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zUJr3aSWbgXhvFft"
Content-Disposition: inline
In-Reply-To: <20211126165316.1662-1-shayne.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--zUJr3aSWbgXhvFft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Set 6GHz cap to iftype data which is matched to the type of
> current interface.

In this case data points to data[idx] since mt7921 supports just
NL80211_IFTYPE_STATION (please note idx =3D 0 and idx !=3D i).
Anyway this can be an issue in the future when we will add more vif_type.
Maybe we can drop Fixes tag, not sure. Anyway:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: 50ac15a511e3 ("mt76: mt7921: add 6GHz support")
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 5a64126..5540b2d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -178,7 +178,7 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80=
211_band band,
>  			if (vht_cap->cap & IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN)
>  				cap |=3D IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
> =20
> -			data->he_6ghz_capa.capa =3D cpu_to_le16(cap);
> +			data[idx].he_6ghz_capa.capa =3D cpu_to_le16(cap);
>  		}
>  		idx++;
>  	}
> --=20
> 2.25.1
>=20

--zUJr3aSWbgXhvFft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYaJEEwAKCRA6cBh0uS2t
rOIVAP9Igd1KDjdhJHQHIReTFXMdhNhWSVpGQFZXXzNLDCAFOgD+NVNS9h1ulTfi
LPxg4eCrt+xRDAzpwn5R458JiIuzdwI=
=EMib
-----END PGP SIGNATURE-----

--zUJr3aSWbgXhvFft--

