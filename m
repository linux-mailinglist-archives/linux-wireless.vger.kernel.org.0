Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121794CD569
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 14:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiCDNrc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 08:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiCDNrb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 08:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB5981B84FF
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 05:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646401603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wz6z65dkHPdQyQ0pWYfJjraXVAkrYsdmyBNYDdC7B3o=;
        b=QdYyHR0U21N23UpJGoKKqyOwA2n2vWh3s8Azg8zO5E9YZHcy9hufT9B+evb3EeH5+0tL/Y
        J7eKvgxbYIZp96xkT2+RQmaixTUshPSybI8EGlnxtnYDw4Fpi97eT47DBgwAO4OU3Y1DGg
        RfxJrVnaDVLbNbW6Jjpt6pRdTIzuZtQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-2IXCLo0fMt-yenot6_QCfg-1; Fri, 04 Mar 2022 08:46:39 -0500
X-MC-Unique: 2IXCLo0fMt-yenot6_QCfg-1
Received: by mail-wm1-f71.google.com with SMTP id 14-20020a05600c104e00b003897a167353so567057wmx.8
        for <linux-wireless@vger.kernel.org>; Fri, 04 Mar 2022 05:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wz6z65dkHPdQyQ0pWYfJjraXVAkrYsdmyBNYDdC7B3o=;
        b=I/A7NUZxHpm5xfWa3tzO2rWmX0Mf7/87TRbJXdb5kr/H88/FsTRjTlZQ1KJ8tXwlFh
         5N6io0fk578+inTw7vyztdw/VvlxNbn45ajOE2XNcEWnugesWnjB6XQDrhIGhw4rlQDA
         zWQZcW0s4SPoVziJna/UoHZolB+ASe3YWjXUwZhEMRnPYkSRwcBRjEgdAkgg3pqg30II
         jRl/vlwM+psItXGDTdAw/YA/JqZzlq31LFOTgMKs5CsOEghFncXVBugmQf1NkuBJ1uLU
         1NdXjWwiSUf/oIjrL38KWMThpB5fs8KWhmsQ+PD//2EyDjS19AKUf2sUdHfF0gJsofEv
         9IRg==
X-Gm-Message-State: AOAM530GGuKtnvH8Ovt1JOZQK0NhGGRAJxMSXe8sDX0nePSDNe4pC4/P
        ddda9ugPgdbZDkOcXJetOb8BWbyBfE4egWkTgV+5866ibgwCmtnOYB9QR2BkonV9xZvHyUu9pZK
        rAosqu7H4ENINnGs5m0d/08NjiJQ=
X-Received: by 2002:a1c:730e:0:b0:381:103f:d6d9 with SMTP id d14-20020a1c730e000000b00381103fd6d9mr7678756wmb.46.1646401598464;
        Fri, 04 Mar 2022 05:46:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztzn670jFCGVKJcrKHdY7hzQCt9wDoFTJ9g8ihoRQEE+zs2gw/11hBOYRc/bYkBgotquxzXw==
X-Received: by 2002:a1c:730e:0:b0:381:103f:d6d9 with SMTP id d14-20020a1c730e000000b00381103fd6d9mr7678747wmb.46.1646401598217;
        Fri, 04 Mar 2022 05:46:38 -0800 (PST)
Received: from localhost ([37.183.9.66])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d6d0f000000b001ef7dca67fasm5365891wrq.114.2022.03.04.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:46:37 -0800 (PST)
Date:   Fri, 4 Mar 2022 14:46:35 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jouni Malinen <j@w1.fi>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, hostap@lists.infradead.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: Re: [PATCH 8/9] DFS: switch to background radar channel if available
Message-ID: <YiIYOzben74/wF/d@lore-desk>
References: <cover.1640014128.git.lorenzo@kernel.org>
 <ec706e090d7e44bcc9afd2f9789802f8c07e3c3f.1640014128.git.lorenzo@kernel.org>
 <20220303222009.GC33342@w1.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0kc95zljO+Fjl9/s"
Content-Disposition: inline
In-Reply-To: <20220303222009.GC33342@w1.fi>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--0kc95zljO+Fjl9/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Dec 20, 2021 at 04:48:23PM +0100, Lorenzo Bianconi wrote:
> > On radar detection on the main chain switch to the channel monitored
> > by the background chain if we have already performed the CAC there.
>=20
> Is it clear that the channel on the background chain, if one is
> available with CAC performed, comply with the ETSI uniform spreading
> requirements? The comment below feels a bit misleading, but the way
> patch 5/9 picks the channel for background CAC might be sufficient for
> this. If so, it would be good to note that in the comment here:

ack, got your point here. We should force channel_type to DFS_ANY_CHANNEL
for ETSI regdmain in hostpad_dfs_update_background_chain() and not just
DFS_NO_CAC_YET. I will fix it in next revision. Thanks.

Regards,
Lorenzo

>=20
> > diff --git a/src/ap/dfs.c b/src/ap/dfs.c
> > +hostapd_dfs_background_start_channel_switch(struct hostapd_iface *ifac=
e,
>=20
> > +	/*
> > +	 * If background radar detection is supported and radar channel
> > +	 * monitored by background chain is available switch to it without
> > +	 * waiting for the CAC otherwise let's keep a random channel.
>=20
> That first part leaves it a bit open whether the random channel part from
> the end of the sentence applies in practice for the new operating
> channel. It is important to make this clearly describe the functionality
> needed to meet uniform spreading requirement.
>=20
> --=20
> Jouni Malinen                                            PGP id EFC895FA
>=20

--0kc95zljO+Fjl9/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYiIYOwAKCRA6cBh0uS2t
rMAtAQC74SmxQqvKrUhntSYvQS7xZI7Pal1eDgmxft1dG45NVQD/Yf0bqfb6g8Ug
u6QcANGr+2IzTV/KuLVZgQAySVF4Ngc=
=Bs87
-----END PGP SIGNATURE-----

--0kc95zljO+Fjl9/s--

