Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC07E9895
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 10:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjKMJLY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 04:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMJLX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 04:11:23 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C49D10D1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 01:11:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9d267605ceeso622735666b.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 01:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699866678; x=1700471478; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1W4uE/XVzgEoCccSE2mjCxi0tTITGdhzgbqpdJeXWUA=;
        b=OjfQdNTyKxmH50rvoDK5+RodYS7sVFQ5RwPu+aFRwnadKVT4GNAUSrAOJCMPPIz7bd
         bLgiAyTGqZMR0+684aZrIqfJPAifPtqh/tkbJqE2Bgo+bL75X1/3agjPBTj8d7KCUiso
         f0WmdTys5/d8hNxb66dgYLI8UQLBCI5ngo0O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699866678; x=1700471478;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1W4uE/XVzgEoCccSE2mjCxi0tTITGdhzgbqpdJeXWUA=;
        b=HmgY6wAdcz5XGwfEeg8nrQWpfWQPlPQa5Xu/ZA5JjGwpJoDmfN1oIAnKoBt96o1h+T
         I89vV6Q2txJDj1/gIOmjJE1Y4LIFnK84kD/ggG/DEpR6D+9++90yTe9rJPSKlArK0eDY
         ehmsN7eg9L8wzEjaH7oPCx7SWugrhHJigQTjz2HSHrE1QsXj0mtgOvCsc2QCfxgMhvC+
         k69PPGJjEITEitwHClh3/pQqILK6+h2tThYbSxc1Uz3QbbbRzBfn6dZjlBjCd1RMGlnN
         GcWloohi5IJpHnRZDhRf/GhNwcaMfWAi8yNbr8WA3Ko7FTFGCEeEjrqIqJoj3bZTd1ST
         EXDQ==
X-Gm-Message-State: AOJu0Yyf9FC9vjf3hLZNIzZP2xdyU76jYH+xj87oxmyjWB4NeWmb7Wg6
        n+nqnPiEzXa0FppsFucs/AufcA==
X-Google-Smtp-Source: AGHT+IGJshc8psBCRqqAoQSYAtIjzqHW3hMxtNKQoVtAlqlqCZWY90UoiqOh12ZNQQDg/yzAq25sNw==
X-Received: by 2002:a17:906:1395:b0:9c7:59d1:b2ce with SMTP id f21-20020a170906139500b009c759d1b2cemr3605109ejc.5.1699866677960;
        Mon, 13 Nov 2023 01:11:17 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709064e9500b009df5d874ca7sm3705777eju.23.2023.11.13.01.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:11:16 -0800 (PST)
Message-ID: <d8f7dc94-40f5-4544-9693-01d7cbc6fefb@broadcom.com>
Date:   Mon, 13 Nov 2023 10:11:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To:     Stefan Wahren <wahrenst@gmx.net>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Hector Martin <marcan@marcan.st>,
        Kalle Valo <kvalo@kernel.org>
References: <d9c9336a-6314-4de9-aead-8b865bb30f05@gmx.net>
 <18bbf6acf10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <cb07408d-af14-4b01-bd96-15c480989643@gmx.net>
 <5c462fac-b27d-41c0-a62c-a8951bf445d2@gmx.net>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <5c462fac-b27d-41c0-a62c-a8951bf445d2@gmx.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008710bd060a050d9f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000008710bd060a050d9f
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2023 9:30 PM, Stefan Wahren wrote:
> Am 11.11.23 um 19:29 schrieb Stefan Wahren:
>>
>> Am 11.11.23 um 18:25 schrieb Arend Van Spriel:
>>> On November 11, 2023 5:48:46 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>>>
>>>
>>> Again look like these are disabled channels. At least chanspec 0xd022
>>> is 5G channel 34. You say you get this only once so not every 60
>>> seconds?
>> I get this everytime i trigger a reconnect to the wifi network, so not
>> periodically (checked that). Strangely the initial automatic connect
>> doesn't trigger this errors.
> I additionally placed a WARN_ON_ONCE after the error log and enabled the
> firmware error log of brcmf_fil_cmd_data(). Maybe this helps.

It does a bit. At least it shows this is happening with the dump_survey 
(again). I don't really understand why though. It implies the channel is 
not disabled, but unclear why. The channel flags are changed in 
brcmf_construct_chaninfo() so we probably should focus debug on that 
function.

Regards,
Arend

