Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1549A55471F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiFVJgj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiFVJgh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 05:36:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D532CE0C
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 02:36:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 128so8574136pfv.12
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=conP16AfxLbsRQkGvTrju1ADG/qKMw8etzUTMHQVznI=;
        b=dKTho97GFoU21wb/oVKOqzpJ3U6D2yUvxamrczcH8ftZEUbxJQdCv5+6GMxuEzKZIG
         N0TPqbNYk9GECSy6Kz2ZfiGzWudd6pG9l0pOTcg8obuk0hyXbwsTogdf6DA/Ub7fOjbR
         P2a71+pl2ygE926JKMw0fvL78rji4prEvnD28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=conP16AfxLbsRQkGvTrju1ADG/qKMw8etzUTMHQVznI=;
        b=gcBiDMoxmfHbz5a5OqMZGCCx/s3SI5TbZXjifiHR8Kx2D1S45zlJhTh3pbLCM5kKnP
         eEqB24qgGLJ/oCeRr4+JcooQe7g1YlbxLaN9iFTtSafugJyS3sq1NT67AsUnkBAmRHvk
         DJShSnu4vUtQNaRmFJ5YNP1u9Yo2n96mtpo9V9/XmaV4hAHZkgD89dqZAT5wmdb/bxYl
         gnUXeWNE6BIV30/UYSjELXSZBBFj0GWcTUVPrNpFfIxa0c91XWNtj9yNAsAZusb1bBbG
         CZK7h6ec5j4VAbJlZj4wAmnkXYPtnIdCvhBQ55pBFClZdTMLVSzmXLc4v/WOqM7jf9lX
         1ElA==
X-Gm-Message-State: AJIora+A6yoe1b1abV2m9tQM1FwES23iDbLymTxcgizJsKMQcqiUY6jM
        aG07VMP3iD32/yjYgZQK81lzvg==
X-Google-Smtp-Source: AGRyM1tRbrlm4ahkiGmm8Yne+x5FbBCPc8PO/SQC95diRJ5un7/0kLN9hjK714NU7sK6cdGfhL1ZQw==
X-Received: by 2002:aa7:9911:0:b0:525:1bb3:965a with SMTP id z17-20020aa79911000000b005251bb3965amr18110731pff.79.1655890595722;
        Wed, 22 Jun 2022 02:36:35 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id mm21-20020a17090b359500b001ec86a0490csm8191864pjb.32.2022.06.22.02.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:36:34 -0700 (PDT)
Message-ID: <cb66e6f4-3377-99be-74d0-87e1c57599f4@broadcom.com>
Date:   Wed, 22 Jun 2022 11:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to
 firmware-crash
To:     Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl>
 <1a116224-66ff-17b1-bb8b-9c0918dd47e4@broadcom.com>
 <kB9OdQYlBnucF05VoKxTvsT8eUrPGJc_we9irAdR-2gmXsEl4NvkhMzDcTahLm3HLA2zKVXnhEOstESbIEcHGKYHvMOyIcr4vh80f0eJCJ0=@dannyvanheumen.nl>
 <MV9-h4Mgj6FKxRJY93AQMhYFsz2yz0CoDQ70V8JWe742HUdLdl6Q1LbFTxGa-NCzodUmI3dbSoRGXebbE5rWPKKehHdixSTjW4TKZt10AJk=@dannyvanheumen.nl>
 <1815e2011e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <PDYrcmiOE8drECietqr7SILEQI8DpX6gL8pbVCR6IbqNrKjyXTLYPhgsWfHL-s9FuElU5v84HUUWaFntR5RZJG5EBABE2XilCP_2O9ZipMk=@dannyvanheumen.nl>
 <Ct5-sN_CGLyGf5qHNiakimNNG33Yb_7toxutmv8ELxgBqGZQXM6DkaIJg2cctTqSFyawKx8XeU3ySO2Ce6idBXv-ZWrT6Wy5_a9nFr4svy4=@dannyvanheumen.nl>
 <45d90d65-cd0e-e65f-edcf-d55802a4a6bd@broadcom.com>
 <VJRRELjxfxQK1fFLbnYr2IZVHdPU-0YotbBIG2-ycUA2OCppqr4TrzsbXHC_wpS0ZA7HNLJxZNA6-Bzy0BOAuV16DR6wqT9TPDLjQwYcp7w=@dannyvanheumen.nl>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <VJRRELjxfxQK1fFLbnYr2IZVHdPU-0YotbBIG2-ycUA2OCppqr4TrzsbXHC_wpS0ZA7HNLJxZNA6-Bzy0BOAuV16DR6wqT9TPDLjQwYcp7w=@dannyvanheumen.nl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c2e1f405e20612c7"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000c2e1f405e20612c7
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/2022 3:18 PM, Danny van Heumen wrote:
> Hi Arend,
> 
> ------- Original Message -------
> On Tuesday, June 21st, 2022 at 09:41, Arend van Spriel <arend.vanspriel@broadcom.com> wrote:
> 
>> [..]
>>
>> Maybe overlooked, but I have not seen a patch from you on the
>> linux-wireless list. Do you have reference, ie. URL or Message-ID?
> 
> I'm not sure what's most convenient here, but here's an archive link:
> https://marc.info/?l=linux-wireless&m=165547582612979
> 
> Message-ID: ThT2jwvySn9tFQm9FxrlPNMQkiGUnx_87cOhmmeexoVOFZqOkpjmAntCWG-
> kIBMj2830LHZaOULlJxQKiRXkVtGYrrT8rBaB7R65qjIinYo= () dannyvanheumen ! nl

