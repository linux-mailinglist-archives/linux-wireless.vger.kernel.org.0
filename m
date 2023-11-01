Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC47DDA5F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 01:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjKAAsm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Oct 2023 20:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjKAAsl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Oct 2023 20:48:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCACEA
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 17:48:35 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A10mJhQ5803123, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A10mJhQ5803123
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 08:48:19 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 1 Nov 2023 08:48:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 1 Nov 2023 08:48:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 1 Nov 2023 08:48:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtw88: simplify rtw_chip_cfg_csi_rate()
Thread-Topic: [PATCH 1/2] wifi: rtw88: simplify rtw_chip_cfg_csi_rate()
Thread-Index: AQHaCxP/7YRshr6njkC7FTt89gksa7BkopFg
Date:   Wed, 1 Nov 2023 00:48:19 +0000
Message-ID: <41e756e2184e4b1fa3422fa5c682cf91@realtek.com>
References: <20231030093144.82504-1-dmantipov@yandex.ru>
In-Reply-To: <20231030093144.82504-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antivirus-attachment-filter-interceptor-info: license violation
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Monday, October 30, 2023 5:32 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 1/2] wifi: rtw88: simplify rtw_chip_cfg_csi_rate()
> 
> Since fix rate flag in 'rtw_dynamic_csi_rate()' is a hardcoded
> zero and actually unused in an underlying 'rtw_bf_cfg_csi_rate()',
> simplify 'rtw_chip_cfg_csi_rate()' by dropping last argument and
> adjust '(*cfg_csi_rate)()' of 'struct rtw_chip_ops' accordingly.
> 
> Briefly tested on the following USB dongle:
> 
> usb 3-6: new high-speed USB device number 7 using xhci_hcd
> usb 3-6: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice=2.10
> usb 3-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 3-6: Product: USB3.0 802.11ac 1200M Adapter
> usb 3-6: Manufacturer: Realtek
> usb 3-6: SerialNumber: 123456
> rtw_8822bu 3-6:1.0: Firmware version 27.2.0, H2C version 13
> usbcore: registered new interface driver rtw_8822bu
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtw88/bf.c   | 2 +-
>  drivers/net/wireless/realtek/rtw88/bf.h   | 9 +++++----
>  drivers/net/wireless/realtek/rtw88/main.c | 4 +---
>  drivers/net/wireless/realtek/rtw88/main.h | 2 +-
>  4 files changed, 8 insertions(+), 9 deletions(-)
> 

[...]

> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index 4a33d2e47f33..4ea2f09709b0 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -170,7 +170,6 @@ struct rtw_watch_dog_iter_data {
>  static void rtw_dynamic_csi_rate(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
>  {
>         struct rtw_bf_info *bf_info = &rtwdev->bf_info;
> -       u8 fix_rate_enable = 0;

rtw88 is still active and possible to tune this parameter for certain circumstances,
and this parameter is helpful to understand current configuration, so I would tend
to not merge this patchset. 

Ping-Ke 

