Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC2072F2DC
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 04:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjFNC4s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 22:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjFNC4q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 22:56:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B58E6F
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 19:56:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35E2uLfpD029021, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35E2uLfpD029021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 14 Jun 2023 10:56:21 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 14 Jun 2023 10:56:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Jun 2023 10:56:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 14 Jun 2023 10:56:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle Valo" <kvalo@kernel.org>
Subject: RE: [PATCH 3/3] wifi: rtw89: fix typo
Thread-Topic: [PATCH 3/3] wifi: rtw89: fix typo
Thread-Index: AQHZnd4lYeopVUYrUUOZRrgC7ldGua+Jm1GQ
Date:   Wed, 14 Jun 2023 02:56:38 +0000
Message-ID: <1fa19bca19604997a94d523d8da6eb9b@realtek.com>
References: <975dee84-fa8f-1dbd-a2b8-2aba5a880b60@yandex.ru>
 <20230613100154.116586-1-dmantipov@yandex.ru>
 <20230613100154.116586-3-dmantipov@yandex.ru>
In-Reply-To: <20230613100154.116586-3-dmantipov@yandex.ru>
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



> -----Original Message-----
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Tuesday, June 13, 2023 6:02 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org; Kalle Valo <kvalo@kernel.org>; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 3/3] wifi: rtw89: fix typo

If you will send next version, please make subject more specific. 
I means something like "wifi: rtw89: fix spelling typo of IQK debug messages". 

> 
> Fix typo in '_doiqk()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
> b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
> index 466fa8e406da..48f1bcc46eda 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
> @@ -1586,7 +1586,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
>                               BTC_WRFK_ONESHOT_START);
> 
>         rtw89_debug(rtwdev, RTW89_DBG_RFK,
> -                   "[IQK]==========IQK strat!!!!!==========\n");
> +                   "[IQK]==========IQK start!!!!!==========\n");
>         iqk_info->iqk_times++;
>         iqk_info->version = RTW8851B_IQK_VER;
> 
> --
> 2.40.1

