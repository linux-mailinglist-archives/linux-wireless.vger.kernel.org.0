Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6C2FB41F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 09:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbhASIbi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 03:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbhASIbY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 03:31:24 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46189C061573
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 00:30:44 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id j12so4636855pfj.12
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=DDd48v+D50OMI9uocfcDNvX494UL3d8sTDWSb3gbimQ=;
        b=L/A45lLPZJp5X5mAnAJmHyUnqhT7tE9mfl7B6LfGDDnThSvtl06GQMRc8i73ZG7VJg
         r5S/+BWirs0AtQnT7Dp3JnmnPC16jOm5s/FtK4oX+jqP9WeIVFeoHp8BIz4tZgcdNLd+
         5vcD1egXq0/mDGvT2KffdFnV5rbWmJpM6eQ8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=DDd48v+D50OMI9uocfcDNvX494UL3d8sTDWSb3gbimQ=;
        b=aTkLfUXxY7BS+YFq4qkNPU3jqYY1W9Jh2U531S+XNkLYno0vKWU7aJDLKv4jZq+S5K
         D9DNxUf8RDPvBLm1TjlfsgHyvHsXXyyf8cVtjZldMBgSBf9aNp4cfbRZiQLW0Ec6ZB/Q
         Hxlf0QMGzg+58RyGBOqNZ2qQf3i+AQgJYKqozEIsvQFh7HctvoyWyOXih7EnDUJWZ2Af
         rUFThPBwHXa2/it5sLC3smtZtN2O1GWiOquUc7y5BT/XE/GVCZiedZfDY0DoZURpQf09
         MqPG36IKaOK3/XYpEvMGKG+CyNRqkOjvf1W3wtjkwJa1Dobs7tHjd/ZQoqhjTUqvI/vB
         3Nrg==
X-Gm-Message-State: AOAM533SLf1tgj+qxt4XQttudJ8wTVBFim/5udpcXmUT1GbMOp2w/tGY
        bSYUCXu97dCe51orjmY2OSz/e5tl/GwZUT2r9aYRbE+7tlOybEYcjF283LVQbnr0z6HrbYEd/V9
        Q1V5yGvz9Dd78PGyOPA==
X-Google-Smtp-Source: ABdhPJzQiIblyjx/CyJ2R/nfQe4kIXabY72O5eoxv+jDDEJR3FnINYt/BfB1wesg8sTcfDWtrq6/LQ==
X-Received: by 2002:aa7:8813:0:b029:19d:cd3b:6f89 with SMTP id c19-20020aa788130000b029019dcd3b6f89mr3408182pfo.42.1611045043584;
        Tue, 19 Jan 2021 00:30:43 -0800 (PST)
Received: from [10.230.32.84] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id bt8sm2803746pjb.0.2021.01.19.00.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 00:30:42 -0800 (PST)
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
 <2adec5d6-fbc9-680c-01d6-25f83327bf21@broadcom.com>
 <3a7de182-b0c7-352c-323b-3e3cebb9ffa3@bang-olufsen.dk>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <2b070521-b995-371f-d853-37cffc1a546a@broadcom.com>
Date:   Tue, 19 Jan 2021 09:30:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3a7de182-b0c7-352c-323b-3e3cebb9ffa3@bang-olufsen.dk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000091dc0b05b93ca784"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000091dc0b05b93ca784
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/15/2021 3:57 PM, Alvin =C5=A0ipraga wrote:
> Hi Arend,
>=20
> On 1/15/21 3:10 PM, Arend Van Spriel wrote:
>> + Johannes
>> - netdevs
>>
>> On 1/14/2021 5:36 PM, 'Alvin =C5=A0ipraga' via BRCM80211-DEV-LIST,PDL wr=
ote:
>>> Add support for CQM RSSI measurement reporting and advertise the
>>> NL80211_EXT_FEATURE_CQM_RSSI_LIST feature. This enables a userspace
>>> supplicant such as iwd to be notified of changes in the RSSI for roamin=
g
>>> and signal monitoring purposes.
>>
>> The more I am looking into this API the less I understand it or at least
>> it raises a couple of questions. Looking into nl80211_set_cqm_rssi() [1]
>> two behaviors are supported: 1) driver is provisioned with a threshold
>> and hysteresis, or 2) driver is provisioned with high and low threshold.=
 >
>> The second behavior is used when the driver advertises
>> NL80211_EXT_FEATURE_CQM_RSSI_LIST *and* user-space provides more than
>> one RSSI threshold. In both cases the same driver callback is being used
>> so I wonder what is expected from the driver. Seems to me the driver
>> would need to be able to distinguish between the two behavioral
>> scenarios. As there is no obvious way I assume the driver should behave
>> the same for both cases, but again it is unclear to me what that
>> expected/required behavior is.
>=20
> It will only provision the driver according to behaviour (1) if 0 or 1
> thresholds are being set AND the driver implements
> set_cqm_rssi_config(). But it says in the documentation for the
> set_cqm_rssi_range_config() callback[1] that it supersedes
> set_cqm_rssi_config() (or at least that there is no point in
> implementing _config if range_config is implemented). In that case, and
> if just one threshold is supplied (with a hysteresis), then a suitable
> range is computed by cfg80211_cqm_rssi_update() and provided to
> set_cqm_rssi_range_config(). I guess the implication here is that the
> two behaviours are functionally equivalent. I'm not sure I can argue for
> or against that because I don't really know what the semantics of the
> original API were supposed to be, but it seems reasonable.
>=20
> As a starting point - and since the firmware behaviour is very close
> already - I implemented only set_cqm_rssi_range(). I have been testing
> with iwd, which by default sets just a single threshold and hysteresis,
> and the driver was sending notifications as would be expected.

OK. I overlooked that there were two different callbacks involved. So I=20
will review the patch with that knowledge. What wifi chip did you test=20
this with and more importantly which firmware version?

Regards,
Arend

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

--00000000000091dc0b05b93ca784
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
IDcgKKypireDtnI8Ar1K2pI5mxEOj7Te0FCIpzf3lbnJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDExOTA4MzA0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA5Ye/No5fR4qAAzyQo
XYfiOjNfA2vCNlz7cEEs1y73stzMc/HZL6z72RAW7fIfYunoLlp/8GkAhxMbdP3SBI8v4otVTWi3
HI/YQB5fDwF9OZtwDZ7qD2mF4K1HU0qM/ixeHNOBeEm8Tg9GB7spIeavB2wvs1S5tjX4pVeiy8lF
r/+m+cYm/ZJe9O1LoHi/yJubaZKr7UT1TR1iaDlzWcs2jVe0lDzs2CL+g/FrEwe+sV/1LHJBbsW3
ivsqTZcHUh/3+0/eDbN2jnu/C7+d/QpaiHWwAHHdpCmQAhx8xZ7ZJd9p93YVlcOgyffY9Uzbbj4J
SwixgW3+zZs8/3GTCeqn
--00000000000091dc0b05b93ca784--
