Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C1425D36
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Oct 2021 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhJGU2a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 16:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242525AbhJGU2S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 16:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633638383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hZusz9cYbIWQpV9csYN7a8WKv66KCgntMG2FiC0Mxdw=;
        b=dVeckXyZgcrqy+hOFg3MfTuSUIPHff67gEPr4XAeFdOLEXLEWcAG2ZwMtGRa8s9jsfZi7V
        eRQ48JcI5PKtHk/yaH0EFmvQquA1gppS3+Tc6u7BqNZmq9DCr/ZvauZ4eV47HDjMWaxhaM
        BT9vknJUlmXS81sVXYN2ShhhyechnDE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-cukKCR0iOpCR7h0tGD7SWw-1; Thu, 07 Oct 2021 16:26:17 -0400
X-MC-Unique: cukKCR0iOpCR7h0tGD7SWw-1
Received: by mail-ed1-f71.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso7030121edf.7
        for <linux-wireless@vger.kernel.org>; Thu, 07 Oct 2021 13:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hZusz9cYbIWQpV9csYN7a8WKv66KCgntMG2FiC0Mxdw=;
        b=vKnqxNDtG2p7TztGQI8B4rePsp2bLrt0QmHCz2hxpxoX51o24kZ2J3tySBw27+ufyc
         Q8Rpnxak12yb5+2Sq1zmcn9Upm0aluUWGp12gPUCjSxqvcWlOcYagjbl8M637hcVn12A
         D78v6odlK3KZJyYQTlZnYs4Vz4YZSFxn1f98+Ga7w3RslxHJmSoNzgQhZtMnsKlM/7u6
         CYa+a9ueeH/+vQmcWgERCbxvPF9t4XaEjF/pfRnhBTmQJB9cc5iF041eSQ1Vb4mEYwHK
         Xjxuo8tY8yn4SZKeL3f4SIWUoOdDj1R2MwBJDqA8uzOuLLhTMLGiNS1izvMWbUNoCvNv
         esDw==
X-Gm-Message-State: AOAM530X8ywlrMEJBMQqE+LrtUQH6gVdDmFrZ+Rvb31udzhT2jI3IEDA
        GgWenDTsW3as9i/5JRvep/5FEjbdNDJMK5gO3Z6xXcSBYbR7law0VZ81oWNTT8nz4Mcg4K0KxdO
        MHzVyicZ4wSFoamoRhbRWpjebDoI=
X-Received: by 2002:a17:906:1945:: with SMTP id b5mr8122716eje.347.1633638376272;
        Thu, 07 Oct 2021 13:26:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNxpIBpDKVTBcNdJ7m+OMEIWpOE/VlJ/xlBkqyxOTuTBAy7834GbYjWU2EDtyZU/IHTeYWGg==
X-Received: by 2002:a17:906:1945:: with SMTP id b5mr8122686eje.347.1633638375992;
        Thu, 07 Oct 2021 13:26:15 -0700 (PDT)
Received: from localhost (net-2-47-237-124.cust.vodafonedsl.it. [2.47.237.124])
        by smtp.gmail.com with ESMTPSA id z16sm200305edb.16.2021.10.07.13.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:26:15 -0700 (PDT)
