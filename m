Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC4D6376CC
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 11:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKXKth (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 05:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKXKtf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 05:49:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC9542F71
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 02:49:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id x17so1892849wrn.6
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 02:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6IZHHK1+PunHuaylrLxEpqrNSRt9m4djMXlzrm8laxo=;
        b=GfcyCDjmJ2hqeoutsN6S74h4UoLVy67XGX2M5t0fPTDnGiUNqMdo8+pTiu6odAWRVH
         cYcIWm/Vw5vuQUKTHDtHrD3NsZrUcR9KKcODK6es8gI8FSiDt6FLzDHjsuei9v4tAAgr
         FuBMG5SpvXWockIBVvfE4KoMXB4K8Hig3n2YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IZHHK1+PunHuaylrLxEpqrNSRt9m4djMXlzrm8laxo=;
        b=XDqqgz3pFteA9vtqhYkfmfdy7NAj8eGHF+23krY8kAGT+f1X2f34TWlg67IgVzx1s2
         egb4TX4guX7nLXWKYRibcuqk9R5uj5HfSKOQ44ZWnUvRBbDa+4bhFmE8V3RvjRZEfXmZ
         RLSrdGKeVL3yIEh/jGxG+cVNEaZw6jIpvNoZIttoKFOr5fLQ2V7P7f8SWKHgTchSNbjL
         pP8/EwsrSCbcPRNkzlzDND2leqGF6SE0RarGpmucwYWlbZKUoFj3X0k9zBfx1oSVqjwI
         vI3noz3IiqPTcqUxfl2Tj85rmbYKsfGzh27teLT+l0+xsO2+yymX2b9IWpNrSXrsdQ8j
         Q4xQ==
X-Gm-Message-State: ANoB5pmlPTxicxgenT6PKnpaXskQMhFysWpvWYwOFIkzIGdUgkZwvivS
        MtmLyMW3fdEJrPXzIzTomhqykUMhU5ojMHRtx1g=
X-Google-Smtp-Source: AA0mqf6ubXO4Wn9lNh8zAvaENRtkqW6DEPcx0zJyNSuNgpvE+BfTxgsMK9f50uLo63kZRSNkSSfhYQ==
X-Received: by 2002:a5d:6b45:0:b0:236:7a1c:c41a with SMTP id x5-20020a5d6b45000000b002367a1cc41amr8729161wrw.680.1669286972109;
        Thu, 24 Nov 2022 02:49:32 -0800 (PST)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id m18-20020adffa12000000b00241c6729c2bsm1012032wrr.26.2022.11.24.02.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 02:49:30 -0800 (PST)
Message-ID: <6774d660-eb2e-50be-0024-8faf9b3d4c4e@broadcom.com>
Date:   Thu, 24 Nov 2022 11:49:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
To:     Andy Green <andy@warmcat.com>, Shengyu Qu <wiagn233@outlook.com>
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
 <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com>
 <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com>
 <1848793db88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3a562a50-0cef-4879-3691-3258596f5213@warmcat.com>
 <1cbb3bf5-fd70-e9db-2405-640178862857@broadcom.com>
 <bea00730-5411-a3c4-0ead-bb73889c25f6@warmcat.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <bea00730-5411-a3c4-0ead-bb73889c25f6@warmcat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000004c53e05ee3529df"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000004c53e05ee3529df
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/2022 11:20 AM, Andy Green wrote:
> 
> 
> On 11/24/22 09:42, Arend van Spriel wrote:
>> On 11/18/2022 6:41 AM, Andy Green wrote:
>>>
>>>
>>> On 11/17/22 21:52, Arend Van Spriel wrote:
>>>
>>>> I see. So could you load bcmdhd and provide log. Preferably with 
>>>> higher debug level. It also has a module parameter for it. I think 
>>>> it is called dhd_msg_level and please set it to 0x817.
>>>
>>> It's here:
>>>
>>> https://warmcat.com/ap6275p-dhd-log1.txt
>>
>> Hi Andy,
>>
>> Thanks for the log. Together with the dhd driver sources I could make 
>> some sense of it. Perhaps you can try the following hack and see if we 
>> make it over the first hurdle.
> 
> Thanks, I tried it, but although it looks necessary, there's evidently 
> something else since the result was the same.
> 
>> +
>> +    entropy_info.signture = cpu_to_le32(BRCMF_SEED_SIGNATURE);
> 
> This should be ... .signature = ...

That's what you get if you get too confident... :-(

> The debug logs
> 
> [    3.487772] brcmfmac: brcmfmac_module_init No platform data available.
> [    3.487858] brcmfmac 0002:21:00.0: enabling device (0000 -> 0002)
> [    3.487896] brcmfmac: brcmf_chip_recognition found AXI chip: BCM43752/2
> [    3.488799] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:65 base 
> 0x18000000 wrap 0x18100000
> [    3.488801] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:82 base 
> 0x18001000 wrap 0x18101000
> [    3.488803] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:16 base 
> 0x18002000 wrap 0x18102000
> [    3.488804] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:65 base 
> 0x18003000 wrap 0x18103000
> [    3.488805] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:26 base 
> 0x18004000 wrap 0x18104000
> [    3.488807] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x844:2 base 
> 0x18005000 wrap 0x18105000
> [    3.488808] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x840:15 base 
> 0x18010000 wrap 0x00000000
> [    3.488810] brcmfmac: brcmf_chip_cores_check  [8 ] core 0x827:35 base 
> 0x18012000 wrap 0x00000000
> [    3.488811] brcmfmac: brcmf_chip_cores_check  [9 ] core 0x240:0 base 
> 0x00000000 wrap 0x1810a000
> [    3.488813] brcmfmac: brcmf_chip_cores_check  [10] core 0x135:0 base 
> 0x00000000 wrap 0x18112000
> [    3.488814] brcmfmac: brcmf_chip_cores_check  [11] core 0x135:0 base 
> 0x00000000 wrap 0x18113000
> [    3.488815] brcmfmac: brcmf_chip_set_passive Enter
> [    3.594733] brcmfmac: brcmf_chip_set_passive Enter
> [    3.595214] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
> [    3.595215] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
> size=1310720 (0x140000) sr=0 (0x0)
> [    3.595238] brcmfmac: brcmf_chip_setup ccrev=65, pmurev=35, 
> pmucaps=0x84565f23
> [    3.595241] brcmfmac: brcmf_get_module_param Enter, bus=2, 
> chip=43752, rev=2
> [    3.595246] brcmfmac: brcmf_alloc Enter
> [    3.595254] brcmfmac: brcmf_fw_alloc_request: using 
> brcm/fw_bcm43752a2_pcie for chip BCM43752/2
> [    3.595257] brcmfmac: brcmf_fw_get_firmwares enter: dev=0002:21:00.0
> [    3.595259] brcmfmac: brcm_alt_fw_path FW alt path: 
> brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.bin
> [    3.595555] brcmfmac 0002:21:00.0: Direct firmware load for 
> brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.bin failed with error -2
> [    3.600006] brcmfmac: brcmf_fw_complete_request firmware 
> brcm/fw_bcm43752a2_pcie.bin found
> [    3.600010] brcmfmac: brcm_alt_fw_path FW alt path: 
> brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.txt
> [    3.600323] brcmfmac: brcmf_fw_complete_request firmware 
> brcm/fw_bcm43752a2_pcie.txt found
> [    3.600324] brcmfmac: brcmf_fw_request_nvram_done enter: 
> dev=0002:21:00.0
> [    3.600378] brcmfmac: brcmf_fw_request_nvram_done nvram 
> 00000000eea1e0fd len 6040
> [    3.600381] brcmfmac: brcm_alt_fw_path FW alt path: 
> brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.clm_blob
> [    3.600641] brcmfmac: brcmf_fw_complete_request firmware 
> brcm/fw_bcm43752a2_pcie.clm_blob found
> [    3.600836] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
> [    3.600837] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
> size=1310720 (0x140000) sr=0 (0x0)
> [    3.694272] brcmfmac: Download NVRAM brcm/fw_bcm43752a2_pcie.txt
> [    3.694895] brcmfmac: brcmf_pcie_write_entropy_bytes: written 6040 
> entropy bytes
> [    3.694910] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 
> 0xfa1a05e5
> [    3.694911] brcmfmac: brcmf_chip_set_active Enter
> [    9.774716] brcmfmac 0002:21:00.0: brcmf_pcie_download_fw_nvram: FW 
> failed to initialize: 0xfa1a05e5
> [    9.774733] brcmfmac: brcmf_detach Enter
> [    9.798714] brcmfmac: brcmf_bus_change_state 0 -> 0
> [    9.798716] brcmfmac: brcmf_proto_detach Enter
> 
> I added a log showing it sending the entropy bytes.

Ok. Something is off there. Maybe I tried to be to smart. How does that 
log statement look which you added?

Regards,
Arend

--00000000000004c53e05ee3529df
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBjxqA5iRiTzCfwL3Dq
Wa10AyVUd+BxE5BFTWUqdLtMsTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjExMjQxMDQ5MzJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAiW7niscKNIyqT4dyMPFSkvF+wbu/OMAGF3qN
d1EfhQv05MDvefvMhBiShC1H0893c4JLzB98kZvde97O6QDBjukt5T5MZ8gymxbSJC5QUmFZdIhp
GT5q6pSbMxPNGubchK4swP+rUAnMxby+d+dzXhpUEOj9xDmABZg2v9n8ZaiFFtx0MMLpQZx9VoBA
IPVMxawZXO910WGw/wOga7Xztoyr5G/7o1vjYmQpUkI9qpIMorirNbcIXTg0t3L8J6mGqcbjhr6o
+2Z5pekQAZRDIX0cCj8Y9cf/HojDQFykGcp4fY2VHbe1LxiB+TirB3Chpbbplm3B0/LeXd83xcL6
LA==
--00000000000004c53e05ee3529df--
