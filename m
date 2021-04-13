Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C8B35DA0C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 10:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhDMI1l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 04:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhDMI1h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 04:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618302438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jiiG8Clf8t5R+yIl4ZpFU0sMe9/ISamVusDbSNI6k/s=;
        b=Bx7egw/SLY1RPmtP3rP22BSl/TgDKpDrbdgbJ2Qvsy1Udy2vNbpGt06qvxMHAXMSuNy6/S
        PIXRztmGG7DcS/6GE4miItuwTHWQQuFAuGuSkDnnBikRL1Ghuf9EMD36zji+dCH4brfZ8x
        V1zXxGUh01Jw0ApMhQs+fN95xpZ69eI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-GAliUAxLN4WjdsAB8Xw5mg-1; Tue, 13 Apr 2021 04:27:16 -0400
X-MC-Unique: GAliUAxLN4WjdsAB8Xw5mg-1
Received: by mail-ej1-f72.google.com with SMTP id a11so4539409ejg.7
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 01:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jiiG8Clf8t5R+yIl4ZpFU0sMe9/ISamVusDbSNI6k/s=;
        b=MOVMkSbwhv5jPf/O8P6ScXeQ+bsSFXrEP8YtyJUbSGYcWflc4VydDIvSPSwlR25sxQ
         znCJXAf5BrBD6LghgqUmFHKDeIbYwUBfTunMmFFlf+GA9xltsL7Yr9DQKMGEYH8tGZKB
         26bu7jgPkItXmH/G3vqAIxRhzyTxUui86PYlA4tbMwgJbuiyKEvNhGlXQtvlXW8omT7f
         K3boRrvysua5gWCYeOB3Sh7bZrq+gtq8HgN2a0em/2nCPTIfh6/NWFTlaMtM61TrM5vV
         fXygOO/pIGwDRQulpVkiZEdHQ1hDsUiNM8dSvaGKBAmhWqDLe7zCoAulbC5i0Sn89WTe
         KGhg==
X-Gm-Message-State: AOAM532QnU0Rjd74xji1IAfCs0OCPAhs7ZtSRcVSCzAyYRwVNqo//3q4
        QR1IrLGYaXugWwGH1G9kbO1ovl448ZpoHKdhXclM2cJXkBR7kbZqqh+BdnScgpf1uN3LE4lHTY2
        YO1O/SCWYQ9c4yv9BtkzsWpcujHQ=
X-Received: by 2002:a05:6402:138f:: with SMTP id b15mr33773341edv.121.1618302434970;
        Tue, 13 Apr 2021 01:27:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMMzOkmecv9UpjR+nzuiw2opOJhJl9N62ou0TpBBs4uG6Vnnwtjh0LkwgBgEeaFpLh9KHE6g==
X-Received: by 2002:a05:6402:138f:: with SMTP id b15mr33773327edv.121.1618302434779;
        Tue, 13 Apr 2021 01:27:14 -0700 (PDT)
Received: from localhost ([151.66.38.94])
        by smtp.gmail.com with ESMTPSA id n13sm3783534ejx.27.2021.04.13.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 01:27:14 -0700 (PDT)
Date:   Tue, 13 Apr 2021 10:27:11 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: Re: [PATCH] mt76: mt7921: get rid of mt7921_dma_cleanup
Message-ID: <YHVV3xtrPueZriNR@lore-desk>
References: <a685211cdac6d961744cbbc6c9af54c177023e95.1618301684.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9fgPcQv0xKNGPojk"
Content-Disposition: inline
In-Reply-To: <a685211cdac6d961744cbbc6c9af54c177023e95.1618301684.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--9fgPcQv0xKNGPojk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Remove mt7921_dma_cleanup routine since it is no longer used
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/dma.c   | 23 -------------------
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 -
>  2 files changed, 24 deletions(-)

Hi Felix,

please ignore this patch, we need mt7921_dma_cleanup unloading the module.

Regards,
Lorenzo

>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/dma.c
> index 992faf82ad09..14e694563a89 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> @@ -331,26 +331,3 @@ int mt7921_dma_init(struct mt7921_dev *dev)
> =20
>  	return 0;
>  }
> -
> -void mt7921_dma_cleanup(struct mt7921_dev *dev)
> -{
> -	/* disable */
> -	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
> -		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
> -		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
> -		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
> -		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
> -		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
> -		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
> -
> -	/* reset */
> -	mt76_clear(dev, MT_WFDMA0_RST,
> -		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
> -		   MT_WFDMA0_RST_LOGIC_RST);
> -
> -	mt76_set(dev, MT_WFDMA0_RST,
> -		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
> -		 MT_WFDMA0_RST_LOGIC_RST);
> -
> -	mt76_dma_cleanup(&dev->mt76);
> -}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index e3d83d3d954c..1e70c749bbf3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -225,7 +225,6 @@ int mt7921_eeprom_get_target_power(struct mt7921_dev =
*dev,
>  void mt7921_eeprom_init_sku(struct mt7921_dev *dev);
>  int mt7921_dma_init(struct mt7921_dev *dev);
>  void mt7921_dma_prefetch(struct mt7921_dev *dev);
> -void mt7921_dma_cleanup(struct mt7921_dev *dev);
>  int mt7921_run_firmware(struct mt7921_dev *dev);
>  int mt7921_mcu_init(struct mt7921_dev *dev);
>  int mt7921_mcu_add_bss_info(struct mt7921_phy *phy,
> --=20
> 2.30.2
>=20

--9fgPcQv0xKNGPojk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYHVV3AAKCRA6cBh0uS2t
rJTfAP9uYJMI8I6VGzw0zM7kMTy1zgiqjXeYqF6yCVmOlKowKwEAvFcUOIUVlQF8
s+0CBgmcw+9BK6mKCeiK4X+YGVw2FwA=
=2EOY
-----END PGP SIGNATURE-----

--9fgPcQv0xKNGPojk--

