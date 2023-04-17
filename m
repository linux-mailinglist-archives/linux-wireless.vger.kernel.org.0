Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862BF6E4DD6
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 17:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjDQP5e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjDQP5c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 11:57:32 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD84044B7
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 08:57:30 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id d1so6949714oiw.13
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681747050; x=1684339050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6wzry6zXay5MDyIZd1MuO3n4m2qR/l/mcK+Gxj9lrQQ=;
        b=HBY9aDDncbO3sJ8OLWX+wdwALrf/fPlNQH4XTNuaiQBTtUsdOPrC3CnP/faENdWeSb
         a0UC+s53kFQkxF3RKMaAoMezEtVzkAxuYAN576SBVzzEMbd4osi9HFpKguPDhZfQOJBW
         ru01TWFZRAE3xwkz5Nl+WJhXtdPbL91oXqtVoyo0TKXUJ3ZYmIVILK2zc9NGLJq6Y5Td
         vBlKZ1iBYpiQFu6Kjnp9i8D5MYHduERaWMK4wHBks53e6R6pKGLEJrOcH/Q7tx2rXJkZ
         OU4uNi9ebLp4aQaJpVjGsSmHdSycexpiuZ/wr+hcrketvbctoWsRILOMJJ33NreCVTUT
         VkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681747050; x=1684339050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wzry6zXay5MDyIZd1MuO3n4m2qR/l/mcK+Gxj9lrQQ=;
        b=d8PxtwyR/JBmqrdTIWhcnu1OkVhG+s/kbSLnezuGWSijvDpG+NeC9s6AEpHiTSc9l2
         I39QN+ozNLtQCpkmzxKAyoQ6+tbOijprddERMCPBz24UcYksT6Y6+8Op1cEB88PVizwg
         TBGgGzgdojrlzlZXUOzd9TkBIlCaHvv9pxjhyJyarPsn6tBHpsNzIMa8TR6tt8zIYmes
         Fn9rOE8GGlXlRggoN3xlIUd9L56y46TUNHN4bUfs/YYDurAOV0pVkYVxh7VRoSpaBRKE
         3DPuQ4CrY0jZKCrXuKIFZpfHqP+iP8/cLCItsXGJqaD6pHAjFZbMmGJuGi4RuAvDHkNQ
         Wv3g==
X-Gm-Message-State: AAQBX9cek+B1N5VuBky1aXQq0TvgZ/suuAwtU7C2g9+cNdPLWAd+bcWE
        ur/vs3rh2qVmnUcIitOx1n7spbpCvDI=
X-Google-Smtp-Source: AKy350ZUZEfKzTw3E5jEqZ6Ee4Hukq4YnbbEp29am70azsi7eSmPHlgoIei50mkSFcxj4nbP3IPRqg==
X-Received: by 2002:a05:6808:1451:b0:38c:589d:5595 with SMTP id x17-20020a056808145100b0038c589d5595mr4467695oiv.10.1681747050038;
        Mon, 17 Apr 2023 08:57:30 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id 2-20020a544182000000b0038e07fe2c97sm1176846oiy.42.2023.04.17.08.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:57:29 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <579f78b3-eec5-534d-407f-40216b31c755@lwfinger.net>
Date:   Mon, 17 Apr 2023 10:57:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: rtw88: Fix memory leak in rtw88_usb
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20230415011422.11162-1-Larry.Finger@lwfinger.net>
 <085f8fe9ec9749689e9f3fc51bfe1cce@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <085f8fe9ec9749689e9f3fc51bfe1cce@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/17/23 01:08, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
>> Sent: Saturday, April 15, 2023 9:14 AM
>> To: Kalle Valo <kvalo@kernel.org>
>> Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org; Larry Finger
>> <Larry.Finger@lwfinger.net>; Sascha Hauer <s.hauer@pengutronix.de>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH] wifi: rtw88: Fix memory leak in rtw88_usb
>>
>> Kmemleak shows the following leak arising from routine in the usb
>> probe routine:
>>
>> unreferenced object 0xffff895cb29bba00 (size 512):
>>    comm "(udev-worker)", pid 534, jiffies 4294903932 (age 102751.088s)
>>    hex dump (first 32 bytes):
>>      77 30 30 30 00 00 00 00 02 2f 2d 2b 30 00 00 00  w000...../-+0...
>>      02 00 2a 28 00 00 00 00 ff 55 ff ff ff 00 00 00  ..*(.....U......
>>    backtrace:
>>      [<ffffffff9265fa36>] kmalloc_trace+0x26/0x90
>>      [<ffffffffc17eec41>] rtw_usb_probe+0x2f1/0x680 [rtw_usb]
>>      [<ffffffffc03e19fd>] usb_probe_interface+0xdd/0x2e0 [usbcore]
>>      [<ffffffff92b4f2fe>] really_probe+0x18e/0x3d0
>>      [<ffffffff92b4f5b8>] __driver_probe_device+0x78/0x160
>>      [<ffffffff92b4f6bf>] driver_probe_device+0x1f/0x90
>>      [<ffffffff92b4f8df>] __driver_attach+0xbf/0x1b0
>>      [<ffffffff92b4d350>] bus_for_each_dev+0x70/0xc0
>>      [<ffffffff92b4e51e>] bus_add_driver+0x10e/0x210
>>      [<ffffffff92b50935>] driver_register+0x55/0xf0
>>      [<ffffffffc03e0708>] usb_register_driver+0x88/0x140 [usbcore]
>>      [<ffffffff92401153>] do_one_initcall+0x43/0x210
>>      [<ffffffff9254f42a>] do_init_module+0x4a/0x200
>>      [<ffffffff92551d1c>] __do_sys_finit_module+0xac/0x120
>>      [<ffffffff92ee6626>] do_syscall_64+0x56/0x80
>>      [<ffffffff9300006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>> The leak was verified to be real by unloading the driver, which resulted
>> in a dangling pointer to the allocation.
>>
>> The allocated memory is freed in rtw_usb_disconnect().
>>
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Ping-Ke Shih <pkshih@realtek.com>
>> ---
>>   drivers/net/wireless/realtek/rtw88/usb.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>> index 68e1b782d199..d28493a8f16c 100644
>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>> @@ -882,6 +882,7 @@ void rtw_usb_disconnect(struct usb_interface *intf)
>>          rtw_unregister_hw(rtwdev, hw);
>>          rtw_usb_deinit_tx(rtwdev);
>>          rtw_usb_deinit_rx(rtwdev);
>> +       kfree(rtwusb->usb_data);
> 
> I suggest to do this in rtw_usb_intf_deinit() instead, because rtwusb->usb_data is
> allocated by rtw_usb_intf_init(). Not only make the code symmetric also can handle
> error cases properly of rtw_usb_probe().

Ping-Ke,

Thanks for the suggestion. I chose my location because the allocation was just 
before the call to rtw_usb_init_tx(), thus the free went after 
rtw_usb_deinit_tx(), but I see your point. I will submit v2.

Larry



