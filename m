Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FD876108D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 12:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjGYKWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjGYKW3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 06:22:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C920910D8
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 03:22:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb8e45185bso12188175ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690280547; x=1690885347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=st1c6y6bpzS1m6/OLQ/WRJ6hdioncwRRD9te/qaHNm0=;
        b=oNjiEPYT5xOd9syCdBiia6JXFOYaOrHnjHetbNWxCruQpkyjk8GxUDHaUBmzcM9sfI
         h8TTZ8w/VZ7QrAR9K9e6Ysre8HdyuCc6K6zRwM+AJv7wRMtSr9hkiAcpkR0FiIAYJT7+
         1vwauLkrXnK3A9JSX8+3X9S7MPKt+skRTqGpiAcoQhpiDwn6zMQArGrgd9qLBed+0CBq
         AwHuQ4GTKICZM7nheNUM2qFjR9b0SfxernYQmC47+DAmnzp8oRE0pnG9cinfWRETHmf9
         AFT3/0FNfpB9o0z0rtsxJG4TB3sFgRSigpCQSs6GMV68uOzx1Xja6I3569vu5Tnpd3f4
         mgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690280547; x=1690885347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st1c6y6bpzS1m6/OLQ/WRJ6hdioncwRRD9te/qaHNm0=;
        b=lT149zDSoj0W1FN1P+gazJISH/isJj92Xxyn3RNYIyPa9gQE2TnRRgj+cSGa9Y6lVI
         sl5sNZtvkCls3MznYfXjm++Jnzsrlxs3yJW+eGdXDRdUxb8JrESRhHS63AdFSW9q+y2x
         juDfDlUh+nJKwh1tNJQ37kAbCqgmTS0g6tdOzE/DWsBXtQbiC7+gmh4gI2OUqaQi1vMA
         Vo3JTbZMNmSh0VQNSikcq3cwtectVHmDlhiL5GmL+xwu1FKG1r6GTQIE38/8JutkG2aq
         c0LKE7NDsXX3EXYo2MxBE+PBu6iTkmPkVZCQOQ721+4LMCJiYfjRoQKH4AsXUDqhXq2y
         O7FA==
X-Gm-Message-State: ABy/qLbf0JS2kNr+Yq4aDMNLiN2jGgglYOQWGwnqEgnYWCUkdtyME4WM
        ZypVU6T5jtqbhglhdfA7YNo=
X-Google-Smtp-Source: APBJJlH8waVFJBjk2pzAHNfgFspl+McpQX/EQlkc8JCDxWgqg42Zzi0aaMimRtwVYCQrMlU5sF7BLg==
X-Received: by 2002:a17:902:ea04:b0:1b8:b3f9:58e5 with SMTP id s4-20020a170902ea0400b001b8b3f958e5mr12806537plg.38.1690280547139;
        Tue, 25 Jul 2023 03:22:27 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902c1c900b001bb8be10a84sm6239417plc.304.2023.07.25.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:22:26 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2EE88811C67C; Tue, 25 Jul 2023 17:22:22 +0700 (WIB)
Date:   Tue, 25 Jul 2023 17:22:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Jeff as ath10k, ath11k and ath12k
 maintainer
Message-ID: <ZL+iXrR1yNz3cfV8@debian.me>
References: <20230725094248.3205486-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0xVLwENwrMrscJsq"
Content-Disposition: inline
In-Reply-To: <20230725094248.3205486-1-kvalo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--0xVLwENwrMrscJsq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 12:42:48PM +0300, Kalle Valo wrote:
> Jeff will now start maintaining these drivers together with me.
>=20
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42e78a696be6..292910ef17d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17433,6 +17433,7 @@ F:	drivers/media/tuners/qt1010*
> =20
>  QUALCOMM ATH12K WIRELESS DRIVER
>  M:	Kalle Valo <kvalo@kernel.org>
> +M:	Jeff Johnson <quic_jjohnson@quicinc.com>
>  L:	ath12k@lists.infradead.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
> @@ -17440,6 +17441,7 @@ F:	drivers/net/wireless/ath/ath12k/
> =20
>  QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
>  M:	Kalle Valo <kvalo@kernel.org>
> +M:	Jeff Johnson <quic_jjohnson@quicinc.com>
>  L:	ath10k@lists.infradead.org
>  S:	Supported
>  W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
> @@ -17449,6 +17451,7 @@ F:	drivers/net/wireless/ath/ath10k/
> =20
>  QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
>  M:	Kalle Valo <kvalo@kernel.org>
> +M:	Jeff Johnson <quic_jjohnson@quicinc.com>
>  L:	ath11k@lists.infradead.org
>  S:	Supported
>  W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath11k
>=20

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--0xVLwENwrMrscJsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZL+iVwAKCRD2uYlJVVFO
o+acAP9X8xYaesXihr/7vqWc6wUpnMRtMCbxV78gKtoPHMbG6gEAnyUtaVWC3EPc
RMQk45NVfU1ycG+UPXGAtjUWiMYT2gU=
=lWF5
-----END PGP SIGNATURE-----

--0xVLwENwrMrscJsq--
