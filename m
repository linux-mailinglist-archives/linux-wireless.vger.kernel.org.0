Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068A46EDEE6
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 11:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjDYJQS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDYJQR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 05:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5D10FD
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682414134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NhHAX0VlICT6SJ2yIjYuGBSOLHy5fvpP1/I8XUa+avA=;
        b=g2kedOmTBmuRUyrKAUidaMK4fK7iu0+Dwwm1fkSNF+Xr7qAxjgJO5lYadB9WbVrxWKj7DV
        oTtn8T8lYjfjDwzMpsqiFF0zXbTuotA3XooYRUIBdfR/4Etz4ZP1qbe/R4ijmZ+wgamraW
        eW/24evtSFBlVEMg321HRQzks9c3+Gc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-WPTSSUTuOz-2kDLZr5sPlg-1; Tue, 25 Apr 2023 05:15:30 -0400
X-MC-Unique: WPTSSUTuOz-2kDLZr5sPlg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-301110f1756so1965184f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 02:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682414129; x=1685006129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhHAX0VlICT6SJ2yIjYuGBSOLHy5fvpP1/I8XUa+avA=;
        b=Koyi/GL26pr9Z5LY9WQL6tbWkdQouo9oGCotSrG7uxkeYIUkrxY9sCGPoYY+mn2JAu
         Sf1wL7K74lnPbi7GjmSMs+6Mbq0R0WIT3S92mhP0OlnggXU8kUlSiR+eTqyyn6TScpJY
         l8si41nRDLbQOZq/72TnMT73VRZZubUIvOsU7nwEHFIB9e/6xNgVjK4joo1pKlFC81XB
         VhqR+6bTJaQOH0gu4KsN+XMsV/6QX6m8MJgH92iInioFReOqGVO3Zr48ueaMm7MjqCnQ
         DUKtc9K6vMlHHZTbP+d840wW//zr+xIlP4Twl9raMgAC4O7L0wBbKdBHmLEqV6C29h9u
         ZJIQ==
X-Gm-Message-State: AAQBX9fy+w8VwlDphUJJlWvWZ6oobB5CXdmhz8FLQecvP1FbDV7MOGxs
        u4h/ID694DQYcGMOWm0SPo/Tmiz/8yISgNaM+Pzqn9fFzhjdSzFFgnYfLQfeXchzG6C2JBabt1X
        0ep/RDM7QTiFtRse5S4PV3wspgxY=
X-Received: by 2002:adf:fa85:0:b0:2fa:6929:eb81 with SMTP id h5-20020adffa85000000b002fa6929eb81mr10610042wrr.31.1682414129233;
        Tue, 25 Apr 2023 02:15:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yzo8tilXa86cYLLhoIWmR3SPkVzVPAP1fY+v3Z4ulVIYXIN2Qw3dZu+twfdymURcj0zUBW+A==
X-Received: by 2002:adf:fa85:0:b0:2fa:6929:eb81 with SMTP id h5-20020adffa85000000b002fa6929eb81mr10610024wrr.31.1682414128925;
        Tue, 25 Apr 2023 02:15:28 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d468f000000b002f5fbc6ffb2sm12621195wrq.23.2023.04.25.02.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 02:15:28 -0700 (PDT)
Date:   Tue, 25 Apr 2023 11:15:26 +0200
From:   "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <Ryder.Lee@mediatek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Shayne Chen =?utf-8?B?KOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        Evelyn Tsai =?utf-8?B?KOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        Chui-hao Chiu =?utf-8?B?KOmCseWegua1qSk=?= 
        <Chui-hao.Chiu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7915: rework tx bytes/packets when WED
 is active
Message-ID: <ZEeaLiG458e3oDSU@lore-desk>
References: <d9466e4641a7db661058896f4ccd4bba4a9cdb3b.1682411744.git.ryder.lee@mediatek.com>
 <ZEeUF8T8gmjGIk5e@lore-desk>
 <00f1427faabd54d260aca8d083c1dd4e190d4c75.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nfYNmmsp/Ll5LRBs"