Found it. Had to check my gmail account instead of my work account.

> You haven't commented yet on my question regarding definition macro for the clm_blob.
> I intend to send a patch for it, because I believe _at the very least_ some parts of distribution
> processes rely on these firmware entries. It would be good if you can confirm.

The clm_blob is optional unless the firmware image was built without any 
clm data. If that is the case for 43456 (I think it is not) than it 
should be reflected with BRCMF_FW_CLM_DEF(). Otherwise it is fine as it 
is right now.

Thanks,
Arend

--000000000000c2e1f405e20612c7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
XSlOP9s1dqWlRRnnNxV7BVC87lkKKy0+1M2DOF6qRYQlnW4EfOyCToYLAG5zeV+AjepMoX6J9bUz
yj4BlDtwH4HFjaRIlPPbdLshUA54/tV84x8woATuLGBq+hTZEpkZAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFKb+3b9pz8zo
0QsCHGb/p0UrBlU+MA0GCSqGSIb3DQEBCwUAA4IBAQCHisuRNqP0NfYfG3U3XF+bocf//aGLOCGj
NvbnSbaUDT/ZkRFb9dQfDRVnZUJ7eDZWHfC+kukEzFwiSK1irDPZQAG9diwy4p9dM0xw5RXSAC1w
FzQ0ClJvhK8PsjXF2yzITFmZsEhYEToTn2owD613HvBNijAnDDLV8D0K5gtDnVqkVB9TUAGjHsmo
aAwIDFKdqL0O19Kui0WI1qNsu1tE2wAZk0XE9FG0OKyY2a2oFwJ85c5IO0q53U7+YePIwv4/J5aP
OGM6lFPJCVnfKc3H76g/FyPyaE4AL/hfdNP8ObvCB6N/BVCccjNdglRsL2ewttAG3GM06LkvrLhv
UCvjMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMMSnY
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAgNUcMltswVL8z6B9l
ySynhfrf1kzWhzm1108PKj983TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjA2MjIwOTM2MzVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAY0G0HhkcOCyjDxhWRUcxsaLzieKwc7Gjdavk
mFIITTREyMmptSYV2MlQi7dtJ6QN9k3rzrU7HI/yJVfMdWqCYtzkON2St2qeMqoDzUqWpgXMLBZH
3dVRipsQ/ILL3I9N50hsZveXVruLaB0h76L1NqPXquVMqR3/l9mT1zv9v6kaAHb0uZXgHNxflfVl
2hT0fuM8Kh4Pf2ya4uiG2r+N1j6MIQuke90d67LYIxITNB5raqGSU0vk5EdVBJvkJTYOcQcPCD5L
vcKMkpCy4akfGjip9/mxZpD/Vc1Ep2Jp9tNg/KqFE8p/Adl3NGg/n+2QAi79S3nrznE8b84tXCpF
gg==
--000000000000c2e1f405e20612c7--
