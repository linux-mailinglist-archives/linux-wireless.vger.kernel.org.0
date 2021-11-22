Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3F458CDA
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 11:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhKVLBv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 06:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhKVLBu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 06:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637578723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aV21YnslcFFKasiSz2I/ZaKQ4SFsZW/x8CmqNDwJkU0=;
        b=dweqfS7XUT7z4073EMZdocPSMhSEOd36aLO0YwFvTGdHD1d6m7KQwX5O4Pl7+ISGjde2ks
        5DI0QGLN+lfLx+Dmh4MxCWZtOPWM9lKZhoJfetcWcBQ/+3YxMA8Bd0ZAYIzyzF1rJXqERP
        Uc36fcvRf6NqdyDrMujMPWLImADKRlw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-j-JIhN-vONyfjZGwI1z5bw-1; Mon, 22 Nov 2021 05:58:42 -0500
X-MC-Unique: j-JIhN-vONyfjZGwI1z5bw-1
Received: by mail-ed1-f71.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so14446216edx.4
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 02:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aV21YnslcFFKasiSz2I/ZaKQ4SFsZW/x8CmqNDwJkU0=;
        b=IhuUjG2hznJ5pORkhKsheeq2mQrn+C68PNvU3C0tWMxiGm4AOFGcatb5JjjP4Hqhbs
         iyXJ1CIJwA69oFVSp6SiiSjyewvJwkLPajRclQlXAlNWIjqFzymgKcdaMp5fDmGtgAmP
         7GvbI2sUYqsARWD+mTmbOXU6bZTJqn9dNmIMoAuLQnoElt3YIg5prPY7iToiLjqBDwS0
         KszbcFwGin6U6Rnw1fNzii1+hOBDmBI+7wlk/indWZ/wU4lS/Y0ZX5iyM0BCgcIfFKob
         1d0oMf43BhDvSoONWu9088SqYYs6EqltPpJ3P7fSl8Xj0KTwgdG/ETtHOcH5+Wph0m+x
         tC3g==
X-Gm-Message-State: AOAM531CHTFgX3FcI9RC87vuqUcxBWk7lWrEkCM9HNY7SEdPZd7uKXst
        qB/qMisA6b5HRMafRmZJ7VmlHljOzfaRCc6uQRewuumibBjizrE+RUANXY0F2vwMzujFK/bRaJa
        gnU4brG+zje3wud+zWuHSPwvoxJQ=
X-Received: by 2002:a05:6402:3594:: with SMTP id y20mr64167027edc.328.1637578720721;
        Mon, 22 Nov 2021 02:58:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqvugdB/aT1inHUrGcSOuTp9gYKDN+k0jQJP02YHPKsPPSc9n/hJACN9XMBNx/pFyAhqjcqA==
X-Received: by 2002:a05:6402:3594:: with SMTP id y20mr64167010edc.328.1637578720597;
        Mon, 22 Nov 2021 02:58:40 -0800 (PST)
Received: from localhost (net-93-151-197-210.cust.vodafonedsl.it. [93.151.197.210])
        by smtp.gmail.com with ESMTPSA id de37sm3503171ejc.60.2021.11.22.02.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 02:58:40 -0800 (PST)
Date:   Mon, 22 Nov 2021 11:58:38 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, cjhuang@codeaurora.org
Subject: Re: [PATCH mac80211] cfg80211: check nla_parse_nested return code in
 nl80211_set_sar_specs
Message-ID: <YZt33qMzxkxSAAxY@lore-desk>
References: <3b6fee130e2d264242463cff063bcfb6d6f5da83.1637494779.git.lorenzo@kernel.org>
 <a54298c0b747ba562caa47f271f058b9831810ee.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fxByCKSwajzW4WMX"
Content-Disposition: inline
In-Reply-To: <a54298c0b747ba562caa47f271f058b9831810ee.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--fxByCKSwajzW4WMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 2021-11-21 at 12:41 +0100, Lorenzo Bianconi wrote:
> > Check error code returned by nla_parse_nested in nl80211_set_sar_specs
> > routine before parsing SAR sub-specs.
> >=20
>=20
> I don't think we need to. The policy already states it:
>=20
>         [NL80211_ATTR_SAR_SPEC] =3D NLA_POLICY_NESTED(sar_policy),

ack, right, I missed that. I guess we can drop the patch.

Regards,
Lorenzo

>=20
>=20
> Since we always parse the top-level already in the generic netlink code,
> it will recurse down here by way of that policy link, and then it will
> already be validated as much as nla_parse_nested() can do again - so we
> only do it again here to actually get access to the pointers.
>=20
> johannes
>=20

--fxByCKSwajzW4WMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZt33gAKCRA6cBh0uS2t
rMicAP4iCS0Y4hxL6H396MSMyOcxY6Xx4etmrZ1L23l0pMUxSQD9GhzWCHpgPxqZ
RwJ3ZB/HXTzmSdijjVC7g94wukGGsQ0=
=Kc3Z
-----END PGP SIGNATURE-----

--fxByCKSwajzW4WMX--

