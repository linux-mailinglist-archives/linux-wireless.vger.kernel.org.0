Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9683A790FA0
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Sep 2023 03:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbjIDBeR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Sep 2023 21:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjIDBeR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Sep 2023 21:34:17 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D419FF0
        for <linux-wireless@vger.kernel.org>; Sun,  3 Sep 2023 18:34:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3841Xe9kA000981, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3841Xe9kA000981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Sep 2023 09:33:40 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 4 Sep 2023 09:34:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 4 Sep 2023 09:34:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Mon, 4 Sep 2023 09:34:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Shubh <shubhisroking@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: Fix spelling mistake "nerver" -> "never"
Thread-Topic: [PATCH] wifi: rtlwifi: Fix spelling mistake "nerver" -> "never"
Thread-Index: AQHZ3X0MiJxICAqZA0+oCnRLrtY4OLAJ5EgA
Date:   Mon, 4 Sep 2023 01:34:06 +0000
Message-ID: <53577222509340228cd27847e4d7f999@realtek.com>
References: <20230902090808.67926-1-shubhisroking@gmail.com>
In-Reply-To: <20230902090808.67926-1-shubhisroking@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Shubh <shubhisroking@gmail.com>
> Sent: Saturday, September 2, 2023 5:08 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org; Shubh <shubhisroking@gmail.com>
> Subject: [PATCH] wifi: rtlwifi: Fix spelling mistake "nerver" -> "never"
> 

I think any patch needs commit message. Even, a simple patch like this.

Others look good to me. 


> Signed-off-by: Shubh <shubhisroking@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
> index 807a53a97..679bdc46d 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/base.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/base.c
> @@ -1265,7 +1265,7 @@ void rtl_get_tcb_desc(struct ieee80211_hw *hw,
>                         tcb_desc->disable_ratefallback = 1;
>                 } else {
>                         /*
> -                        *because hw will nerver use hw_rate
> +                        *because hw will never use hw_rate
>                          *when tcb_desc->use_driver_rate = false
>                          *so we never set highest N rate here,
>                          *and N rate will all be controlled by FW
> --
> 2.42.0

