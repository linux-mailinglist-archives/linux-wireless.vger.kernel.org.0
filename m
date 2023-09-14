Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B0679FC51
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 08:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjINGxV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 02:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjINGxU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 02:53:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09935CCD
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 23:53:16 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DE1D43F66B
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 06:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694674393;
        bh=HiHG2jt50W9HCzIxwUn2Z5ZHOh1f4Ny/paadoyMnaSk=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=t7h+2zUv8vLTH8LRFKSoZXMmDb+yvTnk690n1yV3H5Tkru8d9AZtc7jLgeCgpL2uK
         az/FVsWNJIHZOE2oNsrLTqbUwRr/Z5EADyex7DsCxgpuYp/j2655knmaalqx4RB7kh
         hXJ8PolLkk8bNcK0hmk6S3VW6VXZv8taliPI7lX5QBD8JMXSGTa6GKAvjf/MMuIgR+
         dj7Qr6cJHQ8cXW+jDGHWSBmWKvVVBfh4ML45ChDCBpgN+rPRfa92PbacVs5cxDUWtu
         oijZR7NYiUCRGvx785Bo2KLIZGWt35IbZGw/KTEmnrRmkZxqoC/HSIxoxLYYHmbXF2
         z/PL490+0y1EQ==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31f8e062cadso430521f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 23:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694674393; x=1695279193;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiHG2jt50W9HCzIxwUn2Z5ZHOh1f4Ny/paadoyMnaSk=;
        b=X8r2YzcXApH5yHOfxBiqtlOdrUHfA974B9GVmV8XcYtLE5l7N/mChm+McErO8gG1bI
         aeVjIl8sWM9dayt6Dbql0blH7CS6Jf/sdM0hD3qYpkG1Eu+WHCKNp9iO8M+Oo9DVNKHq
         iLhR2D6WkEkrV2pWIVFDaZY7l7Bm+STsktRaQ0/mzv1Uhgb/KC39BZsOgPLcyMw9lMW6
         LyxPQvd6L7SvFKJQ4/InarSZaQ6Qy292cO0Lz75CBWZsE/TxkjQIP2jc/b//bKPlwvFg
         pr/ZE51ZOy8tEQP3zX89nGi4Zicv5+r3lRqfAVMXQCxKrF1WdxOP2CwaQfkl0/hCetvG
         ayoQ==
X-Gm-Message-State: AOJu0YzEIv9bJ6pdWeymtxb2r14W9NRZkWr94LWO5ZbdGbc8/6Xv9jRh
        1hPJroGTLaR+pjza2YBN3/Y0N2gaOrhlEUeeqVlSvz6VmYRllfA6w8MjhmDk06OPgBGHZh/jAro
        TrKjC94+16KSbMkOjDPIAgzvSfNHIpplguJrlepncTk31
X-Received: by 2002:a5d:5985:0:b0:31f:e2b9:de1f with SMTP id n5-20020a5d5985000000b0031fe2b9de1fmr525033wri.24.1694674393536;
        Wed, 13 Sep 2023 23:53:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpdWk/K3M8ecFkXkPMJyw76oX3Q9tBYVnSnX+gjm/uUsFWyOCaJRPfYeiT9dtQzLd6vakkxQ==
X-Received: by 2002:a5d:5985:0:b0:31f:e2b9:de1f with SMTP id n5-20020a5d5985000000b0031fe2b9de1fmr525021wri.24.1694674393196;
        Wed, 13 Sep 2023 23:53:13 -0700 (PDT)
Received: from smeagol ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000100c00b0031ae2a7adb5sm857727wrx.85.2023.09.13.23.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 23:53:12 -0700 (PDT)
Date:   Thu, 14 Sep 2023 08:53:10 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, marcan@marcan.st, keescook@chromium.org,
        gustavoars@kernel.org, hdegoede@redhat.com,
        ryohei.kondo@cypress.com
Subject: Re: [PATCH] wifi: brcmfmac: Replace 1-element arrays with flexible
 arrays
Message-ID: <20230914085310.334e4c09@smeagol>
In-Reply-To: <0f23e4a2-b11b-98bd-c419-d9a9fb7ddb4e@embeddedor.com>
References: <20230913065421.12615-1-juerg.haefliger@canonical.com>
        <0f23e4a2-b11b-98bd-c419-d9a9fb7ddb4e@embeddedor.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SB99e06DGpk4FarBJmna.kW";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/SB99e06DGpk4FarBJmna.kW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Sep 2023 10:02:12 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 9/13/23 00:54, Juerg Haefliger wrote:
