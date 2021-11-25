Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1E945D785
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 10:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349868AbhKYJtk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 04:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354243AbhKYJri (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 04:47:38 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C3C061763
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 01:44:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m24so4106950pls.10
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 01:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=ZYbE7d7rCCNkSPkELMwK6d1/y/zAbMXrIl7A1CBNzUg=;
        b=efEfb69tadMEkFUFWU2iF1smTMNnrxM4URsNfQHRf2Tgt+7PNUzDPaAqm5jyQSkQKf
         itchSosT4BpSM7ZIXPDJct+5+GRVnE7XoAN+NiYj2f6rCUesxtrWS2SKY6h1hWCEyuar
         4XJJT3ZBxEmj3/7/VgmDtcqYnwNVN32B4nSh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=ZYbE7d7rCCNkSPkELMwK6d1/y/zAbMXrIl7A1CBNzUg=;
        b=ma4takpkQW67SLoqARD9vYMr3uYxlzniiKCk5nCXlvdkLfDH3ydqZpyHn8vOFa8nbx
         NtSl+TlhG9c0gq1AYSG3VKI2bCs1ZEXzrcn8hF/akCFpSMZdRsxKrAbF+ziW0gG0fxPi
         DjapT5EkRZFc0gjhQMgUTp2IEnwy0Dw5rBB1Aum0RxWNVKWE2uYJDl0W92Vw0zs3mkjm
         btQIQ0e73YkNZIK9x/BR26Ur+kXRDrXkKho2qfUP1UH/A6LJMZISmBT1erVUMXA9I1b/
         lQJ5a5YZ5i+IwQztGF42XNoW3kdTG/55s5SZVKCYwIbDs1wamr2McOyt/bt4HNfTOgm+
         Fetw==
X-Gm-Message-State: AOAM532PLXYcMxYSn4vr3YWR8RRIUUcWobQxEYq/uMxrF19L7Tyx4mMm
        3/4IGYskzLk0WnHUBBvkEenQ7SsNNVASvmfdej0=
X-Google-Smtp-Source: ABdhPJycQXBdUjduz6q+JQ7T69L7W4WJNClhr+5A0XbI26D4/VRrpp/Qg+YpTU6hUo6Tvx+QFYii9g==
X-Received: by 2002:a17:902:d505:b0:142:175d:1d4 with SMTP id b5-20020a170902d50500b00142175d01d4mr27955570plg.50.1637833466637;
        Thu, 25 Nov 2021 01:44:26 -0800 (PST)
Received: from [192.168.178.136] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id h13sm2503749pfv.37.2021.11.25.01.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 01:44:24 -0800 (PST)
Message-ID: <ac096741-70d1-9ecd-00fe-9182ace525d3@broadcom.com>
Date:   Thu, 25 Nov 2021 10:44:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] brcmfmac: add CYW43570 PCIE device
To:     "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin-ee@infineon.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, Chi-Hsien.Lin@infineon.com,
        Wright.Feng@infineon.com, Double.Lo@infineon.com
References: <3f57f2b0-82c2-e339-ee6a-1569186143d6@infineon.com>
 <d7d7c3dc-d8bb-e9ab-8357-f8c921fcdd75@broadcom.com>
 <ca0b63d7-b50b-748e-1a3f-e07464eb3949@infineon.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <ca0b63d7-b50b-748e-1a3f-e07464eb3949@infineon.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000000002105d199d296"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000000002105d199d296
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/2021 10:29 AM, Lin Ian (CSSITB CSS ICW SW WFS / EE) wrote:
> 
> 
> On 11/23/2021 8:32 PM, Arend van Spriel wrote:
>> On November 23, 2021 7:24:32 AM "Lin Ian (CSSITB CSS ICW SW WFS / EE)" 
>> <ian.lin-ee@infineon.com> wrote:
>>
>>> From: Soontak Lee <soontak.lee@cypress.com>
>>>
>>> CYW43570 is a 3-antenna, 2x2 MIMO,802.11a/b/g/n/ac, PCIe 3.0 for WLAN.
>>> It is BT/WIFI combo.
>>>
>>> Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
>>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
>>
>> Missing signoff
>>
>>> Jira:SWLINUX-1213
>>
>> Meaningless to the public so remove it when submitting to the community.
> I will send a new patch mail that modified the commit message, thank you.

great.

>>> ---
>>>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 1 +
>>>  drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>> index 8b149996fc00..ceeb1f10752a 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>> @@ -2106,6 +2106,7 @@ static const struct pci_device_id
>>> brcmf_pcie_devid_table[] = {
>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID),
>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID),
>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID),
>>> +    BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_RAW_DEVICE_ID),
>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_4358_DEVICE_ID),
>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_4359_DEVICE_ID),
>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_DEVICE_ID),
>>> diff --git
>>> a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>> b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>> index 9d81320164ce..3bbe2388ec54 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>> @@ -71,6 +71,7 @@
>>>  #define BRCM_PCIE_4356_DEVICE_ID    0x43ec
>>>  #define BRCM_PCIE_43567_DEVICE_ID    0x43d3
>>>  #define BRCM_PCIE_43570_DEVICE_ID    0x43d9
>>> +#define BRCM_PCIE_43570_RAW_DEVICE_ID    0xaa31
>>
>> It is just a name, but what does RAW mean here? Also 0xaa31 is 43569 
>> in decimal. Is this really a valid device ID or is this an 
>> unprogrammed device (without valid devid in OTP).
> It's a unprogrammed device, basically 0xaa31 is the id with blank OTP.

So do we expect linux end-users to come across such a device. As far as 
I know a device with unprogrammed OTP will use the chip id as the PCI 
devid. If this is needed to enable development with unprogrammed devices 
I would suggest to have these under Kconfig option.

Regards,
Arend

--00000000000000002105d199d296
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCP1el8BVx83ux8u1KW
TOYSqYpboKnBsTRQlDP2spW61DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMTExMjUwOTQ0MjZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANkrTYqllu2X19AzqULBwFAyK1U4LxovGSBzK
g36DwBtzgx2VGkb5AaA+GlmhflO22lk3o8I7bJW7486/H/13IRZI12HpYNyvCOJsJhI0/yk/lk8t
pS+5rtPuci2K0gHHqvmeJv5lIlC+Z0+rKLXs6m4eC8BmLvpzdN4t/xVGQqT0w26UhZdvHpJqFReY
BpiORpbdyCZ92kh6Xql6iB58VzejyZ5zXKIZe7o0yPAc1MBrnzXBbtwza2mLo6Xp31DFnjaoIQxu
QdZPfnXmCi/CgkiWWYPWkpeVDi4+bGIUnL8qVQflPACCEYcwToivyxf7PCbm66mY183MZb1w62HC
5A==
--00000000000000002105d199d296--
