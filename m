Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134535A1E2D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 03:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbiHZBaK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 21:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbiHZBaG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 21:30:06 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8B1EC75
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 18:30:03 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id p187so320176oia.9
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 18:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bcdonadio.com; s=google;
        h=organization:subject:from:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc;
        bh=yMHBcPcy7CgRvAdigu9VQJfxiESlERkodRZgdRs56PQ=;
        b=TwafeCLJ5Mps6e2KZRDWOsi63tZwOw3P9qUaxkZAmjF/64E35Hi96ZZJyDIOuBnruU
         f3tBRpDtsCtxhvl2V31yjSOtZZTCUDeSHjfAQ6WfDWByk+eOjRpbxXD5e4LlWpNhOuJ6
         ll6Gj5T3kOx7DskcgySVHNCWKXabi68YDH6VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=organization:subject:from:cc:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc;
        bh=yMHBcPcy7CgRvAdigu9VQJfxiESlERkodRZgdRs56PQ=;
        b=AD3pvSC5Fs3jfb78fNKYKOPW9CHLLKFnkpdRiqrR+ZfSji62CuIeq6JykNZ3Zr0PnS
         QY1m2fUeWW2TJ2Y+WzrN2honfjnHPOKfiifINoQ6mPAu17TMt0Hwh/YRBIt6lSiQREUx
         7bJ3sTbmf0lKOJH76VKPdXIf5NSc/p0e3ZYMUu7b1aks/iItON8Bj77WvXozoo0xg78N
         VvvaBLm/jxpAFAabf/ASnPj5JwK5wJjWvBRnYq2kOPOJV1ul3t15RgCQtEug/FuxRxcv
         W5NbCMZMJJDE707jPoSAkdI0crz0Ltcl4xUwzKdwEXqlne85wo8v0MJwWPKcWYFoV767
         yKkQ==
X-Gm-Message-State: ACgBeo2Jwt6lPx2qe1OS4+Rp+jXfXYNpJ6tvNnGsfzUvy9NwZdSHMVIq
        CHTWjRnSlA3w42S4fMlI7XxEOZ5gFhZpDg==
X-Google-Smtp-Source: AA6agR5mVODUSloWUQqb/cGSSD+IjzAPMNweQ5lztwYd+/3i0eueCgLcQruRwxqSRZFVC2GsN/S4VA==
X-Received: by 2002:a05:6808:1242:b0:345:7e6b:961b with SMTP id o2-20020a056808124200b003457e6b961bmr642399oiv.290.1661477402596;
        Thu, 25 Aug 2022 18:30:02 -0700 (PDT)
Received: from [192.168.128.166] ([177.156.134.128])
        by smtp.gmail.com with ESMTPSA id f23-20020a4ad817000000b004359da266b4sm455877oov.14.2022.08.25.18.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 18:30:01 -0700 (PDT)
Message-ID: <b68e876e-1555-4a37-762f-3b38d383722d@bcdonadio.com>
Date:   Thu, 25 Aug 2022 22:29:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Seth Forshe <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
From:   Bernardo Donadio <bcdonadio@bcdonadio.com>
Subject: wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Organization: bcdonadio.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050807090506080407010507"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050807090506080407010507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

