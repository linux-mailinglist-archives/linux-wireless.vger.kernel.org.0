Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F128A7273CC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 02:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjFHAkm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jun 2023 20:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFHAkk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jun 2023 20:40:40 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33AE213C
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jun 2023 17:40:39 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3580eFUC1022217, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3580eFUC1022217
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 08:40:15 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 8 Jun 2023 08:40:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Jun 2023 08:40:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 08:40:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtw89: cleanup rtw89_iqk_info and related code
Thread-Topic: [PATCH 2/2] wifi: rtw89: cleanup rtw89_iqk_info and related code
Thread-Index: AQHZmICRpaKuGIBk3keApvrDwZUUPK+AEhMA
Date:   Thu, 8 Jun 2023 00:40:30 +0000
Message-ID: <4940e73006ec49c5adf76200c35d7704@realtek.com>
References: <20230606083354.375287-1-dmantipov@yandex.ru>
 <20230606140806.606352-1-dmantipov@yandex.ru>
 <20230606140806.606352-2-dmantipov@yandex.ru>
In-Reply-To: <20230606140806.606352-2-dmantipov@yandex.ru>
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
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Tuesday, June 6, 2023 10:08 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 2/2] wifi: rtw89: cleanup rtw89_iqk_info and related code
> 
> Drop useless '_iqk_track()' and 'rtw8852a_iqk_track()' (they
> just change 'thermal_rek_en' field which is set but unused
> and so removed as well) functions, set but unused 'kcount'
> field of 'struct rtw89_iqk_info', convert 'thermal' to local
> variables where appropriate (it doesn't need to have longer
> storage duration because it is actually used for debugging
> purposes only), fix typos.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/core.h     |  3 --
>  drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 -
>  .../net/wireless/realtek/rtw89/rtw8852a_rfk.c | 34 +------------------
>  .../net/wireless/realtek/rtw89/rtw8852a_rfk.h |  1 -
>  .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |  8 +----
>  .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  9 ++---
>  6 files changed, 4 insertions(+), 52 deletions(-)
> 

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> index cd6c39b7f802..afb7eba3dc44 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> @@ -1284,11 +1284,8 @@ static void _iqk_info_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
>         u32 tmp = 0x0;
>         bool flag = 0x0;
> 
> -       iqk_info->thermal[path] =
> -               ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
> -       iqk_info->thermal_rek_en = false;
>         rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_thermal = %d\n", path,
> -                   iqk_info->thermal[path]);
> +                   (u8)ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]));

nit: no need casting (u8)

>         rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_LOK_COR_fail= %d\n", path,
>                     iqk_info->lok_cor_fail[0][path]);
>         rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_LOK_FIN_fail= %d\n", path,

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
> index 2c0bc3a4ab3b..d8c8688faee4 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
> @@ -1261,11 +1261,8 @@ static void _iqk_info_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
>         u32 tmp;
>         bool flag;
> 
> -       iqk_info->thermal[path] =
> -               ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
> -       iqk_info->thermal_rek_en = false;
>         rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_thermal = %d\n", path,
> -                   iqk_info->thermal[path]);
> +                   (u8)ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]));

nit: no need casting (u8)

>         rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_LOK_COR_fail= %d\n", path,
>                     iqk_info->lok_cor_fail[0][path]);
>         rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d_LOK_FIN_fail= %d\n", path,

[...]

