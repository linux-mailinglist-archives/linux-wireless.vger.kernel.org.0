Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971FE4CA099
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 10:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbiCBJYw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 04:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiCBJYu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 04:24:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD43FDBB
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 01:24:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so131085pju.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Mar 2022 01:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=jvz8O9VPCfiXM2t7VUGmE7NjrVFbUPb7U1TCIe6oVBY=;
        b=ZHo/uk7S+tyl+nk2Pjo0zezePPssF1FocGuyXsxkv3xjg1y7cKUFEVtsc+KsR9t1yk
         p1z7rwAebdSxE1bMbBJBY/zzlcoAT6sZ4WKF39p/uvV+/qGVa1Ia2F/K7UmvxamByUPO
         rg/A1j5AxQJ1dHkPsfteTiejt6eJWjdaoMQ/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=jvz8O9VPCfiXM2t7VUGmE7NjrVFbUPb7U1TCIe6oVBY=;
        b=RtprMHyOsvx9bSmEohmxzb+QDgI76AUEfci+zLntyZJvjtL6FbjozuYxxEhaSgz0U6
         oEXyjhPNly6E+rjC6wu6g+j1+tGwQEb5kNBUB6BEO9uv/m0UK+aeiKE+M9T7Fx/iokeP
         XuiFiqL83xI2lCI/p3j9XQERzRU6A/Saya8rVbgW5qY7D6fUgAkDOTz7nViQK0eKsumn
         vvMYrdNiA7QXQyhra3WxK5rTzkLkGzU8t5lQG2uuG11zZPRFDUKjJcEVknN5CkizU5aD
         u9aVPSi451CIyuiOgpL9heXvBzKbQsBBuqmPwnBgn8Npm9H3bmK0CKES6Vw0GJkBbJJA
         rOCg==
X-Gm-Message-State: AOAM531lYT6Zf7y0hl0tu60do63KzqWa6pq081mNsglLI7EwZeibhwMy
        PdpQiwSpyrIyjMVFKqRCFIFdQFw6hhSg/6fF4rs=
X-Google-Smtp-Source: ABdhPJw4CLyQhYt5FwsB3xEWca13mqaVoGXftX4Of0zDgFQji8r/uuc+y/du1QJD76y9o7NrK2Osew==
X-Received: by 2002:a17:90a:7f8a:b0:1be:d017:2df4 with SMTP id m10-20020a17090a7f8a00b001bed0172df4mr9120584pjl.98.1646213046390;
        Wed, 02 Mar 2022 01:24:06 -0800 (PST)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm20350901pfu.40.2022.03.02.01.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:24:05 -0800 (PST)
Message-ID: <89b87db4-1751-21b2-3e22-94d71e46c8d2@broadcom.com>
Date:   Wed, 2 Mar 2022 10:24:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] brcmfmac: include missing AP scan feature
To:     James Prestwood <prestwoj@gmail.com>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20220224181809.2808754-1-prestwoj@gmail.com>
 <87o82ud09z.fsf@bang-olufsen.dk>
 <a6fc2d3b3fbd4ed2149fd85a21f7aae8f7fdc926.camel@gmail.com>
 <87k0dhdg0d.fsf@bang-olufsen.dk>
 <50df7d732efb392a6669d89e0893b17f8cec4204.camel@gmail.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <50df7d732efb392a6669d89e0893b17f8cec4204.camel@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000dfc53105d938d7d6"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000dfc53105d938d7d6
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/28/2022 6:17 PM, James Prestwood wrote:
> Hi Alvin,
> 
> On Sat, 2022-02-26 at 11:27 +0000, Alvin Šipraga wrote:
>> Hi James,
>>
>> James Prestwood <prestwoj@gmail.com> writes:
>>
>>> Hi Alvin,
>>>
>>> On Fri, 2022-02-25 at 22:55 +0000, Alvin Šipraga wrote:
>>>> Hi James,
>>>>
>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>
>>>>> This driver does not advertise this feature yet scanning with
>>>>> on an
>>>>> AP interface appears to work just fine.
>>>>> ---
>>>>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |
>>>>> 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> I've submitted this patch mainly to start a discussion about
>>>>> it. I
>>>>> find it hard to believe that ALL brcmfmac devices support AP
>>>>> scanning
>>>>> in which case this feature needs to be limited to those devices
>>>>> only. Trouble is there is no FW feature for AP scanning AFAIK.
>>>>>
>>>>> In any case I think this driver needs to sort out if it
>>>>> supports
>>>>> this
>>>>> feature or not, and advertise as such rather than leaving
>>>>> userspace
>>>>> in the dark.
>>>>
>>>> By the way, what are the typical use-cases for AP scanning?
>>>>
>>>> I know that hostapd does a passive scan on the AP interface on
>>>> the
>>>> assumption that the driver/firmware will gather channel survey
>>>> data,
>>>> but
>>>> that's not a universally applicable assumption. Not all
>>>> implementations
>>>> will do that.
>>>
>>> We have someone wanting it for onboarding/configuring a new
>>> headless
>>> device. Where on boot, if it is unconfigured, it starts an AP and
>>> waits
>>> for a client to configure it.
>>>
>>> A client would connect, have the device scan and present available
>>> networks. The client then selects a network and provides
>>> credentials.
>>> The new device can then switch back to station mode and connect.
>>>
>>> This is a relatively common practice I've seen with IoT devices.
>>
>> Ah OK! Actually we do pretty much the same here at B&O with
>> brcmfmac. But rather than starting the AP on the primary interface
>> (the
>> one default created by the driver), we add a separate AP interface
>> with
>> the equivalent of the following command:
>>
>> # iw dev wlan0 add uap0 type __ap
>>
>> Here wlan0 is the primary interface, and uap0 is what I call my AP.
>>
>> In that case you can start the AP on uap0, but still do scanning on
>> wlan0 (which remains in station mode). Don't quote me on it, but I
>> think
>> this is the canonical approach with this driver. Is it something you
>> have considered?
> 
> Thanks, this does seem to work on brcmfmac. I had tried this on other
> hardware without any luck. I mentioned this to the user but since the
> AP scanning feature has been implemented they may want to still use
> that, but who knows. I think finding out if brcmfmac is intended to
> scan on the AP interface would still be good to know.

There is no easy answer to that. It really depends on the 
device/firmware. To be honest I don't know if the older chips can 
support it. Need to check that.

What device are you specifically looking at?

Regards,
Arend

--000000000000dfc53105d938d7d6
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAuyzBNn3AS/eM+RI5y
p6SOijESRefoCgY9MjvTYW6qazAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjAzMDIwOTI0MDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAdqkcREShGSpyrcvbaqtx/05EUJkZhIMNw2aO
R2x5av28uF4DyyavveUHxDMXXBtaDWwgXtDvkvu3VEa61WvAxXoFCBDeef/noWb+SY6Ov5mIIm9s
JEqbzJ83jy4Sm641+ew6Um0hpTdd4KUCH3OUsaFxhI0ALW1wCz6TQATbP0+7SPp4/ILNp9kYmuVV
QVxH9lJVfMrefBTZPY7mW1XTF7XiEsksLPouojiC0V2hqADn3PW/H7BH9eHs56izCckzsMX2RXFX
pHit+rRJUjym3GK7jbERSXsydIzk8Y6iIQu4HBqlq+qa6r2u4Tdcc8VsRoqo6BIdBCJJyQD4X2Mo
vw==
--000000000000dfc53105d938d7d6--
