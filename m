Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83B862BC3A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 12:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiKPLlk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 06:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiKPLlF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 06:41:05 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9349B4A
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 03:27:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v7so11684339wmn.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 03:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kjhHpb9gtIBf6B9VO54IRKzXm+XONNsNUcyoZA57EII=;
        b=Ix2MEZ32aGFnH8rgDp5ZJGIqGDxtMQGAI5Zj8ydulwCw5shienQjQPdFsMeqAwRiLt
         J/hrnezFDOz8L5HaAUgCCoTcnq2RGliAzItg9HV62Ed7zHQOyiCt6P74IKEtsmxDY1Vj
         YYNYxQ1b+VFCPLm0vIR0hhfuarBi0z8oRnnPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjhHpb9gtIBf6B9VO54IRKzXm+XONNsNUcyoZA57EII=;
        b=R5cIk3xAig90PESiFhF6C0/rEmZmO9ZRuHQZlfuBCNvZqhdVhH3ztOkXFoAPBl9nL7
         /Ws0oLdHxPp7pFfPzYQvFpZmHGodfB1azVlPEEjtfnQsx926jQl///3m5DOo5dMslmTe
         xZmJgROkKCuCFHQe9QZD115d7KREFO5pr/DmRDt81Mq6CeZCSzVLzuluCGNTvYI9Qiz4
         tGL2BfdqUVFadSpjNriYpxkjLW9ZOch+abnGYEnxeuWc9lf095BgmGcrZBRXHhffJa2K
         bwJFGwp/XrhZ5U5wUF4JfiTnp87Wqm5Cr5yFH2Rhjy/ewHtmPgCWI2srH6ooUpuQpR/f
         b8nQ==
X-Gm-Message-State: ANoB5pnWvXT0IGnlkNTTVHM6GLKYiTaAWExmjDR6aSkBTEehQX7VDpCF
        5/ddTMZbrlg8QXYKvz94dZJW5w==
X-Google-Smtp-Source: AA0mqf7VqOi6jZPV7x/3w85TZP2OcSuzdUW4+xd+wR+9jfhgxOa22jGN3mY5yqCXwA0sFWvKdM51DQ==
X-Received: by 2002:a1c:f703:0:b0:3cf:6c05:809e with SMTP id v3-20020a1cf703000000b003cf6c05809emr1851188wmh.74.1668598047804;
        Wed, 16 Nov 2022 03:27:27 -0800 (PST)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d694b000000b0023691d62cffsm14551762wrw.70.2022.11.16.03.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:27:26 -0800 (PST)
Message-ID: <7a566a14-9e33-5307-0ccb-051368f5f169@broadcom.com>
Date:   Wed, 16 Nov 2022 12:27:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] wifi: brcmfmac: Check the count value of channel spec to
 prevent out-of-bounds reads
To:     Kalle Valo <kvalo@kernel.org>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Cc:     linux-wireless@vger.kernel.org, aspriel@gmail.com,
        dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr
References: <20221111075346.136376-1-linuxlovemin@yonsei.ac.kr>
 <166859062890.16887.3852526152218508056.kvalo@kernel.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <166859062890.16887.3852526152218508056.kvalo@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ee3b5b05ed94c1c0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000ee3b5b05ed94c1c0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/2022 10:23 AM, Kalle Valo wrote:
