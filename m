Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3B7CECF2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 02:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjJSAvT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 20:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjJSAvS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 20:51:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1646411D
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 17:51:16 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39J0p7r052253286, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39J0p7r052253286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 08:51:07 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 19 Oct 2023 08:51:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 19 Oct 2023 08:51:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 19 Oct 2023 08:51:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/3] wifi: rtlwifi: drop fill_fake_txdesc() from HAL interface
Thread-Topic: [PATCH 2/3] wifi: rtlwifi: drop fill_fake_txdesc() from HAL
 interface
Thread-Index: AQHaADke8Ye0f2ZZLkqHErhOihkgZLBQTCww
Date:   Thu, 19 Oct 2023 00:51:07 +0000
Message-ID: <4bda4f8f29d84a128caa3bc3d820a2be@realtek.com>
References: <20231016135925.129223-1-dmantipov@yandex.ru>
 <20231016135925.129223-2-dmantipov@yandex.ru>
In-Reply-To: <20231016135925.129223-2-dmantipov@yandex.ru>
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
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Monday, October 16, 2023 9:59 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 2/3] wifi: rtlwifi: drop fill_fake_txdesc() from HAL interface
> 
> Since 'fill_fake_txdesc()' is actually implemented for rtl8192cu
> only but never used, there is no need to maintain function pointer
> in 'struct rtl_hal_ops' and 'rtl92cu_fill_fake_txdesc()' may be
> dropped. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


