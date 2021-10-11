Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD644289D8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 11:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhJKJmq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhJKJmp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 05:42:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5BC061570
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 02:40:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so497302pjb.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Ia5oIcen9D5aAnT0p4Yzmvq7uZcCpq4VgFmHeG+bHUI=;
        b=KtcgVgLMjCr6eqX2oUqlaiUFECH1jTwNyRGVnXmzIDF4MMojrJIhrhkv3RXPST+0Uy
         B++KXA19lH10ukCrAS6iQ90NyFw9H3ZR6FNfaBXi9f03KvZjFzsI8KKqY0O5p3djmWTx
         CDOqj+J5azufJF3kzMcIXTrw2QT6+4560rLB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Ia5oIcen9D5aAnT0p4Yzmvq7uZcCpq4VgFmHeG+bHUI=;
        b=tmRxFD4reNSby7RgzOLaiT2zoXqdIylmXy/JgXiIlVikvh8xZOc5PMNSluJ6hOmd1I
         wMz9X43BEnNur8oXYdlPda4OTdw2grRm/3V160tVZIB+m9/w+7pbwNA3Z4Zbw1H7YrPz
         VAwukMFpEPKE+UIX4yLMHan9Vj/3AoYG78cy62X3fi++GEJoh/iL3bkwSunks38AkAyB
         tDkxnGbftUPe9WgJw2NQ9XFP8jOi5kciRTADcyEYqq/owbYIKB6lsAGCIeqEDmDytmE3
         2vMWotNPQyVt6q9xtCXbPMwb2k2HXfLNl4rl9ZDlk+SxJLNo1SpZIgmjJeiukKhp+FfO
         qtMA==
X-Gm-Message-State: AOAM531VFjSedWOtA2Uf/kahP2UM++SCKLmRwY9cl2vktZCSaUe25Nqr
        oiZKqLF/pwBYCp85VT+8A6fKvw0Q5XHtNhql5LDUIJ4Q6b9GcAwDh70ZIbUieJhBmajFtVudTaN
        /s27E7v7VLO33xQzyrg==
X-Google-Smtp-Source: ABdhPJyh/ynktYKx03O5v57h0IWpP5/8iFqat8/ZefXtI47ckPwdTR7Mbuq8MvTYWDpNjpGtD/g54Q==
X-Received: by 2002:a17:902:8b8b:b0:13d:e91c:a1b9 with SMTP id ay11-20020a1709028b8b00b0013de91ca1b9mr23677159plb.60.1633945245262;
        Mon, 11 Oct 2021 02:40:45 -0700 (PDT)
Received: from [10.176.68.97] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id o4sm6544571pfb.48.2021.10.11.02.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 02:40:44 -0700 (PDT)
Subject: Re: wireless: guidelines for user space interfaces
To:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, tony0620emma@gmail.com,
        linux-wireless@vger.kernel.org, steventing@realtek.com,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
References: <20210422030413.9738-1-pkshih@realtek.com>
 <20210422030413.9738-2-pkshih@realtek.com> <YMPqT8VH5alHQXXA@google.com>
 <87mtnf52z9.fsf_-_@codeaurora.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <f670553b-274e-0801-50b4-a8e9d7fcf54e@broadcom.com>
Date:   Mon, 11 Oct 2021 11:40:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87mtnf52z9.fsf_-_@codeaurora.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f43be705ce108592"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000f43be705ce108592
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US

On 10/11/2021 11:23 AM, Kalle Valo wrote:
> (changing subject, was "Re: [PATCH v2 2/2] rtw88: add debugfs to force lowest basic rate")
> 
> Brian Norris <briannorris@chromium.org> writes:
> 
>> BTW, if we have clear guidelines on debugfs, module parameters, etc.,
>> maybe those should be going on the wiki? I know this came up before:
>>
>> https://lore.kernel.org/linux-wireless/87d09u7tyr.fsf@codeaurora.org/
>>
>> At this point, I'm willing to write such guidelines, if I get an ack
>> from the relevant folks (I guess that's just Kalle?). It probably
>> belongs somewhere in this tree:
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation
>>
>> similar to this:
>> https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api
>> except it's not really an nl80211 thing. Suggestions welcome.
> 
> I think this is a very good idea. Having general guidelines for wireless
> drivers using user space interfaces would help both people submitting
> patches and also people like me reviewing the patches.
> 
> We should try to get an ack for the guidelines at least from Johannes,
> but I would prefer also involve Jakub and Dave (CCed) as they might have
> some input from the network subsystem point of view.
> 
> Just to get this started, here's a draft list I came up of different
> user space interfaces upstream wireless drivers are using:
> 
> * generic nl80211 (excluding testmode and vendor commands)
> 
> * nl80211 testmode commands
> 
> * nl80211 vendor commands
> 
> * sysfs[1]
> 
> * debugfs
> 
> * relayfs
> 
> * configfs[1]
> 
> * module parameters
> 
> * thermal subsystem
> 
> * firmware_request()
> 
> I'm not saying that we need to document all these in the first version,
> I'm just trying to come up a comprehensive overview how wireless drivers
> interact with the user space. And I'm sure I missed something. so please
> do fill in.

Not sure if all of the above can be considered user-space interfaces, 
but wireless driver developers could benefit from guidelines for them 
regardless. Maybe following needs to be considered as well although I 
think cfg80211 is taking care of it:

* rfkill

Regards,
Arend

>> Side note: it could really use some cleanup -- like this page:
>> https://wireless.wiki.kernel.org/en/developers/process
> 
> Heh, that is old information. TBH in practise I maintain only the
> submittingpatches page (link in the signature), other pages I rarely
> touch. And naturally I also look after ath10k and ath11k pages.
> 
> Any volunteers to clean that up?
> 
> [1] Actually I don't know if there are any valid use cases for sysfs and
>      configfs at the moment, but I'll include them in the list for
>      completeness.
> 

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

--000000000000f43be705ce108592
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDLw9dxwR1vf9tX8xQw
BPfE9VknqVm3g96iCB+AxFMkRDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMTEwMTEwOTQwNDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAgGOW6kwnN8Tl2M7gSFmaWW1PM51HR4F4a5gj
yL3BnIyUStohC5O1OIU6/WJXi7v1ssyPkOqBTwQWYPa/g7vPUTGdrGWNhmM5Dr71h5F6MN42omQJ
kvLlmSZ9AGu+3Ymy+/rJA0mYVoujTgWE4b7GntE/SLH/WBzcVscfFtl2GQFNUUQ5Uv4TFBWBIcX7
H2WZ/ljEPvxzq7bPaEIGMbdlvdfJpILODCA1Mp9jvWSRH11VZuWr0RaNu3cvnRq2YVpGgO7W/tXr
SQrL4DocULKXuLjNbiiBbk4/jJfl2Qg2EL2lddc5QKp+ZbFMRJbWSmFgmv7j1n7cUcjAw/uQq87V
4A==
--000000000000f43be705ce108592--
