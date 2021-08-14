Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151CB3EC117
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Aug 2021 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhHNHTZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Aug 2021 03:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhHNHTZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Aug 2021 03:19:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D4C06175F
        for <linux-wireless@vger.kernel.org>; Sat, 14 Aug 2021 00:18:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lo4so22321297ejb.7
        for <linux-wireless@vger.kernel.org>; Sat, 14 Aug 2021 00:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version;
        bh=MRJTLhNkf/r4LBSYGQpa781XHZuwuh9h8ZoN7H/mDbs=;
        b=giPu6LC6iwaWSrnH838SohGKps9t/y31quRlGxzkkywVvui4FJe48Hv9rmFCkwfV6M
         bqypjmnSjcLLIN1Jr+5tuv7YvGd1dFpL04QVf+BwUNhzV079Gb47mflqYRnnuXTC82Kt
         UVK6DxKgcGahZVRANZGz8D1AsipedkYyAR11o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version;
        bh=MRJTLhNkf/r4LBSYGQpa781XHZuwuh9h8ZoN7H/mDbs=;
        b=d++jpHft3wOG5bP52EF6e6Q7te1MZxMRR6HJDqDWufEw12j7g7PcO9MwhWBdWNU5+h
         BI3HQZs0NBWhkXFVWHg2LvTfBisHTdr1tDKEJNu/64Rbe0tvwsiBu9hsDmBKhTDxFT+8
         RP1UjatXOEAx6wHQBdQ2VJ69b5Wi3qM2o5rnRw2Wzkm6sAr6EdNEJfWnQpYbKKcoYQZi
         GW7da0WLFsjMUdcviptOZiPtQu3lNMjvsGUp847MCfem0EEAZI4W+3qZh7u7J34oGyF8
         S7M8tlOaY34wxFnWaW6pPNi+ktEox2cchhxgONgizXBb7JzhoTNMLhGceZBDCoImjEv5
         QeLA==
X-Gm-Message-State: AOAM532m39q49c6bLpy08R6RP721j0Jhe1eV1m0iGhS/tD+Nq1CPZXXS
        C3mbzstXLM9NGEGGILiy0rguBUk0c36cY/Nj6ZpldbmQ8TB3WEX6/nulVa6JNfXEOuF3bUhFClm
        yAGwG3U6a+aQXzFQCuA==
X-Google-Smtp-Source: ABdhPJyf4TlBQMMzZKhdOOydaKrJW5ON3yHMgW8NG1zCOebAONzRDKXjB83m34eZBy5t77xJFfI4TA==
X-Received: by 2002:a17:906:c251:: with SMTP id bl17mr6239919ejb.219.1628925533990;
        Sat, 14 Aug 2021 00:18:53 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id u2sm1439803ejc.61.2021.08.14.00.18.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Aug 2021 00:18:52 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     "M.Sadegh Zeyghami" <mszeyghami@gmail.com>,
        <Chi-Hsien.Lin@cypress.com>
CC:     <linux-wireless@vger.kernel.org>
Date:   Sat, 14 Aug 2021 09:18:52 +0200
Message-ID: <17b43871760.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CACiH_1pQPod2zEYFDHbs35QnowmWbhund+tvLxnP1eYQXtX8NQ@mail.gmail.com>
References: <CACiH_1qejUGY5h84AJwdpzu7hnv1QcpUwxusuUHTYvHudZ1XQQ@mail.gmail.com>
 <CACiH_1oOYQtTK+ZHToocwJDFZJwsqfXn+rfNTPNKfs4216tdRQ@mail.gmail.com>
 <CACiH_1oJ82bRqf6chxbz60ocU5Lt_U1tzC2BzhxQnc2sPkAH=Q@mail.gmail.com>
 <2020122116491715139911@myirtech.com>
 <CACiH_1rKWwKBN90cMHyDVfTLjxpq74n8+xR1fLTwUw=omazkRQ@mail.gmail.com>
 <202012211717114369410@myirtech.com>
 <CACiH_1radH2fiCGEqrFd2KT3LmXXTt0kwS=h1nJ4ONKv86vO=g@mail.gmail.com>
 <202101210845326804970@myirtech.com>
 <CACiH_1rbn8cvOLOcwPjnh3J18tu1RO-MsSrCPqHn4gX_oxg=sw@mail.gmail.com>
 <202105170852049596790@myirtech.com>
 <CACiH_1r=yvmZOjCTH+Brrks0uv_+uw1FXyVGO7GW3-g0Qki-iw@mail.gmail.com>
 <CACiH_1qG=o9XNw3Fby=ta9edGe4LPMmcZ2qgM3o5unhkmmpxiw@mail.gmail.com>
 <202105191404513233631@myirtech.com>
 <CACiH_1ryCWNgGJZ7+sCT3EBdDLh98qhNKvn2BHrfYkt+pPpTLA@mail.gmail.com>
 <202105200917269788315@myirtech.com>
 <CACiH_1r16eNxgT+2iTWOafwh4m+3H1ZoASfAyY-Vyu4z6Xwn_w@mail.gmail.com>
 <202106031043566804622@myirtech.com>
 <CACiH_1pJAJNSKC=Grkv64itzJZQw6cKF14fW7+QhAouMVgJ6Dw@mail.gmail.com>
 <CACiH_1oOxQL2wuv0O7i75WZroUkFqbbaoDsN+Enk51RsiZddPQ@mail.gmail.com>
 <202106070850449973117@myirtech.com>
 <CACiH_1oNK7c1F9FmMDEA9gsAiQ1Ccp3c_aHFqPesuSFdHZUtMw@mail.gmail.com>
 <202106081344596009918@myirtech.com>
 <CACiH_1q+6aYHinK=mV1Tux8V-XHJ6cJ9czM8nbMj8n5jk2peqg@mail.gmail.com>
 <202106081408186587600@myirtech.com>
 <CACiH_1r-PJio4aK5K1muQ=JDkmE__00OsXbmvFzcNkcsqAfQUQ@mail.gmail.com>
 <CACiH_1rNAR2E1ybaT8CbHE9dM+1kTxs=DvVpdpUwqAE--yv3eQ@mail.gmail.com>
 <2021060909525128128510@myirtech.com>
 <CACiH_1qnY+=9NRrpv7Ey1ANSqZ_dO+uxP_gS1X=PAVe2GcUnHQ@mail.gmail.com>
 <CACiH_1rMHucS2yKDEAQYChFoEsCSjqpwhw7aDHU7Yh0DyuQRhw@mail.gmail.com>
 <CACiH_1q7OAeipL1AUbWnCAt+O+abXKC4-jvd3BAwL_OEqLfKwA@mail.gmail.com>
 <CACiH_1pQPod2zEYFDHbs35QnowmWbhund+tvLxnP1eYQXtX8NQ@mail.gmail.com>
