Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CCE7A15FB
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 08:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjIOGUv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 02:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjIOGUu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 02:20:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C83CF196
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 23:20:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38F6JU2j82199273, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38F6JU2j82199273
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 14:19:30 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 15 Sep 2023 14:19:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 15 Sep 2023 14:19:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Fri, 15 Sep 2023 14:19:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "Stanislaw Gruszka" <sgruszka@redhat.com>,
        Brian Norris <briannorris@chromium.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
Subject: RE: [PATCH] rtw88: debug: Fix Fix the NULL vs IS_ERR() bug for debugfs_create_file()
Thread-Topic: [PATCH] rtw88: debug: Fix Fix the NULL vs IS_ERR() bug for
 debugfs_create_file()
Thread-Index: AQHZ5rvGT7BX67mBJUWEvWs679dwq7Aba0sQ
Date:   Fri, 15 Sep 2023 06:19:30 +0000
Message-ID: <1ce0e303159449779b296be3e68e3bb6@realtek.com>
References: <20230914032915.3758138-1-ruanjinjie@huawei.com>
In-Reply-To: <20230914032915.3758138-1-ruanjinjie@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> Sent: Thursday, September 14, 2023 11:29 AM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>;
> Stanislaw Gruszka <sgruszka@redhat.com>; Brian Norris <briannorris@chromium.org>; Yan-Hsuan Chuang
> <yhchuang@realtek.com>
> Cc: ruanjinjie@huawei.com
> Subject: [PATCH] rtw88: debug: Fix Fix the NULL vs IS_ERR() bug for debugfs_create_file()

Excepting to typo "Fix Fix" in subject, patch looks fine to me. 

> 
> 
> Since debugfs_create_file() return ERR_PTR and never return NULL, so use
> IS_ERR() to check it instead of checking NULL.
> 
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtw88/debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
> index f8ba133baff0..35bc37a3c469 100644
> --- a/drivers/net/wireless/realtek/rtw88/debug.c
> +++ b/drivers/net/wireless/realtek/rtw88/debug.c
> @@ -1233,9 +1233,9 @@ static struct rtw_debugfs_priv rtw_debug_priv_dm_cap = {
>  #define rtw_debugfs_add_core(name, mode, fopname, parent)              \
>         do {                                                            \
>                 rtw_debug_priv_ ##name.rtwdev = rtwdev;                 \
> -               if (!debugfs_create_file(#name, mode,                   \
> +               if (IS_ERR(debugfs_create_file(#name, mode,             \
>                                          parent, &rtw_debug_priv_ ##name,\
> -                                        &file_ops_ ##fopname))         \
> +                                        &file_ops_ ##fopname)))        \
>                         pr_debug("Unable to initialize debugfs:%s\n",   \
>                                #name);                                  \
>         } while (0)
> --
> 2.34.1

