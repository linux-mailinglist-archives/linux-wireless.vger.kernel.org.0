Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352F76E3F68
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 08:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDQGIq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 02:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDQGIo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 02:08:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1842A1FE1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 23:08:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33H67nz86001805, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33H67nz86001805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 17 Apr 2023 14:07:49 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 17 Apr 2023 14:08:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 17 Apr 2023 14:08:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 17 Apr 2023 14:08:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: RE: [PATCH] wifi: rtw88: Fix memory leak in rtw88_usb
Thread-Topic: [PATCH] wifi: rtw88: Fix memory leak in rtw88_usb
Thread-Index: AQHZbzesjaETNjjjhUGpyEIsOiNIha8vBpzw
Date:   Mon, 17 Apr 2023 06:08:12 +0000
Message-ID: <085f8fe9ec9749689e9f3fc51bfe1cce@realtek.com>
References: <20230415011422.11162-1-Larry.Finger@lwfinger.net>
In-Reply-To: <20230415011422.11162-1-Larry.Finger@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
> Sent: Saturday, April 15, 2023 9:14 AM
> To: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org; Larry Finger
> <Larry.Finger@lwfinger.net>; Sascha Hauer <s.hauer@pengutronix.de>; Ping-Ke Shih <pkshih@realtek.com>
> Subject: [PATCH] wifi: rtw88: Fix memory leak in rtw88_usb
> 
> Kmemleak shows the following leak arising from routine in the usb
> probe routine:
> 
> unreferenced object 0xffff895cb29bba00 (size 512):
>   comm "(udev-worker)", pid 534, jiffies 4294903932 (age 102751.088s)
>   hex dump (first 32 bytes):
>     77 30 30 30 00 00 00 00 02 2f 2d 2b 30 00 00 00  w000...../-+0...
>     02 00 2a 28 00 00 00 00 ff 55 ff ff ff 00 00 00  ..*(.....U......
>   backtrace:
>     [<ffffffff9265fa36>] kmalloc_trace+0x26/0x90
>     [<ffffffffc17eec41>] rtw_usb_probe+0x2f1/0x680 [rtw_usb]
>     [<ffffffffc03e19fd>] usb_probe_interface+0xdd/0x2e0 [usbcore]
>     [<ffffffff92b4f2fe>] really_probe+0x18e/0x3d0
>     [<ffffffff92b4f5b8>] __driver_probe_device+0x78/0x160
>     [<ffffffff92b4f6bf>] driver_probe_device+0x1f/0x90
>     [<ffffffff92b4f8df>] __driver_attach+0xbf/0x1b0
>     [<ffffffff92b4d350>] bus_for_each_dev+0x70/0xc0
>     [<ffffffff92b4e51e>] bus_add_driver+0x10e/0x210
>     [<ffffffff92b50935>] driver_register+0x55/0xf0
>     [<ffffffffc03e0708>] usb_register_driver+0x88/0x140 [usbcore]
>     [<ffffffff92401153>] do_one_initcall+0x43/0x210
>     [<ffffffff9254f42a>] do_init_module+0x4a/0x200
>     [<ffffffff92551d1c>] __do_sys_finit_module+0xac/0x120
>     [<ffffffff92ee6626>] do_syscall_64+0x56/0x80
>     [<ffffffff9300006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> The leak was verified to be real by unloading the driver, which resulted
> in a dangling pointer to the allocation.
> 
> The allocated memory is freed in rtw_usb_disconnect().
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/usb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 68e1b782d199..d28493a8f16c 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -882,6 +882,7 @@ void rtw_usb_disconnect(struct usb_interface *intf)
>         rtw_unregister_hw(rtwdev, hw);
>         rtw_usb_deinit_tx(rtwdev);
>         rtw_usb_deinit_rx(rtwdev);
> +       kfree(rtwusb->usb_data);

I suggest to do this in rtw_usb_intf_deinit() instead, because rtwusb->usb_data is
allocated by rtw_usb_intf_init(). Not only make the code symmetric also can handle
error cases properly of rtw_usb_probe().

Ping-Ke