I would like to request the following inclusion to the BR entry in the 
regdb, since Anatel (Brazil's telecomunication regulatory body) has 
officially licensed the WiFi 6E band in February 26, 2021.

It was defined as the 5.925 to 7.125MHz spectrum range, strictly for 
indoor use, limited to 30dBm EIRP for AP stations and 24dBm for clients. 
Requirement for NO-IR was explicitly waived, and no requirement for 
AUTO-BW or DFS was made. No specific channel width was defined besides 
the spectral power density limitation of 5dBm/MHz, so 160MHz channels 
are allowed if my math is right (I would appreciate if someone could 
double-check it).

The original publication regulating bands for local private use can be 
found here: http://www.ncc.org.br/img/Ato%2014448.pdf

The amendment that allowed the 6E band can be found here: 
https://www.in.gov.br/web/dou/-/ato-n-1.306-de-26-de-fevereiro-de-2021-306493325 
in section 11.7.

Allowing outdoor use is being debated, but it hasn't been licensed yet 
since 5G operators want to use the same slice of spectrum. There could 
be further changes in the next year.

Thank you.

-- 
Bernardo Donadio
Site Reliability Engineer
https://bcdonadio.com


--------------ms050807090506080407010507
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
C70wggWlMIIEjaADAgECAhBqPzL42AO8SuNm9ZzurnikMA0GCSqGSIb3DQEBCwUAMIGWMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDYxNTAwMDAw
MFoXDTIzMDYxNTIzNTk1OVowgbExCzAJBgNVBAYTAkJSMRowGAYDVQQIExFSaW8gR3JhbmRl
IGRvIFN1bDEWMBQGA1UEChMNYmNkb25hZGlvLmNvbTErMCkGA1UECxMiUGVyc29uYWwgQXV0
aGVudGljYXRpb24gRW50ZXJwcmlzZTEZMBcGA1UEAxMQQmVybmFyZG8gRG9uYWRpbzEmMCQG
CSqGSIb3DQEJARYXYmNkb25hZGlvQGJjZG9uYWRpby5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDWXXoj4n9CnFRKOWg84Y707goEkr9z9QXr2IPD8bixEqivDO1ElSCd
17SoDJAvQsho+JU3enjqIIANM/9z44Is2qDFJkdOPpx/AuvdwlsHqhqscWjM0IHPDRjpD+Nd
RlteFLVO7H+QC+4Z6ggzFC4GRwfemFkwigb2/aqk/J85YS8KvSPxJz5lmuiT8PFxFKI/UUDk
gq49qQSi0B6h8rXoS3z30mvJJbhb+8egiO7JD2jg7hj/SC+mE8won9dRjctyTlltEH37rHk/
6ijDJV2kPOafk/GFiUa/ftOA4P9FGPGRri2aeRKBYlAmJ6mSmf3TOKBK+cYRmX8T8xJNZMr1
AgMBAAGjggHQMIIBzDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4E
FgQU24T33l8emVivwrV+t+JBhaa60WMwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAw
HQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQEC
AQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEw
T6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRp
Y2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcw
AoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGln
by5jb20wIgYDVR0RBBswGYEXYmNkb25hZGlvQGJjZG9uYWRpby5jb20wDQYJKoZIhvcNAQEL
BQADggEBAL+T0Do7Z7CeS8jz6enkrehc9Pmra10Rbl7XPrLjEyetyicys0Si6VK5TgLh5JPQ
JpEHM7x3IPS36k7w4RMsnvJ7pVBMOCUOlNweDai4hjKwLRNdA2Drdcenkqggkan+qfJeHMXv
4wSWW8wL6Wsn3NmpyStwD/f2xCB9EuSVd8HHUolAcfZdvhpARY9HI4BeiK0fu7UbSogEPxvv
khSwzJKiiaScEkM8bUICCC9iDTfHdLMI+HjV7MOa1t1r8niy2O6pjOiVfvE21G8J5TVN7DHI
RE0E79FY73UXoDMtCz3RrfyzgxhRdrbhDM202K2zEmT/lvkY+d6bWXjmt3kkVHswggYQMIID
+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJV
UzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZp
Y2F0aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQ
gT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8
HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabP
i2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hG
Aez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+Q
U5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYD
VR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8E
CDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYG
BFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJU
cnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/Bggr
BgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0
Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3
DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswh
h2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQ
Xyn7kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI
+jheXUV1eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ576
0CdO2VnpsXP4KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsb
ZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6
rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pL
kAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95
QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8mybM2JzGCBDIwggQuAgEBMIGrMIGW
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNB
IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhBqPzL42AO8SuNm
9ZzurnikMA0GCWCGSAFlAwQCAQUAoIICVzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMjA4MjYwMTI5NThaMC8GCSqGSIb3DQEJBDEiBCA/Ye9+zelUr2L0
Q7NMWmadV++c1rqUm+lRelX5+7ZPkjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIG8BgkrBgEEAYI3EAQxga4wgaswgZYxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQx
GDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEGo/MvjYA7xK42b1nO6ueKQw
gb4GCyqGSIb3DQEJEAILMYGuoIGrMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBAhBqPzL42AO8SuNm9ZzurnikMA0GCSqGSIb3DQEBAQUABIIBAE+tQIeJ
MzJd2QCm4bEUwmEKHDYXk4SjjfJ3ZYZigIBYPu/SJw2pY3+o6gSx5vCK3Q1seozqag3s55iH
o/tSs30HYjYMTMQ3wPghhVYAF9qeDXgkfRzRXwO+Zi7sqeS5UUOgo3xuiyJYTnw2qwnD+EHl
P/BRhKslQKSM15VG+rpoM6TzcAUgP7Csi7YIeB6JbH9pPFcgeV5fssAKHSMq4W6ucgYF5EJ1
PA0EuOJD7WDghwy6Y2MfN8d1bdPqCM5iSdPeurYkgEUrred9VlGFmDKkCu85PctHorP4xJ5j
KTHeGHm0EzV4LTmQiWNqnvjPlbIssioEzucLk77/6WOXnQAAAAAAAAA=
--------------ms050807090506080407010507--
