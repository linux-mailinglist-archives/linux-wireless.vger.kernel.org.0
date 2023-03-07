Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A1D6AFA16
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 00:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCGXPt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 18:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCGXPr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 18:15:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60748A2253
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 15:15:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a25so59120051edb.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Mar 2023 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1678230944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AvyDAJZ6bXR3+bCkneSkFX3JjEKBmzTg1APcQut5+/g=;
        b=EnOltLGevkDWdzaVgVxeDFf+f+SFEyM3vMLjbHBcnOov/1N873YhPGC2++tjkeqJ09
         e5v9DV/JbYV4dX4fX+v9szxymXpTH9K1m86sj76XMROLe0NI1gdRaqtkq0pitCsdHLrM
         siS2hEKmplOZTPueDP7Gdo80kvbbaem3Rot+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678230944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvyDAJZ6bXR3+bCkneSkFX3JjEKBmzTg1APcQut5+/g=;
        b=5B2larbyuM6k/guTDHJ7Hawi7VNMHEezOWTd6C5uGCbmqcFlbcYC1Lo7UgzcO8xzH5
         drhadDZ6CJR4frokjG0kTeg2ZFWC9pVcBwxikncmDdGXkP3XfOHQjkk5cudEAhSnWg/N
         jklG5k7dc2wgWdTsbWg0uS9YOhK7gP6/Kd7dmtahze4OI29emIRq59DHznJYjoSdGbJU
         LdnADyg1TsMYrrc0APHofwRDomgqczPk8mKyUYW+8LN/PMxEh2JJAVC93WQpMJDfx9A3
         C+iLRM6pXaxSrp/OU0GX0RAF0DtcMMUOnmRbNaFNnzT3776e/q0i7OdmlCwpqNyVbuy5
         I31w==
X-Gm-Message-State: AO0yUKVVfT84g2G7n63Q74mnvkt6uLOn6AgoJv5KaeRxlddGaKbBwpHO
        +Qo5ACKjl8ekd7nyoFQcHLNQEE6OAft0yWnvVUtryg==
X-Google-Smtp-Source: AK7set/N5F8fE4yKA3XQ+PsxXjvloLB4RdlQpyV8IotSZcUtwXqCmc1OOPVxv18jQLpAYxhP1G5kjwDIR2mOJVscNB4=
X-Received: by 2002:a17:906:a0d8:b0:8b1:3d0d:5333 with SMTP id
 bh24-20020a170906a0d800b008b13d0d5333mr7267360ejb.13.1678230943730; Tue, 07
 Mar 2023 15:15:43 -0800 (PST)
MIME-Version: 1.0
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr> <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr> <6be2c348-b343-876a-a77f-a8297676de6a@free.fr>
 <a215e398-2c49-19d2-0730-5e8c51df1ed9@free.fr>
