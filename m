Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB5072A974
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jun 2023 08:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjFJGoJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jun 2023 02:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFJGoJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jun 2023 02:44:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358F43A89
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 23:44:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-651f2f38634so2650123b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jun 2023 23:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686379447; x=1688971447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9028RCYhy0wUCoYOed6ZfhpUYbRnkrP1YsKrCE12Bj8=;
        b=ovR/GYdBQyiemHONPmM5TJdwY8+SHiZ/Q7msRoBEkXXtGY8i+EGoMk4rnoJE9CHf80
         HwVCL1QsLSNTxp+5ayaQtILzC2vlGaK3pMU+Ee+sGBAmlO+n2f1yOe425sOTtxSwSEXM
         OiyQyPC2wQBvhRxDe026rOvfSVyhkX/37GC3xjrNGsITRhG+9ryNT6pUkbsq/XDQJNzH
         eIw8YiVnbriz1ZWB8YBbBWOKUq/uad09R3VsIYu8551GKJfrsDCKdT4hOsYafODdrXTK
         jdTQSGqLw3pZlTaaaFGrb2ImveCf9jdM4Q48n+hJSZt50Rm8nFIq4gfrjgKdIcaZWCxz
         xOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686379447; x=1688971447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9028RCYhy0wUCoYOed6ZfhpUYbRnkrP1YsKrCE12Bj8=;
        b=HCpby2K4WkHHBiRRGQl9U1yTH0vhAqaBNeI52GGiq2ijF/BuAa/w2h2ZvHiAH7kanQ
         zI1w6wG8aK9uCTVVwjKepjDGGcdS7e7aeKaisryJeTxoKZ50bEY1d0DW0co5rIA+8LJ6
         P9rZStKyUduOTFMEoB5WIurH84fJlQ+XVANj9a1vr952lfBFfGdMOH/t0FT1UOSR584E
         WpPeVI/uLJakbin1zJkhMxOsr2/qniWBJvKauFNYABqCSoYZlDvEYyoN6/EYmtWqh29J
         ybIovI0V1VB+iyvzZl5o7LEoDQJ1aigo+oE4YtZg7Dj8rZozBU/WpqKBpksy+BQIc/mW
         5Yaw==
X-Gm-Message-State: AC+VfDxatsS+id9pKjfrAeAzrLqhHVo+tRPuBW6mXwy1DCoSZAF9ww54
        GKtFLgODM42hjjhcDVMp+aZSgsABQWc=
X-Google-Smtp-Source: ACHHUZ4vYhETxEs/w9/FVf1Gl+uDCEWXTwPOi3yFwtPwNyS09TWtQGWr/VaLzt1ERAsJo82k+Md6mQ==
X-Received: by 2002:a05:6a21:30ca:b0:10e:e813:46ed with SMTP id yf10-20020a056a2130ca00b0010ee81346edmr3081409pzb.43.1686379447522;
        Fri, 09 Jun 2023 23:44:07 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id c16-20020aa781d0000000b0063f0068cf6csm3550562pfn.198.2023.06.09.23.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 23:44:07 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DBDBC106AB1; Sat, 10 Jun 2023 13:44:03 +0700 (WIB)
Date:   Sat, 10 Jun 2023 13:44:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Nicolas Escande <nico.escande@gmail.com>, nbd@nbd.name,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [regression] STP on 80211s is broken in 6.4-rc4
Message-ID: <ZIQbs0wqdRh7c0Kx@debian.me>
References: <CT5GNZSK28AI.2K6M69OXM9RW5@syracuse>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AnK2bowbY2wzP825"
Content-Disposition: inline
In-Reply-To: <CT5GNZSK28AI.2K6M69OXM9RW5@syracuse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--AnK2bowbY2wzP825
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 12:55:57PM +0200, Nicolas Escande wrote:
> Hello Felix,
>=20
> As user of the mesh part of mac80211 on multiple products at work let me =
say
> thank you for all the work you do on wifi, especially on 80211s, and espe=
cially
> the recent improvements you made for mesh fast RX/TX & cross vendor AMSDU=
 compat
>=20
> We upgraded our kernel from an older (5.15) to a newer 6.4. The problem i=
s STP=20
> doesn't work anymore and alas we use it for now (for the better or worse).
>=20
> What I gathered so far from my setup:
>  - we use ath9k & ath10k
>  - in my case STP frames are received as regular packet and not as amsdu
>  - the received packets have a wrong length of 44 in tcpdump
>    (instead of 38 with our previous kernel)
>  - llc_fixup_skb() tries to pull some 41 bytes out of a 35 bytes packet
>    this makes llc_rcv() discard the frames & breaks STP
>=20
> >From bisecting the culprit seems to be 986e43b19ae9176093da35e0a844e65c8=
bf9ede7
> (wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces)
>=20
> I guess that your changes to handle both ampdu subframes & normal frames =
in the
> same datapath ends up putting a wrong skb->len for STP (multicast) frames=
 ?
> Honestly I don't understand enough of the 80211 internals & spec to pinpo=
int the
> exact problem.
>=20
> It seems this change was already in the 6.3 kernel so I guess someone sho=
uld
> have seen it before (but I didn't find anything..) ? Maybe I missed somet=
hing...
>=20
> Anyway I'm happy to provide more info or try anything you throw at me.
>=20

Thanks for the regression report. I'm adding it to regzbot:

(Felix: it looks like this regression is introcued by a commit authored by =
you.
Would you like to take a look on it?)

#regzbot ^introduced: 986e43b19ae917

--=20
An old man doll... just what I always wanted! - Clara

--AnK2bowbY2wzP825
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIQbrwAKCRD2uYlJVVFO
o6mfAPwKDa60GgI6OLmQE2Azp1jDptNJ1AD+/oDHNObrFjqZCAEAm+tAyXvMCHPG
aE8UayLKE+V/ziT/lC2I6IDiS4+f6Qs=
=Wcw6
-----END PGP SIGNATURE-----

--AnK2bowbY2wzP825--
