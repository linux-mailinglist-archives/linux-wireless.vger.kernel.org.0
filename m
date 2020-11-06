Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984132A925B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 10:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKFJT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 04:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgKFJTt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 04:19:49 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58489C0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 01:19:49 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f38so490994pgm.2
        for <linux-wireless@vger.kernel.org>; Fri, 06 Nov 2020 01:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=qC9lzQJbcu0rjpzOUURDYUAlWZMG9yWo+Zh+ZOlIggw=;
        b=NJq7frASSqMDStnM4QjF5utRE/mWimch5MajG3d3wUpgcSvHEoA4gop4QSXVa9fUWK
         wLJQuc76GLzJPhMVJJn5GiEaun/vnozoto/yevJUXtP9n5wk8CaseJQIdPz8CcVSf+1u
         XcaVQ4E+b0ekMvPdgYxz877BBKAsD0Hg+0XmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=qC9lzQJbcu0rjpzOUURDYUAlWZMG9yWo+Zh+ZOlIggw=;
        b=hYKJk4rnaJ9K0D+XFbQSVNb0yeBP/l++JuexbVHjEKasN8o/2g+VrjdusvXV5Ow3ui
         IAwp2hl8MwvSysydcTBzj5Qap9wcrqhIMgQimMJCZ3jOu2eGafJZ5lOgI9tmscQLzDIK
         gO0V5m5dia1nQwHIGAEQzfXyOVaTe+72JEICQkevBiup1vN8HBIw+WAgjRzMhIBt0x+t
         Ofr+lQjvJgtElRaMsuAMGdXJaY5PXVbQyFjVNCDmfp3ub1kW618ljU2lFkWln4e8XFGI
         arE/QLzcMLukEfRhXgRbl3lZuTEUIiUf8fK2w82FD2FbqnQgTAZAXYXWShX/ZAyAkj9f
         pZYA==
X-Gm-Message-State: AOAM530r35ciWZwP59k9lM1SScv4QDpxfavkdN1FeWae3QuevOSZa2ag
        U8g/XEplcLQToOSYuWqTCMX3havw0TyAGT4Pm54Gs+I57k3z6ycikB2/gp+UZvtYGQY2UcSR7QX
        JcSF9K/7GWoScWW6/UE4SjkFMY+l8wkOOl6QOEoyQXwbVQ9psPx0QF9RzOWF2bUAlToklBgaKzf
        tB9jvgwZJZeTQYnZDe
X-Google-Smtp-Source: ABdhPJz9mY1DEAIK000EDTyueJwHVAFTsqleqMzEC50grdM9ur8UYu2c5trc31AN/xtuLSiIqdzqmA==
X-Received: by 2002:a17:90a:a107:: with SMTP id s7mr1488383pjp.208.1604654388466;
        Fri, 06 Nov 2020 01:19:48 -0800 (PST)
Received: from [10.230.33.93] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id e7sm1117486pgj.19.2020.11.06.01.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 01:19:47 -0800 (PST)
Subject: Re: [PATCH] iw: add optional argument to parse 6G band channel
To:     Johannes Berg <johannes@sipsolutions.net>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <1602283770-8026-1-git-send-email-pradeepc@codeaurora.org>
 <5c39eaec897af4d7b1005d1f7cb80552c3404e54.camel@sipsolutions.net>
 <e0ba2a4d-3f82-22f6-e928-1ac25eb1448b@broadcom.com>
 <f25189bb18fe0d4e9a70f5468eab74b209b83054.camel@sipsolutions.net>
 <4bbc1e91-ba41-7e05-cb53-baa74232388d@broadcom.com>
 <02802f0fc1b3e4941ce137fcf6a637c32a756a4a.camel@sipsolutions.net>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <a1e8c34d-55f3-a6ae-1829-432e6853c898@broadcom.com>
Date:   Fri, 6 Nov 2020 10:19:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <02802f0fc1b3e4941ce137fcf6a637c32a756a4a.camel@sipsolutions.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d6729f05b36cb61b"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000d6729f05b36cb61b
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 11/6/2020 10:12 AM, Johannes Berg wrote:
> On Fri, 2020-11-06 at 10:12 +0100, Arend Van Spriel wrote:
>> On 11/6/2020 10:06 AM, Johannes Berg wrote:
>>> On Fri, 2020-11-06 at 10:05 +0100, Arend Van Spriel wrote:
>>>> On 11/6/2020 9:55 AM, Johannes Berg wrote:
>>>>> On Fri, 2020-10-09 at 15:49 -0700, Pradeep Kumar Chitrapu wrote:
>>>>>> Channel numbers of 6G band overlaps with those of 2G or 5G bands.
>>>>>> Therefore, an optional argument "6G" is added and expected next
>>>>>> to channel number to map it to correct 6GHz frequency. If not
>>>>>> specified, defaults to matching 2G or 5G frequency.
>>>>>>
>>>>>> example:
>>>>>> iw wlanX set channel 149 6G 80MHz  --> maps to 6695 MHz
>>>>>> iw wlanX set channel 149 80MHz     --> maps to 5745 MHz
>>>>>
>>>>> Hm. I can't really say I like this much.
>>>>>
>>>>> Is it _really_ needed? I mean, we mostly specify the frequency today, so
>>>>> ... why not just always do that for 6 GHz?
>>>>
>>>> I suspect there are people preferring channel numbers as much as there
>>>> are people preferring frequencies. Personally, I think it is acceptable
>>>> to put this limitation on 6G.
>>>
>>> :)
>>>
>>> After I sent the message I figured maybe then we should have different
>>> syntax, where we say prefix the channel number by the band?
>>>
>>>    iw wlanX set channel 6:149 ...
>>>    iw wlanX set channel 5:149 ...
>>>    iw wlanX set channel 2.4:11 ...
>>
>> Do you want to make that band: prefix required or optional.
> 
> That's a good question. Probably should be optional, otherwise
> everything breaks ...

