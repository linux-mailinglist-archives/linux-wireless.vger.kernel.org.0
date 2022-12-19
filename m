Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B9D65112A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiLSRVR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 12:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiLSRU5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 12:20:57 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993D92DF4
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 09:20:55 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kw15so23134510ejc.10
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 09:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/L4nPRpIJMpPEUoGv8qagiWCBkAdtRmMzg6d3hfEoLM=;
        b=EVSGzqE9EpRYoxJTzZ9Fi/CHQV4TmxJy/alq4R43x2JKb+RP8g7ODfBO9y/kRMYShr
         hz4Ji7syv0qAHzaytmk0rh5M0TItQRbIb33D9ZYZYyD+HWfLpqfsARoW2vmN46KdCRwM
         owRU30Am/qdfy5QXm/iNo2mewR4qJB0dSDHng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L4nPRpIJMpPEUoGv8qagiWCBkAdtRmMzg6d3hfEoLM=;
        b=GykqT66qQuFYNUNdr76CjuxJSKiNsQjSzuTXsBQlrZsPqPM366GBxGyQCKRgBiSOSR
         umjC3G0/Dd9bhVgIDSUsZNHCPEFlYM8thd+xCVZ++rtTb0apjqoP7bkWm83xR/DDhu6r
         NaBlqEI8xLh/kMu8F84Wo/+Ui1cJY9hcwnQG3YiYX5VPNaSRPiXRIZKxNFHKh1G/7xa1
         0Q+JeOv5XkOnhkXoAMNSnj9yEtnS2qlG36vjb7v8luMs+XO+Ax1wl6w5KkRaIe5cMi/Z
         aQx9orps4o4nUjPYjTV3tb9oI97tePuQFzYIfM7DoIKtg3RPVoVMGQuYJQvksx6M+DwW
         61nA==
X-Gm-Message-State: ANoB5pk11eyoZYq4h9iJgyf/hLNI3pokYm7W9BjoH1uqL/wPzPRyIXh+
        PT5n80vAfFAy/j0Dn1mH5pYTaWfijHYT7xA5xt0=
X-Google-Smtp-Source: AA0mqf54CxGlBSrMtlsqcV8vU1St14XKV/+LfL9T9MLAKaV70uIW2VRDeSQppXB/dowRDTExgWtM/g==
X-Received: by 2002:a17:906:4c4b:b0:7c1:1ada:5e1e with SMTP id d11-20020a1709064c4b00b007c11ada5e1emr35295209ejw.26.1671470454180;
        Mon, 19 Dec 2022 09:20:54 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090631d600b007aece68483csm4595832ejf.193.2022.12.19.09.20.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2022 09:20:53 -0800 (PST)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
CC:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>, <linux-firmware@kernel.org>
Date:   Mon, 19 Dec 2022 18:20:51 +0100
Message-ID: <1852b670938.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <812120ff-2fcd-e05e-7748-6a731e782811@gmail.com>
References: <20221207230556.383935-1-arend.vanspriel@broadcom.com>
 <20221207230556.383935-3-arend.vanspriel@broadcom.com>
 <812120ff-2fcd-e05e-7748-6a731e782811@gmail.com>
User-Agent: AquaMail/1.41.0 (build: 104100234)
Subject: Re: [PATCH 2/8] brcm: update bcm4329 firmware file
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000af225b05f0318a18"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000af225b05f0318a18
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On December 19, 2022 5:58:29 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> Hi,
>
> 08.12.2022 02:05, Arend van Spriel пишет:
>> bump version from 4.220.48.0 to 4.218.248.44. Version numbering
>> scheme is obscure but this is a more recent firmware file.
>>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> ---
>> brcm/brcmfmac4329-sdio.bin | Bin 253748 -> 246791 bytes
>> 1 file changed, 0 insertions(+), 0 deletions(-)
>
> This firmware version doesn't work on any of NVIDIA Tegra tablets
> supported by upstream kernel, tested using next-20221216. Please revert
> or fix, thanks!
>
> Faulty 4.218.248.44 kernel log:
>
> brcmfmac: brcmf_wcc_attach: executing
> brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2),
> device may have limited channels available
> brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4329/3 wl0: May 25 2012
> 17:57:45 version 4.218.248.44
> ieee80211 phy0: brcmf_c_set_joinpref_default: Set join_pref error (-52)
> ieee80211 phy0: brcmf_setup_wiphybands: rxchain unsupported
> ieee80211 phy0: brcmf_construct_chaninfo: get chanspecs error (-52)
> ieee80211 phy0: brcmf_setup_wiphybands: brcmf_construct_chaninfo failed
> (-52)
> ieee80211 phy0: brcmf_cfg80211_attach: Setting wiphy bands failed (-52)
> ieee80211 phy0: brcmf_bus_started: failed: -12
> ieee80211 phy0: brcmf_attach: dongle is not responding: err=-12
> brcmfmac: brcmf_wcc_detach: executing
> brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed

Thanks, Dmitry

Could you provide the full log and insert brcmfmac with debug=0x1416 
(requires CONFIG_BRCMDBG).

Regards,
Arend

> Good 4.220.48.0 kernel log:
>
> brcmfmac: brcmf_wcc_attach: executing
> brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2),
> device may have limited channels available
> brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4329/3 wl0: Sep  2 2011
> 14:48:19 version 4.220.48
> ieee80211 phy0: brcmf_setup_wiphybands: rxchain unsupported




--000000000000af225b05f0318a18
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC4MCgJ+6IH9V1N3Ny4
vC+cRmuylkzgokAc+LfHITm3tjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjEyMTkxNzIwNTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA0JI6mufhgt7U2j4QDAFeFs0mE/6Gjii+gnOh
gRX439Ss3pRb01YEBKAo/K1f/6efCasRacglGxylRjIuPGmCMfV0wVCLXeBJp4OxnNiSHdkFThsY
IC9EhUQFpNpdi77QVLNf471ael4Mw/ynATflq8tZtGfemBmwQabDnDBr0uN9RUd0oS7j/sqh4D24
rfU7FQzB82f7WGCfwzGkYoYMEglQ1bMyfoEcyzYaKX5+pRyRS+BTKRYA1YVSLrCevgzPQ/WFNqBk
3ulNRpAXCDPffUAVB9mj+NkvsdIgBEeeOldQOXOW9Wvh288xfHpXu11ZCv21Vtj730J7fqH9OXL2
6Q==
--000000000000af225b05f0318a18--
