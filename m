Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFAB3EC288
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Aug 2021 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhHNMDd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Aug 2021 08:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbhHNMDc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Aug 2021 08:03:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12449C061764
        for <linux-wireless@vger.kernel.org>; Sat, 14 Aug 2021 05:03:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id d11so23215361eja.8
        for <linux-wireless@vger.kernel.org>; Sat, 14 Aug 2021 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version;
        bh=s2I4LJah/RaKQ/5LyyWD/4dd3ubFDxZgFk3ecD0u5+E=;
        b=SMg84clhIKpMnDsVAlVge/SfOMQ8iz0q62W8BtuPZnFHYEd2GoG9QO9+oV1zw7HzX9
         ydbdU3Mm3yo3PlvZbBni9z6CWf4hxo+1MnHVgiRrlDxgZkD0fC2YofWnLgwJNq95FYgs
         FHOSACCVOAWMGQ+gkIeeezt2JsxqlI5D28C9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version;
        bh=s2I4LJah/RaKQ/5LyyWD/4dd3ubFDxZgFk3ecD0u5+E=;
        b=nvs+A2g/uxqr9TeStiBXWvRHYli6iSc2kuOEuQoD0e7VBpUIxuS6Ov7BttPp3Hc/HE
         DGzk9REhvwO3pifQusgvEeXUls1ZnGcLE5fLlSAJHAoIpNv85XANas9S9rbQ8edC+9Tw
         UkB4FI2z/kr4pz0Y6LV8sVUjhw7SWR+wVL1/7UR7AhAiQiUCTMvZMGfmwx+9Ck1OXxnu
         E5Uf1VV4Xg5XlTDJd/GXtcLsyG7iYYwHbROL1wZI+QlxADB9whFQ7+ZGCq1k3iEagdQe
         kapL8nDymJHcZOtk6AdwXn/qCh6gXBOH9n/hSCMyCIsRJvBd/+BPKJYVbJpdAVHgVZgF
         HEyA==
X-Gm-Message-State: AOAM531FCOn+dhWRSpGpkBSXn5AHVMgg5MHgeRIVFA0q5eKxQh7Ipc+L
        wWip5BUkK4xRIz9cHDXytCoYeEyFE+alXGhuv/B6RZAfZ/BAi76vF5cN9SE4b2dY6VMFVGI8Xeh
        BTCaKYIFK6yACQIRYgw==
X-Google-Smtp-Source: ABdhPJyQop8RZlA97Eu9LZaLsGnyT0e920kGuIQL4LE0u4jdOCnI2+FtzNIK9iE67Ked6Lx5pU5mAA==
X-Received: by 2002:a17:906:a24c:: with SMTP id bi12mr7168414ejb.530.1628942582339;
        Sat, 14 Aug 2021 05:03:02 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id n26sm2158664eds.63.2021.08.14.05.03.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Aug 2021 05:03:00 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     "M.Sadegh Zeyghami" <mszeyghami@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Date:   Sat, 14 Aug 2021 14:03:00 +0200
Message-ID: <17b448b3920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CACiH_1pRgjO7X5a5tvc6ygLy13arC4GjCp6qWOY7-Rxe3D93yA@mail.gmail.com>
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
 <17b43871760.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CACiH_1ph6bYFtKDLc=mVJP7ntWbhGotWzBH2DOhgK8PPik83=Q@mail.gmail.com>
 <CACiH_1pRgjO7X5a5tvc6ygLy13arC4GjCp6qWOY7-Rxe3D93yA@mail.gmail.com>
User-Agent: AquaMail/1.30.1-1828 (build: 103001000)
Subject: Re: add support for brcm43362
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000002385105c983c0d4"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000002385105c983c0d4
Content-Type: text/plain; format=flowed; charset="US-ASCII"

Please keep linux-wireless in Cc:

On August 14, 2021 1:14:14 PM "M.Sadegh Zeyghami" <mszeyghami@gmail.com> wrote:

> I have fixed the regulatory.db error. but the issue still persists.

Right. That should not be an issue for you right now. The driver does not 
seem to get to a state where that would matter.

So taking a look at brcmf_ops_sdio_probe() [1]. It should end up calling 
brcmf_sdiod_probe() which would show up in the kernel log. As it doesn't I 
only see two places that may fail but those are allocations so that would 
dump a stack trace in the log. So I have no clue unless that SDK you are 
using has some modifications in brcmfmac driver.

Regards,
Arend

[1] 
https://elixir.bootlin.com/linux/v5.4.3/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c#L991

