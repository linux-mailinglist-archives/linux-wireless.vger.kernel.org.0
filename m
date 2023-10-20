Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA387D07E2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 07:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346936AbjJTFyb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 01:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjJTFy3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 01:54:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B8ACA
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 22:54:27 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39K5sGxaD3838771, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39K5sGxaD3838771
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 13:54:16 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 20 Oct 2023 13:54:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 20 Oct 2023 13:54:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 20 Oct 2023 13:54:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Tom Rix <trix@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] [v2] wifi: rtw89: cleanup firmware elements parsing
Thread-Topic: [PATCH] [v2] wifi: rtw89: cleanup firmware elements parsing
Thread-Index: AQHaAwuJwJleqZFKiUy1cRrrMiPrQ7BSK6sw
Date:   Fri, 20 Oct 2023 05:54:15 +0000
Message-ID: <03284f2e74444d5ebf103dfe46bf5657@realtek.com>
References: <661e7dffafdb403abc2c4cab23c7d1ed@realtek.com>
 <20231020040940.33154-1-dmantipov@yandex.ru>
In-Reply-To: <20231020040940.33154-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.71.113]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
> Sent: Friday, October 20, 2023 12:10 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Tom Rix <trix@redhat.com>; Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry
> Antipov <dmantipov@yandex.ru>
> Subject: [PATCH] [v2] wifi: rtw89: cleanup firmware elements parsing
> 
> When compiling with clang-18, I've noticed the following:
> 
> drivers/net/wireless/realtek/rtw89/fw.c:389:28: warning: cast to smaller
> integer type 'enum rtw89_fw_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>   389 |         enum rtw89_fw_type type = (enum rtw89_fw_type)data;
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/fw.c:569:13: warning: cast to smaller
> integer type 'enum rtw89_rf_path' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>   569 |                 rf_path = (enum rtw89_rf_path)data;
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> So avoid brutal everything-to-const-void-and-back casts, introduce
> 'union rtw89_fw_element_arg' to pass parameters to element handler
> callbacks, and adjust all of the related bits accordingly. Compile
> tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

I take this patch locally, and performance looks as regular. Thanks.

Acked-and-tested-by: Ping-Ke Shih <pkshih@realtek.com>


