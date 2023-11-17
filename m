Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AAD7EEB4C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 04:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjKQDF7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 22:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQDF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 22:05:58 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3249F
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 19:05:55 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AH35eOsA2832665, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AH35eOsA2832665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 11:05:40 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 17 Nov 2023 11:05:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 17 Nov 2023 11:05:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 17 Nov 2023 11:05:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH 1/2] wifi: rtlwifi: more cleanup for struct rtl_hal
Thread-Topic: [PATCH 1/2] wifi: rtlwifi: more cleanup for struct rtl_hal
Thread-Index: AQHaFkCHTBsHuqTCt0G6N7QDezkgG7B9173Q
Date:   Fri, 17 Nov 2023 03:05:40 +0000
Message-ID: <0dbc9bb6820d4efba40af93f14ef5418@realtek.com>
References: <20231113144734.197359-1-dmantipov@yandex.ru>
In-Reply-To: <20231113144734.197359-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
> Sent: Monday, November 13, 2023 10:47 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; lvc-project@linuxtesting.org; Dmitry
> Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 1/2] wifi: rtlwifi: more cleanup for struct rtl_hal
> 
> Following commit d1e6b020c32d ("wifi: rtlwifi: cleanup struct rtl_hal"),
> remove unused 'hal_coex_8723', 'current_bandtypebackup', 'master_of_dmsp'
> and 'slave_of_dmsp' members of 'struct rtl_hal' as well. Compile tested
> only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtlwifi/wifi.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
> index 171a461cd812..33c3e001266f 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
> +++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
> @@ -1605,7 +1605,6 @@ struct rtl_hal {
>         bool being_init_adapter;
>         bool mac_func_enable;
>         bool pre_edcca_enable;
> -       struct bt_coexist_8723 hal_coex_8723;

In drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c, it does a global
static variable:
   static struct bt_coexist_8723 hal_coex_8723;

That's not a good practice. It would be better to use the field you are removing.
To prevent wasting space, we can dynamically allocate the space when 8723AE
is presented only.

Note, I don't have this old module 8723AE, so even you achieve the patch, 
I can't test it on a real hardware. 


