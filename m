Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23696F9697
	for <lists+linux-wireless@lfdr.de>; Sun,  7 May 2023 04:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjEGCeQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 May 2023 22:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGCeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 May 2023 22:34:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B613C0C;
        Sat,  6 May 2023 19:34:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64359d9c531so2443946b3a.3;
        Sat, 06 May 2023 19:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683426851; x=1686018851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6m2i8964ey9FKIQVYoul4zNGiU1tR8noRvHejWkEJ4U=;
        b=fbNOOrGXXgaOaj3QPUvXonFQi2tDbKt0CqVt4X+Hlqmg7a3ceS6LXRbjnKbVljFoab
         tLYLFmYp0XeF9R49438ynw9RLL2pzJFOgHmQIVFPoRHiEHJHa5FNkwUZJgFnLb9WB1hH
         EB7cKRkSqTQ3ZT2TJrEqbZsG98VWKjG65GbXFNPD0mMsDBaiXmvbOi5NUbzRAkKjzMH4
         WZFvk90M4V/cCQrOypS+YQF9KUc1Vpd86o/lb6OLhKx2yytluvpgjNbyrV1BqUqKYuIW
         ZGEjO6WCQYkaO3+apd42b3lwgkX42mE9siQ6iwzLKJFn3c7syaFpuTdf/GMzG8FW9z5Y
         itkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683426851; x=1686018851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m2i8964ey9FKIQVYoul4zNGiU1tR8noRvHejWkEJ4U=;
        b=JAhtF/+lLOZsGtQ4LhAqefuI8eM2kum7dlr2VhukdcwslxeBhSsGWTCAVm1lunXS++
         lIHSWfTROtibYopUx2yc8zcGE/fo4cBnRRK+yOGOpkoPgxg5UHZVWDDMLdepuHo8Qt9n
         6Po88lMj7hfkDaXjmERBwOcSAe1xVEc0J2rMXVHTDCQmp/d2uTCHgmj5FV9pdWN/Jm3Y
         LGa5fiymABDSvYHThBkKQM98t7LB32nJlEWbsYEpjdek9yFdMSRF9luckQT/0z6UBwas
         oXXwrM2N3U6hbT+3oyOWf0QwCjbarArUMVC/1JWgvqNk8oWueJv4glP9vhpa8iQAUShH
         Y/3w==
X-Gm-Message-State: AC+VfDzIt0osTa87m9Vey4s8WMvd34m+Ed/fpWPY2Y5Nsj+JxuNDcNUu
        +8uZnDuuNPbtI/ZOrGBN3D/9qqQ5Slw=
X-Google-Smtp-Source: ACHHUZ6t6+esLF0hTaUE8GkdhdpwOOQtP+mQuy2cIC4+az7TXUhgl0cD/GlkNfQaYUIz+sGKijgUEw==
X-Received: by 2002:a05:6a21:7898:b0:f0:5a5b:7bea with SMTP id bf24-20020a056a21789800b000f05a5b7beamr8357667pzc.61.1683426851152;
        Sat, 06 May 2023 19:34:11 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7850c000000b00627e87f51a5sm3723168pfn.161.2023.05.06.19.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 19:34:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F12B1106873; Sun,  7 May 2023 09:34:06 +0700 (WIB)
Date:   Sun, 7 May 2023 09:34:06 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     evgeny nikiforov <evgeny.niki4off@gmail.com>,
        stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Golan Ben Ami <golan.ben.ami@intel.com>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Subject: Re: [iwlwifi] 6.3 regression, AX201 crash on traffic activity with
 Pixel 7, bisected
Message-ID: <ZFcOHkwI8erdlKdC@debian.me>
References: <CAPrf5XXD8COh6DK9s41uvgJ5V57nenUQVeb1f=cFVqaWDN++dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F/57nm9pIGEA54YJ"
Content-Disposition: inline
In-Reply-To: <CAPrf5XXD8COh6DK9s41uvgJ5V57nenUQVeb1f=cFVqaWDN++dA@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--F/57nm9pIGEA54YJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 02:29:14AM +0500, evgeny nikiforov wrote:
> Hello
> I have a laptop with Intel Wi-Fi 6 AX201.
> After updating from 6.2 to 6.3, I'm experiencing wifi crashes, wifi
> restart when traffic is flowing with Pixel 7 Pro (wifi 6E/802.11ax).
> Other older wifi devices probably not affected (tried Xiaomi pad with
> wifi 5/802.11ac).
> Tested with iperf3 in both directions, rsyncing Pixel photos to
> laptop, via router (wifi 5) or via Pixel wifi hotspot.
> The whole system freezes for seconds, no cursor movements possible at
> these moments (libinput "Touch jump detected and discarded" in logs
> indicating this).
> No problem with the 6.2 kernel.
>=20
> Bisecting leads to this commit of bumping FW API to 74
> 9ad1e7e5b0c488e4518edd698238a87ac6a73caa,
> looking strange to me, but reverting from 74 to 72 in 6.3 indeed
> successful with no crash.

Thanks for the report. However, it is better to also attach your .config
so that people here can know which config options are enabled (and your
hardware setup).

Interestingly, when I see the culprit commit, it looks trivial to me:
it just bumps maximum firmware API version, so theoretically drivers
using lower API version should continue to work. Maybe you got
one of your bisection steps wrong.

Anyway, I'm adding this to regzbot:

#regzbot ^introduced: 9ad1e7e5b0c488
#regzbot title: AX201 crash on traffic activity due to firmware API bump

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--F/57nm9pIGEA54YJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFcOGAAKCRD2uYlJVVFO
ox7CAQDz7X4BIZetFYf5xDlesSK4n/xhGALqkQA/jbiy76HqXwD/VdhazGC5IYYE
0QcUnhKVoWyq18YVsBCPK4gMmS1s5wQ=
=7XJc
-----END PGP SIGNATURE-----

--F/57nm9pIGEA54YJ--
