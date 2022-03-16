Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8F4DB6ED
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 18:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbiCPRMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbiCPRMV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 13:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF6E412AEF
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647450665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XlihbDg7cQ33/RZefEfKPqV6TU+bN7s1DmA66a15ROQ=;
        b=XeT4F1QRja/M4SRMgILUwxajtxyi/3DiWxlDmHNPPEZvHZeEfRHxncNgUrlN9KoJttj+zx
        qHJaT1UMplBlf4sm3/tUwprlXWxCldg2rY9kLEcbnIqij7Ow0RQ+SzvtR880K4tcPcUfmX
        H3pM6oH9Q9LDVCHyT5o+nL+lvGtRaAI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-7WIT5sbLPUyBotF5Ysj5nA-1; Wed, 16 Mar 2022 13:11:04 -0400
X-MC-Unique: 7WIT5sbLPUyBotF5Ysj5nA-1
Received: by mail-ed1-f70.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so1693335edw.7
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 10:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XlihbDg7cQ33/RZefEfKPqV6TU+bN7s1DmA66a15ROQ=;
        b=1D14duGFWLHgZWLeqVNAYNhRaG5NsSQmdIZYPBAKdKUnMTxxxzI4PQME/xrRU8RPkC
         OIFhTm6ogucpnH+3hiSLYVeBUfCjtXIj6WCnMtXlUih+08Hby3BHQniSX98axHHvU83e
         sZdBJTuT2R6a6ove5gd+QFoE/BQkTzURfaA0gDz0KqnNzLiGueT+oIW7wKPK2hke0ka4
         yvIt2KgNwKHzABUaa81vspa0lB+TRmJUabGlMblMosAQYVUGaSeA3e0IchjYOw4cpfs4
         NduWlk7hjTfStueD+sOX/Fnwkat+1UWlyyTQ7xS2vm5FUNwzltrHKorwMeflgacYDnYz
         3kLA==
X-Gm-Message-State: AOAM530dqiqIRi7+Gl3bRuDvlH5RjsFummXFtTBGtgHuJSCi9YQ+wga/
        DS5mexsGY54QTtETOz7KnFDDQoBmHOkFwyROUOP37roYU0IqHepI4NfI3HLGgiMT2/daXFmWo66
        T24ruHEASVhQk4h7FyRVYD2dhgTI=
X-Received: by 2002:a17:906:b157:b0:6d0:9f3b:a6aa with SMTP id bt23-20020a170906b15700b006d09f3ba6aamr768774ejb.365.1647450662572;
        Wed, 16 Mar 2022 10:11:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysl79FB4NHENPw2CZv5ieSfCIyiyw42T7IAMHdtSiDaQ+TpF1nG90KDDu4PzrUVmXRwdp87A==
X-Received: by 2002:a17:906:b157:b0:6d0:9f3b:a6aa with SMTP id bt23-20020a170906b15700b006d09f3ba6aamr768755ejb.365.1647450662360;
        Wed, 16 Mar 2022 10:11:02 -0700 (PDT)
Received: from localhost (mob-31-159-59-198.net.vodafone.it. [31.159.59.198])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm1295682edt.70.2022.03.16.10.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 10:11:01 -0700 (PDT)
Date:   Wed, 16 Mar 2022 16:15:36 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Deren Wu <Deren.Wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: fix monitor rx FCS error in DFS channel
Message-ID: <YjH/GCCfQoZ5OPPM@localhost.localdomain>
References: <7243650f3d51b1919bd4fd0017ff8b0186149e54.1647421054.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qGeKCzL1sC2OXSsX"
Content-Disposition: inline
In-Reply-To: <7243650f3d51b1919bd4fd0017ff8b0186149e54.1647421054.git.deren.wu@mediatek.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--qGeKCzL1sC2OXSsX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> When setup monitor mode in DFS channel, mt76 send CH_SWITCH_DFS to
> fw for channel config. This would cause rx performance bad while
> monitoring frames. Settings CH_SWITCH_NORMAL in monitor mode would
> get the same performance as normal channels.

Hi Deren,

>=20
> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 ++-
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 3 ++-
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index 390add3144c2..97e2a85cb728 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -2151,7 +2151,8 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy=
, int cmd)
>  		.center_chan2 =3D ieee80211_frequency_to_channel(freq2),
>  	};
> =20
> -	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH))
> +	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH) ||
> +	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)

is this patch compliant with 802.11h DFS standard?

Regards,
Lorenzo

>  		req.switch_reason =3D CH_SWITCH_NORMAL;
>  	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
>  		req.switch_reason =3D CH_SWITCH_SCAN_BYPASS_DPD;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index 10dc4bf5adec..c56d48342aaf 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2833,7 +2833,8 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy=
, int cmd)
>  	}
>  #endif
> =20
> -	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH))
> +	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH) ||
> +	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
>  		req.switch_reason =3D CH_SWITCH_NORMAL;
>  	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
>  		req.switch_reason =3D CH_SWITCH_SCAN_BYPASS_DPD;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 5ef8b24f0ab3..da2be050ed7c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -863,7 +863,8 @@ int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, =
int cmd)
>  	else
>  		req.channel_band =3D chandef->chan->band;
> =20
> -	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH))
> +	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH) ||
> +	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
>  		req.switch_reason =3D CH_SWITCH_NORMAL;
>  	else if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
>  		req.switch_reason =3D CH_SWITCH_SCAN_BYPASS_DPD;
> --=20
> 2.18.0
>=20

--qGeKCzL1sC2OXSsX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYjH/DwAKCRA6cBh0uS2t
rF9YAP9Ox9jPWfxbiA2T4XjcII2rxrXGYiAg+x0hhromc9pEBgD/R4XK+Ueyo2R0
7wp0X4yKB541uW2Kv6Kia5CQkbKOqwg=
=dB/z
-----END PGP SIGNATURE-----

--qGeKCzL1sC2OXSsX--

