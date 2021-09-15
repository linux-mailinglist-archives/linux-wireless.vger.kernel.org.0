Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE3840C65E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhION1m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 09:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhION1m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 09:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631712383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLNVfP4T56EFi98NbmMuurxnOngj+c1xtiUUquS4Kac=;
        b=UxVuWCqHSvAR6WzICmnag1jwPTYiCJSwx8D0loXw1fMXdjXOJznm7xF19cMq0iWDY9EIOf
        t3F7cXV+/I8QYCS7i/P8fjqLfzHWZTYzjiXAy4NGhLTfIJ0WKSXMvcMmbD3gwBszxkemXD
        8llbkUbVj/DlxSBv50fi6wJmrwLsoSE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-2JIGMa8TOBaVohBW83tU-g-1; Wed, 15 Sep 2021 09:26:21 -0400
X-MC-Unique: 2JIGMa8TOBaVohBW83tU-g-1
Received: by mail-ej1-f71.google.com with SMTP id 22-20020a170906301600b005ca77a21183so1498610ejz.20
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 06:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PLNVfP4T56EFi98NbmMuurxnOngj+c1xtiUUquS4Kac=;
        b=aRaKEv78Kj4DlXBWdicihscbGf3lSSLNjnq9fDDFBeVdlr7J1coHOoUhwEy+xQUgdK
         5xDP/sfJKT3SVQaPAtffHl5RChDKLkZJEfa/NWGA1gO8wvO63sqyi8zXusloyMew5hxP
         9PaQCi4toC+iqrSr41k8kEZSQv2fUyprKRElTrZTP/w2n8cCTo8QnnFNqCulTPws6ukr
         9KLVbRBWNY9W6hOWr50W0Vt42a3/HCAGd7itAv6WAE97tUvXoT0y5aPZ8dBogq8KxKU8
         dzuUbi/qD1+6xkpXOo0qgBiJw/3X+sXhsgwD5Nr49ZrBxBx76FxVgr3E5XpBn2+xj6Rl
         SpKg==
X-Gm-Message-State: AOAM5309erkcsiQo/xfUajYKBaqk2ai54RF6AcArqT2EJEOsVdh5HHvb
        MNL6j6xggzMGD/vozT/fdiJQM49Q8F5pldIWlEoeP64KH0qLCWLOcMPE36u2BUK8dWcwmfzVMUU
        srixI+OE0dBpzjJJ5xKasKCgehbg=
X-Received: by 2002:a17:907:7844:: with SMTP id lb4mr24775800ejc.381.1631712378922;
        Wed, 15 Sep 2021 06:26:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt6btJTnB/MBnZDYz3YNkoYdJaAuuF29sX8HGUXrIZC88DNOFBJGOfJ3yoFBmrIMW+oTuAXA==
X-Received: by 2002:a17:907:7844:: with SMTP id lb4mr24775774ejc.381.1631712378640;
        Wed, 15 Sep 2021 06:26:18 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id h10sm7382419edf.85.2021.09.15.06.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:26:18 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:26:15 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        steve.lee@mediatek.com, jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 10/16] mt76: mt7921: use physical addr to unify
 register access
Message-ID: <YUH0d5nPfS+6uejD@lore-desk>
References: <cover.1631667941.git.objelf@gmail.com>
 <856edf387e8e7f444d0eaf95ffac0616571146d1.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mzLskt4Q02/YFtkH"
Content-Disposition: inline
In-Reply-To: <856edf387e8e7f444d0eaf95ffac0616571146d1.1631667941.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--mzLskt4Q02/YFtkH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 15, Sean Wang wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Use physical address to unify the register access and reorder the
> entries in fixed_map table to accelerate the address lookup for
> MT7921e.
>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/dma.c   | 19 ++++++++--------
>  .../net/wireless/mediatek/mt76/mt7921/regs.h  | 22 +++++++++----------
>  2 files changed, 21 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/dma.c
> index be24241fb8e6..f31c4aef8b27 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> @@ -85,6 +85,14 @@ static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u=
32 addr)
>  		u32 mapped;
>  		u32 size;
>  	} fixed_map[] =3D {
> +		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
> +		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
> +		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
> +		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
> +		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
> +		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
> +		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
> +		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
>  		{ 0x00400000, 0x80000, 0x10000}, /* WF_MCU_SYSRAM */
>  		{ 0x00410000, 0x90000, 0x10000}, /* WF_MCU_SYSRAM (configure register)=
 */
>  		{ 0x40000000, 0x70000, 0x10000}, /* WF_UMAC_SYSRAM */

not related to this patch, but since you are chaing it can you please add a
space at the end of the line above? Thanks :)

Regards,
Lorenzo

> @@ -99,22 +107,15 @@ static u32 __mt7921_reg_addr(struct mt7921_dev *dev,=
 u32 addr)
