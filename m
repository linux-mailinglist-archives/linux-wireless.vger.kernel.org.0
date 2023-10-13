Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEFC7C7FAF
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjJMILt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 04:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjJMILp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 04:11:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A186DE6
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 01:11:40 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39D8BTZk82526398, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39D8BTZk82526398
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 16:11:29 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 13 Oct 2023 16:11:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Oct 2023 16:11:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 13 Oct 2023 16:11:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtlwifi: cleanup struct rtl_ps_ctl
Thread-Topic: [PATCH 1/2] wifi: rtlwifi: cleanup struct rtl_ps_ctl
Thread-Index: AQHZ/FoulYvRw5Dw6USDK7ijEJ2gv7BHYLTw
Date:   Fri, 13 Oct 2023 08:11:28 +0000
Message-ID: <a4bb3324101e4269b7a922ea8ae70875@realtek.com>
References: <20231011154442.52457-1-dmantipov@yandex.ru>
In-Reply-To: <20231011154442.52457-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Wednesday, October 11, 2023 11:45 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 1/2] wifi: rtlwifi: cleanup struct rtl_ps_ctl
> 
> Remove set but otherwise unused 'sleep_ms', 'last_action',
> and 'last_slept' members of 'struct rtl_ps_ctl' (these
> seems to be a leftovers from some older code) and adjust
> 'rtl_swlps_wq_callback()' accordingly.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtlwifi/ps.c   | 10 ----------
>  drivers/net/wireless/realtek/rtlwifi/wifi.h |  3 ---
>  2 files changed, 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
> index 629c03271bde..ba61fcec9fae 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/ps.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
> @@ -688,16 +688,6 @@ void rtl_swlps_wq_callback(struct work_struct *work)
>         /* we can sleep after ps null send ok */
>         if (rtlpriv->psc.state_inap) {
>                 rtl_swlps_rf_sleep(hw);
> -
> -               if (rtlpriv->psc.state && !ps) {
> -                       rtlpriv->psc.sleep_ms = jiffies_to_msecs(jiffies -
> -                                                rtlpriv->psc.last_action);
> -               }
> -
> -               if (ps)
> -                       rtlpriv->psc.last_slept = jiffies;
> -
> -               rtlpriv->psc.last_action = jiffies;
>                 rtlpriv->psc.state = ps;

'state' is also unused. 

>         }
>  }
> diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
> index 47b4685b6d24..cabf6c82a639 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
> +++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
> @@ -2037,14 +2037,11 @@ struct rtl_ps_ctl {
>         bool multi_buffered;
>         u16 nullfunc_seq;
>         unsigned int dtim_counter;
> -       unsigned int sleep_ms;
>         unsigned long last_sleep_jiffies;
>         unsigned long last_awake_jiffies;
>         unsigned long last_delaylps_stamp_jiffies;
>         unsigned long last_dtim;
>         unsigned long last_beacon;
> -       unsigned long last_action;
> -       unsigned long last_slept;
> 
>         /*For P2P PS */
>         struct rtl_p2p_ps_info p2p_ps_info;
> --
> 2.41.0