> > Since commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC"),
> > UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> > 'element' and 'channel_list' will trigger warnings, so make them proper
> > flexible arrays.
> >=20
> > False positive warnings were:
> >=20
> >    UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/br=
cm80211/brcmfmac/cfg80211.c:6984:20
> >    index 1 is out of range for type '__le32 [1]'
> >=20
> >    UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/br=
cm80211/brcmfmac/cfg80211.c:1126:27
> >    index 1 is out of range for type '__le16 [1]'
> >=20
> > for these lines of code:
> >=20
> >    6884  ch.chspec =3D (u16)le32_to_cpu(list->element[i]);
> >=20
> >    1126  params_le->channel_list[i] =3D cpu_to_le16(chanspec);
> >=20
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > ---
> >   .../wireless/broadcom/brcm80211/brcmfmac/fwil_types.h    | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_type=
s.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> > index bece26741d3a..ed723a5b5d54 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> > @@ -442,7 +442,12 @@ struct brcmf_scan_params_v2_le {
> >   				 * fixed parameter portion is assumed, otherwise
> >   				 * ssid in the fixed portion is ignored
> >   				 */
> > -	__le16 channel_list[1];	/* list of chanspecs */
> > +	union {
> > +		__le16 padding;	/* Reserve space for at least 1 entry for abort
> > +				 * which uses an on stack brcmf_scan_params_v2_le
> > +				 */
> > +		DECLARE_FLEX_ARRAY(__le16, channel_list);	/* chanspecs */
> > +	};
> >   };
> >  =20
> >   struct brcmf_scan_results {
> > @@ -702,7 +707,7 @@ struct brcmf_sta_info_le {
> >  =20
> >   struct brcmf_chanspec_list {
> >   	__le32	count;		/* # of entries */
> > -	__le32	element[1];	/* variable length uint32 list */
> > +	DECLARE_FLEX_ARRAY(__le32, element);	/* variable length uint32 list *=
/ =20
>=20
> If no padding is needed, as in the other case, then DFA() is not necessar=
y.
> Just remove the 1 from the array declaration:
>=20
>   struct brcmf_chanspec_list {
>          __le32  count;          /* # of entries */
> -       __le32  element[1];     /* variable length uint32 list */
> +       __le32  element[];      /* variable length uint32 list */
>   };

Ah, I wasn't sure if that is still acceptable. Will send a v2.

...Juerg

=20
> --
> Gustavo
>=20
> >   };
> >  =20
> >   /* =20


--Sig_/SB99e06DGpk4FarBJmna.kW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmUCrdYACgkQD9OLCQum
QreEhg/8C6JzNKkwPCXJ14Nhx2JA/oY9A5EkPWKnZNJvJkKRINnnPsYwOL02fkkR
AlhjKGuPP5kpqq80ybANO6ke1CLqNJ1qHvmHpIK4M8BX6fQofLPPrszRiFF2K5Ny
WNmdMmn8cV8Yu/xkkTPHT8EsWN1/5HNrG1aHV8im4OV3v3Dw1+0JQuhdYvQU1Ogu
FWECYLscSYiwkeSaJ7khVhMakS9brskZh5OpvNRkmJQu3EKvp7HpEWmaAIiBjyWt
7+MeC9W/yY037Wksh3kmLCAYEXh3037WyZ+sGjHigGl5h8ygUyCJO8TW83ALpaaS
3WDG4cRNNjR3BgnoBeBWpjiR3PRc7JMlRYzG0a+7WGgcybJMTvf/W/RooLFuMDZ+
KvQlQs+9lIrl8XKtUEhoqWCbkSKgf4ZWQ9vH76sT4Wv9qqx3A5MJ06bPWWY/A72v
6TL4H+0d/kvpQ+qZwBg6t16it3hm7U+bJo9KFtbRgtmcIgWYjpK5QXQoiPOpVVec
RP/p9SUy6iseTLMIevQ9fvNN5e/rwqRVEAq8dzyADXmg8FhC7lCnXOMmJMdTbMNj
Cb6px7h+Yexa+5g5ZzN6Xv3cJEWplKHe+Uml0XtnWuk7SLLZzu6EgUN4cwyOEFwd
gROXMdp/2OHpSU1xUYtI4kezz8aSz/EqJtxGH/xtUe4l4RUJkgE=
=pv6c
-----END PGP SIGNATURE-----

--Sig_/SB99e06DGpk4FarBJmna.kW--
