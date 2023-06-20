Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981C5736251
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 05:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjFTDt4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 23:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjFTDtx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 23:49:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5310110C2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 20:49:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35K3mx0F3026483, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35K3mx0F3026483
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 20 Jun 2023 11:48:59 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 20 Jun 2023 11:49:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Jun 2023 11:49:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 20 Jun 2023 11:49:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 3/3] [v3] wifi: rtw88: remove unused USB bulkout size set
Thread-Topic: [PATCH 3/3] [v3] wifi: rtw88: remove unused USB bulkout size set
Thread-Index: AQHZoDDgsqypGkZyX0KWVgPRq7dcwq+TEihw
Date:   Tue, 20 Jun 2023 03:49:19 +0000
Message-ID: <5ecd668942f44275953081ae63acc57c@realtek.com>
References: <20230616085917.60662-1-dmantipov@yandex.ru>
 <20230616085917.60662-3-dmantipov@yandex.ru>
In-Reply-To: <20230616085917.60662-3-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

// add rtw88 USB author Sascha for his comments.

> -----Original Message-----
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Friday, June 16, 2023 4:59 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 3/3] [v3] wifi: rtw88: remove unused USB bulkout size set
> 
> Drop no longer used 'bulkout_size' of 'struct rtw_usb'
> and related macros from usb.h, but preserve sanity check
> in 'rtw_usb_parse()'. This follows commit 462c8db6a011
> ("wifi: rtw88: usb: drop now unnecessary URB size check").
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtw88/usb.c | 5 -----
>  drivers/net/wireless/realtek/rtw88/usb.h | 5 -----
>  2 files changed, 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 6862338b1d51..40e614f58349 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -186,13 +186,8 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
>         switch (usbd->speed) {
>         case USB_SPEED_LOW:
>         case USB_SPEED_FULL:
> -               rtwusb->bulkout_size = RTW_USB_FULL_SPEED_BULK_SIZE;
> -               break;
>         case USB_SPEED_HIGH:
> -               rtwusb->bulkout_size = RTW_USB_HIGH_SPEED_BULK_SIZE;
> -               break;
>         case USB_SPEED_SUPER:
> -               rtwusb->bulkout_size = RTW_USB_SUPER_SPEED_BULK_SIZE;
>                 break;
>         default:
>                 rtw_err(rtwdev, "failed to detect usb speed\n");

If we decide to remove rtwusb->bulkout_size, I suggest to remove whole
switch..case chunk.



