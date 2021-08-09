Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE273E4113
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 09:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhHIHuF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 03:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbhHIHuC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 03:50:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F05AC0613CF
        for <linux-wireless@vger.kernel.org>; Mon,  9 Aug 2021 00:49:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id go31so27381594ejc.6
        for <linux-wireless@vger.kernel.org>; Mon, 09 Aug 2021 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=It/Lnuu272+nF4W+Ep4xg1QXYSFim5ZjrrqER9h8h/s=;
        b=Cuk1V3lkcqyLbJ8SraPIcwsLohA5ypb1u0CX54TVlLeE80YM3d2AiDcMlnlVYOVHeF
         EMX0yp4+RayV0cEZhfCsSEk1A2emuja4QSXLg1nBs+uYkBlb/45GqzVjG2XolNIQXoKo
         Ck9c2hjawtBYWv7Y6Dea7riQiY+Cc3i6eCI6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=It/Lnuu272+nF4W+Ep4xg1QXYSFim5ZjrrqER9h8h/s=;
        b=uc5WheORSpjXrfMc3dsnwrIO0BLmg6EN72NUE5o4lwYaKJDXnMtKIz1g/nqODsbg0t
         aT1QkhLpGose8U5cNUSvoSrt6O9FQXVqEQMo/eJfUMGbpewdpTbjMtnDkDSAXGSfnTed
         GSvLVF5QpzUyYdgi0TxEsgfmT3GY/ysMV65oJ5q6bZlrvd+f9mCtj/eH4jzPW46cF/t1
         YOEHOupzx5OMhvWMOV97rHQYtEGu822YFsiN6+LbbuWcRLu9ihQfKNxFgbtBIQ2v5/ic
         19VnGXdbuaGBuOEZ9u3jZA8nU1Qvo2AyLh/LzHmT4dTFMbY64pXMVaYdy7qJP6kFHFZV
         RFOw==
X-Gm-Message-State: AOAM531D3KoIoYiY5kcwSmebkjo3yypNRdJfUrgO78SsT976skR5s5hd
        Xc+znrP30daxyWOPHZm8i7q+sbqgGyPDKLWKOuvzM/Lo1GnJKMpi+EBOL8nDa2MOTQt4Hi6I63p
        8EfR6Ja8kjEIkBpil6g==
X-Google-Smtp-Source: ABdhPJwFPVa1G/bGb8qVNYPpkciVXa5d6v+MwkNG+OmG/Ni1PNKKMVbQmOsSaCL8if2GbJ+C4etxrA==
X-Received: by 2002:a17:906:3157:: with SMTP id e23mr135678eje.29.1628495381058;
        Mon, 09 Aug 2021 00:49:41 -0700 (PDT)
Received: from [192.168.178.136] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id e22sm7716640edu.35.2021.08.09.00.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 00:49:40 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] iwlwifi: mei: add the driver to allow cooperation
 with CSME
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Beker, Ayala" <ayala.beker@intel.com>
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
 <87bl7vi3o1.fsf@codeaurora.org>
 <CANUX_P3QE9xNnQLT=mHNDp4VCv37Bcjuvn9O1wQ4Btejjkbrvg@mail.gmail.com>
 <87k0l0c8pa.fsf@codeaurora.org>
 <SA0PR11MB4752B06F7330E6C14717E113F2F49@SA0PR11MB4752.namprd11.prod.outlook.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <7f027e15-71a7-8843-7b60-91b57f88a553@broadcom.com>
Date:   Mon, 9 Aug 2021 09:49:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <SA0PR11MB4752B06F7330E6C14717E113F2F49@SA0PR11MB4752.namprd11.prod.outlook.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b9b8b705c91ba0cf"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000b9b8b705c91ba0cf
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US



On 8/7/2021 8:38 PM, Grumbach, Emmanuel wrote:
>>
>>>>> +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_OPEN !=
>>>>> +                  (u32)SAP_WIFI_AUTH_TYPE_OPEN);
>>>>> +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA !=
>>>>> +                  (u32)SAP_WIFI_AUTH_TYPE_RSNA);
>>>>> +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA_PSK !=
>>>>> +                  (u32)SAP_WIFI_AUTH_TYPE_RSNA_PSK);
>>>>> +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_SAE !=
>>>>> +                  (u32)SAP_WIFI_AUTH_TYPE_SAE);
>>>>> +
>>>>> +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_NONE !=
>>>>> +                  (u32)SAP_WIFI_CIPHER_ALG_NONE);
>>>>> +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_CCMP !=
>>>>> +                  (u32)SAP_WIFI_CIPHER_ALG_CCMP);
>>>>> +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP !=
>>>>> +                  (u32)SAP_WIFI_CIPHER_ALG_GCMP);
>>>>> +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP_256 !=
>>>>> +                  (u32)SAP_WIFI_CIPHER_ALG_GCMP_256);
>>>>
>>>> These look just weird, and suspicious. You are using two different
>>>> enums but they have to be same values, or what?
>>>
>>> Exactly. I don't want the userspace to have to include all the SAP
>>> protocol header file. OTOH, I don't want to have to translate between
>>> vendor commands attributes values and the SAP values.
>>
>> Why not? I assume you would just need a helper function with switch
>> statements to "translate" between enums, not much more lines of code but
>> a lot cleaner code.
>>
> 
> I disagree that it'll give us a cleaner code.
> What we'll have is two different enums with two different values and functions
> that translate from one value to another. This is very bug prone. When you want
> to debug, you get a value, you always need to think of what type of enum you're
> dealing with.
> I believe your suggestion is not good, but since I am tired arguing I will do it to
> make you happy.

I don't want to flare up this fire further, but have you considered to 
declare the enum values needed by user-space in uapi header and simply 
declare the SAP enum using those values:

#include <uapi/iwlmei.h>

enum sap_cipher {
	SAP_WIFI_CIPHER_ALG_NONE = IWL_MEI_CIPHER_NONE,
	SAP_WIFI_CIPHER_ALG_CCMP = IWL_MEI_CIPHER_CCMP,
		:
};

Seems like assurance enough that user-space api is cleanly separated and 
using the same values.

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

--000000000000b9b8b705c91ba0cf
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBnBl4Qa0CXqsyUBUUt
7buc4O4177kzGl2hxBRXDHHaEzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMTA4MDkwNzQ5NDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEADebZO+YQQ2TLqOkRQFCFPXsJn6DxeOMtG1T0
TM63MpKFn0Ok3TQ8bvz0frN30T48WRzkccNbbnL7EkqSvmP+e1CgbFuE7VBAxczemhdMoJjUeO3l
PLvplm7FZZs6vWtPpHmJj//pkFw7A4YK2doT4GSTeihrDsGnwX1V7DKCPYERER23NPsDM5Avi9/n
tfHQQXr8UGerBTNTnScqnjERwhEx3TWAg5t+cgs2bHjL4L5IBxPaxJptcZC5Ci8mORjZctHFYaoX
d5H6FwEovm0PdyVJT2AzxySOD0rKaYthSov0XbUEvL3dYcLvGzZIPyzz0qtxNlbL1U+B6DZucwMB
ig==
--000000000000b9b8b705c91ba0cf--
