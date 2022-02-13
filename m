Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B124B3C7E
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Feb 2022 18:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiBMRWJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Feb 2022 12:22:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiBMRWJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Feb 2022 12:22:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A7DB59395
        for <linux-wireless@vger.kernel.org>; Sun, 13 Feb 2022 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644772922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UEbNs2LWwc8c6HkSKwc+PmwK7oT5oIHIc4Lc+WeqQ8g=;
        b=DZ5mN7h99ZIKAxpzhvV+3nk/dzkGnxmYgvfIyXCA8ZTOttK3AXpU+acROY02PLqjsLVlwi
        x2XUU8I9hauN0M+VDCB2IJ55MVlWe0+wb+pVN5V7y5MbbSYzRaxGTlmebaoNy0k5hLnAMU
        7yGZj9eZ26XGkHQWFGLXpFw1PZZnqcM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-xkjlLXtaPI67J0NTVtv8zA-1; Sun, 13 Feb 2022 12:22:01 -0500
X-MC-Unique: xkjlLXtaPI67J0NTVtv8zA-1
Received: by mail-ed1-f69.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso8798948edb.5
        for <linux-wireless@vger.kernel.org>; Sun, 13 Feb 2022 09:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UEbNs2LWwc8c6HkSKwc+PmwK7oT5oIHIc4Lc+WeqQ8g=;
        b=ev+5BUFWY2vyV3x0ZqeK3LH+jwVFX/3Og3QZepWAQ2GlK3XNWoR1b3EmtbnfOeaK0a
         84JeY6f2lGVfr/RzfTmnpPaSNWJRkBJ3U9+ZudmK3+Bt75tKaDCbJcw6TFZfR+tTnTVX
         qEtyUrRF91cCtEYQSMi37yZriY2ogwMu9WR8K9ZR4nHX5AC1Uxrd6+njR1alDxa+iukp
         oioJxm5PVTudYhJYQ1+3DJC8TTS/es3WKHQ5MaBhD5TWRAnX7U86eFaMo42T2x6BG9xu
         ai4ZMWd/fYFOg5RWWeGVvrDnunKUKt2ngq0JImL6k2gLCG9Prz30cGyzBBblpxuPTr1h
         smOw==
X-Gm-Message-State: AOAM533ej6ra4kVcYXvrSAy3qHc0TuaGzuldBcbQiI5Z69VCJYEQ8oBd
        9g9ONiJLRgolu1fb86Ya/6dRg/zhOhexjo66l44XYkkqHqVqUWYsDYVc6EhM2Rnpp12+yUzORN3
        bJ45hGFdql6i9Cwsjb0k9w8zna54=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr11157700edf.299.1644772919996;
        Sun, 13 Feb 2022 09:21:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzm2+oPdfL9M99wCEDq6LEFXqQwRvwvCmvp8h/JKCBasrO95D3J7apVIuCBZkDobUhp79bgA==
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr11157688edf.299.1644772919773;
        Sun, 13 Feb 2022 09:21:59 -0800 (PST)
Received: from localhost (net-37-182-17-113.cust.vodafonedsl.it. [37.182.17.113])
        by smtp.gmail.com with ESMTPSA id 5sm1116256ejr.144.2022.02.13.09.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 09:21:59 -0800 (PST)
Date:   Sun, 13 Feb 2022 18:21:57 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Chad Monroe <chad.monroe@smartrg.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: connac: adjust wlan_idx size from u8 to u16
Message-ID: <Ygk+NbOPnIzphMSd@lore-desk>
References: <a0644f7da6ba09195ee247a5affa562179328207.1644688718.git.chad.monroe@smartrg.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hPEQp+DxvyZdzxkr"
Content-Disposition: inline
In-Reply-To: <a0644f7da6ba09195ee247a5affa562179328207.1644688718.git.chad.monroe@smartrg.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--hPEQp+DxvyZdzxkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thx for fixing it.
I guess we can add the following Fixes tag:

Fixes: 49126ac1f8d26 ("mt76: connac: move mt76_connac_mcu_bss_basic_tlv in =
connac module")

Anyway:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Newer chips such as MT7915 require up to 16-bits for this field.
>=20
> Signed-off-by: Chad Monroe <chad.monroe@smartrg.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index cdd82a62eeb1..f3fdd755a3bb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -2656,7 +2656,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_ext_tlv);
>  int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
>  				  struct ieee80211_vif *vif,
>  				  struct ieee80211_sta *sta,
> -				  struct mt76_phy *phy, u8 wlan_idx,
> +				  struct mt76_phy *phy, u16 wlan_idx,
>  				  bool enable)
>  {
>  	struct mt76_vif *mvif =3D (struct mt76_vif *)vif->drv_priv;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index 7b9d82dd3f9d..384c3eab1c8a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1642,7 +1642,7 @@ void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *s=
kb,
>  int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
>  				  struct ieee80211_vif *vif,
>  				  struct ieee80211_sta *sta,
> -				  struct mt76_phy *phy, u8 wlan_idx,
> +				  struct mt76_phy *phy, u16 wlan_idx,
>  				  bool enable);
>  void mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif=
 *vif,
>  			       struct ieee80211_sta *sta);
> --=20
> 2.32.0 (Apple Git-132)
>=20

--hPEQp+DxvyZdzxkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYgk+NQAKCRA6cBh0uS2t
rMpAAQDwkrw5UKBqElKj8k80s9mWHyVwxadFBsfy8U6ooKJmBQEAuSFOvB0uw5sh
zVa82nYMLMqqBE86wcSD5HIMM/cgrwA=
=A9mv
-----END PGP SIGNATURE-----

--hPEQp+DxvyZdzxkr--

