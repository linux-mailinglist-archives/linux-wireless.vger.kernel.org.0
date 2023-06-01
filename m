Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC6671956D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFAIXd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjFAIXc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 04:23:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC82C9F
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 01:23:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3518N8meC021670, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3518N8meC021670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 1 Jun 2023 16:23:08 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 1 Jun 2023 16:23:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 1 Jun 2023 16:23:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 1 Jun 2023 16:23:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] [v3] wifi: rtlwifi: remove unused timer and related code
Thread-Topic: [PATCH] [v3] wifi: rtlwifi: remove unused timer and related code
Thread-Index: AQHZlGGXyVzacUwTC0CodhPhiDe4jK91mrrg
Date:   Thu, 1 Jun 2023 08:23:21 +0000
Message-ID: <afaf8b2cb4fe4c4688620e126d26edbb@realtek.com>
References: <6c9982b9f48e41c4ba4f3528cb5489fd@realtek.com>
 <20230601081715.44739-1-dmantipov@yandex.ru>
In-Reply-To: <20230601081715.44739-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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
> Sent: Thursday, June 1, 2023 4:17 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH] [v3] wifi: rtlwifi: remove unused timer and related code
> 
> Drop unused 'dualmac_easyconcurrent_retrytimer' of 'struct rtl_works',
> corresponding 'rtl_easy_concurrent_retrytimer_callback()' handler,
> 'dualmac_easy_concurrent' function pointer of 'struct rtl_hal_ops'
> and related call to 'timer_setup()' in '_rtl_init_deferred_work()'.
> 
> [v2] fix title (Ping-Ke Shih)
> 
> [v3] make Signed-off-by: to match From: (Kalle Vallo)
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

move changelog here starting with '---' that will be discarded when getting merged.

---
v3: make Signed-off-by: to match From: (Kalle Vallo)
v2: fix title (Ping-Ke Shih)

> ---
>  drivers/net/wireless/realtek/rtlwifi/base.c | 16 +---------------
>  drivers/net/wireless/realtek/rtlwifi/base.h |  1 -
>  drivers/net/wireless/realtek/rtlwifi/wifi.h |  2 --
>  3 files changed, 1 insertion(+), 18 deletions(-)
> 

[...]

