Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F37B71842B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 16:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbjEaOF4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 10:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbjEaOFn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 10:05:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7638955AD
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 07:00:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so4063398b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685541553; x=1688133553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BZZCnP2GiYn1lTtNgOs+Ak6zQVz1K4t2mnjh1u+GPE=;
        b=FGHcu6q+w5Hfvc0K3nH2AzjZ2vE0SVBR+fHsBZQkAM3ahQ1xUijYETFC1Rc7cqwnsS
         o8pZMOT3piRVYz1cVGBONbWfXLK0ZKra91Bh6OP7Fkm8rrx6P6bf5n/ZUdnpyv9IybVF
         /fH2uS40Ro+DDBi99pJoFSWNngM0Yaxa0pgz4DG2imFKAdZQ3PAoahLtRWJ4+JlQaXQU
         e6SyWg7RFMIHFR3ABKqe47u3WtLq1M04s21tjw2crpdF0k55xdycuZE5RNIhbgolizLK
         tHN50jMQAJH+F7llmBBGSVciLGMSOuzWArBHauND3tHcL6GoWdU7kixT4COcj3aZNdVQ
         Sxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685541553; x=1688133553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BZZCnP2GiYn1lTtNgOs+Ak6zQVz1K4t2mnjh1u+GPE=;
        b=FrdaXPYOOCnb2a1L36uG4EZpBbYv8LVF1LVsVPm4VsGhOtfYP78l6UxTOBddEGwnk2
         YWbKjPuzya/kNY4cWHwVIwZHS7Y7XlybzQRfrlJLnmBq3GSRlpM7M2eWisSVWufL6gGO
         QeKVZlV6eu4o8ezI4RQL2dTU2c30TeRdByuVkc4QnZrjD+TvDuu2WNVBPEgGjIpPQnQ0
         vDRWbE13627LgKfPuvEdgZF7XPmeNncDtaaTvVtFWvn6tesIjMcI1WVFx/elxDhlvp4P
         ExwCmgbBpHigHEs5rs8WMRgOSOwZH7uVFqekZJVp4XQf3bTkue2gpid4Mt5cepXlhKLk
         jOUQ==
X-Gm-Message-State: AC+VfDydyq9JIQpSArQX3VD+/g3G8P6mI6qrpJ+/XktcSOdngF/OKRy3
        gpYKgvU5rCaqtdnRYYSjaDg=
X-Google-Smtp-Source: ACHHUZ5v2w0egjsLOzrLJ8jkL/x2vqfDwXHPw3ockLWBxecpTR/w5ZJcFoqgAHynQsux2H+lMrLqAg==
X-Received: by 2002:a05:6a00:14cb:b0:64e:bada:2411 with SMTP id w11-20020a056a0014cb00b0064ebada2411mr5783023pfu.25.1685541552756;
        Wed, 31 May 2023 06:59:12 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-12.three.co.id. [180.214.233.12])
        by smtp.gmail.com with ESMTPSA id v11-20020a655c4b000000b00520b677c645sm1223359pgr.41.2023.05.31.06.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:59:12 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 41531106990; Wed, 31 May 2023 20:59:09 +0700 (WIB)
Date:   Wed, 31 May 2023 20:59:09 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: Re: iwlwifi: AX201 misdetected as AX101
Message-ID: <ZHdSrGmyN-TjYxEO@debian.me>
References: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="23nFZxpH4dyHvOLV"
Content-Disposition: inline
In-Reply-To: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--23nFZxpH4dyHvOLV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 05:55:48PM +0000, Barnab=C3=A1s P=C5=91cze wrote:
> Hi all,
>=20
> I have an Acer Aspire A315-58 laptop[0], which, according to lspci has th=
e following intel wireless chip:
>=20
>    Device:	00:14.3
>     Class:	Network controller [0280]
>    Vendor:	Intel Corporation [8086]
>    Device:	Wi-Fi 6 AX201 [a0f0]
>   SVendor:	Intel Corporation [8086]
>   SDevice:	Wi-Fi 6 AX201 [0244]
>       Rev:	20
>    ProgIf:	00
>    Driver:	iwlwifi
>    Module:	iwlwifi
>=20
> However, in the kernel message buffer, the following message is written:
>=20
>   [    3.633490] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX101, R=
EV=3D0x351
>=20
> Also, this chip did not work with the 6.3.3 Arch Linux kernel, the driver=
 loaded the
> `QuZ-a0-hr-b0-74.ucode` firmware:
>=20
>   [    6.516505] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger =
13 fired (delay=3D0ms).
>   [    6.517615] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
>   [    6.517616] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, vali=
d: 6
>   [    6.517617] iwlwifi 0000:00:14.3: Loaded firmware version: 74.a5e958=
8b.0 QuZ-a0-hr-b0-74.ucode
>   [    6.517619] iwlwifi 0000:00:14.3: 0x00000084 | NMI_INTERRUPT_UNKNOWN=
      =20
>   ...
>   [    6.861510] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110
>=20
>=20
> I then noticed that firmwares 75-77 are available and that there were rec=
ent changes
> to the iwlwifi module that increased IWL_22000_UCODE_API_MAX, so I gave i=
t a go,
> and built the kernel at ae8373a5add4ea39f032563cf12a02946d1e3546 and now =
firmware 77
> is loaded, and that seems to work, at least I did not notice any issues s=
o far.

Does 6.3.x work with your v77 firmware? 6.4-rc4 with previous v74 firmware?

Seems like moving all parts at once here, hence I asked above to
isolate possible reason why your above case works.

--=20
An old man doll... just what I always wanted! - Clara

--23nFZxpH4dyHvOLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHdSqAAKCRD2uYlJVVFO
o0RuAP4xn1GRKP6vslUe5NOImW+UHf7BqDHY4eIkUskhD1b0pgEAiaiqQL3u8/iQ
+R2Vh9oM1s56kPCFlrEI8KxXeTX+fg4=
=1p9c
-----END PGP SIGNATURE-----

--23nFZxpH4dyHvOLV--
