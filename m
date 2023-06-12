Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6397872B4FE
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 02:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjFLAiv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jun 2023 20:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFLAiu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jun 2023 20:38:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F4D135
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jun 2023 17:38:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35C0cOAU1005175, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35C0cOAU1005175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 12 Jun 2023 08:38:24 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 12 Jun 2023 08:38:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Jun 2023 08:38:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 12 Jun 2023 08:38:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kevin Lo <kevlo@kevlo.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: use the correct bit in the R_AX_PLE_INI_STATUS register
Thread-Topic: [PATCH] wifi: rtw89: use the correct bit in the
 R_AX_PLE_INI_STATUS register
Thread-Index: AQHZmqVjsIXsIWMjREWpyKsynom8xq+GVpMg
Date:   Mon, 12 Jun 2023 00:38:41 +0000
Message-ID: <b630340d34224c2a8d66ccb344f060ad@realtek.com>
References: <ZILW8Uct7yUjsVyh@ns.kevlo.org>
In-Reply-To: <ZILW8Uct7yUjsVyh@ns.kevlo.org>
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
> From: Kevin Lo <kevlo@kevlo.org>
> Sent: Friday, June 9, 2023 3:38 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: [PATCH] wifi: rtw89: use the correct bit in the R_AX_PLE_INI_STATUS register
> 
> Use the PLE_MGN_INI_RDY bit rather than WDE_MGN_INI_RDY to check if
> PLE cfg ready runs into a timeout.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index 512de491a064..4e0cec7c59a2 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -1814,7 +1814,7 @@ static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
>         }
> 
>         ret = read_poll_timeout(rtw89_read32, ini,
> -                               (ini & WDE_MGN_INI_RDY) == WDE_MGN_INI_RDY, 1,
> +                               (ini & PLE_MGN_INI_RDY) == PLE_MGN_INI_RDY, 1,

Luckily, definitions of WDE_MGN_INI_RDY and PLE_MGN_INI_RDY are the same, so
I don't really need to verify it.

>                                 2000, false, rtwdev, R_AX_PLE_INI_STATUS);
>         if (ret) {
>                 rtw89_err(rtwdev, "[ERR]PLE cfg ready\n");
> 
> 
> ------Please consider the environment before printing this e-mail.
