Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B539C65BD86
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 10:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbjACJ5W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 04:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjACJ5U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 04:57:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC97E0D9
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 01:57:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso35390420pjp.4
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jan 2023 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hNTxUks51lIdT/PVztQAxnsCQxL7KeTf7DUe055d7Ik=;
        b=A85Ep9uraWC5Pq9ALRHglkfKRF165Kap5jb5Wf0RF63wUmvtxXSMadYBcmq27psX5Y
         S2eTcIrHoFjGYBZmKcSky9US7ISYnXr5XPcKwd5T6nfk1dGDZlCY6JVtrGfope1AI0HP
         L2vPl/pi/evXEDLXJvjJzVTorwp3YeSl6kEck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNTxUks51lIdT/PVztQAxnsCQxL7KeTf7DUe055d7Ik=;
        b=SF24Rt2E00NTp9VS+iVGYhUrkP8aJBU1SqoLA2h5gKx/QdA5kA2seUg+eiw7NJVzPM
         fDAh+ZNMsZfnvCI56XspZwUdk+qKi5QU7eIJY0hY2AkWAsMIWgalMIQAAzs7bs/8/4G1
         3ZE2FaCeEeLbKDeCBbJmnbBCp5Wodhk0IgmGfQHheTq9ftRZbPISFVRG3bFGtgLMPZAe
         KdhQ95fgdJ6x2is86p1+/JKwzqsrNJ6JdvLD9Jr+U3mtDa0wBYDmPbX9hjh68rJqTndT
         lzTM57SHePQZVdRMvD9hSw41QRK+ExlTf+Hb012Kz8pIiwFWTNDlJ8GXoIjD2MrE2dQK
         zmMQ==
X-Gm-Message-State: AFqh2kqM+uq9WK+NX25OH3+MG0LLBVcD3QNrAZW/SVAi7bmjGiJDCwbL
        PiZh/dNo8a4D8OMDPz6bv0HjSw==
X-Google-Smtp-Source: AMrXdXsk3CCFDl6q2qjm9Kznf3aEu/wqCBF+UMmauIRxhmiovWz2DAsfCU+HdpHRl0QE6XdXjS+7Bw==
X-Received: by 2002:a05:6a20:e686:b0:ac:b2a3:e39c with SMTP id mz6-20020a056a20e68600b000acb2a3e39cmr50557623pzb.62.1672739839461;
        Tue, 03 Jan 2023 01:57:19 -0800 (PST)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id f193-20020a6238ca000000b0058269b74da9sm4121703pfa.95.2023.01.03.01.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:57:18 -0800 (PST)
Message-ID: <094e993a-a709-07b8-0c1a-4ccea11e7072@broadcom.com>
Date:   Tue, 3 Jan 2023 10:57:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: brcmfmac: Unexpected cfg80211_set_channel: set chanspec ... fail,
 reason -52
To:     Johannes Berg <johannes@sipsolutions.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <2635fd4f-dfa0-1d87-058b-e455cee96750@i2se.com>
 <1f428e2b-f73f-64ff-02d3-eefbcd11db89@broadcom.com>
 <ee24c4eda8d389ac7197b6296944e168ccc6b602.camel@sipsolutions.net>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <ee24c4eda8d389ac7197b6296944e168ccc6b602.camel@sipsolutions.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f3da6705f159173c"
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000f3da6705f159173c
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/3/2023 8:07 AM, Johannes Berg wrote:
> Hi,
> 
> 
>>> [  104.897615] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail,
>>> reason -52
> 
> [...]
> 
>>
>>> All of these 10 errors are repeated every 60 sec.
>>
>> Catching up after the holidays ;-) Above chanspec values are invalid.
>> 0x100e = channel 14/bw 20MHz. The 'iw list' output shows all these
>> channels are disabled. So who/what is trying to set these channels.
>> Scanning sets the channel in firmware. Is this initiated from hostapd?
> 
> Yeah, what userspace is running here? Looks like cfg80211_set_channel()
> is only used for survey?
> 
> Couple of observations on the side:
>   * might be nice to have some "brcm" indication in that name :P
>   * dump_survey should just dump data, not actually implement the data
>     collection, I think?

commit 6c04deae1438e5df59fc4848795248fc34961f51
Author: Wright Feng <wright.feng@cypress.com>
Commit: Kalle Valo <kvalo@kernel.org>

     brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection

     To enable ACS feature in Hostap daemon, dump_survey cfg80211 ops 
and dump
     obss survey command in firmware side are needed. This patch is for 
adding
     dump_survey feature and adding DUMP_OBSS feature flag to check if
     firmware supports dump_obss iovar.

     Signed-off-by: Wright Feng <wright.feng@cypress.com>
     Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
     Signed-off-by: Ian Lin <ian.lin@infineon.com>
     Signed-off-by: Kalle Valo <kvalo@kernel.org>
     Link: 
https://lore.kernel.org/r/20220929012527.4152-2-ian.lin@infineon.com

I did comment on one of the patches in the series, but I now I looked at 
the diff and it is giving me the infamous eyeball cancer paraphrasing 
John Linville.

>> Maybe trying ACS?
>>
> 
> Seems it must be something like that.
> 
>> As these are marked as disabled user-space should not
>> use them. What I don't understand is why these pass the cfg80211 layer
>> so adding Johannes here.
>>
> 
> Well that goes back to my earlier observation above: dump_survey()
> should just dump all *available* data, not actually try to *collect*
> data. So if userspace requests data for a channel that's disabled,
> that's actually OK, but you shouldn't _have_ any data for that channel
> since it's disabled. Also nl80211 won't send the data out if it exists,
> but there's no check to see if asking the driver makes sense since if
> it's a channel that exists, it should be valid to ask the driver if it
> has data - it just shouldn't have any.
> 
> The way it works in mac80211 is that survey data is collected during
> scan, I think?

My assumption is that our scan does not collect the survey data so this 
implementation initiates a dedicated scan/measurement/survey/whatever 
and returns the results. Might have been better to propose a scan flag 
so this could be initiated upon a scan request.

Anyway, I see in nl80211.c we are skipping sending up survey data for 
disable channels. So let me send a quick patch for avoiding the error 
messages and renaming the function. Thanks for your thought. Always 
appreciated. Best wishes for 2023.

Gr. AvS

--000000000000f3da6705f159173c
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA1nw4qxIWnX9uI8jUM
GIR1FnTI98GgLI5QdLTSojlY0zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzAxMDMwOTU3MTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJSismOvkO+07bG+uOJvZa+OomkQtNzEz1For
1cbDBGrCSrjQCWbZ1i9sUj6PQ2QCy/ixv1H/J77Kc94u7MYwFYWFVIW026avh2D0aQXgZPdLUbSC
kYB4MVPZH6GHJdxubaT4Ojg/KK89seDOFOYSJ1FcVhKf7nvpqY4XR1eIiyrK5gazlXhzGXRcvcyE
bmCvYP+BYdGID2njdD3OK/ewwq5OJyV/lAuepLwz1t0OujD/fGy1hWW0pz6ZAS5whofnCztGrzps
x5/sUGIVJ6+t6RDt5M8SC0Y0FvB8Bp4jYYWsjYqnfiEAgdVITSuBlymfciftnI4Xi3nVqAzBJIJe
JQ==
--000000000000f3da6705f159173c--