Date:   Thu, 7 Oct 2021 22:26:11 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: add MU EDCA cmd support
Message-ID: <YV9X43y1pQCDApd5@localhost.localdomain>
References: <181a8f619a55c5a509c838d2ea5ec64641d4aa19.1633632336.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JNVcCZ/mkz4SeEUI"
Content-Disposition: inline
In-Reply-To: <181a8f619a55c5a509c838d2ea5ec64641d4aa19.1633632336.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--JNVcCZ/mkz4SeEUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Add MU EDCA MCU command support to update MU AC parameter record field
> from the access point.
>=20
> Co-developed-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
> Signed-off-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
> Tested-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 56 ++++++++++++++++++-
>  2 files changed, 54 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index cb36dd39221c..0ce670d65673 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -563,6 +563,7 @@ enum {
>  	MCU_CMD_SCHED_SCAN_ENABLE =3D MCU_CE_PREFIX | 0x61,
>  	MCU_CMD_SCHED_SCAN_REQ =3D MCU_CE_PREFIX | 0x62,
>  	MCU_CMD_GET_NIC_CAPAB =3D MCU_CE_PREFIX | 0x8a,
> +	MCU_CMD_SET_MU_EDCA_PARMS =3D MCU_CE_PREFIX | 0xb0,
>  	MCU_CMD_REG_WRITE =3D MCU_CE_PREFIX | 0xc0,
>  	MCU_CMD_REG_READ =3D MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
>  	MCU_CMD_CHIP_CONFIG =3D MCU_CE_PREFIX | 0xca,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 56fb7e54e283..53b2eaad2af7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -974,7 +974,31 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct=
 ieee80211_vif *vif)
>  		.total =3D IEEE80211_NUM_ACS,
>  	};
>  	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> -	int ac;
> +

can you please remove blank line here?

> +	struct mu_edca {
> +		u8 cw_min;
> +		u8 cw_max;
> +		u8 aifsn;
> +		u8 acm;
> +		u8 timer;
> +		u8 padding[3];
> +	};
> +	struct mt7921_mcu_mu_tx {
> +		u8 ver;
> +		u8 pad0;
> +		u16 len;

I guess __le16 here (even if it is not actually used)

Regards,
Lorenzo

> +		u8 bss_idx;
> +		u8 qos;
> +		u8 wmm_idx;
> +		u8 pad1;
> +		struct mu_edca edca[IEEE80211_NUM_ACS];
> +		u8 pad3[32];
> +	} __packed req_mu =3D {
> +		.bss_idx =3D mvif->mt76.idx,
> +		.qos =3D vif->bss_conf.qos,
> +		.wmm_idx =3D mvif->mt76.wmm_idx,
> +	};
> +	int ac, ret;
> =20
>  	for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
>  		struct ieee80211_tx_queue_params *q =3D &mvif->queue_params[ac];
> @@ -995,8 +1019,34 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struc=
t ieee80211_vif *vif)
>  		else
>  			e->cw_max =3D cpu_to_le16(10);
>  	}
> -	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
> -				 sizeof(req), true);
> +
> +	ret =3D mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
> +				sizeof(req), true);
> +	if (ret)
> +		return ret;
> +
> +	if (!vif->bss_conf.he_support)
> +		return 0;
> +
> +	for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
> +		struct ieee80211_he_mu_edca_param_ac_rec *q;
> +		struct mu_edca *e;
> +		int to_aci[] =3D {1, 0, 2, 3};
> +
> +		if (!mvif->queue_params[ac].mu_edca)
> +			break;
> +
> +		q =3D &mvif->queue_params[ac].mu_edca_param_rec;
> +		e =3D &(req_mu.edca[to_aci[ac]]);
> +
> +		e->cw_min =3D q->ecw_min_max & 0xf;
> +		e->cw_max =3D (q->ecw_min_max & 0xf0) >> 4;
> +		e->aifsn =3D q->aifsn;
> +		e->timer =3D q->mu_edca_timer;
> +	}
> +
> +	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_MU_EDCA_PARMS, &req_mu,
> +				 sizeof(req_mu), false);
>  }
> =20
>  int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
> --=20
> 2.25.1
>=20

--JNVcCZ/mkz4SeEUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYV9X2AAKCRA6cBh0uS2t
rBrWAP0Q6iX7EM5XsMtfJajnloN+IIQAmc7DNNcOvp8BXDkA+gEApGfu8/DNDOPK
akalhUaMq1vu40nkD/2t2Y4AtSEUxA8=
=HSnB
-----END PGP SIGNATURE-----

--JNVcCZ/mkz4SeEUI--

