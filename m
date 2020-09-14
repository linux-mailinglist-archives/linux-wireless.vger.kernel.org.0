Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA2268768
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 10:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgINImH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Sep 2020 04:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgINImG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Sep 2020 04:42:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E10C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 14 Sep 2020 01:42:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so4984046pjr.3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Sep 2020 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=SaAFwZvZgNUtU1KGkhtp5aV75CQaABWgmBzc1H1F2jE=;
        b=fO10We3y7+W3VdkrRCgpWRh+228tk7UPcrM4EHGSodpW+zX46iGE6c9d058C9EGODK
         hIE89xRXvDUkSpu9qr+VSgZAX4Q1tTPjFgzoyX7rb+AuwMr2MGbh/5B8eaMZZp27++yJ
         WHh/6juW3M8ELY4E7qty/FfQilQJqq1J6cfwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=SaAFwZvZgNUtU1KGkhtp5aV75CQaABWgmBzc1H1F2jE=;
        b=fmFmJspXikW4zAhTyEFLfIwDg/P1Wv2bUAZJiHwGicPEGDnxDNwDgsrs1XsmuMP9n1
         Va15z9YGDaInMzoFOIxJSoOZP6/sTp/Bm4PyICSpcTnyHeBbof4g8uWHsCn9wgkTLSRX
         bYa27b4eDLBZgN5lKA1nw8/jQ04Mx4Arf/Zb55N5wlzkMst8keNdStyCfGsMTiuTUTL9
         zrn880WUIG8NlEL9Lgpa/UvNx04iZjwHihXycPd7zLOVC6txKOtNzzATFf65HxIL6MKd
         PeSbd39vqk2cJxABz9U1bVe6s762jT/VODvQDrwnkUkL6iF+AXVt3oWZ5mNeTOk4Yzrs
         K7mg==
X-Gm-Message-State: AOAM533DWChbBclsZDBgZGqxnTS00XEUxLrYx6F/Lm31pKqPYX/I7a4C
        31iR1+SN0+cnYVa/tLh6DsUNVg==
X-Google-Smtp-Source: ABdhPJzfMa1bvVQNqbvmtFHMJVtuwBNdg+QPuOVe1Gna7VIvdC/gjn2BVwn6BdgZGSC3qJRRYtiSUQ==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr8569369pjb.78.1600072925924;
        Mon, 14 Sep 2020 01:42:05 -0700 (PDT)
Received: from [10.230.32.194] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id x19sm7808641pge.22.2020.09.14.01.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 01:42:05 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] brcmfmac: set net carrier on via test tool for AP
 mode
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com, Kurt Lee <kurt.lee@cypress.com>
References: <20200914031634.190721-1-wright.feng@cypress.com>
 <20200914031634.190721-3-wright.feng@cypress.com>
 <87v9ggojkx.fsf@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <0813cce5-1833-cad2-ddba-ccdeed8872ab@broadcom.com>
Date:   Mon, 14 Sep 2020 10:42:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <87v9ggojkx.fsf@codeaurora.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000637e2f05af4202da"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000637e2f05af4202da
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 9/14/2020 10:20 AM, Kalle Valo wrote:
> Wright Feng <wright.feng@cypress.com> writes:
> 
>> From: Kurt Lee <kurt.lee@cypress.com>
>>
>> In manufacturing line, test tool may be used to enable SoftAP. Such
>> SoftAP can't pass traffic because netif carrier is off by default. To
>> allow such use case, let brcmfmac parse ioctl cmd, and then set iftype
>> to ap mode and report netif_carrier_on to upper layer.
> 
> nl80211 does not use ioctl(), so the commit log is misleading.
> 
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
>> @@ -64,6 +64,15 @@ static int brcmf_cfg80211_vndr_cmds_dcmd_handler(struct wiphy *wiphy,
>>   		*(char *)(dcmd_buf + len)  = '\0';
>>   	}
>>   
>> +	if (cmdhdr->cmd == BRCMF_C_SET_AP) {
>> +		if (*(int *)(dcmd_buf) == 1) {
>> +			ifp->vif->wdev.iftype = NL80211_IFTYPE_AP;
>> +			brcmf_net_setcarrier(ifp, true);
>> +		} else {
>> +			ifp->vif->wdev.iftype = NL80211_IFTYPE_STATION;
>> +		}
>> +	}
> 
> We now have rules for the vendor API:
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api
> 
> As the BRCMF_VNDR_CMDS_DCMD just seems to be a simple pipe between the
> user space and the firmware I'm leaning towards that we should just
> remove support for that command from brcmfmac.
> 
> And besides, for factory tests you should be using NL80211_CMD_TESTMODE.
> The vendor API is meant for normal mode usage.

We talked about this API before. This command used to be a TESTMODE 
command, but with the introduction of vendor commands in cfg80211 I 
changed that. My reasons being that 1) it helps me in cfg80211 callback 
development, and 2) (some of) our customers were not accepting the need 
for a separate driver (build) for manufacturing. My intent has always 
been to keep this opaque for the driver so I am opposed to patches like 
this that are interpreting the opaque blob. The firmware could simply 
generate a CARRIER event and the driver can act on that.

Regards,
Arend

--000000000000637e2f05af4202da
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
IBMxWmiDnzmlLjyU1hmsHOsx/MV7TSIO4U+v4/wZY16BMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDkxNDA4NDIwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB2YJDJoAelhw48E9Ms
wkm8/MDuqfeNoiJEH5XSI9Tm0pcCEXM3zZcJZxheYhMv3rOThXOlnB/CpM98sWVb6w7/ay0wD8ZX
zjfeiD9LIHikzHjjU+CJKRVIusp++0Qj5zQzu7sapgY+5JuGKlf2ihkWD4l0LJ2hS81w9X/6yJ0A
Ld9VivgEJ92PepOABskkyWzIGrJpPChfAs4n4Nldo1DmXQuFrPTTqu9LXcFoYDnxjTSAbVoWbod/
xUZ0FghPaEAoaG/rNLXrhS+B6rEgDgTEvFUgT2JnyfYSOGc1iEKSHXMH6PcXy9hDul8J/hFBvs4g
1m4HaxzvcO+p+HrFSGXt
--000000000000637e2f05af4202da--
