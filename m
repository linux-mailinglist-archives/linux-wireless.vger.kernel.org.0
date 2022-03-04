Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051764CD19D
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 10:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiCDJtr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 04:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiCDJtp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 04:49:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA5256D979
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 01:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646387337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DA88YDp1aXlIRjKxKvvKL1bH7OFx/TLYJqYHpJjge+A=;
        b=A9bwSSKN/vlQgZWACwdatdtxw1E28+Q8DxgN0lzddQb67HN2PpWz+b0MGkyT8FGEh6SxHL
        v1PsDRS1eia5IPXzx+RGJh47U3wNkbdf5FQfJxJnVtfZ0Xvtre6KJh5yKlAfgAcC09GQ9P
        SHXUm9QUFmoF+xcpLUTTx9XBQSCFyUs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-wupi7PeTMemaQXN2unzP8w-1; Fri, 04 Mar 2022 04:48:55 -0500
X-MC-Unique: wupi7PeTMemaQXN2unzP8w-1
Received: by mail-wm1-f71.google.com with SMTP id 3-20020a05600c230300b00384e15ceae4so2531913wmo.7
        for <linux-wireless@vger.kernel.org>; Fri, 04 Mar 2022 01:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DA88YDp1aXlIRjKxKvvKL1bH7OFx/TLYJqYHpJjge+A=;
        b=DwRFMUJRufNOFzKLdqh/OTs1dBWBkvFpzUvDwYlQtuOnvoCTQGGSquuA2I+qVzaxkm
         BeXzYvjGb5+JPFVjHZWV0bLNNQ7mGYl04jzfZpMPjIdBLdrO3GpSd1uPK2UZUo1Qn5TF
         WX2/Nrb0Jmu+HF6mIxmdyuQsnYTXvMUw186DsObn5dhiCudb2yXlHL5uFCbzHKQQxWEj
         +nmoTw21vRUuCc8dlGWhc2wwrWAfXybqiScPrLlGyACbI41fyNLTRvM8SiPaV7szHm2Y
         qAI4fYzDzxXA6EsRhK4N4n8VHEGmXRutlfu7TGYNS6EmPNTRtYgy31qEfWPKqti8XBr6
         8W9A==
X-Gm-Message-State: AOAM532QGhWFlZjygv7fEqgsr3vCE0UJqCabao5UOiK3n1+oUvVc4Ob0
        c9U+7+nojgDWnhcga0rAYwAMr34JTyBJhn7YQzYsTHwlJtIS0wUGRKjFGkxta8lQTF4JEkSLAuW
        cF/gON3GZ/3fHOs155m9VV0z1ygo=
X-Received: by 2002:a1c:f315:0:b0:381:1f6d:6ca6 with SMTP id q21-20020a1cf315000000b003811f6d6ca6mr7013385wmq.25.1646387334530;
        Fri, 04 Mar 2022 01:48:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywT7HggAPGIm4CVmNq1XdeJdSX7YfwBafBFRZvhAbD7vIBNKz9T7Jiy5Y+fpBismtVH3vfOA==
X-Received: by 2002:a1c:f315:0:b0:381:1f6d:6ca6 with SMTP id q21-20020a1cf315000000b003811f6d6ca6mr7013366wmq.25.1646387334304;
        Fri, 04 Mar 2022 01:48:54 -0800 (PST)
Received: from localhost ([37.183.9.66])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c4fd600b0038133076dcesm4939622wmq.16.2022.03.04.01.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 01:48:53 -0800 (PST)
Date:   Fri, 4 Mar 2022 10:48:51 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jouni Malinen <j@w1.fi>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, hostap@lists.infradead.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: Re: [PATCH 0/9] introduce background radar detection support
Message-ID: <YiHggy0NLUwHVMXR@lore-desk>
References: <cover.1640014128.git.lorenzo@kernel.org>
 <20220303231922.GA481387@w1.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qdwdfWUnNTaLKKWa"
Content-Disposition: inline
In-Reply-To: <20220303231922.GA481387@w1.fi>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--qdwdfWUnNTaLKKWa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Dec 20, 2021 at 04:48:15PM +0100, Lorenzo Bianconi wrote:
> > Introduce background radar/CAC detection through a dedicated off-channel
> > chain available on some hw (e.g. mt7915).
> > Background radar/CAC detection allows to avoid the CAC downtime
> > switching on a different channel during CAC detection on the selected
> > radar channel.
> >=20
> > Lorenzo Bianconi (9):
> >   Sync include/uapi/linux/nl80211.h with mac80211-next.git
> >   DFS: introduce dfs_set_valid_channel utility routine
> >   DFS: add capability select radar-only channels
> >   nl80211: report background radar/cac detection capability
>=20
> Thanks, applied patches 2-4 with some cleanup (mainly, replaced the
> int flags parameter in 3/9 with an enum to make the code more readable.
> Patch 1 changes are covered by another commit.
>=20
> >   DFS: configure background radar/cac detection.
> >   DFS: introduce hostapd_dfs_request_channel_switch routine
> >   DFS: enable CSA for background radar detection
> >   DFS: switch to background radar channel if available
> >   DFS: introduce radar_background parameter to config file
>=20
> These have open questions or dependencies on patches with open
> questions.

Hi Jouni,

Thx for the review, I will address comments in the pending patches.

Regards,
Lorenzo

> =20
> --=20
> Jouni Malinen                                            PGP id EFC895FA
>=20

--qdwdfWUnNTaLKKWa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYiHggwAKCRA6cBh0uS2t
rMzsAQDP6Q4wRk5zHo8qJORTTvhdCWj6VPBYqWcsF5mYUoYomgD8CQkam7uVzK//
VPnjoRjgtR6Jgjwvs8JNndSgmDrStAw=
=MWih
-----END PGP SIGNATURE-----

--qdwdfWUnNTaLKKWa--