User-Agent: AquaMail/1.30.1-1828 (build: 103001000)
Subject: Re: add support for brcm43362
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d5a58305c97fc7b3"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000d5a58305c97fc7b3
Content-Type: text/plain; format=flowed; charset="US-ASCII"

+ linux-wireless list

On August 14, 2021 6:07:15 AM "M.Sadegh Zeyghami" <mszeyghami@gmail.com> wrote:

> Hi,
> How are you?
> I've compiled a linux OS using yocto project. I want to have wifi interface
> using WM-N-BM-02SDIO . I have set the WM-N-BM-02SDIO on sdio-1 which is
> considered for sd card. I have successfully added wifi before in a project
> with kernel 4.x.x.
> now I'm trying with new sdk:
> uname -a
> 5.4.3-g9c2490ac8-dirty #3 SMP PREEMPT Sun Aug 8 12:11:16 UTC 2021 armv7l
> GNU/Linux
>
> I have an issue with the brcmfmac kernel module. I have enabled brcmfmac
> debug and enabled all message types in debug messages.
>
> you can see the dmesg output when I put this command insmod /<path to ko
> file>/brcmfmac.ko debug=0x1FFFE :
>
> [ 2526.159218] brcmfmac: brcmfmac_module_init No platform data available.
> [ 2526.168959] brcmfmac: brcmf_ops_sdio_probe Enter
> [ 2526.168979] brcmfmac: brcmf_ops_sdio_probe Class=0
> [ 2526.168991] brcmfmac: brcmf_ops_sdio_probe sdio vendor ID: 0x02d0
> [ 2526.169001] brcmfmac: brcmf_ops_sdio_probe sdio device ID: 0xa962
> [ 2526.169011] brcmfmac: brcmf_ops_sdio_probe Function#: 1
> [ 2526.169347] brcmfmac: brcmf_ops_sdio_probe Enter
> [ 2526.169362] brcmfmac: brcmf_ops_sdio_probe Class=0
> [ 2526.169372] brcmfmac: brcmf_ops_sdio_probe sdio vendor ID: 0x02d0
> [ 2526.169383] brcmfmac: brcmf_ops_sdio_probe sdio device ID: 0xa962
> [ 2526.169392] brcmfmac: brcmf_ops_sdio_probe Function#: 2[
> 3249.364285] brcmfmac: brcmf_sdio_exit Enter

The vendor and device id are correct so can you retry using debug=0x31416 
enabling SDIO debug level.

Regards,
Arend



-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--000000000000d5a58305c97fc7b3
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCmhJBt6MeUA5VpIder
7bPY0BHwrbtSl445gls5GdgMsDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMTA4MTQwNzE4NTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALQneyaox7CypKsjUw55m2kkPRwiU6IvGrJMh
BCBRnxeBakPz7tSYpd2/hbPfYPssJhBK2M+v++Y7hVShwUeuDcxPNVgcRQCde3584/OBFx3hw71i
wNLtUcaIp84Fb3HchAtQ288rR7kcYdWrrpfB/FVBWMgjQfqVR8q6eOY22cwgMcD2Gn5rtxP3pDoE
5GlAjFo8iN+EQ6RLW3Jvf3F/lDDyyECVyw8Rx5Rbq8DHmVKaAAjuACH7/bSXQbGZfOVbrOycEo7T
r1mqhMXKuyXDWfSpFVqsuwyyil08FEb2UreoJRgo7ggVt0RW2vcOMKq6Mebfp1CDL9LDXHgammz8
sQ==
--000000000000d5a58305c97fc7b3--