Right.

>> btw. starts
>> to look like the format we use with our wl utility ;-)
> 
> Hah! Maybe you have a better idea there? :)

Not really. The above format seems fine as is.

Gr. AvS

--000000000000d6729f05b36cb61b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQTAYJKoZIhvcNAQcCoIIQPTCCEDkCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2hMIIE6DCCA9CgAwIBAgIOSBtqCRO9gCTKXSLwFPMwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UE
CxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMT
Ckdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAwWhcNMjQwNjE1MDAwMDAwWjBdMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpZok2X9LAHsYqMNVL+Ly6RDkaKar7GD8rVtb9nw6tzPFnvXGeOEA4X5xh9wjx9sScVpGR5wkTg1
fgJIXTlrGESmaqXIdPRd9YQ+Yx9xRIIIPu3Jp/bpbiZBKYDJSbr/2Xago7sb9nnfSyjTSnucUcIP
ZVChn6hKneVGBI2DT9yyyD3PmCEJmEzA8Y96qT83JmVH2GaPSSbCw0C+Zj1s/zqtKUbwE5zh8uuZ
p4vC019QbaIOb8cGlzgvTqGORwK0gwDYpOO6QQdg5d03WvIHwTunnJdoLrfvqUg2vOlpqJmqR+nH
9lHS+bEstsVJtZieU1Pa+3LzfA/4cT7XA/pnwwIDAQABo4IBtTCCAbEwDgYDVR0PAQH/BAQDAgEG
MGoGA1UdJQRjMGEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAwkGCisGAQQBgjcUAgIGCisG
AQQBgjcKAwQGCSsGAQQBgjcVBgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFGlygmIxZ5VEhXeRgMQENkmdewthMB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMGcGA1UdIARgMF4wCwYJKwYBBAGgMgEoMAwGCisG
AQQBoDIBKAowQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNp
Z24uY29tL3JlcG9zaXRvcnkvMA0GCSqGSIb3DQEBCwUAA4IBAQConc0yzHxn4gtQ16VccKNm4iXv
6rS2UzBuhxI3XDPiwihW45O9RZXzWNgVcUzz5IKJFL7+pcxHvesGVII+5r++9eqI9XnEKCILjHr2
DgvjKq5Jmg6bwifybLYbVUoBthnhaFB0WLwSRRhPrt5eGxMw51UmNICi/hSKBKsHhGFSEaJQALZy
4HL0EWduE6ILYAjX6BSXRDtHFeUPddb46f5Hf5rzITGLsn9BIpoOVrgS878O4JnfUWQi29yBfn75
HajifFvPC+uqn+rcVnvrpLgsLOYG/64kWX/FRH8+mhVe+mcSX3xsUpcxK9q9vLTVtroU/yJUmEC4
OcH5dQsbHBqjMIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4G
A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aE
yiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5
uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bL
yCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg
6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkW
qQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+
yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5
RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpYKBov
Hd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX42
68NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o
2HLO02JQZR7rkpeDMdmztcpHWD9fMIIFTjCCBDagAwIBAgIMUd5uz4+i70IloyctMA0GCSqGSIb3
DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMwHhcNMjAwOTA0MDc1
NDIyWhcNMjIwOTA1MDc1NDIyWjCBlTELMAkGA1UEBhMCSU4xEjAQBgNVBAgTCUthcm5hdGFrYTES
MBAGA1UEBxMJQmFuZ2Fsb3JlMRYwFAYDVQQKEw1Ccm9hZGNvbSBJbmMuMRkwFwYDVQQDExBBcmVu
ZCBWYW4gU3ByaWVsMSswKQYJKoZIhvcNAQkBFhxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqJ64ukMVTPoACllUoR4YapHXMtf3JP4e
MniQLw3G3qPYDcmuupakle+cqBUzxXOu9odSBxw7Ww4qooIVjDOuA1VxtYzieKLPmZ0sgvy1RhVR
obr58d7/2azKP6wecAiglkT6jZ0by1TbLhuXNFByGxm7iF1Hh/sF3nWKCHMxBtEFrmaKhM1MwCDS
j5+GBWrrZ/SNgVS+XqjaQyRg/h3WB95FxduXpYq5p0kWPJZhV4QeyMGSIRzqPwLbKdqIlRhkGxds
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
IL5ZHP59tcf0TtjSMHS+wWmPtmxMxYaFCy1GpYm/pQKLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIwMTEwNjA5MTk0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB5uRakRxxQd/KMbjmF
T5Bwp+U+aVU6cJAiKzzyAYo7mBqjYkSJKVEiDGw87cwv0VqcP1Mbdo2F+/ltIovV89+BuHGw1abe
jVxMgawsujCu+CQTwOZPztk2vl7G7pJu32zHvzKUNq+UjUvdhZRR0AX7tAxJXEwl9MC9sIVwz43K
a7Pn0rgxC829+35MIPPj8dX97PW2+HsmYmof1fNjN6cWGn94KgbgAdoZpyaTwxMLgRukzaRhpzkz
cJis+doC2skfd3Vq+tP5ojPbLOPrNImqTSUJDAP5raIvbTW0jj7/g9wMRDXTFslQ3bXYsUax99I5
1fRQBrXjlTTzs3zxLPDv
--000000000000d6729f05b36cb61b--