> Minsuk Kang <linuxlovemin@yonsei.ac.kr> wrote:
> 
>> This patch fixes slab-out-of-bounds reads in brcmfmac that occur in
>> brcmf_construct_chaninfo() and brcmf_enable_bw40_2g() when the count
>> value of channel specifications provided by the device is greater than
>> the length of 'list->element[]', decided by the size of the 'list'
>> allocated with kzalloc(). The patch adds checks that make the functions
>> free the buffer and return -EINVAL if that is the case. Note that the
>> negative return is handled by the caller, brcmf_setup_wiphybands() or
>> brcmf_cfg80211_attach().
>>
>> Found by a modified version of syzkaller.
>>
>> Crash Report from brcmf_construct_chaninfo():
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in brcmf_setup_wiphybands+0x1238/0x1430
>> Read of size 4 at addr ffff888115f24600 by task kworker/0:2/1896
>>
>> CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G        W  O      5.14.0+ #132
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>> Workqueue: usb_hub_wq hub_event
>> Call Trace:
>>   dump_stack_lvl+0x57/0x7d
>>   print_address_description.constprop.0.cold+0x93/0x334
>>   kasan_report.cold+0x83/0xdf
>>   brcmf_setup_wiphybands+0x1238/0x1430
>>   brcmf_cfg80211_attach+0x2118/0x3fd0
>>   brcmf_attach+0x389/0xd40
>>   brcmf_usb_probe+0x12de/0x1690
>>   usb_probe_interface+0x25f/0x710
>>   really_probe+0x1be/0xa90
>>   __driver_probe_device+0x2ab/0x460
>>   driver_probe_device+0x49/0x120
>>   __device_attach_driver+0x18a/0x250
>>   bus_for_each_drv+0x123/0x1a0
>>   __device_attach+0x207/0x330
>>   bus_probe_device+0x1a2/0x260
>>   device_add+0xa61/0x1ce0
>>   usb_set_configuration+0x984/0x1770
>>   usb_generic_driver_probe+0x69/0x90
>>   usb_probe_device+0x9c/0x220
>>   really_probe+0x1be/0xa90
>>   __driver_probe_device+0x2ab/0x460
>>   driver_probe_device+0x49/0x120
>>   __device_attach_driver+0x18a/0x250
>>   bus_for_each_drv+0x123/0x1a0
>>   __device_attach+0x207/0x330
>>   bus_probe_device+0x1a2/0x260
>>   device_add+0xa61/0x1ce0
>>   usb_new_device.cold+0x463/0xf66
>>   hub_event+0x10d5/0x3330
>>   process_one_work+0x873/0x13e0
>>   worker_thread+0x8b/0xd10
>>   kthread+0x379/0x450
>>   ret_from_fork+0x1f/0x30
>>
>> Allocated by task 1896:
>>   kasan_save_stack+0x1b/0x40
>>   __kasan_kmalloc+0x7c/0x90
>>   kmem_cache_alloc_trace+0x19e/0x330
>>   brcmf_setup_wiphybands+0x290/0x1430
>>   brcmf_cfg80211_attach+0x2118/0x3fd0
>>   brcmf_attach+0x389/0xd40
>>   brcmf_usb_probe+0x12de/0x1690
>>   usb_probe_interface+0x25f/0x710
>>   really_probe+0x1be/0xa90
>>   __driver_probe_device+0x2ab/0x460
>>   driver_probe_device+0x49/0x120
>>   __device_attach_driver+0x18a/0x250
>>   bus_for_each_drv+0x123/0x1a0
>>   __device_attach+0x207/0x330
>>   bus_probe_device+0x1a2/0x260
>>   device_add+0xa61/0x1ce0
>>   usb_set_configuration+0x984/0x1770
>>   usb_generic_driver_probe+0x69/0x90
>>   usb_probe_device+0x9c/0x220
>>   really_probe+0x1be/0xa90
>>   __driver_probe_device+0x2ab/0x460
>>   driver_probe_device+0x49/0x120
>>   __device_attach_driver+0x18a/0x250
>>   bus_for_each_drv+0x123/0x1a0
>>   __device_attach+0x207/0x330
>>   bus_probe_device+0x1a2/0x260
>>   device_add+0xa61/0x1ce0
>>   usb_new_device.cold+0x463/0xf66
>>   hub_event+0x10d5/0x3330
>>   process_one_work+0x873/0x13e0
>>   worker_thread+0x8b/0xd10
>>   kthread+0x379/0x450
>>   ret_from_fork+0x1f/0x30
>>
>> The buggy address belongs to the object at ffff888115f24000
>>   which belongs to the cache kmalloc-2k of size 2048
>> The buggy address is located 1536 bytes inside of
>>   2048-byte region [ffff888115f24000, ffff888115f24800)
>>
>> Memory state around the buggy address:
>>   ffff888115f24500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   ffff888115f24580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> ffff888115f24600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>                     ^
>>   ffff888115f24680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff888115f24700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ==================================================================
>>
>> Crash Report from brcmf_enable_bw40_2g():
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in brcmf_cfg80211_attach+0x3d11/0x3fd0
>> Read of size 4 at addr ffff888103787600 by task kworker/0:2/1896
>>
>> CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G        W  O      5.14.0+ #132
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>> Workqueue: usb_hub_wq hub_event
>> Call Trace:
>>   dump_stack_lvl+0x57/0x7d
>>   print_address_description.constprop.0.cold+0x93/0x334
>>   kasan_report.cold+0x83/0xdf
>>   brcmf_cfg80211_attach+0x3d11/0x3fd0
>>   brcmf_attach+0x389/0xd40
>>   brcmf_usb_probe+0x12de/0x1690
>>   usb_probe_interface+0x25f/0x710
>>   really_probe+0x1be/0xa90
>>   __driver_probe_device+0x2ab/0x460
>>   driver_probe_device+0x49/0x120
>>   __device_attach_driver+0x18a/0x250
>>   bus_for_each_drv+0x123/0x1a0
>>   __device_attach+0x207/0x330
>>   bus_probe_device+0x1a2/0x260
>>   device_add+0xa61/0x1ce0
>>   usb_set_configuration+0x984/0x1770
>>   usb_generic_driver_probe+0x69/0x90
>>   usb_probe_device+0x9c/0x220
>>   really_probe+0x1be/0xa90
>>   __driver_probe_device+0x2ab/0x460
>>   driver_probe_device+0x49/0x120
>>   __device_attach_driver+0x18a/0x250
>>   bus_for_each_drv+0x123/0x1a0
>>   __device_attach+0x207/0x330
>>   bus_probe_device+0x1a2/0x260
>>   device_add+0xa61/0x1ce0
>>   usb_new_device.cold+0x463/0xf66
>>   hub_event+0x10d5/0x3330
>>   process_one_work+0x873/0x13e0
>>   worker_thread+0x8b/0xd10
>>   kthread+0x379/0x450
>>   ret_from_fork+0x1f/0x30
>>
>> Allocated by task 1896:
>>   kasan_save_stack+0x1b/0x40
>>   __kasan_kmalloc+0x7c/0x90
>>   kmem_cache_alloc_trace+0x19e/0x330
>>   brcmf_cfg80211_attach+0x3302/0x3fd0
>>   brcmf_attach+0x389/0xd40
>>   brcmf_usb_probe+0x12de/0x1690
>>   usb_probe_interface+0x25f/0x710
>>   really_probe+0x1be/0xa90
>>   __driver_probe_device+0x2ab/0x460
>>   driver_probe_device+0x49/0x120
>>   __device_attach_driver+0x18a/0x250
>>   bus_for_each_drv+0x123/0x1a0
>>   __device_attach+0x207/0x330
>>   bus_probe_device+0x1a2/0x260
>>   device_add+0xa61/0x1ce0
>>   usb_set_configuration+0x984/0x1770
>>   usb_generic_driver_probe+0x69/0x90
>>   usb_probe_device+0x9c/0x220
>>   really_probe+0x1be/0xa90
>>   __driver_probe_device+0x2ab/0x460
>>   driver_probe_device+0x49/0x120
>>   __device_attach_driver+0x18a/0x250
>>   bus_for_each_drv+0x123/0x1a0
>>   __device_attach+0x207/0x330
>>   bus_probe_device+0x1a2/0x260
>>   device_add+0xa61/0x1ce0
>>   usb_new_device.cold+0x463/0xf66
>>   hub_event+0x10d5/0x3330
>>   process_one_work+0x873/0x13e0
>>   worker_thread+0x8b/0xd10
>>   kthread+0x379/0x450
>>   ret_from_fork+0x1f/0x30
>>
>> The buggy address belongs to the object at ffff888103787000
>>   which belongs to the cache kmalloc-2k of size 2048
>> The buggy address is located 1536 bytes inside of
>>   2048-byte region [ffff888103787000, ffff888103787800)
>>
>> Memory state around the buggy address:
>>   ffff888103787500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   ffff888103787580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> ffff888103787600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>                     ^
>>   ffff888103787680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff888103787700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ==================================================================
>>
>> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
>> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
>> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
>> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> 
> Can someone review this, please?

Missed this one, but I will have a look now.

Regards,
Arend

--000000000000ee3b5b05ed94c1c0
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCfOGwzSUHfeZMsNvwh
4H8AUFYxBBhwlFy2APKniTgMZjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjExMTYxMTI3MjhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAlllqrRsrkaIwI8lFWHVRX/3DfIqn5MCLesa2
F15fSRKyTuk4KAIQHjsJh3kkYIb/uW3QLE9AYjBwVDI0rc7O+1YIYCakMlOtf6n3h9qFbRZ5EOfz
O6hnmKSctz3XL5ofYc9+QtHkoZKtDTEIZjKsnSg3w9KuSNFk88ZHOjgexQJS9U+USJ8yuxYlvqrJ
/2r1JWGefmsZITvBNSoEPl2+M3p67ZoQjyx7bIXT4OBUx0c1OZD0DEwrcKRElvMxYtHLO9Y8PNac
b6H4nnenNEU9ngboivZBUA8GbxVP5KHAW+Tpp4IzbMx+uJpEImx/gcKHAb/Al9nFq5hkDuGtT2aC
JA==
--000000000000ee3b5b05ed94c1c0--
