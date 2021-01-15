Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6E2F7DD1
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 15:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbhAOOLp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 09:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbhAOOLo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 09:11:44 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ACCC0613C1
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jan 2021 06:11:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w1so6289464pjc.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jan 2021 06:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=PSOT/zvY8PWlY0VcY9SaD2isv4sKHVSsvjjVM3smDQg=;
        b=ZPLvBufp8i5oqF82RkQfuFNaq+6WTTEprfeZjA5iNB1u+Us3+Gd2rDuocoaN3k3+eu
         IMCxPa4fFMppqMqjibXDJC84R7spePK30seJLg8IepI6jgzSUhIjAxx+yMULuXGL+k1A
         ScguSoIco/5qBHDdZFpkx2yoL0eZxzRZyFSgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=PSOT/zvY8PWlY0VcY9SaD2isv4sKHVSsvjjVM3smDQg=;
        b=D4kyA4sABUD8yh3UtONts7Yql9ygCBt2Bd2UYlQflRYH+74TG/64zTKjbCNbh7CV35
         q5PGHrWly9uEvCXsQPvAO3vExMMSdjrn9OBQierKhOnznJt1XgbCEub2cYM/Jr9y8/ut
         htKIe7fIxh1O7TV1oNC61kIGTEHLsoNnzDDJgiQ/qLSs+rbvOFAJzXsev3t7jImG3m9Y
         4IRHtvlfSwAVDA8FCcVn+57bHL/2a2QxnmhW+bDxjnJ0CKIcZhNb/za1J0FmGrIDbnGu
         CMkvmaNevjsCoxNh0TEk61awg8D04rvMZW4H+OsC9XNwkHJTL/nIdv8XbpoDDu8QIcnR
         z7Dg==
X-Gm-Message-State: AOAM5334LqF6PmNpcAK9p4sk9MXMT41QPflj8l2xCuZr9MKmWXkBvN+Z
        iYDYO+r5nQ84U8ckgzxZT2/Z7I2/Z491jVRiMC/khqviE1r1VNKtH+W5cxnKULQTxA5QZIu6BDY
        4wpz98SXHulKEX+MANw==
X-Google-Smtp-Source: ABdhPJxGhB2odKfadKjoQ9dasBH16p4eooz87Ppy+ql1ChnlB5INyVLQEkWPUIeIw/BeAx18tdGM/g==
X-Received: by 2002:a17:90b:e96:: with SMTP id fv22mr10763251pjb.92.1610719863397;
        Fri, 15 Jan 2021 06:11:03 -0800 (PST)
Received: from [10.230.40.117] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id a31sm8425726pgb.93.2021.01.15.06.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 06:11:02 -0800 (PST)
Subject: Re: [PATCH v2] brcmfmac: add support for CQM RSSI notifications
To:     =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210114163641.2427591-1-alsi@bang-olufsen.dk>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <2adec5d6-fbc9-680c-01d6-25f83327bf21@broadcom.com>
Date:   Fri, 15 Jan 2021 15:10:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114163641.2427591-1-alsi@bang-olufsen.dk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005160f305b8f0f116"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000005160f305b8f0f116
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

+ Johannes
- netdevs

On 1/14/2021 5:36 PM, 'Alvin =C5=A0ipraga' via BRCM80211-DEV-LIST,PDL wrote=
:
> Add support for CQM RSSI measurement reporting and advertise the
> NL80211_EXT_FEATURE_CQM_RSSI_LIST feature. This enables a userspace
> supplicant such as iwd to be notified of changes in the RSSI for roaming
> and signal monitoring purposes.

The more I am looking into this API the less I understand it or at least=20
it raises a couple of questions. Looking into nl80211_set_cqm_rssi() [1]=20
two behaviors are supported: 1) driver is provisioned with a threshold=20
and hysteresis, or 2) driver is provisioned with high and low threshold.

The second behavior is used when the driver advertises=20
NL80211_EXT_FEATURE_CQM_RSSI_LIST *and* user-space provides more than=20
one RSSI threshold. In both cases the same driver callback is being used=20
so I wonder what is expected from the driver. Seems to me the driver=20
would need to be able to distinguish between the two behavioral=20
scenarios. As there is no obvious way I assume the driver should behave=20
the same for both cases, but again it is unclear to me what that=20
expected/required behavior is.

With behavior 2) some processing is done in cfg80211 itself by=20
cfg80211_cqm_rssi_update() which is called from nl80211_set_cqm_rssi()=20
upon NL80211_CMD_SET_CQM and cfg80211_cqm_rssi_notify() called by=20
driver. If I look at that it matches pretty close what our firmware is=20
doing. The difference is that our firmware avoids RSSI oscillation with=20
a time constraint between RSSI events whereas cfg80211 uses the hysteresis.