> Here is the output after the first reconnect:
> 
> [   98.820098] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
> [   98.820135] ------------[ cut here ]------------
> [   98.820145] WARNING: CPU: 3 PID: 469 at
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:8073
> brcmf_cfg80211_dump_survey+0x330/0x348 [brcmfmac]
> [   98.820256] Modules linked in: aes_arm aes_generic cmac brcmfmac_wcc
> vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core sha256_generic
> ac97_bus libsha256 snd_pcm_dmaengine sha256_arm snd_pcm cfg80211
> hci_uart snd_timer btbcm snd bluetooth soundcore onboard_usb_hub
> drm_dma_helper ecdh_generic ecc libaes raspberrypi_hwmon bcm2835_thermal
> microchip lan78xx crc32_arm_ce
> [   98.820459] CPU: 3 PID: 469 Comm: wpa_supplicant Not tainted
> 6.6.0-15494-g6bc986ab839c-dirty #136
> [   98.820476] Hardware name: BCM2835
> [   98.820495]  unwind_backtrace from show_stack+0x10/0x14
> [   98.820534]  show_stack from dump_stack_lvl+0x40/0x4c
> [   98.820564]  dump_stack_lvl from __warn+0x7c/0x124
> [   98.820600]  __warn from warn_slowpath_fmt+0x170/0x178
> [   98.820636]  warn_slowpath_fmt from
> brcmf_cfg80211_dump_survey+0x330/0x348 [brcmfmac]
> [   98.820749]  brcmf_cfg80211_dump_survey [brcmfmac] from
> nl80211_dump_survey+0x174/0x2bc [cfg80211]
> [   98.821014]  nl80211_dump_survey [cfg80211] from genl_dumpit+0x38/0x74
> [   98.821185]  genl_dumpit from netlink_dump+0x158/0x334
> [   98.821211]  netlink_dump from __netlink_dump_start+0x1bc/0x27c
> [   98.821234]  __netlink_dump_start from genl_rcv_msg+0x148/0x358
> [   98.821259]  genl_rcv_msg from netlink_rcv_skb+0xb4/0x10c
> [   98.821285]  netlink_rcv_skb from genl_rcv+0x24/0x34
> [   98.821310]  genl_rcv from netlink_unicast+0x1f4/0x2d0
> [   98.821336]  netlink_unicast from netlink_sendmsg+0x1cc/0x454
> [   98.821361]  netlink_sendmsg from ____sys_sendmsg+0xa0/0x26c
> [   98.821393]  ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
> [   98.821428]  ___sys_sendmsg from sys_sendmsg+0x4c/0x88
> [   98.821466]  sys_sendmsg from ret_fast_syscall+0x0/0x54
> [   98.821495] Exception stack(0xf10f9fa8 to 0xf10f9ff0)
> [   98.821512] 9fa0:                   00247210 00247628 00000004
> bed3d8c8 00000000 00000000
> [   98.821530] 9fc0: 00247210 00247628 00247198 00000128 b6f32000
> bed3d994 00000001 00000004
> [   98.821543] 9fe0: 0000006c bed3d880 b6f175bc b6a7a970
> [   98.821554] ---[ end trace 0000000000000000 ]---
> [   98.821566] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail,
> reason -52
> [   98.930254] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
> [   98.930287] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail,
> reason -52
> [   99.040104] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
> [   99.040134] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail,
> reason -52
> [   99.150242] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
> [   99.150279] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
> reason -52
> [  100.910174] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
> [  100.910211] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
> reason -52
> [  115.670205] net_ratelimit: 10 callbacks suppressed
> [  115.670232] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
> [  115.670259] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail,
> reason -52
> [  115.780284] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
> [  115.780313] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail,
> reason -52
> [  115.890261] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
> [  115.890296] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail,
> reason -52
> [  116.000283] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
> [  116.000313] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
> reason -52
> [  117.760217] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
> [  117.760253] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
> reason -52
> 
>>
>> Regards
>>>
>>> Regards,
>>> Arend
>>>
>>>> Best regards
>>>>
>>>> [1] -
>>>> https://lore.kernel.org/linux-wireless/2635fd4f-dfa0-1d87-058b-e455cee96750@i2se.com/
>>>>
>>>> [2] -
>>>> https://lore.kernel.org/linux-wireless/2635fd4f-dfa0-1d87-058b-e455cee96750@i2se.com/
>>>>
>>>
>>>
>>>
>>
> 

--0000000000008710bd060a050d9f
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAdQGhjow5bRmDgRBRE
OhR1IEs2nO1yk3zWLXx8m1TwizAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzExMTMwOTExMThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATqALPtRUc7yO8SQ043AFHNDL3Ahp1a3g1f5l
pYiFXv0wM9GgG2X48MCPyYYnyuKWHshfVKh4OQSPbTcLBOuWNl9y0522Gli9mVHRuMSB9NgFK3Zo
uaot5+lA/gAG6CYiKIpf/pK58WBqMQr8qmpeKBXJucqubPozQRrub9+aX3AwgH4dbR3jRGmd8iha
uQW+rRa9S42DFAs7X01JpM1FamFKm6ULWOoaPo/Bml0FubCrZPEdeoKlSavrSVEfOdAWWYaLEK4W
FkYY+6sbcFA23WSiKrDjLCT0VDvj/el4XZDKV0WV1MJxe3WmtEkyVhwAgppV4PGyrZvVOPRxusVa
0A==
--0000000000008710bd060a050d9f--
