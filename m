Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C94417D7C
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 00:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbhIXWIC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 18:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344720AbhIXWIB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 18:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632521187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hHoJmPfxSKttuuAnVsRjqgs+T2Fmc7TgpFTSsEj6CKM=;
        b=d4JWMFv1+zGuabBYAPJ+M3AnSzRT7jqcq8315Lldrgsphgh8zh9oOuC2eMgDfl9J5weTXU
        dZzev9aFMZ6VH5jrzUhyET/S5/6wZi6g9yTuogDMAO1DrRNe5TrwWB5UbUOh+mGxLKQjdx
        3dCGHSc2ZXlV6xZXpNkAQg/lFo1H2GI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-Ps9E9-IEMFawFfymR8IMUA-1; Fri, 24 Sep 2021 18:06:25 -0400
X-MC-Unique: Ps9E9-IEMFawFfymR8IMUA-1
Received: by mail-ed1-f72.google.com with SMTP id c36-20020a509fa7000000b003da5a9e5d68so999098edf.15
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 15:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hHoJmPfxSKttuuAnVsRjqgs+T2Fmc7TgpFTSsEj6CKM=;
        b=j2okqFtXcmXpH7sFWNW9B4ZmS06hyrohIVG6RW/r+vYZ9x79r9foImUBrAQwLX0cmq
         KOXiS7MWSV6L0OPyGJPcObNGjEd2alDPLlUmivgBPm2zm+KdxnCfehnOEpMltqpE2C54
         pFeeL2TzM+GI7Cpdg2wwlXavUi4EPuuXi+nWAecLXG0J61k5YVdpbl1Mk8JJ0XRv8508
         EO3fQVOAmNriHgKR5iy+sz1NLy+24zbAxS0jKxjpjcgTsjgHOP8HoBMSUr1u6A8pua65
         6GDZkQtsmkz6bYNmKOMCSNtxVMG+QENbb+VBNvAeeprG+OlfYk2TZV2wQWBfAVGd9Wi8
         BJKQ==
X-Gm-Message-State: AOAM530s866OvBmOoy51Z8keCui3s8PTDrXZe4RLWAQ/xB+UUl9AXMy0
        qkK1IRFy+DvRoOgeAZBB5bb4oRdK18cxiWJAuru+d4vtT+/gAe8GlFaRxtRwjaqXhafJaA3XIud
        DpHhCnrrI2TJhlwAUMyuXN3uiLps=
X-Received: by 2002:a17:906:1b15:: with SMTP id o21mr14136509ejg.473.1632521183984;
        Fri, 24 Sep 2021 15:06:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPEAanDT02cZdPZpWL4KZOqxiywwiaFscCLmVAfSUAtFITEMTLYa6CrPsn82hLZEh6FhffVA==
X-Received: by 2002:a17:906:1b15:: with SMTP id o21mr14136492ejg.473.1632521183799;
        Fri, 24 Sep 2021 15:06:23 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id s18sm5620636ejc.52.2021.09.24.15.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 15:06:23 -0700 (PDT)
Date:   Sat, 25 Sep 2021 00:06:21 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: Re: [PATCH 0/2] introduce a dedicated mt7915 debugfs sub-dir for
 ext-phy
Message-ID: <YU5L3bMC75BV0HaE@lore-desk>
References: <cover.1632476677.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2sv5gT7PavhV6wW4"
Content-Disposition: inline
In-Reply-To: <cover.1632476677.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--2sv5gT7PavhV6wW4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce a dedicated mt76 debugfs sub-dir for ext-phy in dbdc mode for m=
t7915
> driver. This is a preliminary series to add zero-wait dfs support.
>=20
> Lorenzo Bianconi (2):
>   mt76: rely on phy pointer in mt76_register_debugfs_fops routine
>     signature
>   mt76: mt7915: introduce mt76 debugfs sub-dir for ext-phy

I will repost this series since it does not apply on the new mt76 tree.

Regards,
Lorenzo

>=20
>  drivers/net/wireless/mediatek/mt76/debugfs.c  |  5 +-
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  4 +-
>  .../wireless/mediatek/mt76/mt7615/debugfs.c   |  2 +-
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 63 ++++++++++---------
>  .../net/wireless/mediatek/mt76/mt7915/init.c  |  6 +-
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
>  .../wireless/mediatek/mt76/mt7921/debugfs.c   |  2 +-
>  7 files changed, 45 insertions(+), 39 deletions(-)
>=20
> --=20
> 2.31.1
>=20

--2sv5gT7PavhV6wW4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYU5L1wAKCRA6cBh0uS2t
rL09AP9EWHQoUIqE+lyvmMJwvnIvnNCNPWRwKBBVF5XzNZpnqAD9G7Ne04sVns/u
tW/v+fAlJawS4QucKz6b25yu39ZTZgo=
=r9+V
-----END PGP SIGNATURE-----

--2sv5gT7PavhV6wW4--

