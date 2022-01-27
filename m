Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E274049E761
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 17:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbiA0QWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 11:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiA0QWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 11:22:20 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A200BC061714
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 08:22:20 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 192so3086396pfz.3
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 08:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=MsSX/5uHbsXMk0DLDuU+CeC/P1F+Ecbu2je5TdAaEqo=;
        b=MEENHHqBS4Ou5e5yQD1NK3gWjmsyB5dScfXI0KKRVS4UXl6IDaSqW4CSFfX1dgJL1D
         QezI2ucGRWYL4IG93FeHA+Fz3a9d4pS2/N/QVXQe5uPwloz2zl2xt0jcCt4lFWhRoOna
         WehUZ58WQrFKofN3PjAgErayVTX2G06aqgkFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=MsSX/5uHbsXMk0DLDuU+CeC/P1F+Ecbu2je5TdAaEqo=;
        b=YmMhSj9K97DWzTPGyFL1RfTNgUVpomK/8l1RqE3yQWaZh7Jtgi73PzzXRNSsy/O8sI
         d6q3txC390BLgkKsFIsH74dqIQtALR+7eT9QSBfch6mO8MBO/9MzEMvJ7Ze6e87EO9Sn
         16IdAOuTvwPjolZ6SAOfVMhy4A1f6RmJNdqEt/d+Mq+I898Xzf2hyOUAK6qiF50P1NN1
         akrs6VWi2FFa05lYupcLW/9FNJRTjSJI1f0TFssfXYGWa4YWlNOXkU153J4O6bY4QqLI
         W6k0nT6WtDaHaiHRCL30Z2xjpx4pQ92ejgW3ET6CooyDm/s3ox3XxnejPt1ufuQSQ9LU
         Y27w==
X-Gm-Message-State: AOAM531HsBSq4v8oVYWztjsiH8D3YXn6M2z1/In/NfJxOWrfYKLtkXLN
        Wa2Ure8a+3iZzQa30mghY6JSuA==
X-Google-Smtp-Source: ABdhPJzgYD3SDJCvydbKk+dDjWbvScqHPPdsO4CtsQ4iL14GxXrAgTOPXX9RaTBViZv5icsl62uQXw==
X-Received: by 2002:a63:2021:: with SMTP id g33mr3198487pgg.51.1643300540034;
        Thu, 27 Jan 2022 08:22:20 -0800 (PST)
Received: from [192.168.178.136] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id f20sm103594pgh.60.2022.01.27.08.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 08:22:18 -0800 (PST)
Message-ID: <4c877164-5fcf-aa07-2ffa-f9446d4394ff@broadcom.com>
Date:   Thu, 27 Jan 2022 17:22:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] brcmfmac: firmware: Fix crash in brcm_alt_fw_path
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        Arend van Spriel <aspriel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20220118154514.3245524-1-phil@raspberrypi.com>
 <87h7a0gt7f.fsf@kernel.org>
 <07dbaff1-bc12-d782-ed14-ef3f33d3c041@raspberrypi.com>
 <ebe36c68-cdf9-b005-6d02-f72c3917d292@broadcom.com>
 <87r18tjs9k.fsf@kernel.org>
 <a0179a36-0daa-06ca-6d54-ace6b6eceeb8@broadcom.com>
 <87ee4tjp24.fsf@kernel.org>
 <82bf9633-ccd4-106f-89f5-921dd0534214@broadcom.com>
 <87y231i429.fsf@kernel.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <87y231i429.fsf@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f883c905d692b84a"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000f883c905d692b84a
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/2022 4:36 PM, Kalle Valo wrote:
> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
> 
>> On 1/27/2022 2:17 PM, Kalle Valo wrote:
>>> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>>>
>>>> On 1/27/2022 1:08 PM, Kalle Valo wrote:
>>>>> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>>>>>
>>>>>> On 1/19/2022 9:53 AM, Phil Elwell wrote:
>>>>>>> On 19/01/2022 06:01, Kalle Valo wrote:
>>>>>>>> Phil Elwell <phil@raspberrypi.com> writes:
>>>>>>>>
>>>>>>>>> The call to brcm_alt_fw_path in brcmf_fw_get_firmwares is not protected
>>>>>>>>> by a check to the validity of the fwctx->req->board_type pointer. This
>>>>>>>>> results in a crash in strlcat when, for example, the WLAN chip is found
>>>>>>>>> in a USB dongle.
>>>>>>>>>
>>>>>>>>> Prevent the crash by adding the necessary check.
>>>>>>>>>
>>>>>>>>> See: https://github.com/raspberrypi/linux/issues/4833
>>>>>>>>>
>>>>>>>>> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware
>>>>>>>>> binaries")
>>>>>>>>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>>>>>>>>
>>>>>>>> I think this should go to v5.17.
>>>>>>>
>>>>>>> Is that an Ack? Are you asking me to submit the patch in a different way?
>>>>>>
>>>>>> Similar/same patch was submitted by Hector Martin [1].
>>>>
>>>> Fine by me. Hector's subset series (fixes) is ready to be taken as
>>>> well, right?
>>>
>>> I have not looked at Hector's patches yet, my plan is to take them to
>>> wireless-next.
>>
>> Some of them are improvements so wireless-next is where those belong,
>> but a few (patches #1-3, and #6) are actual bug fixes.
> 
> To avoid conflicts I'm keeping the bar high for patches going to
> wireless, so it's mostly regression fixes or otherwise important fixes.

Understood. No problem.

Regards,
Arend

--000000000000f883c905d692b84a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQdwYJKoZIhvcNAQcCoIIQaDCCEGQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3OMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVYwggQ+oAMCAQICDDEp2IfSf0SOoLB27jANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNzQ0MjBaFw0yMjA5MDUwNzU0MjJaMIGV
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEFyZW5kIFZhbiBTcHJpZWwxKzApBgkqhkiG
9w0BCQEWHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQCk4MT79XIz7iNEpTGuhXGSqyRQpztUN1sWBVx/wStC1VrFGgbpD1o8BotGl4zf
9f8V8oZn4DA0tTWOOJdhPNtxa/h3XyRV5fWCDDhHAXK4fYeh1hJZcystQwfXnjtLkQB13yCEyaNl
7yYlPUsbagt6XI40W6K5Rc3zcTQYXq+G88K2n1C9ha7dwK04XbIbhPq8XNopPTt8IM9+BIDlfC/i
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA/izz3pskiLFNXXk1D
T2Ggbr+iFST11RWi5hJBsUsvKjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjAxMjcxNjIyMjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHoQiIsX2uJSEVp1NeLwV+Qb9zPpCUYiGjBKh
QQK7tijPnKHbiTXXmuTHiVkfbJrk0ueo1lWjv/1GUDFvKbfRAVXTdJO+JC+6YhskkEVf3uHUy4By
LmpjOjS4LFnNtedgcOYPnfhsjW+hqENUh2jrPsedVkA1D+gq0k7XJmc53cUoeVdmLzGD5Z6HMfWr
ay/ZUyPtdilbUBbDr8dsj7l66DfFxuxShLKXrOosq+F0Ic92IU6myFg0UXzmyQ16Rbsoyy0TunhD
nQsZaY+W8jZVuP8WTjoaueAJ/WLVCiOmiduFYFxrFA29xixXEARsKy63YvXgtYg7C1RgDasvDNm1
eQ==
--000000000000f883c905d692b84a--
