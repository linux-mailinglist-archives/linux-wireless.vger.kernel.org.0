Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAC14CE3E8
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Mar 2022 10:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiCEJLg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Mar 2022 04:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiCEJLe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Mar 2022 04:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0B0910A7CF
        for <linux-wireless@vger.kernel.org>; Sat,  5 Mar 2022 01:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646471443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZZrmZK1SofDvRpfwtg14KKk1bJFHoZMR0F05LWYzd38=;
        b=WCRgISFR25kFQD/7ShChbRTP5Grs5FKZqXOOv+ss+JwhGLY+ZpImERiAb88t3U6nniSudI
        g+LnHOfkdosRpZsot/kJv7kfJ5HGrbQm0LCmT7M9lB4pZGa2WmlucmiJ26bRHgsiLjG3cP
        CoPdIl8OaNaNal1sbVhAIm7dIFOvs7s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-UNFg5zTbOkujMQZ8g24Aiw-1; Sat, 05 Mar 2022 04:10:42 -0500
X-MC-Unique: UNFg5zTbOkujMQZ8g24Aiw-1
Received: by mail-ej1-f70.google.com with SMTP id ey18-20020a1709070b9200b006da9614af58so3391972ejc.10
        for <linux-wireless@vger.kernel.org>; Sat, 05 Mar 2022 01:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZZrmZK1SofDvRpfwtg14KKk1bJFHoZMR0F05LWYzd38=;
        b=GuqBvOob9dLEhF0WqIc4vAXVvDZbxdyjRDawD84m59x9Czmtl/Wo9iXYb/tnbaUM7j
         VcQNBE+9OCGS/7xnFIrxy95CG8lDQhjDFeNQkVkS8Z4GkeVLA0B6TJD/K02DoQ2fICKx
         FM6Ni4G97d12CjAPn3Kw+GeH65jwbFlB50WQfT3NKLQOV35HN4qqp5JI/RLsBrP1f8Sp
         tMeBI6hmxcVhTqlLDnla1B7O6eowEoj9gAz4PMyGmf62msFH44pm4t1UPbAp5Iqnq+O4
         XXPiN+puqbxKchIsiKgYaf83wvTluG67v3R4Msi4mrJEXzas48mJ5orwplgj9cnU9/Cv
         vdIQ==
X-Gm-Message-State: AOAM531UeuVs1+OPrvB9zMSuPkL5nUl9ju0zGLsA0NoXp2G9/d4vlGxa
        jqeF1TjhPCDQKmDruyzx/7UbhUkd7yIpN9PG5svLi3laWsFyavaNaxEkOysmjuti8N4TdEeOPfq
        y4njMP80F9UEJXwWozx83WdBLBFU=
X-Received: by 2002:a17:906:2584:b0:6d6:e5c9:221b with SMTP id m4-20020a170906258400b006d6e5c9221bmr2119771ejb.514.1646471440596;
        Sat, 05 Mar 2022 01:10:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwO7FrT0LfBJwjA34pK47wDRiVVNrXRiG5aaLAVt1/yLCwhDkZ5CCuW6ldpKLr/kD42W6UpA==
X-Received: by 2002:a17:906:2584:b0:6d6:e5c9:221b with SMTP id m4-20020a170906258400b006d6e5c9221bmr2119759ejb.514.1646471440323;
        Sat, 05 Mar 2022 01:10:40 -0800 (PST)
Received: from localhost ([37.183.9.66])
        by smtp.gmail.com with ESMTPSA id bq23-20020a170906d0d700b006db0372d3a2sm385886ejb.20.2022.03.05.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 01:10:39 -0800 (PST)
Date:   Sat, 5 Mar 2022 10:10:37 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Deren.Wu@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/9] introduce mt7921u driver
Message-ID: <YiMpDQq8zMS9FWVd@lore-desk>
References: <cover.1646235785.git.lorenzo@kernel.org>
 <1646461027-5374-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QITdTzB0R+dIiE3F"
Content-Disposition: inline
In-Reply-To: <1646461027-5374-1-git-send-email-sean.wang@mediatek.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--QITdTzB0R+dIiE3F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 05, Sean Wang wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> >Introduce support for MT7921U 802.11ax 2x2:2SS wireless devices.
> >
>=20
> Tested the whole series with sta and monitor mode and it is working well.
>=20
> Tested-by: Sean Wang <sean.wang@mediatek.com>

thx Sean for testing. I will post v2 with some fixes.

Regards,
Lorenzo

>=20
> >Lorenzo Bianconi (9):
> >  mt76: usb: add req_type to ___mt76u_rr signature
> >  mt76: usb: add req_type to ___mt76u_wr signature
> >  mt76: usb: introduce __mt76u_init utility routine
> >  mt76: mt7921: disable runtime pm for usb
> >  mt76: mt7921: update mt7921_skb_add_usb_sdio_hdr to support usb
> >  mt76: mt7921: move mt7921_usb_sdio_tx_prepare_skb in common mac code
> >  mt76: mt7921: move mt7921_usb_sdio_tx_complete_skb in common mac code.
> >  mt76: mt7921: move mt7921_usb_sdio_tx_status_data in mac common code.
> >  mt76: mt7921: add mt7921u driver
> >
> > drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +-
> > .../net/wireless/mediatek/mt76/mt7615/usb.c   |  68 ++-
> > .../net/wireless/mediatek/mt76/mt76x0/usb.c   |   2 +-
> > .../net/wireless/mediatek/mt76/mt76x2/usb.c   |   2 +-
> > .../net/wireless/mediatek/mt76/mt7921/Kconfig |  11 +
> > .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +
> > .../wireless/mediatek/mt76/mt7921/debugfs.c   |   6 +
> > .../net/wireless/mediatek/mt76/mt7921/init.c  |  12 +-
> > .../net/wireless/mediatek/mt76/mt7921/mac.c   |  91 ++++
> > .../net/wireless/mediatek/mt76/mt7921/mac.h   |   1 +
> > .../net/wireless/mediatek/mt76/mt7921/main.c  |   3 +-
> > .../wireless/mediatek/mt76/mt7921/mt7921.h    |  25 +-
> > .../net/wireless/mediatek/mt76/mt7921/regs.h  |  36 +-
> > .../net/wireless/mediatek/mt76/mt7921/sdio.c  |   6 +-
> > .../wireless/mediatek/mt76/mt7921/sdio_mac.c  |  83 ----
> > .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |   2 +-
> > .../net/wireless/mediatek/mt76/mt7921/usb.c   | 397 ++++++++++++++++++
> > drivers/net/wireless/mediatek/mt76/usb.c      | 125 ++----
> > 18 files changed, 689 insertions(+), 195 deletions(-)  create mode 1006=
44 drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> >
> >--
> >2.35.1
> >
> >
>=20
>=20

--QITdTzB0R+dIiE3F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYiMpDQAKCRA6cBh0uS2t
rGMcAP9LXM0FH4wlPliwvk4rYwOfYzcMVxjq6kKix3HMMuFmbwEA1a4PdrscMp/l
TPVtQExE06vAOPXg1naTWkTiPg8IjgM=
=FkVr
-----END PGP SIGNATURE-----

--QITdTzB0R+dIiE3F--

