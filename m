Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BAC51BF34
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbiEEMZy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiEEMZv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 08:25:51 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B17421209B
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651753329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GshgH8iXfCF4+xTmbDXAF0RSdFsyNvlSWCbyGAs7kcQ=;
        b=DBL31m+usrIBVW2mWtCMBkOjUJaPg8me8krsOrTih5FjYy/lBFYb2QH/XAktb4pc76dY/Q
        JxX+5rogOAT4+3UGlphz/0OqGNFrmIi3zokU2esakFevzXsUp4O9/S28kSKUUKSMzJgeJY
        T2L4M4aoLkuOBFu3ONgV2M2goolXCys=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-xljDdsMcNnCZMUCbt9zKmA-1; Thu, 05 May 2022 08:22:08 -0400
X-MC-Unique: xljDdsMcNnCZMUCbt9zKmA-1
Received: by mail-qk1-f197.google.com with SMTP id 66-20020a370345000000b0069fcc5f6ac4so2700381qkd.19
        for <linux-wireless@vger.kernel.org>; Thu, 05 May 2022 05:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GshgH8iXfCF4+xTmbDXAF0RSdFsyNvlSWCbyGAs7kcQ=;
        b=rz6cehPJDyG29B8lEhlgXUbFT60jjNd9qtrMVt9GXMA4nTvtFHX/4A+Czb0yRDEVHk
         JGOEXnNfikQ3OiaLDJ/cIP1k84zV4PU7vh59BC2cxq2CnFjBjbnPnyYwEH5ssqIthQOn
         jrGpiUhPkjPnJcq90M8Elay2epkCBwp795U8ZzssiLorNk8KCRTkse56N9pRscnypR7I
         edKtakpRg61z2Xv2rAtVVQbOEgnxL79yDk6NV+B3GXnI1pWqLa+uPNNMagjk5cBIQG1O
         dVI3Bo6uTuJvXx5NzZx42mYb8Kkll8Sf7Pwo6kEqhHkVEEsn8n5nfpctFd43x0MliHF8
         16YA==
X-Gm-Message-State: AOAM530ypTTlk6jV64bxu27xjwtc4xgvmSw4lz1ixF+U9AZ18tKyn2m8
        1o8K/6NF1g8EfFGUwaP8SOkSqsLQxsdwUo3g0Y7yYiz5yjlwOusypyc99fnkVq7pVQyZtTB6UlT
        HQtvblHBBjdWMBDys5WC7/IOjVZI=
X-Received: by 2002:a05:6214:c64:b0:458:bcc:8562 with SMTP id t4-20020a0562140c6400b004580bcc8562mr21508227qvj.30.1651753327652;
        Thu, 05 May 2022 05:22:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydl/J2ua638U63TRMQFayxe4xxABq/X4Zwv/dHtE23jUUlyxFZ8iGjJ5dwL/Iw7X7LUKIZNw==
X-Received: by 2002:a05:6214:c64:b0:458:bcc:8562 with SMTP id t4-20020a0562140c6400b004580bcc8562mr21508209qvj.30.1651753327373;
        Thu, 05 May 2022 05:22:07 -0700 (PDT)
Received: from localhost (net-93-71-56-156.cust.vodafonedsl.it. [93.71.56.156])
        by smtp.gmail.com with ESMTPSA id c14-20020ac8518e000000b002f39b99f694sm742651qtn.46.2022.05.05.05.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 05:22:06 -0700 (PDT)
Date:   Thu, 5 May 2022 14:22:03 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Peter Chiu <chui-hao.chiu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/4] mt76: mt7915: reject duplicated twt flows
Message-ID: <YnPBaw1d3nA791PP@lore-desk>
References: <20220505082554.16656-1-chui-hao.chiu@mediatek.com>
 <20220505082554.16656-3-chui-hao.chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JuvCUEvvWg5UF+kk"
Content-Disposition: inline
In-Reply-To: <20220505082554.16656-3-chui-hao.chiu@mediatek.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--JuvCUEvvWg5UF+kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Reject twt flows with the same parameters to prevent some potential issues
> causing by duplicated establishment.
>=20
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index 94a1871fbf43..ff60a3d2d26d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -2601,6 +2601,34 @@ static int mt7915_mac_check_twt_req(struct ieee802=
11_twt_setup *twt)
>  	return 0;
>  }
> =20
> +static inline bool
> +mt7915_mac_twt_param_equal(struct mt7915_sta *msta,
> +			   struct ieee80211_twt_params *twt_agrt)

nit: please do not use inline in .c files.

Regards,
Lorenzo

> +{
> +	u16 type =3D le16_to_cpu(twt_agrt->req_type);
> +	u8 exp;
> +	int i;
> +
> +	exp =3D FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, type);
> +	for (i =3D 0; i < MT7915_MAX_STA_TWT_AGRT; i++) {
> +		struct mt7915_twt_flow *f;
> +
> +		if (!(msta->twt.flowid_mask & BIT(i)))
> +			continue;
> +
> +		f =3D &msta->twt.flow[i];
> +		if (f->duration =3D=3D twt_agrt->min_twt_dur &&
> +		    f->mantissa =3D=3D twt_agrt->mantissa &&
> +		    f->exp =3D=3D exp &&
> +		    f->protection =3D=3D !!(type & IEEE80211_TWT_REQTYPE_PROTECTION) &&
> +		    f->flowtype =3D=3D !!(type & IEEE80211_TWT_REQTYPE_FLOWTYPE) &&
> +		    f->trigger =3D=3D !!(type & IEEE80211_TWT_REQTYPE_TRIGGER))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  void mt7915_mac_add_twt_setup(struct ieee80211_hw *hw,
>  			      struct ieee80211_sta *sta,
>  			      struct ieee80211_twt_setup *twt)
> @@ -2634,6 +2662,9 @@ void mt7915_mac_add_twt_setup(struct ieee80211_hw *=
hw,
>  	exp =3D FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, req_type);
>  	sta_setup_cmd =3D FIELD_GET(IEEE80211_TWT_REQTYPE_SETUP_CMD, req_type);
> =20
> +	if (mt7915_mac_twt_param_equal(msta, twt_agrt))
> +		goto unlock;
> +
>  	flow =3D &msta->twt.flow[flowid];
>  	memset(flow, 0, sizeof(*flow));
>  	INIT_LIST_HEAD(&flow->list);
> --=20
> 2.18.0
>=20

--JuvCUEvvWg5UF+kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYnPBawAKCRA6cBh0uS2t
rE7yAQCwyZ8EMpuBz+ESZCMKM1SaVuEgp5HBcs74ZdVEEI3b+AD9E449nVB0v8VY
ZsqEefKcfYF7Jgq4zv0aEX8FR+2VdAE=
=3L4/
-----END PGP SIGNATURE-----

--JuvCUEvvWg5UF+kk--

