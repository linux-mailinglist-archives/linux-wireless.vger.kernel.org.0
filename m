Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1F2959C2
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 10:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509157AbgJVIAx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Oct 2020 04:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509155AbgJVIAx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Oct 2020 04:00:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF5C0613CE
        for <linux-wireless@vger.kernel.org>; Thu, 22 Oct 2020 01:00:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 144so650685pfb.4
        for <linux-wireless@vger.kernel.org>; Thu, 22 Oct 2020 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=4X89VY3urH0ICAGz72YqM/ZPFpjFGB/nPQuUBb6gaXU=;
        b=VW5EdwS9VGdKNyiT660WLlvulzAhBPGj5ZZyv2KqLw9eKIHquFm+m1vNWGPzrdJz8t
         K/tn7btfOWUYvV2wzdwdaKxlp1niVPnRvX6NYU1Jqf22oIdouW63B8VqD/amOlj3HUjr
         wrTvhew2OIhzMY9ticBkrb/9rIpIageiUxSeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=4X89VY3urH0ICAGz72YqM/ZPFpjFGB/nPQuUBb6gaXU=;
        b=Ey2TOow/uRpDp3DIf2nPJc/Ho1pa2ZVs7ZzyZnhS+dmUP7QzuvXFw76PyIlrgruBcI
         nCrkNsUue4GOH2M4+gzjnxaifM14wU9234492C8iCHHlQHUYWd3uAEgEgZIw1hPg3PeZ
         62JC4CWqbK7ZmEqB7OHPswf0NSQNH9/clJcz+GMlCoszsaJPkrWnlEak2lttvzCqmmV4
         MdLKeKnj646FD6boV3pNsnkhREF7OV4JNl6nxPC33841ivpPEpiHlHwG0dcA343LuI5/
         35v/AkvkxqhCpMCAZL3m7kHNfo8Ijt1UP4MWmA9EiJmZvFjrolLqTc8znMUnbcTw/C+w
         Gtjg==
X-Gm-Message-State: AOAM532wIkmyJlTjogBF3QmWb6ZGv0eCIVnF8oWPswDGi/MFWKbjJ0IF
        q1uFLSy7bHvBKaXgdjR/iFIZncLkBdK60Ych
X-Google-Smtp-Source: ABdhPJzrBdvWhhFmh5zpyzY2la4AwfI3vO+G+VqLW2OmeW+JVj/uBUHP9ABD/WGBfXEs/thm/VSsfA==
X-Received: by 2002:a63:1a09:: with SMTP id a9mr1315860pga.188.1603353652716;
        Thu, 22 Oct 2020 01:00:52 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id w6sm1243919pfj.137.2020.10.22.01.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 01:00:52 -0700 (PDT)
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap power
 save
To:     Kalle Valo <kvalo@codeaurora.org>, vnaralas@codeaurora.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
 <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
 <871rilf2th.fsf@codeaurora.org>
 <dbaa655c3f15f800f73b7c19f2b1a054@codeaurora.org>
 <87eelr1oq9.fsf@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <f6c148a3-73de-1481-5f63-2deecb599468@broadcom.com>
Date:   Thu, 22 Oct 2020 10:00:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <87eelr1oq9.fsf@codeaurora.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f2ab3b05b23ddc4e"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000f2ab3b05b23ddc4e
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/21/2020 7:19 PM, Kalle Valo wrote:
> vnaralas@codeaurora.org writes:
> 
>> On 2020-09-29 13:10, Kalle Valo wrote:
>>> Johannes Berg <johannes@sipsolutions.net> writes:
>>>
>>>> On Mon, 2020-08-24 at 13:56 +0530, Venkateswara Naralasetty wrote:
>>>>> AP power save feature is to save power in AP mode, where AP goes
>>>>> to power save mode when no stations associate to it and comes out
>>>>> of power save when any station associate to AP.
>>>>
>>>> Why do you think this requires a vendor command? I mean, that seems
>>>> like
>>>> fairly reasonable - even by default - behaviour?
>>>
>>> I have not studied the details, but doesn't AP power save break normal
>>> functionality? For example, I would guess probe requests from clients
>>> would be lost. So there's a major drawback when enabling this, right?
>>
>> This AP power save feature will not break any functionality, Since one
>> chain is always active and all other chains will be disabled when this
>> feature is enabled. AP can still be able to beacon and receive probe
>> request from the clients. The only drawback is reduced network range
>> when this feature is enabled. Hence, we don't want to enable it by
>> default.
> 
> Yeah, we really would not want to enable that by default. But what
> should be the path forward, a vendor command or a proper nl80211
> command? Any opinions?

I would go for a proper nl80211 command or just add an attribute for use 
in NL80211_CMD_START_AP or deal with NL80211_CMD_SET_POWERSAVE when 
operating in AP mode.

Regards,
Arend

--000000000000f2ab3b05b23ddc4e
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
IAsQ8/M7id4+Owwuh8gyQAULf2DADQAeuGmR1bILgRT/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIwMTAyMjA4MDA1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBQgOxsGCpLeGr//+ha
7PUKDAdOz/p7ubIfSpD2wtuec7POiQbnW2Jk4g2KLAKQx0rkglcehsnue4ljycCHuMN9wg6pOqp3
Za81lgC4mezY31U655I0cvZeBexJ3JtEh40wGB3Jul9Oe+qxymiFqn6VaMtdtchGuTFuA3DebK03
mr/pr0HvYR8BY6p/sNcc7V4afbZ20QyjptpXRYQMruFTLjJTbMEdipUd8h6d80DQxT801c8k7+yn
vHO7+N5djUNnSe82hjoNMWoDH5nltAL50hjUDuLYqU1TK5VTgoNTB8+Gbo7cUTcD9W5bvVfNW8fG
swDR30vbrhon7XIoNLRI
--000000000000f2ab3b05b23ddc4e--
