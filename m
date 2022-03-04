Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817A94CD3CB
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiCDLxJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiCDLxG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:53:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4F261B2ADC
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646394737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLnWEYd6B06miUP9ShhZfHrbLwgIbs7ar/gGymY4dxI=;
        b=D3VgW/entYFf1AGD/U8knjwGYymgq6M2L0+paFy5IthTJSQPIBwhzxl43q4y7+H+Hh9WXv
        pOS62QWBXNakP/FeZep5cFpmTI381uO401nhCxwuR1sz6yH5apcPulssPlSgRzew0QbQuF
        SKtzT/T9xhtlptVWNuVrsMvc2MLU8bw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-23eR-W3tMvSrwxbuOlupEA-1; Fri, 04 Mar 2022 06:52:16 -0500
X-MC-Unique: 23eR-W3tMvSrwxbuOlupEA-1
Received: by mail-qk1-f199.google.com with SMTP id k23-20020a05620a139700b0062cda5c6cecso5317573qki.6
        for <linux-wireless@vger.kernel.org>; Fri, 04 Mar 2022 03:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KLnWEYd6B06miUP9ShhZfHrbLwgIbs7ar/gGymY4dxI=;
        b=lFzcLzZ3L8VlTmHb4Or/tLUhZ2eH5v+PmDj4Z4m0eoIhgvM/KLQNvi+sdLJMl4/QuY
         HGXGxX129Us+mgesn6mGJoMVVePMODJgSOMOkco9GetApl5/EDITJrLQSi7gqo/BJjGh
         Ah7T5b/pl06Yja+dGzgzEKfpjandunmYA+Jn7sOBzLHP6xlOZ4Ly5AJ1kNn7ato0wOzR
         e3hzuZ5nE0QYSR0JU9hSjskhdNi9Cs23GN56gFB+sBRxu5tj1UwZ9GEwbHGLbGb++a5N
         gSs6nquL3beKNTtXyFDmxrZg7VDYm6om3DgsKDxmTMWL718cqKnx6HU9cOAkHC82grbt
         D8Qw==
X-Gm-Message-State: AOAM5337hY6lP9lc2jC/Qyo+mqKniEfpAYAqhhgj/o17ciOTTsLNiW3k
        9vPOjxIsf25smb2CyXEQ3FTNomTc1je9NqrAGJrwBPBGYwi6lYZD+B9CuMlIKIHuDy3cHsdK7Sp
        lMkK5YGVfLXOcWg1JxMxFgG8b5rA=
X-Received: by 2002:a05:6214:21cf:b0:42d:cc:4121 with SMTP id d15-20020a05621421cf00b0042d00cc4121mr27678098qvh.70.1646394735833;
        Fri, 04 Mar 2022 03:52:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKGo10k7Zf7yvB+XVqKyScwHsjhdmSrBYvygYeFSkgVSHlmygv6gKyiyXSvXsDLcAFOjRXMg==
X-Received: by 2002:a05:6214:21cf:b0:42d:cc:4121 with SMTP id d15-20020a05621421cf00b0042d00cc4121mr27678084qvh.70.1646394735487;
        Fri, 04 Mar 2022 03:52:15 -0800 (PST)
Received: from localhost ([37.183.9.66])
        by smtp.gmail.com with ESMTPSA id e9-20020ac85989000000b002de2bfc8f94sm3200576qte.88.2022.03.04.03.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 03:52:15 -0800 (PST)
Date:   Fri, 4 Mar 2022 12:52:12 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jouni Malinen <j@w1.fi>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, hostap@lists.infradead.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: Re: [PATCH 6/9] DFS: introduce hostapd_dfs_request_channel_switch
 routine
Message-ID: <YiH9bM9ay6/yXZiq@lore-desk>
References: <cover.1640014128.git.lorenzo@kernel.org>
 <c1bf7dc195281330e7108c533da5770adf479d84.1640014128.git.lorenzo@kernel.org>
 <20220303225439.GD33342@w1.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8rV6nLJGDvQGW+d0"
Content-Disposition: inline
In-Reply-To: <20220303225439.GD33342@w1.fi>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--8rV6nLJGDvQGW+d0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Dec 20, 2021 at 04:48:21PM +0100, Lorenzo Bianconi wrote:
> > This is a preliminary patch to add Channel Switch Announcement for
> > background radar detection.
>=20
> > diff --git a/src/ap/dfs.c b/src/ap/dfs.c
> > @@ -940,6 +940,85 @@ int hostapd_is_dfs_chan_available(struct hostapd_i=
face *iface)
> > =20
> > +static int hostapd_dfs_request_channel_switch(struct hostapd_iface *if=
ace,
>=20
> > +	struct hostapd_hw_modes *cmode =3D iface->current_mode;
> > +	int ieee80211_mode =3D IEEE80211_MODE_AP, err, i;
>=20
> That i needs to be unsigned int (like it was in the function from which
> it was moved to here) to avoid a compiler warning.

ack, I will fix it

>=20
> > +	u8 new_vht_oper_chwidth;
>=20
> > +	new_vht_oper_chwidth =3D hostapd_get_oper_chwidth(iface->conf);
> > +	hostapd_set_oper_chwidth(iface->conf,
> > +				 hostapd_get_oper_chwidth(iface->conf));
>=20
> This looks quite strange.. hostapd_dfs_start_channel_switch() used
> current_vht_oper_chwidth to store the current value from beginning of
> the function and restored it at this location. The new version in this
> helper function seems to something strange, or well, nothing. That does
> not feel correct.
>=20
> >  static int hostapd_dfs_start_channel_switch(struct hostapd_iface *ifac=
e)
> >  {
> > -	unsigned int i;
>=20
> That's where i was unsigned..
>=20
> > -	u8 current_vht_oper_chwidth =3D hostapd_get_oper_chwidth(iface->conf);
>=20
> And that's where the current value is picked at the beginning of
> hostapd_dfs_start_channel_switch().
>=20
> > -	new_vht_oper_chwidth =3D hostapd_get_oper_chwidth(iface->conf);
> > -	hostapd_set_oper_chwidth(iface->conf, current_vht_oper_chwidth);
>=20
> And this looks quite different compared to what was in the new helper
> function.

ack, I will fix it.

Regards,
Lorenzo

>=20
> --=20
> Jouni Malinen                                            PGP id EFC895FA
>=20

--8rV6nLJGDvQGW+d0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYiH9bAAKCRA6cBh0uS2t
rLTdAQCBT/cUfb21tMJy6CNewKG4i81ro6tuFQJUVaWGDdhXYAEA7k8hGiojtj3o
6nCNz03wREKbwaUf9bkLHDsIDA5nxgg=
=1PQr
-----END PGP SIGNATURE-----

--8rV6nLJGDvQGW+d0--