>  		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
>  		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
>  		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
> -		{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
> +		{ 0x820cc000, 0x0e000, 0x1000 }, /* WF_UMAC_TOP (PP) */
> +		{ 0x820cd000, 0x0f000, 0x1000 }, /* WF_MDP_TOP */
>  		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
>  		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
> -		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
>  		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
>  		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
> -		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
> -		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
> -		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
> -		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
> -		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
>  		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
>  		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
> -		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
>  		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
> -		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
>  		{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
>  		{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
>  		{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/n=
et/wireless/mediatek/mt76/mt7921/regs.h
> index 26fb11823762..cb6069024320 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
> @@ -14,7 +14,7 @@
>  #define MT_MCU_INT_EVENT_SER_TRIGGER	BIT(2)
>  #define MT_MCU_INT_EVENT_RESET_DONE	BIT(3)
> =20
> -#define MT_PLE_BASE			0x8000
> +#define MT_PLE_BASE			0x820c0000
>  #define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
> =20
>  #define MT_PLE_FL_Q0_CTRL		MT_PLE(0x1b0)
> @@ -26,7 +26,7 @@
>  					       ((n) << 2))
>  #define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
> =20
> -#define MT_MDP_BASE			0xf000
> +#define MT_MDP_BASE			0x820cd000
>  #define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
> =20
>  #define MT_MDP_DCR0			MT_MDP(0x000)
> @@ -49,7 +49,7 @@
>  #define MT_MDP_TO_WM			1
> =20
>  /* TMAC: band 0(0x21000), band 1(0xa1000) */
> -#define MT_WF_TMAC_BASE(_band)		((_band) ? 0xa1000 : 0x21000)
> +#define MT_WF_TMAC_BASE(_band)		((_band) ? 0x820f4000 : 0x820e4000)
>  #define MT_WF_TMAC(_band, ofs)		(MT_WF_TMAC_BASE(_band) + (ofs))
> =20
>  #define MT_TMAC_TCR0(_band)		MT_WF_TMAC(_band, 0)
> @@ -74,7 +74,7 @@
>  #define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
>  #define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
> =20
> -#define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
> +#define MT_WF_DMA_BASE(_band)		((_band) ? 0x820f7000 : 0x820e7000)
>  #define MT_WF_DMA(_band, ofs)		(MT_WF_DMA_BASE(_band) + (ofs))
> =20
>  #define MT_DMA_DCR0(_band)		MT_WF_DMA(_band, 0x000)
> @@ -82,7 +82,7 @@
>  #define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
> =20
>  /* LPON: band 0(0x24200), band 1(0xa4200) */
> -#define MT_WF_LPON_BASE(_band)		((_band) ? 0xa4200 : 0x24200)
> +#define MT_WF_LPON_BASE(_band)		((_band) ? 0x820fb000 : 0x820eb000)
>  #define MT_WF_LPON(_band, ofs)		(MT_WF_LPON_BASE(_band) + (ofs))
> =20
>  #define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, 0x080)
> @@ -93,7 +93,7 @@
>  #define MT_LPON_TCR_SW_WRITE		BIT(0)
> =20
>  /* MIB: band 0(0x24800), band 1(0xa4800) */
> -#define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
> +#define MT_WF_MIB_BASE(_band)		((_band) ? 0x820fd000 : 0x820ed000)
>  #define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
> =20
>  #define MT_MIB_SCR1(_band)		MT_WF_MIB(_band, 0x004)
> @@ -142,7 +142,7 @@
>  #define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x0b0 + ((n) << 2))
>  #define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0=
))
> =20
> -#define MT_WTBLON_TOP_BASE		0x34000
> +#define MT_WTBLON_TOP_BASE		0x820d4000
>  #define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
>  #define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x200)
>  #define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
> @@ -152,7 +152,7 @@
>  #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
>  #define MT_WTBL_UPDATE_BUSY		BIT(31)
> =20
> -#define MT_WTBL_BASE			0x38000
> +#define MT_WTBL_BASE			0x820d8000
>  #define MT_WTBL_LMAC_ID			GENMASK(14, 8)
>  #define MT_WTBL_LMAC_DW			GENMASK(7, 2)
>  #define MT_WTBL_LMAC_OFFS(_id, _dw)	(MT_WTBL_BASE | \
> @@ -160,7 +160,7 @@
>  					FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
> =20
>  /* AGG: band 0(0x20800), band 1(0xa0800) */
> -#define MT_WF_AGG_BASE(_band)		((_band) ? 0xa0800 : 0x20800)
> +#define MT_WF_AGG_BASE(_band)		((_band) ? 0x820f2000 : 0x820e2000)
>  #define MT_WF_AGG(_band, ofs)		(MT_WF_AGG_BASE(_band) + (ofs))
> =20
>  #define MT_AGG_AWSCR0(_band, _n)	MT_WF_AGG(_band, 0x05c + (_n) * 4)
> @@ -191,7 +191,7 @@
>  #define MT_AGG_ATCR3(_band)		MT_WF_AGG(_band, 0x0f4)
> =20
>  /* ARB: band 0(0x20c00), band 1(0xa0c00) */
> -#define MT_WF_ARB_BASE(_band)		((_band) ? 0xa0c00 : 0x20c00)
> +#define MT_WF_ARB_BASE(_band)		((_band) ? 0x820f3000 : 0x820e3000)
>  #define MT_WF_ARB(_band, ofs)		(MT_WF_ARB_BASE(_band) + (ofs))
> =20
>  #define MT_ARB_SCR(_band)		MT_WF_ARB(_band, 0x080)
> @@ -201,7 +201,7 @@
>  #define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, 0x194 + (_n) * 4)
> =20
>  /* RMAC: band 0(0x21400), band 1(0xa1400) */
> -#define MT_WF_RMAC_BASE(_band)		((_band) ? 0xa1400 : 0x21400)
> +#define MT_WF_RMAC_BASE(_band)		((_band) ? 0x820f5000 : 0x820e5000)
>  #define MT_WF_RMAC(_band, ofs)		(MT_WF_RMAC_BASE(_band) + (ofs))
> =20
>  #define MT_WF_RFCR(_band)		MT_WF_RMAC(_band, 0x000)
> --=20
> 2.25.1
>=20

--mzLskt4Q02/YFtkH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUH0dAAKCRA6cBh0uS2t
rPdBAP95pHqkybRW6MJB9pPokTJxmJofmKsxc57b4APEs707IQEA401b4jLd0TyH
rwwBIwHKVCd5PEkitoKi+4IX4OGm+Qg=
=pEdz
-----END PGP SIGNATURE-----

--mzLskt4Q02/YFtkH--

