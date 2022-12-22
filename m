Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00F76544F4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 17:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLVQOS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 11:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLVQOR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 11:14:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D7C34
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 08:14:13 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so6164412pje.5
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9K3/vSO3BxctbLxRnnwbO/pRmuZzn/4o2DmqB0G/CSo=;
        b=QtVE5Qh3Z0A6XvnbYKKZoLpk7Pb822tuUz9f5rRY2LaRvnWK6hnjeS+ymqWpVYX43l
         gJMmQrq2t3ZZghIm1NulqxYHTOsDPweMb7vZ6PB2xcbUIR/usOo/QorW5mJmwguvCpK3
         BXbfIDDCGAY9bgXb/BUJ5odUlQ1nylyEuYirI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K3/vSO3BxctbLxRnnwbO/pRmuZzn/4o2DmqB0G/CSo=;
        b=aDX6vt1t3zOlVXB9OkHtgx7YDddyE8QTpqtkJFm9QGhmsBha8LjcZAoSRbRFiOtUHJ
         T2Qr3YvPX5A3fXMc+qNjwz1oY7QZQxOHoWHhK/jU+Cd45Z7l6/RefpUZqtvfvDy8tmk7
         7Ylw5LmMu/GYoehIWJuXTTfC8gKR2NlQx5HHvQIdJLw/VHopcFGZyg36IHem726d6qGc
         RtxJH8tpnl6ZTCDsAfrkfwdquB0rOZBBbEeK+zEmm12tP5fJiklzTZ1Nt3RsDKxwPq2u
         2y0MqRCn8+G/GWOeMVKN0I2IVOsmeZ2+End08me+MnVFpAXi7db2Oc2EpOWdBRwDIaOc
         2p+Q==
X-Gm-Message-State: AFqh2krLFeJg07hFvdxv/ervUqi94ZnRoX6/gVCqrW6jSlSs47CJPxFU
        EH5iw+GzV9U3fZ44ClhRTTTUBA==
X-Google-Smtp-Source: AMrXdXujKB3QisWl7cAlU6EezA5eOHuIszzveuTT6iDQyrKJbP1ylTpW0Q3IrYjsHyDEfBLpUIb6yw==
X-Received: by 2002:a17:902:e742:b0:189:83bb:646f with SMTP id p2-20020a170902e74200b0018983bb646fmr8712110plf.17.1671725652332;
        Thu, 22 Dec 2022 08:14:12 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id v12-20020a655c4c000000b00478e7f87f3bsm926404pgr.67.2022.12.22.08.14.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 08:14:10 -0800 (PST)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
CC:     <linux-wireless@vger.kernel.org>, <dokyungs@yonsei.ac.kr>,
        <jisoo.jang@yonsei.ac.kr>, Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
        kernel test robot <lkp@intel.com>
Date:   Thu, 22 Dec 2022 17:14:06 +0100
Message-ID: <1853a9d00b0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <167172452509.8231.8186319479061770376.kvalo@kernel.org>
References: <20221116145821.544266-1-linuxlovemin@yonsei.ac.kr>
 <167172452509.8231.8186319479061770376.kvalo@kernel.org>
User-Agent: AquaMail/1.41.0 (build: 104100234)
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix potential slab-out-of-bounds read in brcmf_inform_single_bss()
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b2575c05f06cf53e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000b2575c05f06cf53e
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On December 22, 2022 4:55:31 PM Kalle Valo <kvalo@kernel.org> wrote:

