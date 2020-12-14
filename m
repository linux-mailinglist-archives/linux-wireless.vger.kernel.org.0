Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A352D952D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 10:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgLNJ0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 04:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgLNJ0X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 04:26:23 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDBBC0613CF
        for <linux-wireless@vger.kernel.org>; Mon, 14 Dec 2020 01:25:43 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id h186so1231203pfe.0
        for <linux-wireless@vger.kernel.org>; Mon, 14 Dec 2020 01:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=5BoICWqtqzryLKiIFTNa4FGHNhwe9Zg4E1st2vLjeUM=;
        b=MIqG/a8D3hexSJ0dbzRKohWhP0DQdaT+4rm2xITGALp+cXZx0/Oazjv7dOknjQcgGz
         Lgk3FCa8tss2+neppiPBqt3MPP2ZL0KK7UROYvO19wJtOcCsdaZNCS9i0//++Ep/kZbO
         0DMGVQNCe0uTfGe/dS79pSwiZ9ch4YOffXl6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=5BoICWqtqzryLKiIFTNa4FGHNhwe9Zg4E1st2vLjeUM=;
        b=JftzZsMnWt873Ox9uEwsu+K0xtXF06NsSDEtxq+B8g18oQ3PCOMCnaxTAJscbbrGyQ
         mCT5lyUIK9L41iaosdLw1LRluSV+ZhSMcBEgE4uoYqRzyx0clVpQKX2Y0C/+R2PMdA7f
         2ktCtI7bIpZ8fKJ028n2KE5+dueGXNBR1H+nxf1KNJeVuawuBMGayS0dPDbp7nzlJQCu
         iFNIDNA+nH4ldntgVYKt1hpPcQRvmD+CS9TK975wq0DSsYzPGfuuptRs9A8s2ZhlJWYc
         OUAmRFdia5XLKoapF/ENsdi7Vim3LDQqjYumzzJusbalxh+8xQKMZQdqJBN+wxvoHylk
         moag==
X-Gm-Message-State: AOAM533ONVSTQZtL/j4RkPlN3LWVycpEdBqrcqWYAHhADIkvUbZCqqLn
        N63Ud8S+gqmFPL0hu5fYVqzKWoMbAODRRQHfyfaizzqhuZjTo7vWmBIyOshTENfFhZmNWwIA/Et
        MGFDbxsaJMm5JXn4cOBs8FEwcD6s3lEhh50j4iVqAnunJhw/qJhExlZfVJBiUZniCndsLM+Rf02
        wqpQ2q+js5lrgAbzjf
X-Google-Smtp-Source: ABdhPJwLplIOzDDBUZHD3/bhJ2eXtSuTYw7EkUG1hl3IsVu/weajxyty4gP4d7ULq6P88lP5yhge+w==
X-Received: by 2002:a63:f352:: with SMTP id t18mr23541724pgj.57.1607937942267;
        Mon, 14 Dec 2020 01:25:42 -0800 (PST)
Received: from [10.230.33.3] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id 92sm18859755pjv.15.2020.12.14.01.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 01:25:41 -0800 (PST)
Subject: Re: [RFC] Introduce NL80211_IFTYPE_MLO_LINK_DEVICE for MLO link (IEEE
 802.11be)
To:     Johannes Berg <johannes@sipsolutions.net>,
        Sunil Dutt <usdutt@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <1607526302-8063-1-git-send-email-usdutt@codeaurora.org>
 <9320c4f30cd3ba67ababf8e245963b656e2bf1ad.camel@sipsolutions.net>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <73cb65ef-8635-5aad-d22d-3764e919f55d@broadcom.com>
Date:   Mon, 14 Dec 2020 10:25:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9320c4f30cd3ba67ababf8e245963b656e2bf1ad.camel@sipsolutions.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e5e64405b6693947"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000e5e64405b6693947
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US

On 09-12-2020 16:36, Johannes Berg wrote:
> Hi,
> 
>> Multi-link support is introduced in 802.11be specification.
> [...]
> 
> I'll definitely have to take a closer look at this and the spec and
> think about it - but a couple of quick comments below.

Did not get my hands on the spec yet, but just firing random thoughts. 
This multi-link support sounds a bit like bonding. Could that be 
leveraged for wireless? I wonder why there is a need for a non-netdev 
interface. Does networking layer need to be aware of the multi-link for 
scheduling traffic to it? Is there one driver per multi-link or per radio?

[...]

>>   	struct sk_buff *msg;
>>   	void *hdr;
>> +	struct nlattr *nested, *nested_mlo_links;
>> +	struct cfg80211_mlo_link_device_params *mlo_link;
>> +	int i = 0;
>>   
>>   	msg = nlmsg_new(100 + cr->req_ie_len + cr->resp_ie_len +
>>   			cr->fils.kek_len + cr->fils.pmk_len +
>> -			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
>> +			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0) +
>> +			(cr->n_mlo_links ? cr->n_mlo_links * 32 : 0), gfp);
> 
> 32 probably should be some NLA_SIZE or something constant?

Probably sizeof(*mlo_link) ?

> There's also no point in the ternary operator since 0 * 32 is 0 :)
> 
>>   /* Consumes bss object one way or another */
>> @@ -833,7 +849,9 @@ void cfg80211_connect_done(struct net_device *dev,
>>   	ev = kzalloc(sizeof(*ev) + (params->bssid ? ETH_ALEN : 0) +
>>   		     params->req_ie_len + params->resp_ie_len +
>>   		     params->fils.kek_len + params->fils.pmk_len +
>> -		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
>> +		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0) +
>> +		     (params->n_mlo_links ? params->n_mlo_links *
>> +		      sizeof(struct cfg80211_mlo_link_device_params) : 0), gfp);
> 
> same here, no need for the ternary
> 
> 
> It feels strangely asymmetric to have stop and no start ... but I guess
> that's the part where I need to think about it and look a bit at how it
> all works :)

Had the same feeling in my gutt (wherever that is ;-)

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

--000000000000e5e64405b6693947
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
IMeK0BriycKWS9uzqgyYQplGFrQW7dra0NmI8pyjHzMmMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIwMTIxNDA5MjU0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQADvr94iQzfPdsH1ljR
hN1hIr9yLfUouWSRGdc+0Vl4sp0Qi8vtrM+76LFq84sWRKe0E64dbBaiB9VqAwBQU9kpoGLye/Tw
FDOkHUls9KWs5S1cnwb5MVCFdz7ZdbNncpIEZGjRj5mbgnMzqAWrKGeIjf3cZP5CvCTqtA4CoeMY
10WDjb/g6lH4egVuw/fZSG0ew+cxs/ebUSc2BzhXde9qj2ZE4xy0n4jBo8ykkHwzgAUomlqX58f/
ZsSPnj5ZJE2+wqxcQ1GwrcrcK/5blzDH7q5ZgcDMvUidgo4bZyVJDQm3fP51Gh3FjjQ4rLr82PuO
W1iX6XTgr1y79OpzQruh
--000000000000e5e64405b6693947--
