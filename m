Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB379727984
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjFHIDz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 04:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjFHIDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 04:03:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0115826AC
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 01:03:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35883OnN4003109, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35883OnN4003109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 16:03:24 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 8 Jun 2023 16:03:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Jun 2023 16:03:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 16:03:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] [v2] wifi: rtw89: cleanup rtw89_iqk_info and related code
Thread-Topic: [PATCH] [v2] wifi: rtw89: cleanup rtw89_iqk_info and related
 code
Thread-Index: AQHZmd1s7Q37jDBH0UmGQP1o8pzLu6+AioXQ
Date:   Thu, 8 Jun 2023 08:03:39 +0000
Message-ID: <08111dd79ab3457f8cdd569cd725ad22@realtek.com>
References: <20230606140806.606352-2-dmantipov@yandex.ru>
 <20230608074525.29568-1-dmantipov@yandex.ru>
In-Reply-To: <20230608074525.29568-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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
> Sent: Thursday, June 8, 2023 3:45 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH] [v2] wifi: rtw89: cleanup rtw89_iqk_info and related code
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
> v2: integer format specifier quirks (Ping-Ke Shih)

Please resend whole patchset by v3. Only sending patch 1/2 like this would be
hard to maintainers to choose patches. 