Content-Disposition: inline
In-Reply-To: <00f1427faabd54d260aca8d083c1dd4e190d4c75.camel@mediatek.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--nfYNmmsp/Ll5LRBs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 2023-04-25 at 10:49 +0200, Lorenzo Bianconi wrote:
> > > From: Peter Chiu <chui-hao.chiu@mediatek.com>
> > >=20
> > > 1. Mixed tx_byte calculation - need to handle both (non)binding
> > > packets
> > >    when WED is enabled.
> > > 2. PPDU based TxS can only reports MPDU counts whereas mac80211
> > > requires
> > >    MSDU unit(NL80211_STA_INFO_TX_PACKETS).
> > >=20
> > > To solve above issues - switch to use TxS reporting for all tx_byte
> > > when
> > > WED is active and get MSDU Tx counts from WA statistic.
> >=20
> > It seems to me we are doining multiple logic tasks in this patch. Can
> > you
> > please split them on multiple patches?
> >=20
>=20
> OK.
> > >=20
> > > Note that mt7915 WA firmware only counts tx_packet for WED path, so
> > > driver needs to take care of host path.
> > >=20
> > > Fixes: 43eaa3689507 ("wifi: mt76: add PPDU based TxS support for
> > > WED device")
> > > Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
> > >  .../wireless/mediatek/mt76/mt76_connac_mac.c  |  8 +-
> > >  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
> > >  .../net/wireless/mediatek/mt76/mt7915/init.c  |  6 ++
> > >  .../net/wireless/mediatek/mt76/mt7915/main.c  |  6 +-
> > >  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 74
> > > +++++++++++++++++--
> > >  .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 30 +-------
> > >  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
> > >  drivers/net/wireless/mediatek/mt76/tx.c       |  6 ++
> > >  9 files changed, 91 insertions(+), 43 deletions(-)
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h
> > > b/drivers/net/wireless/mediatek/mt76/mt76.h
> > > index 6b07b8fafec2..0e9f4197213a 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> > > @@ -277,7 +277,7 @@ struct mt76_sta_stats {
> > >  	u64 tx_mcs[16];		/* mcs idx */
> > >  	u64 tx_bytes;
> > >  	/* WED TX */
> > > -	u32 tx_packets;
> > > +	u32 tx_packets;		/* unit: MSDU */
> > >  	u32 tx_retries;
> > >  	u32 tx_failed;
> > >  	/* WED RX */
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> > > b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> > > index d39a3cc5e381..84985a989293 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> > > @@ -521,9 +521,9 @@ void mt76_connac2_mac_write_txwi(struct
> > > mt76_dev *dev, __le32 *txwi,
> > >  		q_idx =3D wmm_idx * MT76_CONNAC_MAX_WMM_SETS +
> > >  			mt76_connac_lmac_mapping(skb_get_queue_mapping(
> > > skb));
> > > =20
> > > -		/* counting non-offloading skbs */
> > > -		wcid->stats.tx_bytes +=3D skb->len;
> > > -		wcid->stats.tx_packets++;
> > > +		/* mt7915 WA only counts WED path */
> > > +		if (mtk_wed_device_active(&dev->mmio.wed) &&
> > > is_mt7915(dev))
> > > +			wcid->stats.tx_packets++;
> >=20
> > I think this will crash mt7921 usb/sdio drivers. It is enough to swap
> > the conditions since mt7915 supports mmio only mode.
> >=20
>=20
> OK.
> > >  	}
> > > =20
> > >  	val =3D FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
> > > @@ -610,8 +610,6 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev
> > > *dev, struct mt76_wcid *wcid,
> > >  		stats->tx_bytes +=3D
> > >  			le32_get_bits(txs_data[5],
> > > MT_TXS5_MPDU_TX_BYTE) -
> > >  			le32_get_bits(txs_data[7],
> > > MT_TXS7_MPDU_RETRY_BYTE);
> > > -		stats->tx_packets +=3D
> > > -			le32_get_bits(txs_data[5],
> > > MT_TXS5_MPDU_TX_CNT);
> >=20
> > I think this will break accounting for mt7921, right?
> >=20
>=20
> Why? I don't think mt7921 supports WED. It should not go into this
> chunk.

ack, right. mt7921 just supports MT_TXS0_TXS_FORMAT <=3D 1.

Regards,
Lorenzo

>=20
> > Regards,
> > Lorenzo
> >=20

--nfYNmmsp/Ll5LRBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZEeaLgAKCRA6cBh0uS2t
rFGYAP9IiPY1yQ6QJctiXOnHmoBcJ81dGHaJgTOdhiyn3bjuKQD/T62wZHe3pav0
poWV+P4MDCr0svPp379tG3ZKkPb7zgE=
=svYu
-----END PGP SIGNATURE-----

--nfYNmmsp/Ll5LRBs--

