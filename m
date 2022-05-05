Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE751BF37
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 14:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiEEM1a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348912AbiEEM12 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 08:27:28 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C08855522D
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651753427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcsOcEMvsqnCf6UZrePD7jQ/rSeh0SyWcmsGWJFMGXI=;
        b=gxFTf3N8VMy5t8yBFu0ZpyK0gKJ+nCrsgM8Tq5wMirseownc8V0tF93PTClWIjH3Rvxier
        aL9VIX4jji6Ic7rZ/AtufdcX8uvkuioItAb6AXapjNDjA1czjWwIu4xQX3FXLMh8WehCJ8
        KZuadmT+AwbNAGqqJeugX9Ji4rCM/NQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-FzFjOtPTOaucSUTUkPd7QA-1; Thu, 05 May 2022 08:23:46 -0400
X-MC-Unique: FzFjOtPTOaucSUTUkPd7QA-1
Received: by mail-qv1-f71.google.com with SMTP id g10-20020a0562141cca00b00456332167ffso3040608qvd.13
        for <linux-wireless@vger.kernel.org>; Thu, 05 May 2022 05:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QcsOcEMvsqnCf6UZrePD7jQ/rSeh0SyWcmsGWJFMGXI=;
        b=YmjkEqyWdd5J+DtvrXnMEQ4utVgh0cbgM9y34lBmvLrrIA8wO7STcxXFc5FAWzMZUZ
         nyAkpn0zk6WiO7NXrjRLI5ZzLJuQxHOVFMANikmAc5MpxgIVX2aZK/30op5RpGDpa3o7
         dRxAQjL2baP93MJItRWMWuhVttIx15m3vmRcHF4L2Ug9S8qeTXidRbgk+5c8EF2Ig8w9
         uFXdKZA2l0Iyx5uW5LrA5N41IEVR3se1P+dgQeUsrLcb/nv2SwjV34gCsovuFQn1EIit
         Amd603erIoYN3LlP1UEVseuH7G2XEwLaT4Tyi/HfEBCYmV9IqMKXbVNFBz4ylpkYgrQ0
         Bkwg==
X-Gm-Message-State: AOAM532DmQx5dhikxxJeHh2QGIrN7ryUEUdIgza3g531WWWSJzhG84FP
        DrZUvZdJIYYcN41WcFUnd9VW/JxwelAcNPPyqdpX85EgvsBayogayaRCsa2r5+NF3Px8oUbQ+Dc
        KfbIJZSipDU7ymCH1/SVmBlkjs9I=
X-Received: by 2002:a05:622a:155:b0:2f3:9484:c38e with SMTP id v21-20020a05622a015500b002f39484c38emr23562460qtw.494.1651753426117;
        Thu, 05 May 2022 05:23:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyJRla323wzGrhG3S0ilXmd71jkpt3k18ql7zftEjrnnjfMRtJ3Xq8s+j7dAMI8ks4/R8VFA==
X-Received: by 2002:a05:622a:155:b0:2f3:9484:c38e with SMTP id v21-20020a05622a015500b002f39484c38emr23562449qtw.494.1651753425862;
        Thu, 05 May 2022 05:23:45 -0700 (PDT)
Received: from localhost (net-93-71-56-156.cust.vodafonedsl.it. [93.71.56.156])
        by smtp.gmail.com with ESMTPSA id h16-20020ac85690000000b002f39b99f6b0sm712531qta.74.2022.05.05.05.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 05:23:45 -0700 (PDT)
Date:   Thu, 5 May 2022 14:23:43 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Peter Chiu <chui-hao.chiu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 4/4] mt76: mt7915: limit minimum twt duration
Message-ID: <YnPBz8uB6A5kAPRs@lore-desk>
References: <20220505082554.16656-1-chui-hao.chiu@mediatek.com>
 <20220505082554.16656-4-chui-hao.chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+n6cusc1+H32NyZz"
Content-Disposition: inline
In-Reply-To: <20220505082554.16656-4-chui-hao.chiu@mediatek.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--+n6cusc1+H32NyZz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The minimum twt duration supported by mt7915 is 64 according to hardware
> design. Reply station with TWT_SETUP_CMD_DICTATE if min_twt_dur smaller
> than 64.
>=20
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index ff60a3d2d26d..e912ecacb578 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -2633,6 +2633,7 @@ void mt7915_mac_add_twt_setup(struct ieee80211_hw *=
hw,
>  			      struct ieee80211_sta *sta,
>  			      struct ieee80211_twt_setup *twt)
>  {
> +#define MT7915_MIN_TWT_DUR 64

nit: can you please move MT7915_MIN_TWT_DUR in mt7915.h since we have other=
 twt
defs there?

Regards,
Lorenzo

>  	enum ieee80211_twt_setup_cmd setup_cmd =3D TWT_SETUP_CMD_REJECT;
>  	struct mt7915_sta *msta =3D (struct mt7915_sta *)sta->drv_priv;
>  	struct ieee80211_twt_params *twt_agrt =3D (void *)twt->params;
> @@ -2654,6 +2655,12 @@ void mt7915_mac_add_twt_setup(struct ieee80211_hw =
*hw,
>  	if (hweight8(msta->twt.flowid_mask) =3D=3D ARRAY_SIZE(msta->twt.flow))
>  		goto unlock;
> =20
> +	if (twt_agrt->min_twt_dur < MT7915_MIN_TWT_DUR) {
> +		setup_cmd =3D TWT_SETUP_CMD_DICTATE;
> +		twt_agrt->min_twt_dur =3D MT7915_MIN_TWT_DUR;
> +		goto unlock;
> +	}
> +
>  	flowid =3D ffs(~msta->twt.flowid_mask) - 1;
>  	le16p_replace_bits(&twt_agrt->req_type, flowid,
>  			   IEEE80211_TWT_REQTYPE_FLOWID);
> --=20
> 2.18.0
>=20

--+n6cusc1+H32NyZz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYnPBzgAKCRA6cBh0uS2t
rIDQAQDhYHrCwxPJjf+p21ntsjh+bDF1Fl6SHSsDHIwXcbhO+gEAxiJlnm+G3ce6
aoT9Jliuc4p2blzcYR4vsx5a7D8BzQs=
=/2O9
-----END PGP SIGNATURE-----

--+n6cusc1+H32NyZz--