> Minsuk Kang <linuxlovemin@yonsei.ac.kr> wrote:
>
>> This patch fixes a slab-out-of-bounds read in brcmfmac that occurs in
>> cfg80211_find_elem_match() called from brcmf_inform_single_bss() when
>> the offset and length values of information elements provided by the
>> device exceed the boundary of the escan buffer that contains information
>> elements. The patch adds a check that makes the function return -EINVAL
>> if that is the case. Note that the negative return is handled by the
>> caller, brcmf_inform_bss().
>>
>> Found by a modified version of syzkaller.
>>
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in cfg80211_find_elem_match+0x164/0x180
>> Read of size 1 at addr ffff888018f0fde9 by task kworker/0:2/1896
>>
>> CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #139
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
>> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>> Workqueue: events brcmf_fweh_event_worker
>> Call Trace:
>> dump_stack_lvl+0x8e/0xd1
>> print_address_description.constprop.0.cold+0x93/0x334
>> ? cfg80211_find_elem_match+0x164/0x180
>> kasan_report.cold+0x79/0xd5
>> ? cfg80211_find_elem_match+0x164/0x180
>> cfg80211_find_elem_match+0x164/0x180
>> cfg80211_get_bss_channel+0x69/0x320
>> cfg80211_inform_single_bss_data+0x1a6/0x1060
>> ? cfg80211_bss_update+0x1e20/0x1e20
>> ? rcu_read_lock_sched_held+0xa1/0xd0
>> ? rcu_read_lock_bh_held+0xb0/0xb0
>> ? find_held_lock+0x2d/0x110
>> ? cfg80211_inform_bss_data+0xcb/0x160
>> cfg80211_inform_bss_data+0xcb/0x160
>> ? cfg80211_parse_mbssid_data+0x1540/0x1540
>> ? kvm_clock_get_cycles+0x14/0x20
>> ? ktime_get_with_offset+0x2b9/0x450
>> brcmf_inform_single_bss+0x36d/0x4d0
>> ? brcmf_notify_mic_status+0xb0/0xb0
>> ? __lock_acquire+0x181f/0x5790
>> ? brcmf_p2p_cancel_remain_on_channel+0x30/0x30
>> brcmf_inform_bss+0x131/0x210
>> brcmf_cfg80211_escan_handler+0x779/0xd20
>> ? rcu_read_lock_bh_held+0xb0/0xb0
>> ? lock_acquire+0x19d/0x4e0
>> ? find_held_lock+0x2d/0x110
>> ? brcmf_cfg80211_escan_timeout_worker+0x60/0x60
>> ? brcmf_fweh_event_worker+0x249/0xc00
>> ? mark_held_locks+0x9f/0xe0
>> ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
>> ? brcmf_cfg80211_escan_timeout_worker+0x60/0x60
>> brcmf_fweh_call_event_handler.isra.0+0x90/0x100
>> brcmf_fweh_event_worker+0x117/0xc00
>> ? brcmf_fweh_call_event_handler.isra.0+0x100/0x100
>> ? rcu_read_lock_sched_held+0xa1/0xd0
>> ? rcu_read_lock_bh_held+0xb0/0xb0
>> ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>> process_one_work+0x92b/0x1460
>> ? pwq_dec_nr_in_flight+0x330/0x330
>> ? rwlock_bug.part.0+0x90/0x90
>> worker_thread+0x95/0xe00
>> ? __kthread_parkme+0x115/0x1e0
>> ? process_one_work+0x1460/0x1460
>> kthread+0x3a1/0x480
>> ? set_kthread_struct+0x120/0x120
>> ret_from_fork+0x1f/0x30
>>
>> The buggy address belongs to the page:
>> page:ffffea000063c000 refcount:1 mapcount:0 mapping:0000000000000000 
>> index:0x0 pfn:0x18f00
>> head:ffffea000063c000 order:4 compound_mapcount:0 compound_pincount:0
>> flags: 0x100000000010000(head|node=0|zone=1)
>> raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
>> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>> page_owner tracks the page as allocated
>> page last allocated via order 4, migratetype Unmovable, gfp_mask 
>> 0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), pid 1896, ts 44510886600, free_ts 0
>> prep_new_page+0x1aa/0x240
>> get_page_from_freelist+0x159a/0x27c0
>> __alloc_pages+0x2da/0x6a0
>> alloc_pages+0xec/0x1e0
>> kmalloc_order+0x39/0xf0
>> kmalloc_order_trace+0x19/0x120
>> brcmf_cfg80211_attach+0x5c9/0x3fd0
>> brcmf_attach+0x389/0xd40
>> brcmf_usb_probe+0x12de/0x1690
>> usb_probe_interface+0x2aa/0x760
>> really_probe+0x205/0xb70
>> __driver_probe_device+0x311/0x4b0
>> driver_probe_device+0x4e/0x150
>> __device_attach_driver+0x1cc/0x2a0
>> bus_for_each_drv+0x156/0x1d0
>> __device_attach+0x23f/0x3a0
>> page_owner free stack trace missing
>>
>> Memory state around the buggy address:
>> ffff888018f0fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff888018f0fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> ffff888018f0fd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 fe fe fe
>>                                                  ^
>> ffff888018f0fe00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>> ffff888018f0fe80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>> ==================================================================
>>
>> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
>> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
>> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
>
> Can someone review this?

Will have to see the bigger picture. Probably have time to do that later 
today. What's the deadline? ;-)

Regards,
Arend

> --
> https://patchwork.kernel.org/project/linux-wireless/patch/20221116145821.544266-1-linuxlovemin@yonsei.ac.kr/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches




--000000000000b2575c05f06cf53e
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDH7J1EMdGDtEfvF4Q5
H52NK18hEv2hjnZzK+JijvkffjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjEyMjIxNjE0MTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAlkZCGJrkzXtUnT49t0jvzD14Xg2Q1jMqVsCC
N0/264ohp0R54St9lalOywchmL29GLJzRe7ou9mQbfvH8ECy+nxx0jawvLBgjI6xBrnEFlq4Z0fg
LWX+ArVL0ChHvbjn6R/P2daw/wumtk5PclKV4qQETKy8qOQV/t6eedrQhF5EsuaJb0VKTTLnsdU1
wbWWD59MBhtduMWAoZiNpMlzJekxfwOMMsl9AV2vSHkNcxWmz2yBajsxU7unjJDgP+UTG1TUAsrb
FAIUQ5fyJdogF23ws+JE2MpGmGYCJ5H0NNybyJuCmg0+UE7iOLktp1Gyc/qFWXiQkPmvb3Tk90oY
Qg==
--000000000000b2575c05f06cf53e--
