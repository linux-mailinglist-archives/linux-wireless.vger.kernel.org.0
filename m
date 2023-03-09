Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB96B1F75
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 10:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjCIJJl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 04:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjCIJJ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 04:09:26 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5D66D0A
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 01:09:24 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id ff4so992358qvb.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Mar 2023 01:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1678352964;
        h=in-reply-to:subject:from:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xjlDazLUt6RinoppgGzPRq8rSqXwDqV9kqK/D7UTmtU=;
        b=bQkaGzOVFztevFzZwnVNsJi3BomFO9JnJkedhH0jO5u8BcqAA7hqGJmnk4PRhJeZRW
         KC+rPNpyRzdVsN2tTfWqhufSbuEwTpb0huN2M89XLz6g3mWXoiK/nn9p/m+kRRce1J2t
         RS3Zus3HxqPWwEVgVEpIkb8zr4lRQkMgZ9utM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352964;
        h=in-reply-to:subject:from:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjlDazLUt6RinoppgGzPRq8rSqXwDqV9kqK/D7UTmtU=;
        b=a0ao6chVEnMlLoV97BfCbERKoOxcGZTKKbK3vOUVCBkWkDSp+i2Vs05rfP64RrWDbu
         Zg1k6a6jPevxWsO5U6b6IL+c8j3YRcGU6Zr9gTNoZ7q9OGfm0Mpt7vd3S2WgGvjcUMJp
         z8culNNGxuXxrhFp9g2Umw+ByIHLXwFJME26QiERwUZQP81OoJDPMTE9jyDhGYHw9Byd
         JW6dPTrBtn5DMl9SrQwsbWr3ltmzdRrYrmOPjfb1vve5r1W53Hy0Fn8JkOPnwBtsHpiY
         EDA3czMiyK9oCKrhNxwdWeXDFRMkEoV0k08SR99cOXgWlqdn6Zr4USuj4E4fMe7XscNL
         xm8A==
X-Gm-Message-State: AO0yUKUDSLW8S8Pi5X/izHGcbioFRCZcYj9HhlYKwLn+vYrpX78U9Byh
        HhJxm28mYkWJAfRlCizOspEckmVtl6VxbSeNT8L3pA2eZS8=
X-Google-Smtp-Source: AK7set/NCdsNOu2K/gV8R39oJcBn+AH6XefhOQSXdUUg7ftYHPDTrP6XVj/VhXN+VmGuWnhwpAAzGw==
X-Received: by 2002:a05:6214:d85:b0:574:d6d:a326 with SMTP id e5-20020a0562140d8500b005740d6da326mr37194655qve.15.1678352964018;
        Thu, 09 Mar 2023 01:09:24 -0800 (PST)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id m67-20020a375846000000b00741e27ecb37sm13000833qkb.74.2023.03.09.01.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:09:23 -0800 (PST)
Message-ID: <d8c6c493-5b5e-6a13-6bb9-f8af78e2a3f6@broadcom.com>
Date:   Thu, 9 Mar 2023 10:09:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
To:     Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        linux-wireless@vger.kernel.org
Cc:     dokyungs@yonsei.ac.kr, linuxlovemin@yonsei.ac.kr
References: <20230309014449.2460386-1-jisoo.jang@yonsei.ac.kr>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] wifi: brcmfmac: slab-out-of-bounds read in
 brcmf_get_assoc_ies()
In-Reply-To: <20230309014449.2460386-1-jisoo.jang@yonsei.ac.kr>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003f226305f67400dc"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000003f226305f67400dc
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/2023 2:44 AM, Jisoo Jang wrote:
> Fix a slab-out-of-bounds read that occurs in kmemdup() called from
> brcmf_get_assoc_ies().
> The bug could occur when assoc_info->req_len, data from a URB provided
> by a USB device, is bigger than the size of buffer which is defined as
> WL_EXTRA_BUF_MAX.
> 
> Add the size check for req_len/resp_len of assoc_info.
> 
> Found by a modified version of syzkaller.
> 
> [   46.592467][    T7] ==================================================================
> [   46.594687][    T7] BUG: KASAN: slab-out-of-bounds in kmemdup+0x3e/0x50
> [   46.596572][    T7] Read of size 3014656 at addr ffff888019442000 by task kworker/0:1/7

[...]

> [   46.673620][    T7] Memory state around the buggy address:
> [   46.674213][    T7]  ffff888019442700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   46.675083][    T7]  ffff888019442780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   46.675994][    T7] >ffff888019442800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   46.676875][    T7]                    ^
> [   46.677323][    T7]  ffff888019442880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   46.678190][    T7]  ffff888019442900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   46.679052][    T7] ==================================================================
> [   46.679945][    T7] Disabling lock debugging due to kernel taint
> [   46.680725][    T7] Kernel panic - not syncing:

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index a9690ec4c850..13e590b41b01 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -6165,6 +6165,10 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
>   	req_len = le32_to_cpu(assoc_info->req_len);
>   	resp_len = le32_to_cpu(assoc_info->resp_len);

better do validation of both values here and bail out:

	if ((req_len > WL_EXTRA_BUF_MAX) || (resp_len > WL_EXTRA_BUF_MAX)) {
		bphy_err(drvr, "invalid lengths in assoc info: req %u resp %u\n", 
req_len, resp_len);
		return -EINVAL;
	}

>   	if (req_len) {
> +		if (req_len > WL_EXTRA_BUF_MAX) {
> +			bphy_err(drvr, "assoc req_len %d-byte is larger than buffer\n", req_len);
> +			return -EINVAL;
> +		}
>   		err = brcmf_fil_iovar_data_get(ifp, "assoc_req_ies",
>   					       cfg->extra_buf,
>   					       WL_ASSOC_INFO_MAX);

--0000000000003f226305f67400dc
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDYm/bZDn05e4dpoLio
FaCR1sMD5c25dznkOUVH9v6EvDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzAzMDkwOTA5MjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEACqexPzYwKB9L7ZLfrC+q7OOVOXhZb3dkunDa
orezjsT0bI6DRGJkL3ZITxla7XpYaiPHFQf1goFNq3++7GJs/UMx8/G1POiY0aX6yZby6pa8jT4f
1YZDH/mYwufSSEOrw4l7pBCTZ2hEmfKPb4BqfUM5i6I84viNSqSS495byqju5zEAIhyEw8W30G70
5ZI2xZ2chqriEJEwYTqJIsoJc4JISe1E8ozN1ZrmvW1Dn8cIUzgsMFDoSC2qX8sZLyiYKEHM8YLe
piMlu3sF/OhWt3LLJXVj3pMydZo6K8kr0nKcNvfwSBDbyYK648U1rAJhUjQ6szNtoMzvVzmfesgR
jw==
--0000000000003f226305f67400dc--
