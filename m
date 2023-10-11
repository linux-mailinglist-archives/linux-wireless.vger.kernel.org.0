Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F385D7C4732
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 03:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbjJKBYh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 21:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjJKBYg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 21:24:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247092
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 18:24:32 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39B1OLHp83255901, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39B1OLHp83255901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 09:24:21 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 11 Oct 2023 09:24:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 11 Oct 2023 09:24:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 11 Oct 2023 09:24:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: use convenient list_count_nodes()
Thread-Topic: [PATCH] wifi: rtlwifi: use convenient list_count_nodes()
Thread-Index: AQHZ+3pZXFo0BoARxE+CsxYJLndNNrBDy8/Q
Date:   Wed, 11 Oct 2023 01:24:21 +0000
Message-ID: <cbbd8f38e9ef4e3dba415952cf466ee8@realtek.com>
References: <20231010130353.30461-1-dmantipov@yandex.ru>
In-Reply-To: <20231010130353.30461-1-dmantipov@yandex.ru>
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
> Sent: Tuesday, October 10, 2023 9:04 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; Dmitry Antipov <dmantipov@yandex.ru>
> Subject: [PATCH] wifi: rtlwifi: use convenient list_count_nodes()
> 
> Simplify 'rtl92ee_dm_common_info_self_update()',
> 'rtl8723be_dm_common_info_self_update()', and
> 'rtl8821ae_dm_common_info_self_update()' by using
> 'list_count_nodes()'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c | 5 +----
>  drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c | 5 +----
>  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c | 4 +---
>  3 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
> index 997ff115b9ab..efd22b75c05f 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
> @@ -936,7 +936,6 @@ void rtl92ee_dm_init(struct ieee80211_hw *hw)
>  static void rtl92ee_dm_common_info_self_update(struct ieee80211_hw *hw)
>  {
>         struct rtl_priv *rtlpriv = rtl_priv(hw);
> -       struct rtl_sta_info *drv_priv;
>         u8 cnt = 0;

After 'cnt = list_count_nodes(...)', this initializer is not necessary.
As well as other two cases. 


