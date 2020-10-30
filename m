Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F052A0801
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJ3OgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 10:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3OgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 10:36:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0AAC0613D2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 07:25:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c20so5426463pfr.8
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=w/8x7K3UAWKqFtcltLKAwEAwsbXBm+pQP4LvjDwuXaQ=;
        b=SYJEgfO4WZTTbJsYveDLPlXrBgxevn/HCrOrJpZUR7ngu2/rYH5tESOt0xUeeZQlja
         mvTAsWY+S1vlD2pp6qKxftqVnW9TCVTfWV3rgyL75Vku7UZTF6iwYcS92rfJvBPSfvdr
         MmtEDGS/kG8Q1ISvRmkYwYLdCSRZ+Un30LYgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=w/8x7K3UAWKqFtcltLKAwEAwsbXBm+pQP4LvjDwuXaQ=;
        b=Zs+3cPJG7uya6fYDW2i4F7EwiNAnR+m/4VbooEbmWOzf7ZJLOWTEwTCV+m15EboEfU
         ymou0H8J5TrVe8RCsinsknw9/8Jr6mSscW/CuAH/GIBsgMZlYg0jZQmYqU0fxz01KAgN
         oRnjjU4Ejd2iNyisLT/ZETLF8sKLa0VfbJsn3FjNYVf1nwkruccSNntdyqsXxkCpG198
         Eid+OVTB8oXDLDSmcHbNjYK8lW1jhR2ISnHgd9Rr/TxbitMhYSt4bipPcin8gAv717iJ
         8J8njwiord5lhcSsc50E+HH11tq6JhBaHOCevwpo26xHSbYciiujz4PeefHLXAlok0AF
         6LMQ==
X-Gm-Message-State: AOAM533a9MS9Y+haVuABBbiK0OboPWrkgRkwxvTQwj6uj0OBs99iTqmJ
        aJp1xQx5cEmjhv9+fx5hYOk9QMcUJSHjYGb9hFSpIbSE/EbpLA18ZM0xQq4mEQOOcOGbESgvVm8
        bAz6S06VqaY3Y+hDkwOpN61mYuhNeh2XrxOllt+vLOvy9+yzVsF48lcpdtK8yFxzN7oDOkK6gY4
        /qqn5fVlPGHZ6D4GZj
X-Google-Smtp-Source: ABdhPJx9QifMb1Dzd1BBFYSzCMivNEZ71S7nz7DmpstQA15zfPfeoODoM3RE7w3y4X53MgyTFuaJiw==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr1888373pji.139.1604067943319;
        Fri, 30 Oct 2020 07:25:43 -0700 (PDT)
Received: from [10.230.33.93] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id g7sm3639861pjl.11.2020.10.30.07.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 07:25:42 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: Add 024c:0627 to the list of SDIO
 device-ids
To:     Brian O'Keefe <bokeefe@alum.wpi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
References: <CABtq2xReyqg1wJM7W1d=KWRNTNN0Q6HCgJMWcQ6DH=SmKcxQRg@mail.gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <b0fd8b5a-66f3-871c-fe37-939d814f3f99@broadcom.com>
Date:   Fri, 30 Oct 2020 15:25:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CABtq2xReyqg1wJM7W1d=KWRNTNN0Q6HCgJMWcQ6DH=SmKcxQRg@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fb658505b2e42bce"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000fb658505b2e42bce
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/29/2020 2:52 PM, Brian O'Keefe wrote:
> Add 024c:0627 to the list of SDIO device-ids, based on hardware found in
> the wild. This hardware exists on at least some Acer SW1-011 tablets.
> 
> Signed-off-by: Brian O'Keefe <bokeefe@alum.wpi.edu>
> ---
>   drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 5b1392deb0a7..7256d55fcc1b 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -21,6 +21,7 @@ static const struct sdio_device_id sdio_ids[] =
>          { SDIO_DEVICE(0x024c, 0x0525), },
>          { SDIO_DEVICE(0x024c, 0x0623), },
>          { SDIO_DEVICE(0x024c, 0x0626), },
> +       { SDIO_DEVICE(0x024c, 0x0627), },
>          { SDIO_DEVICE(0x024c, 0xb723), },

shouldn't these be listed in include/linux/mmc/sdio_ids.h ?

Regards,
Arend

--000000000000fb658505b2e42bce
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
IAHFUgKiEMcu8KxR3xvcbAtLQdiw2gjkhaoLTW5NzIrhMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIwMTAzMDE0MjU0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCc1bZ6eQmhGbRWYA7f
EUr/U57xFk2+EJaJugfETeR2Yd5k46OUVHSsPy0h2FBlZQ8zjjB5q2a3a11Z1TsF/5DL7/mLq1+P
wJO4TkiQ/QC+lkrh/1WPMF/FRZ8buEs5z/px0JMIukEmE2L36+7QMiUNMrihB2rfiEtpn0Fr3+2D
yYtdO0a/T1XbsD12I8uamK3Ysnj/Vrdq3c6dqH9RSflXLxIlIWru14kyiPKEUc6vqfQmRbOWz6BR
Xrm/gHEm6LROHI92Zh80YsQCnygjgwsdF0dX4ISn+3XeHfoF0oxrgCG4YhtLuYvMvfqe/qefRexq
rHIB3s2fnJpSdGhenliZ
--000000000000fb658505b2e42bce--
