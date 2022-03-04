Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F814CD30F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiCDLJN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiCDLJM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:09:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC265A645C
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646392103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7IVnnvff8kOoyMP17lSUboCVXSpbzZv1N+T7obG6nJY=;
        b=heIKVmoi3XIA0oaRn4fFnh0l6na1KE8t6DFagqaSfFxniIQM1+YKpXCkTYmP6Rj8v5iYMg
        5VWrXyDQAQQb2BqCvJtrg2tLV3nO4MxC9epUqZKnh1kRoqI0Ra+ObH4Zj7TbU1vaCUPeVJ
        NDOoe6VY4ntZ9jsrQidivGbU9GRC2pU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-6uoLAbiuPwqCyBHu0ktNdw-1; Fri, 04 Mar 2022 06:08:22 -0500
X-MC-Unique: 6uoLAbiuPwqCyBHu0ktNdw-1
Received: by mail-wr1-f70.google.com with SMTP id o1-20020adfe801000000b001f023455317so3248097wrm.3
        for <linux-wireless@vger.kernel.org>; Fri, 04 Mar 2022 03:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7IVnnvff8kOoyMP17lSUboCVXSpbzZv1N+T7obG6nJY=;
        b=dSCzvp/Tc+bHNtjNlSlzak3BiUesGi5P6X6WOVgRNDdD36+dmEexTcGUMqRHmBtpEY
         HqQYQ3KOJNL+9AS6ZYi98U55xQi8xwqti+C2ZI8Z2xNqaenUVHvmnUAbCJ6Zcaq6Fpv+
         ayyhy9R6VQ5mSqj74fYvg9NfZwbCJkqeWGJDE2Idr6VdATX2Wc1/5SZpMzYuZx4965xq
         vfCguSc9wRRyqx1T7DNVbgh+pUnvoX7hAkLdevZ9AbtE2V8PcqItmi4aOJ6iyhrBqUP4
         DXHPrBesdx91C5/w2D2WGPLjQtooZwUfC0MaMp5AViMWbB0qOhEAH4mBdibQ3cN8LCCY
         eEMw==
X-Gm-Message-State: AOAM533EF6D9Dhe0dIeEwllnTxrqMTPPovJ95d+q9ff5vr9g1x11QoOK
        o+FaFOOJjFziVajSuYNvMMzLnOJAKFUPIkEbecSVNH+NKJxQWn59ivZe8ma7iJn/0L0CVu65ctO
        D8snN5qM0HCypZCChbITcJ0FlKqo=
X-Received: by 2002:adf:e941:0:b0:1f0:6427:cc69 with SMTP id m1-20020adfe941000000b001f06427cc69mr3654457wrn.345.1646392101517;
        Fri, 04 Mar 2022 03:08:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXaXuzicyQdwY+ENZdYZWNXr4s9lCYENyvI3fBGUvx3TsNMZwY1fi7QhUj8bkmxvKnjWkPeA==
X-Received: by 2002:adf:e941:0:b0:1f0:6427:cc69 with SMTP id m1-20020adfe941000000b001f06427cc69mr3654445wrn.345.1646392101314;
        Fri, 04 Mar 2022 03:08:21 -0800 (PST)
Received: from localhost ([37.183.9.66])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b001f0247bbdf7sm4331244wrt.64.2022.03.04.03.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 03:08:20 -0800 (PST)
Date:   Fri, 4 Mar 2022 12:08:18 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jouni Malinen <j@w1.fi>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, hostap@lists.infradead.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: Re: [PATCH 9/9] DFS: introduce radar_background parameter to config
 file
Message-ID: <YiHzIglySEgZpwii@lore-desk>
References: <cover.1640014128.git.lorenzo@kernel.org>
 <3683c678668c4de0ee849974977cf56e64c7162c.1640014128.git.lorenzo@kernel.org>
 <20220303215647.GA33342@w1.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E3noIzPmcmMEc2Cy"
Content-Disposition: inline
In-Reply-To: <20220303215647.GA33342@w1.fi>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--E3noIzPmcmMEc2Cy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 03, Jouni Malinen wrote:
> On Mon, Dec 20, 2021 at 04:48:24PM +0100, Lorenzo Bianconi wrote:
> > Introduce radar_background parameter to configuration file
> > in order to enable/disable background radar/CAC detection.
>=20
> What's the use case for this new parameter and the configuration having
> to explicitly enable this functionality? Is there a reason for not doing
> this in cases where the driver supports this capability? It looks like
> patches 1..8 were enabling this functionality automatically and it is
> only this final patch that makes it depend on a configuration parameter
> (which is default by default).

I added this parameter just to add the capability to disable radar_backgrou=
nd
even if the hw supports it (e.g. for testing/debugging).=20

>=20
> > diff --git a/hostapd/hostapd.conf b/hostapd/hostapd.conf
> > @@ -143,6 +143,13 @@ ssid=3Dtest
> > +# Enable radar/CAC detection through a dedicated background chain avai=
lable on
> > +# some hw. The chain can't be used to transmits or receives frames.
> > +# This feature allows to avoid CAC downtime switching on a different c=
hannel
> > +# during CAC detection on the selected radar channel.
> > +# (default: 0 =3D disabled, 1 =3D enabled)
> > +#radar_background=3D0
>=20
> How would someone writing hostapd configuration know when to enable
> this? Or maybe more importantly, when one should not enable this? Would
> use of that dedicated background chain result in some other capabilities
> getting reduced?

nope, the radar_chain is completely independent from the "data" ones.

>=20
> This is also a bit unclear on what happens if the driver does not
> support this capability and radar_background=3D1 is explicitly set in the
> configuration.

it will not be enabled since we always check WPA_DRIVER_RADAR_BACKGROUND
capability.
Since it is not mandatory, I will drop this patch in the series and always
enable RADAR_BACKGROUND if supported by the hw.

Regards,
Lorenzo

>=20
> --=20
> Jouni Malinen                                            PGP id EFC895FA
>=20

--E3noIzPmcmMEc2Cy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYiHzIgAKCRA6cBh0uS2t
rNxBAP9UTvVdvZwjzRHeb1LCgnLWD3/49kx9Itx9ROMttDwqSgEAj3jpM9foQJEA
OmQ4kDga0XXBtkL1glPaiYCs8bS4QAI=
=iJjd
-----END PGP SIGNATURE-----

--E3noIzPmcmMEc2Cy--