In-Reply-To: <a215e398-2c49-19d2-0730-5e8c51df1ed9@free.fr>
From:   Franky Lin <franky.lin@broadcom.com>
Date:   Tue, 7 Mar 2023 15:15:15 -0800
Message-ID: <CA+8PC_du5dMwkmAshG2mM9TdeJft5aeAbEdDp0_q3Rxdvpq4MQ@mail.gmail.com>
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-wireless@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000046d09c05f65797da"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000046d09c05f65797da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 7, 2023 at 6:40=E2=80=AFAM Marc Gonzalez <marc.w.gonzalez@free.=
fr> wrote:
>
> On 06/03/2023 11:41, Marc Gonzalez wrote:
>
> > On 06/03/2023 11:24, Marc Gonzalez wrote:
> >
> >> # cat /sys/bus/sdio/devices/mmc2:0001:1/uevent
> >> OF_NAME=3Dwifi
> >> OF_FULLNAME=3D/soc/sd@ffe03000/wifi@1
> >> OF_COMPATIBLE_0=3Dbrcm,bcm4329-fmac
> >> OF_COMPATIBLE_N=3D1
> >> SDIO_CLASS=3D00
> >> SDIO_ID=3D02D0:AAE7
> >> SDIO_REVISION=3D0.0
> >> MODALIAS=3Dsdio:c00v02D0dAAE7
> >>
> >> 0xaae7 =3D 43751
> >>
> >> Isn't there some overlap between:
> >> include/linux/mmc/sdio_ids.h and
> >> drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h ?
> >>
> >> Reference used: commit d2587c57ffd8dc
> >> "brcmfmac: add 43752 SDIO ids and initialization"
> >>
> >> Looking at all the occurrences of 43752 to insert a 43751,
> >> could someone comment whether this looks reasonable?
> >
> > Obviously, the commit message would have to be rewritten
> > for a real patch.
>
> Help. I am thoroughly confused... :(
>
>
> Through the SDIO bus, the WiFi chip reports 0xaae7 (i.e. 43751)
> hence the /sys/bus/sdio/devices output above.
>
> sdio_read_func_cis() -> sdio_read_cis() which sets
> func->vendor/func->device to 2d0/aae7
>
>
> But when brcmf_chip_recognition() calls ci->ops->read32()
> i.e. brcmf_sdio_buscore_read32()
> [ vs brcmf_sdiod_readl() in brcmf_sdio_probe_attach() ]
>
> [    1.177283] brcmfmac: F1 signature read @0x18000000=3D0x1042aae8
> [    1.182912] found AXI chip: BCM43752/2
> [    1.186384] BCM43752/2: chip=3Daae8 rev=3D2 type=3D1
>
> Here it reports 0xaae8 (i.e. 43752)
>
> Why the discrepancy?
> Can it cause issues?
> (Sometimes, the whole SDIO bus doesn't probe at boot.
> I am still investigating these intermittent problems.)
>
> Should I use 43751 or 43752 firmware...?

This question should be answered by the Cypress/Infineon folks but
unfortunately they have been quiet for a long time. In general we use
the id read from 0x18000000 to decide which firmware to load. But be
aware that the rev also matters. There are some examples in
brcmf_sdio_fwnames table that the different firmware name can be
derived from the same chip common id but different rev.

However sdio device enumeration happens before firmware download so
the intermittent problem you are facing probably is not related to
firmware version.

Regards,
- Franky

>
> Regards.
>
>

--00000000000046d09c05f65797da
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
BZrfei1PlO2m9d3AfpeD7Y1pVL1SrZC1yvhXeDO463M8rGKz/l8XZrJY1P6qU8U6QwxjFgXr5o5B
9N6Yw9IhwXhZI3m6F1pe3mMdZ9cFC3xS3Ke+awIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdmcmFua3kubGluQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU0v383z+6bcUXkukYi4fq7VBiM6swDQYJ
KoZIhvcNAQELBQADggEBABUIiuJPuLq9vbb6/7d0VJ6LS6osA6kNs0Tph9iEX49TxPQJtvA97oy4
AgPCjWNiAMLkmu+kNQKlNZG3Vl3S4A+VMOogB6aKtiLlz73Cs0sPgpohw6GSS41TKVt17PrAzo0o
/xuXczzIbtvrpoi6OnGlsW4aVCqQSOqKUamG8wU8u3/h+iPM1rr4z6ZHdyrllNi+ukH/Z6Dpn6wF
ATUa+n5ReFZpli4TzcqVHw7i+OaB23TMHCwed4OPFm0H3zcCJgVtgt3z95IPak7bBuYLAGMT2c3K
Xkdn27MnpydqZw5mnP970DgyUMHXY3Jvj65UAVioJUr4LkNBL7Tsk/6q0FExggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxcbvtv+NUbtJoPDWwwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOj6ieZcptq/gHNhWLug6B0/ZtNXrltr14K2Ca+l
B1lgMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDMwNzIzMTU0
NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQCMO5mBIr7t0rF5wQJUHnLKywA9CBLDJB46CgTQZOiesHn1opp1Ffj8wbDv
Mez9cT+fN6xwfZ8AhPyRNS5HeIXFcfqxDmnsmpZKB9E1AAAyH0V0TrvnetnUW7/vAWTgF64v1qH0
XJqO9nm616kvEX793arme+5Uk12IVS/PBgOutJfOHm91V4IRpXHPiWV0JKiHn0WzNp8XTbLOvnvD
TI3BFZTCu5+NhhICDfFkhUi0MoXvsoavUIYDjDMrMBdVwYRRaIglQDNqo76spCn85UBMk05clkwU
rgYowYoai99OgO0OjyPfSagqxvuKwxx7C4X4grzUC270Q6m3BClCyECk
--00000000000046d09c05f65797da--