>
> On Sat, Aug 14, 2021 at 2:56 PM M.Sadegh Zeyghami <mszeyghami@gmail.com>
> wrote:
>
>> OK
>> you can see sdio log as below:
>>
>> [  684.265241] brcmfmac: brcmfmac_module_init No platform data available.
>> [  684.271302] brcmfmac: brcmf_ops_sdio_probe Enter
>> [  684.271323] brcmfmac: brcmf_ops_sdio_probe Class=0
>> [  684.271336] brcmfmac: brcmf_ops_sdio_probe sdio vendor ID: 0x02d0
>> [  684.271347] brcmfmac: brcmf_ops_sdio_probe sdio device ID: 0xa962
>> [  684.271357] brcmfmac: brcmf_ops_sdio_probe Function#: 1
>> [  684.271681] brcmfmac: brcmf_ops_sdio_probe Enter
>> [  684.271695] brcmfmac: brcmf_ops_sdio_probe Class=0
>> [  684.271706] brcmfmac: brcmf_ops_sdio_probe sdio vendor ID: 0x02d0
>> [  684.271713] brcmfmac: brcmf_ops_sdio_probe sdio device ID: 0xa962
>> [  684.271722] brcmfmac: brcmf_ops_sdio_probe Function#: 2
>>
>> is it possible that the error is related to below error log?
>>
>> [   18.352425] cfg80211: Loading compiled-in X.509 certificates for
>> regulatory database
>> [   18.552486] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>> [   18.631523] platform regulatory.0: Direct firmware load for
>> regulatory.db failed with error -2
>> [   18.690135] platform regulatory.0: Falling back to sysfs fallback for:
>> regulatory.db
>>
>> On Sat, Aug 14, 2021 at 11:48 AM Arend Van Spriel <
>> arend.vanspriel@broadcom.com> wrote:
>>
>>> + linux-wireless list
>>>
>>> On August 14, 2021 6:07:15 AM "M.Sadegh Zeyghami" <mszeyghami@gmail.com>
>>> wrote:
>>>
>>>> Hi,
>>>> How are you?
>>>> I've compiled a linux OS using yocto project. I want to have wifi
>>> interface
>>>> using WM-N-BM-02SDIO . I have set the WM-N-BM-02SDIO on sdio-1 which is
>>>> considered for sd card. I have successfully added wifi before in a
>>> project
>>>> with kernel 4.x.x.
>>>> now I'm trying with new sdk:
>>>> uname -a
>>>> 5.4.3-g9c2490ac8-dirty #3 SMP PREEMPT Sun Aug 8 12:11:16 UTC 2021 armv7l
>>>> GNU/Linux
>>>>
>>>> I have an issue with the brcmfmac kernel module. I have enabled brcmfmac
>>>> debug and enabled all message types in debug messages.
>>>>
>>>> you can see the dmesg output when I put this command insmod /<path to ko
>>>> file>/brcmfmac.ko debug=0x1FFFE :
>>>>
>>>> [ 2526.159218] brcmfmac: brcmfmac_module_init No platform data
>>> available.
>>>> [ 2526.168959] brcmfmac: brcmf_ops_sdio_probe Enter
>>>> [ 2526.168979] brcmfmac: brcmf_ops_sdio_probe Class=0
>>>> [ 2526.168991] brcmfmac: brcmf_ops_sdio_probe sdio vendor ID: 0x02d0
>>>> [ 2526.169001] brcmfmac: brcmf_ops_sdio_probe sdio device ID: 0xa962
>>>> [ 2526.169011] brcmfmac: brcmf_ops_sdio_probe Function#: 1
>>>> [ 2526.169347] brcmfmac: brcmf_ops_sdio_probe Enter
>>>> [ 2526.169362] brcmfmac: brcmf_ops_sdio_probe Class=0
>>>> [ 2526.169372] brcmfmac: brcmf_ops_sdio_probe sdio vendor ID: 0x02d0
>>>> [ 2526.169383] brcmfmac: brcmf_ops_sdio_probe sdio device ID: 0xa962
>>>> [ 2526.169392] brcmfmac: brcmf_ops_sdio_probe Function#: 2[
>>>> 3249.364285] brcmfmac: brcmf_sdio_exit Enter
>>>
>>> The vendor and device id are correct so can you retry using debug=0x31416
>>> enabling SDIO debug level.
>>>
>>> Regards,
>>> Arend
>>>
>>>
>>>
>>> --
>>> This electronic communication and the information and any files
>>> transmitted
>>> with it, or attached to it, are confidential and are intended solely for
>>> the use of the individual or entity to whom it is addressed and may
>>> contain
>>> information that is confidential, legally privileged, protected by
>>> privacy
>>> laws, or otherwise restricted from disclosure to anyone else. If you are
>>> not the intended recipient or the person responsible for delivering the
>>> e-mail to the intended recipient, you are hereby notified that any use,
>>> copying, distributing, dissemination, forwarding, printing, or copying of
>>> this e-mail is strictly prohibited. If you received this e-mail in error,
>>> please return the e-mail to the sender, delete it from your computer, and
>>> destroy any printed copy of it.




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

--00000000000002385105c983c0d4
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCicDNyrkU5ja6PhNzT
Qvu69txW70WSV9XCDtQH3RJarzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMTA4MTQxMjAzMDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJYuakv4Z0dt1x/670uBB41o5NCqghsbFW3wv
zoxmOFOd5XdtwDoK0yMHpCf5Bm3dlL74iRy3CJqbzGJW4soxNoLtmZwXP1HlKSjzPlAYKyS2Fgij
v9KADxSrVAbAbjjF63/chcByY9EUT8U+ZY9pBzUGzQ8a2/jyh8qFatWCWHc3P2H8Rl38YP4jBXNV
Hn1Cga3/ReGmgMWyndSqQWQFP14BS305W6kkoCbqbx/reXj3pR1r1YjznQTpdYT0EsNsCnYR10Ce
BPGqNNmqWgmNYDIiEGShhahCf8rWbrsAUo4qKFeFGrhlzBXI2OA56HtnuY4aJylno4EmTA/Y1H+U
kg==
--00000000000002385105c983c0d4--