So before moving forward, I hope Johannes can chime in and clarify=20
things. Added the commit message introducing the extended feature below.=20
It mentions backward compatibility, but it only considers the extended=20
feature setting when user-space provides more than one threshold.=20
However, when the drivers set the extended feature is expects (low,=20
high) and (threshold, hysteresis) if not. So it seems the extended=20
feature should have precedence over the number of thresholds provided by=20
user-space.

Regards,
Arend

[1]=20
https://elixir.bootlin.com/linux/v5.10.7/source/net/wireless/nl80211.c#L114=
79

---8<-----------------------------------------------------------------
commit 4a4b8169501b18c3450ac735a7e277b24886a651
Author: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date:   Fri Feb 10 10:02:31 2017 +0100

     cfg80211: Accept multiple RSSI thresholds for CQM

     Change the SET CQM command's RSSI threshold attribute to accept any
     number of thresholds as a sorted array.  The API should be backwards
     compatible so that if one s32 threshold value is passed, the old
     mechanism is enabled.  The netlink event generated is the same in both
     cases.

     cfg80211 handles an arbitrary number of RSSI thresholds but drivers=20
have
     to provide a method (set_cqm_rssi_range_config) that configures a rang=
e
     set by a high and a low value.  Drivers have to call back when the RSS=
I
     goes out of that range and there's no additional event for each=20
time the
     range is reconfigured as there was with the current one-threshold API.

     This method doesn't have a hysteresis parameter because there's no
     benefit to the cfg80211 code from having the hysteresis be handled by
     hardware/driver in terms of the number of wakeups.  At the same time
     it would likely be less consistent between drivers if offloaded or
     done in the drivers.

     Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
     Signed-off-by: Johannes Berg <johannes.berg@intel.com>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000005160f305b8f0f116
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
pra5sIx/TR6gNtLG9MpND9zQt5j42hInkP81vqu9DG8lovoPMuR0JVpFRbPjHZ07cLqqbFMVS/8z
53iSewIDAQABo4IB0zCCAc8wDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggr
BgEFBQcwAoZBaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNp
Z24yc2hhMmczb2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNv
bS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAw
RAYDVR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2ln
bjJzaGEyZzMuY3JsMCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYD
VR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0O
BBYEFHAaaA+cRo3vYiA6aKVu1bOs4YAYMA0GCSqGSIb3DQEBCwUAA4IBAQCYLdyC8SuyQV6oa5uH
kGtqz9FCJC/9gSclQLM8dZLHF3FYX8LlcQg/3Ct5I29YLK3T/r35B2zGljtXqVOIeSEz7sDXfGNy
3dnLIafB1y04e7aR+thVn5Rp1YTF01FUWYbZrixlVuKvjn8vtKC+HhAoDCxvqnqEuA/8Usn7B0/N
uOA46oQTLe3kjdIgXWJ29JWVqFUavYdcK0+0zyfeMBCTO6heYABeMP3wzYHfcuFDhqldTCpumqhZ
WwHVQUbAn+xLMIQpycIQFoJIGJX4MeaTSMfLNP2w7nP2uLNgIeleF284vS0XVkBXSCgIGylP4SN+
HQYrv7fVCbtp+c7nFvP7MYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNI
QTI1NiAtIEczAgxR3m7Pj6LvQiWjJy0wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IN49DNbSIaTsSj2lMkoelr7AKrCHJfHFJ7e1Hohl5a+WMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDExNTE0MTEwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBbKJeP308lCtVHOl2Y
dEqFhbAA3fgyZodyw4Vhf6dQXHnBNioitwW9duXCFHLRLOD04Q7qJEwgaXjKOSFxygOIs+RkKslz
nESFJBV80psjS2JbbbKhdYpLIZ24KvEBelIhMk+Sb2tTF5NqyhwihAkjjK/VDS6iYb1OYFqX2ZuK
CJqWzTyD+ATQdXImgWUSAKODsrSXkMN9DmiRWH5c6uUspfPG7UcXu54EIIS3qxjWYO0oYbQf4Nx7
5AZfBXGiYuvAKjKddEQOSsPkNPrhTjeflE5r5aMMLCiGbwXyOANu/LIb2CYmXNfEpyoJZCui0qPF
a4R0LRBBGUJFqTWJtkWw
--0000000000005160f305b8f0f116--
