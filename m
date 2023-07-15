Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC89E75487B
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jul 2023 13:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjGOLzY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jul 2023 07:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOLzW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jul 2023 07:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26721B6
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jul 2023 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689422077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HO8eluITwq5usskkxIIA5wEQJ0xPhRcAfshKZ7UlAF0=;
        b=SRkVXrjzocQuApkEWY/AZoqhhYZRQ5v/AoQkDk/UVT5e9kYcF56VwOlCLIQLdM/kpbJWvs
        87WmLNW5LorMbrGrh+vr1U1oBBP3vM3cMM/bf/uimzgKV/OXHRVkfXPCOG10dBTd6IOo9x
        Mb1ZaVYIB8GFrsYzOkCcFqu/umfwhFA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-V74IuyZvOUGQf8e6fBG53Q-1; Sat, 15 Jul 2023 07:54:36 -0400
X-MC-Unique: V74IuyZvOUGQf8e6fBG53Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-315a03cae87so1523406f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jul 2023 04:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689422075; x=1692014075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO8eluITwq5usskkxIIA5wEQJ0xPhRcAfshKZ7UlAF0=;
        b=PWljFi6Vsqw2YCI3B71REwgCRHOyb0uz7redWvz9fi1ZAh0HcOFJQ+0aZ4X1QQ+uRa
         uCeXEyf/nxTAs/qXxh7Xp1KV3sYMz3odvfRSA6V7OJgBbP056sOIOj4yHV8h/I1S6+dT
         S2z3wwkPY07IpDXchPhR6yio/gzqFglEl19diF+GVWqp0BD62u//efF3n9R/01duMw70
         3ssJXxQDPFzIAc5wZFCUSuc+YnQyQPYxQWm/zMA9nJKm+pZGoPCO6eWHZP1jLyk+eFiK
         Y3sN/CMKyZDl1tsDYcUiUfqLbbtO9LP0YdZ0CC11UXgcgSEYL+uUK13E8CNl14ulcjfP
         17AQ==
X-Gm-Message-State: ABy/qLYvbsliMyjpcAD9W+Y1IwSWa8qiNDLa1CAgnB5XJw0G0MHcBsR+
        o9cAxJ2+GTcVqoFwpF3mb0MFoUs6+2wUIRGSOnuBWFXQW2PjkFF+KCoXsf388J28tBvURuOtYye
        oHEiH7pmvbzfmO1rlYRuQk4KFEZA=
X-Received: by 2002:a5d:444a:0:b0:314:475:bc6b with SMTP id x10-20020a5d444a000000b003140475bc6bmr4619634wrr.18.1689422075147;
        Sat, 15 Jul 2023 04:54:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFdULB0xr3cUVFtXAPOWUAVW3BYg8EG0CRBXGWW4ar26vrrBLWk/l7ee6qaTJkvOT/aVo7UCQ==
X-Received: by 2002:a5d:444a:0:b0:314:475:bc6b with SMTP id x10-20020a5d444a000000b003140475bc6bmr4619619wrr.18.1689422074688;
        Sat, 15 Jul 2023 04:54:34 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d508c000000b00316f9abf073sm123046wrt.82.2023.07.15.04.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 04:54:32 -0700 (PDT)
Date:   Sat, 15 Jul 2023 13:54:30 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: move mib_stats structure in
 mt76.h
Message-ID: <ZLKI9tiNytMl8Vlo@lore-desk>
References: <cover.1683930235.git.lorenzo@kernel.org>
 <d7f29306df3495e183304825cd3159bf1ccb1d87.1683930235.git.lorenzo@kernel.org>
 <486cb426-737e-fa57-20da-344fc44bb4de@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4D+/XRYv8Rax2OeT"
Content-Disposition: inline
In-Reply-To: <486cb426-737e-fa57-20da-344fc44bb4de@candelatech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--4D+/XRYv8Rax2OeT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 5/12/23 15:29, Lorenzo Bianconi wrote:
> > mib_stats structure is shared by mostly all chipsets. Move it to shared
> > code.
>=20
> In case this thing hasn't been pushed upstream yet, then a suggestion:
>=20
> Create a struct mt76_mib_stats_common class that has the common counters,
> and then per-driver can have that struct as first member of its mib stats.
>=20
> I have added a lot of per-driver stats that never made it upstream
> and are not fully shared across different drivers.

I would say mt76_mib_stats is quite a general name. I think we can do somot=
hing
like (if it is really necessary):

struct mt7915_mib_stats {
	struct mt76_mib_stats mt76;
	...
};

Regards,
Lorenzo

>=20
> Thanks,
> Ben
>=20
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/net/wireless/mediatek/mt76/mt76.h     | 63 +++++++++++++++++++
> >   .../wireless/mediatek/mt76/mt7915/debugfs.c   |  4 +-
> >   .../net/wireless/mediatek/mt76/mt7915/mac.c   |  2 +-
> >   .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +-
> >   .../wireless/mediatek/mt76/mt7915/mt7915.h    | 63 +------------------
> >   5 files changed, 69 insertions(+), 67 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wi=
reless/mediatek/mt76/mt76.h
> > index 75b5c2c56a92..45bf1022a051 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> > @@ -857,6 +857,69 @@ struct mt76_dev {
> >   	};
> >   };
> > +/* per-phy stats.  */
> > +struct mt76_mib_stats {
> > +	u32 ack_fail_cnt;
>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>=20
>=20

--4D+/XRYv8Rax2OeT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZLKI9gAKCRA6cBh0uS2t
rDI4AQDSjKDXZ6AbzTHfPrmpnCFvJvf9oRDR1fcGOCwjMv3HtwEA7bDBKTUD0ken
m79xrORxMP5kAwyEQglWOGvX3MFybgY=
=D/hV
-----END PGP SIGNATURE-----

--4D+/XRYv8Rax2OeT--

