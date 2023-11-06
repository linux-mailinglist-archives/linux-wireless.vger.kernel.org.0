Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230E37E1934
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Nov 2023 04:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjKFDhv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Nov 2023 22:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFDhu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Nov 2023 22:37:50 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA862BD
        for <linux-wireless@vger.kernel.org>; Sun,  5 Nov 2023 19:37:45 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A63bOAW13221444, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A63bOAW13221444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 11:37:24 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 6 Nov 2023 11:37:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 6 Nov 2023 11:37:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 6 Nov 2023 11:37:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH 1/2] wifi: rtlwifi: remove dead code in phy_get_tx_swing_8812A()
Thread-Topic: [PATCH 1/2] wifi: rtlwifi: remove dead code in
 phy_get_tx_swing_8812A()
Thread-Index: AQHaDLfFpHEzB8qQI02jXCHfGystsrBsqVeg
Date:   Mon, 6 Nov 2023 03:37:21 +0000
Message-ID: <e6ae1e6e46d74b3092b28bd17acbefd3@realtek.com>
References: <20231101113510.51290-1-dmantipov@yandex.ru>
In-Reply-To: <20231101113510.51290-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antivirus-attachment-filter-interceptor-info: license violation
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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
> Sent: Wednesday, November 1, 2023 7:35 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; lvc-project@linuxtesting.org; Dmitry
> Antipov <dmantipov@yandex.ru>
> Subject: [PATCH 1/2] wifi: rtlwifi: remove dead code in phy_get_tx_swing_8812A()
> 
> Since 'reg_swing_2g', 'swing_2g', 'reg_swing_5g', and 'swing_5g'
> are compile-time constants, mark all of them as such and remove
> never executed blocks in 'phy_get_tx_swing_8812A()'. Minor style
> adjustments, compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  .../wireless/realtek/rtlwifi/rtl8821ae/phy.c  | 77 ++++---------------
>  1 file changed, 16 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> index 5323ead30db0..c262770fea29 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> @@ -437,12 +437,11 @@ u32 phy_get_tx_swing_8812A(struct ieee80211_hw *hw, u8    band,
>         struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
>         struct rtl_dm *rtldm = rtl_dm(rtlpriv);
>         struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
> -       s8 reg_swing_2g = -1;/* 0xff; */
> -       s8 reg_swing_5g = -1;/* 0xff; */
> -       s8 swing_2g = -1 * reg_swing_2g;
> -       s8 swing_5g = -1 * reg_swing_5g;
> -       u32  out = 0x200;
> -       const s8 auto_temp = -1;
> +       const s8 reg_swing_2g = -1; /* 0xff; */
> +       const s8 reg_swing_5g = -1; /* 0xff; */

Looks like these two can be removed, but I don't really understand what it
wants originally.

> +       const s8 swing_2g = -1 * reg_swing_2g;
> +       const s8 swing_5g = -1 * reg_swing_5g;
> +       u32 out = 0x200;
> 
>         rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
>                 "===> PHY_GetTXBBSwing_8812A, bbSwing_2G: %d, bbSwing_5G: %d,autoload_failflag=%d.\n",
> @@ -452,36 +451,16 @@ u32 phy_get_tx_swing_8812A(struct ieee80211_hw *hw, u8    band,
>         if (rtlefuse->autoload_failflag) {
>                 if (band == BAND_ON_2_4G) {
>                         rtldm->swing_diff_2g = swing_2g;
> -                       if (swing_2g == 0) {
> -                               out = 0x200; /* 0 dB */
> -                       } else if (swing_2g == -3) {
> -                               out = 0x16A; /* -3 dB */
> -                       } else if (swing_2g == -6) {
> -                               out = 0x101; /* -6 dB */
> -                       } else if (swing_2g == -9) {
> -                               out = 0x0B6; /* -9 dB */
> -                       } else {
> -                               rtldm->swing_diff_2g = 0;
> -                               out = 0x200;
> -                       }
> +                       rtldm->swing_diff_2g = 0;
> +                       out = 0x200;

This branch becomes duplicate assignments of swing_diff_2g. 
    rtldm->swing_diff_2g = swing_2g;
    rtldm->swing_diff_2g = 0;
    out = 0x200;

The original branch chunk might be debug purpose, so maybe add a debugfs entry as
the input of 'swing_2g'. Or, that is used by some boards that don't programmed efuse
but read 'swing_2g' from external file.


It is hard to me to decide if we should take this cleanup.

Ping-Ke


