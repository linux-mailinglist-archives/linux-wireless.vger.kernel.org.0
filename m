Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B4F46C43F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 21:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhLGUPT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 15:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229648AbhLGUPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 15:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638907907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5U0T8lId4u/qtnYkSF6w2VpgkSGsEJ9/j1FJIOBWI8=;
        b=DjjOpFgAvojeEsi/nWmfGB14jWvmEsqZvu+vsCtlhFBmvmL7Hf5j3lUDxWQGxx3T4MQ7Vv
        y4+JWL58ZrdLHysDEzL1Zadb9Q/DjXexqNbp6IERFddBpGk5tDdzGx2eVLh6pfoYqNCDd5
        +0SrEFT8RvCH/ft+as4aQJ/WXYcK81Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-BTVOzW-pOrm44Y1D_Cx_IQ-1; Tue, 07 Dec 2021 15:11:45 -0500
X-MC-Unique: BTVOzW-pOrm44Y1D_Cx_IQ-1
Received: by mail-qk1-f198.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so3806qkl.7
        for <linux-wireless@vger.kernel.org>; Tue, 07 Dec 2021 12:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o5U0T8lId4u/qtnYkSF6w2VpgkSGsEJ9/j1FJIOBWI8=;
        b=d/7nd1sYPg3h4nr8D0Quw+k/NKhaX8oiGkfhJ9c7tNfXtDSepirzDVT6ZBTA6gvrmy
         YT+r8e7OKd/4tjwApX80+VUC+Fx9tlHLpqUDJgd0s5hQQcnfmEWMcjm49G4fnHk9EZvs
         vTXZ6UBednB1O23y9p3orvf6JcndiQesuhWL+tH8WJR/fNmBqKjFXuFBT7QrvjHw902f
         H0egD0Euu8wjN1riGM8gH5DpZ04fLDKWufmSSBc+Gl6HJX1QTwEykkTd+qHqvGRjTi5Q
         Qjpszp5pkErJNeRHl4PnQ6u1BLgXqCKkkW/RcnD60LC0F5loAkG02JOekfnuCs+Vxn69
         lSKg==
X-Gm-Message-State: AOAM531alVYI3SEbeuzXvxglcJ57OADyw5yv1j+3JcqEZlFaWoaLJl1Y
        vYTfgotpmbGOd5C9kxtvdUbm7vVRpqFx08njLWuBQnmkJfBV1Rg8zSXJep/cDuitTbsJxZv1BXL
        7/AuYIgKLUeMTRv4DM55VYjMKTjs=
X-Received: by 2002:ac8:5a96:: with SMTP id c22mr2025529qtc.602.1638907905423;
        Tue, 07 Dec 2021 12:11:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwG1pf4MzmjAPKtyQX3aPAClJ9qzTa7/zyMaT+QXwJJXzGjCmrGs3UJyfJTg+vIjTrnhF4fNw==
X-Received: by 2002:ac8:5a96:: with SMTP id c22mr2025501qtc.602.1638907905179;
        Tue, 07 Dec 2021 12:11:45 -0800 (PST)
Received: from localhost (net-37-182-17-175.cust.vodafonedsl.it. [37.182.17.175])
        by smtp.gmail.com with ESMTPSA id t35sm530705qtc.83.2021.12.07.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:11:44 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:11:41 +0100
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
Subject: Re: [PATCH] mt76: mt7921: fix network buffer leak by txs missing
Message-ID: <Ya+//bw09FMMwEh3@lore-desk>
References: <7f6efbd8e749b21bec2257c54b8258ebe89738fe.1638795555.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlBm58Dcb78sl8w9"
Content-Disposition: inline
In-Reply-To: <7f6efbd8e749b21bec2257c54b8258ebe89738fe.1638795555.git.deren.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--HlBm58Dcb78sl8w9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> TXS in mt7921 may be forwared to tx_done event. Should try to catch
> TXS information in tx_done event as well.
>=20
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/mac.c   |  2 +-
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 17 ++++++++++++
>  .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 27 +++++++++++++++++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
>  4 files changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index edf54b192f37..2514708e9ac8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -1150,7 +1150,7 @@ mt7921_mac_add_txs_skb(struct mt7921_dev *dev, stru=
ct mt76_wcid *wcid, int pid,
>  	return !!skb;
>  }
> =20
> -static void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
> +void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
>  {
>  	struct mt7921_sta *msta =3D NULL;
>  	struct mt76_wcid *wcid;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 1227d626e9d3..8f58af4e29c6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -418,6 +418,20 @@ mt7921_mcu_low_power_event(struct mt7921_dev *dev, s=
truct sk_buff *skb)
>  	trace_lp_event(dev, event->state);
>  }
> =20
> +static void
> +mt7921_mcu_tx_done_event(struct mt7921_dev *dev, struct sk_buff *skb)
> +{
> +	struct mt7921_mcu_tx_done_event *event;
> +
> +	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
> +	event =3D (struct mt7921_mcu_tx_done_event *)skb->data;
> +
> +	if (event->pid < MT_PACKET_ID_FIRST)
> +		return;

I guess we do not need it since it is already checked in mt7921_mac_add_txs

> +
> +	mt7921_mac_add_txs(dev, event->txs);
> +}
> +
>  static void
>  mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *=
skb)
>  {
> @@ -445,6 +459,9 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *de=
v, struct sk_buff *skb)
>  	case MCU_EVENT_LP_INFO:
>  		mt7921_mcu_low_power_event(dev, skb);
>  		break;
> +	case MCU_EVENT_TX_DONE:
> +		mt7921_mcu_tx_done_event(dev, skb);
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.h
> index edc0c73f8c01..821af6e8d99a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
> @@ -91,6 +91,33 @@ enum {
>  	MCU_EVENT_COREDUMP =3D 0xf0,
>  };
> =20
> +struct mt7921_mcu_tx_done_event {
> +	u8 pid;
> +	u8 status;
> +	u16 seq;
> +
> +	u8 wlan_idx;
> +	u8 tx_cnt;
> +	u16 tx_rate;

can you please fix endianness of mt7921_mcu_tx_done_event?

Regards,
Lorenzo

> +
> +	u8 flag;
> +	u8 tid;
> +	u8 rsp_rate;
> +	u8 mcs;
> +
> +	u8 bw;
> +	u8 tx_pwr;
> +	u8 reason;
> +	u8 rsv0[1];
> +
> +	u32 delay;
> +	u32 timestamp;
> +	u32 applied_flag;
> +	u8 txs[28];
> +
> +	u8 rsv1[32];
> +} __packed;
> +
>  /* ext event table */
>  enum {
>  	MCU_EXT_EVENT_RATE_REPORT =3D 0x87,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index d6b823713ba3..96647801850a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -464,4 +464,5 @@ int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, voi=
d *txwi_ptr,
>  			   struct mt76_tx_info *tx_info);
>  void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_en=
try *e);
>  bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update);
> +void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
>  #endif
> --=20
> 2.18.0
>=20

--HlBm58Dcb78sl8w9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYa+//QAKCRA6cBh0uS2t
rKIBAQDUBQi44Haok7jXFgo4LaCViKs/FeRb/+crPO6nObM/yQEA0e4HK8uNLDIo
gsLYusdmg+Yxww4wl963+JMstITgngM=
=SGCg
-----END PGP SIGNATURE-----

--HlBm58Dcb78sl8w9--

