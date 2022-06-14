Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5254AC2D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jun 2022 10:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355051AbiFNImU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jun 2022 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354685AbiFNImC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jun 2022 04:42:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB142A28
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jun 2022 01:41:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s37so5304884pfg.11
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jun 2022 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:from:to:cc
         :references:in-reply-to;
        bh=5Jgj71gIRzjnrp1+nr7jAxW63t+bahifEcfs5nKzlXw=;
        b=D9rHpoBn02R5pkI1Z4WR+ft8XQMBFKCrW/P/WIBsBSwajPdILt7aps8ZBfVDON3Rln
         Io1+I/eINhA785ntOtbSkh2WOUw5bOU8czTa2ZKuvB3IdC8gYmhJqlMduAFIFYg46gp1
         bMe3uzv2WqTp3MRYRE9G3qccXyLO7xLYlVPKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :from:to:cc:references:in-reply-to;
        bh=5Jgj71gIRzjnrp1+nr7jAxW63t+bahifEcfs5nKzlXw=;
        b=GyJFgtha9JtAK5+GSPj6PACWy6ROlE0OKCHPGu+VcmcnZHDAxWFW6xYCFfKrEUF8Zc
         azSCLwhwBkkaVhA321Rl0zjM3YUEmEVfNSytwkVJRIsNLU6vcw3CVVOqEg7nAtbq7Psd
         oME9myDZWDp9g/G3dloVrVCoPNQgBxhSbd0N20Fyk65Eq6AKqNr+habJ87YJVBg8vbM+
         +fDptjV4luY1dTBrieJjqD4fxrullJb8SPc0JDmSHqTV7b/S5aj6CO6vahn8QX71m4Jq
         4SgUa9vCTDfwLvq8+BlD72K63J7qoflqiNxklO/1sM5BTkwBliho3XdAtD930rg4DOl+
         eGVg==
X-Gm-Message-State: AJIora/3wS6uIV7tHBxkeqS2l0acI/1pFU47m7pVHshznbcLfNEd2IOt
        SbNKHenam7ML1bHyZd0TLbio0vIFevDREEoSO8Gcjg==
X-Google-Smtp-Source: ABdhPJzZCEEtvV0Zl2nDMkKirJQFVqavaQ/IltadqubkLlMESPeMNz2iaRf62yJFNcM6YmEKjnp0hQ==
X-Received: by 2002:a62:8e11:0:b0:51c:445b:5ae6 with SMTP id k17-20020a628e11000000b0051c445b5ae6mr3683248pfe.48.1655196107980;
        Tue, 14 Jun 2022 01:41:47 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id a10-20020a62d40a000000b0051b416c065esm6901619pfh.8.2022.06.14.01.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 01:41:46 -0700 (PDT)
Message-ID: <2d921af3-9d21-7d86-e6da-bfcd904513e9@broadcom.com>
Date:   Tue, 14 Jun 2022 10:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: brcmfmac
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Hranislav Milenkovic <hmilenkovic@protonmail.com>
References: <ummn1_Vf6iygnVWDDcx07aAvrz2wPRnpMWB6A205JWSOMEYGVkGv0_uWYymiZTO7bManVdxSskozUDe_TcYAn6loKaOAptYNT2pl-Tu6q-g=@protonmail.com>
 <dac01b50-c559-c40a-871a-4da514e7c3a3@broadcom.com>
In-Reply-To: <dac01b50-c559-c40a-871a-4da514e7c3a3@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000012566b05e164608d"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000012566b05e164608d
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/13/2022 11:19 AM, Arend van Spriel wrote:
> On 6/12/2022 5:49 PM, Hranislav Milenkovic wrote:
>> Hi Arend,
>> I fouded your e-mail here 
>> https://wireless.wiki.kernel.org/en/users/drivers/brcm80211 
>> <https://wireless.wiki.kernel.org/en/users/drivers/brcm80211>
>> I have netgear R8000 with brcm 43602 wifi chip. I am using ddwrt with 
>> experimental build. There are 2 versions of build, normal with dhd and 
>> experimental with brvmfmac driver 
>> https://dd-wrt.com/support/other-downloads/?path=betas%2F2022%2F06-10-2022-r49139%2Fnetgear-r8000%2F 
>> <https://dd-wrt.com/support/other-downloads/?path=betas%2F2022%2F06-10-2022-r49139%2Fnetgear-r8000%2F> 
>>
>> Router crashes sometimes and I emailed ddwrt devs with crashlog... but 
>> they told me
>>
>> "there is nothing to fix. its a firmware error. broadcom does not 
>> provide support for these firmwares . I cannot fix the firmware error 
>> for that chipset. its a binary. we can only seek for a newer firmware 
>> binary somewhere in the wild..."
> 
> Looked at the log and ddwrt devs are mistaken. In the log it shows:
> 
>   Jun 12 13:26:00 109.198.5.214 logger : calling done start_checkhostapd
>   Jun 12 13:26:07 109.198.5.214 kernel [ 4743.815344] ieee80211 phy2: 
> brcmf_fil_cmd_data: Firmware error:  (-23) cmd 262
>   Jun 12 13:27:04 109.198.5.214 kernel [ 4800.660849] Unable to handle 
> kernel NULL pointer dereference at virtual address 00000058
> 
> So there is a command failing in firmware with error -23, but this is 
> harmless. The NULL pointer dereference is a driver crash. Can you build 
> the kernel with CONFIG_DEBUG_INFO and provide me with the brcmfmac 
> kernel module, ie. brcmfmac.ko?

Hi Sebastian,

I heared from Hranislav that you have a modified version of brcmfmac so 
it would not help me to get a .ko with debug info from you. So decided 
to ask you directly. I doubt you modified much in flowring.c. Not sure 
about fweh.c, but these are the two source files I am interested in. 
Also I am not scared to look at the ARM assembly so anything you can 
throw at me would work.

Regards,
Arend

--00000000000012566b05e164608d
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCBtBEr21nCF1ReTHH8
DrGFN4WZqCsjco9sZLaWz6IX/TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjA2MTQwODQxNDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAV9RMsaDEYe7NOsO0JsWf8LtvhYG3mDKZ80s6
0oJ+kL2mZMtMfBJXnFhSi55+krc9K0gZUnF7tSOfiEbO5VooLXwB18zFWxBxdOLyLXvA3y249T6F
baEC6BGJ7yoh6nKq75DxkPpQ6hKF+9WESWqviWa78mEHjsT09F6QdZSr3bYpopwHRQQ6MGif7oFY
FgT8n3zVCfZ3XcRtehTQBNxK8vWtv6yJczvw8NCOp0m6RJ5s5PZr7vnFWghvvggWvl7uds0YJDdE
PAQZhM90sdmsnhabuLq+9QvJtmadcIG0BKYJeKGfWA6cI++ZWObtK1XVoLl6nQYd9PuBwooa5Pyp
CQ==
--00000000000012566b05e164608d--
