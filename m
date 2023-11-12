Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71377E911B
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 15:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjKLOI0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 09:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjKLOIZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 09:08:25 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD5C273F
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 06:08:21 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b512dd7d5bso2501614b6e.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 06:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699798101; x=1700402901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYY9iKgDLqPaktwUQQteh4tZmXuoFTMBRZqWPGDKs2Y=;
        b=jr2uJuRoiqb0z13I6/ULEhO/HYIko8GklqCLKeUPFbLKXc4mgK19DvTHgsY/tNaQVv
         kz9rQKh7u8K/kwJTJP/EeHjwMfjXk0SVb7ozEXpl6IB41lz1aROLwmPs7d8ZmbsWjAv6
         nuuYvA/Xw7UPPEGbktTuncne3C/EUGRMA4DpKhSRnJlXuXGYkxjKGONfB+cAx/DU9kDC
         Cxwa2UINyGvHzjL/ulEaK6QBk30C7CrZGLFBHuettUOd/dJOUIdnP3FaW94u8tXf7OkS
         FA8bqlm0rzhgSSV1ts2UMyi3sWpUqwWt1yIu+sTcoSjPHL23gpy0VKdqN2LEJzmCZJXZ
         jDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699798101; x=1700402901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYY9iKgDLqPaktwUQQteh4tZmXuoFTMBRZqWPGDKs2Y=;
        b=iuFX5l2doE10l1ev1H2I85OJ2oxEr1KwpK85mjCdOfCNkKNDuZwEtrJlWecgl/FlzI
         SBCPTOETSezKUPLGOIYNe3acxeZpXRJJoCJ1JY2xuqEbSuoP+bF8bjuuIn2fF6nGJJ4H
         9jDBYqPY7NL7GrRnvrP+fCgO2Hfr5xdlrrsZdeMYHERvZmcbHWc2r00DCUTGKt0Y4ioi
         9jBoXFLSy2PhvkCVJVcYzpEjuaSJUPKUuNCBh81JSUxTs+mRcTURSOJyPLeOmbDsRF5m
         Ncu3kc+91W1Gljyu5i6riQvsYJbe+ENi3s293j/GeI4HSUOINMU9njVrbp30mtUzjvgq
         AOdg==
X-Gm-Message-State: AOJu0YzjfXu19e8Z0l8g9n/tPPOCgV7Cmb+/g/MpeHPzaFPWd+6Ecate
        LydnP42r1QTFvrlCDoA+Y1Q=
X-Google-Smtp-Source: AGHT+IEWKgTK0EJVALX+kNokvKuBqPmzQ5WMm0OS6IIvOJXT9DjmLupXoGm4+r9yYrKunU0bml3/uA==
X-Received: by 2002:a05:6808:209b:b0:3b6:cda3:f379 with SMTP id s27-20020a056808209b00b003b6cda3f379mr7449035oiw.13.1699798100806;
        Sun, 12 Nov 2023 06:08:20 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fb37-20020a056a002da500b006c33ae95898sm2515564pfb.78.2023.11.12.06.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 06:08:20 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 4B2991029D748; Sun, 12 Nov 2023 21:08:17 +0700 (WIB)
Date:   Sun, 12 Nov 2023 21:08:16 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        pagadala.yesu.anjaneyulu@intel.com, gregory.greenman@intel.com,
        Linux Regressions <regressions@lists.linux.dev>,
        Johannes Berg <johannes@sipsolutions.net>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: Re: [PATCH v3] wifi: iwlwifi: fix system commands group ordering
Message-ID: <ZVDcUGV1bSo6pnL_@archie.me>
References: <20231112095943.19353-1-emmanuel.grumbach@intel.com>
 <20231112100944.21177-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Gvvw1kz334TUinYX"
Content-Disposition: inline
In-Reply-To: <20231112100944.21177-1-emmanuel.grumbach@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Gvvw1kz334TUinYX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 12:09:44PM +0200, Emmanuel Grumbach wrote:
> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>=20
> The commands should be sorted inside the group definition.
> Fix the ordering so we won't get following warning:
> WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg))
>=20
> Fixes: b6e3d1ba4fcf ("wifi: iwlwifi: mvm: implement new firmware API for =
statistics")
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Hi Emmanuel,

As this fixes a regression tracked by regzbot, let this be known by
regzbot by adding missing tags:

Link: https://lore.kernel.org/regressions/2fa930bb-54dd-4942-a88d-05a47c8e9=
731@gmail.com/
Link: https://lore.kernel.org/linux-wireless/CAHk-=3Dwix6kqQ5vHZXjOPpZBfM7m=
Mm9bBZxi2Jh7XnaKCqVf94w@mail.gmail.com/

> ---
> v3: remove changeId for real...
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/w=
ireless/intel/iwlwifi/mvm/ops.c
> index fef86a8b4163..1627b2f819db 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> @@ -550,9 +550,9 @@ static const struct iwl_hcmd_names iwl_mvm_system_nam=
es[] =3D {
>  	HCMD_NAME(RFI_CONFIG_CMD),
>  	HCMD_NAME(RFI_GET_FREQ_TABLE_CMD),
>  	HCMD_NAME(SYSTEM_FEATURES_CONTROL_CMD),
> -	HCMD_NAME(RFI_DEACTIVATE_NOTIF),
>  	HCMD_NAME(SYSTEM_STATISTICS_CMD),
>  	HCMD_NAME(SYSTEM_STATISTICS_END_NOTIF),
> +	HCMD_NAME(RFI_DEACTIVATE_NOTIF),
>  };
> =20
>  /* Please keep this array *SORTED* by hex value.

This fix is confirmed by one of original reporter and another tester, so:

Tested-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@gmail.com>
Tested-by: Damian Tometzki <damian@riscv-rocks.de>

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Gvvw1kz334TUinYX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVDcTAAKCRD2uYlJVVFO
o4n1AP9lxf8SrlAb6lA/gtDq4eQtZpoov24bFrAu7uaH8ysB+AEAiTJZjYSGqehF
LIlsl01m9bDrtN+Yf91aKJmxrNryMgc=
=A3Ud
-----END PGP SIGNATURE-----

--Gvvw1kz334TUinYX--
