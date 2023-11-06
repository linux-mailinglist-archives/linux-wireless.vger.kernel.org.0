Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA47E193C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Nov 2023 04:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjKFDpE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Nov 2023 22:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjKFDpD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Nov 2023 22:45:03 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BFFF9
        for <linux-wireless@vger.kernel.org>; Sun,  5 Nov 2023 19:45:00 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A63iooY73228188, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A63iooY73228188
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 11:44:50 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 6 Nov 2023 11:44:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 6 Nov 2023 11:44:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 6 Nov 2023 11:44:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH 2/2] wifi: rtlwifi: simplify _rtl8812ae_phy_get_txpower_limit()
Thread-Topic: [PATCH 2/2] wifi: rtlwifi: simplify
 _rtl8812ae_phy_get_txpower_limit()
Thread-Index: AQHaDLfhFsCt0hys00yQX+j8v0xH3rBsq7dQ
Date:   Mon, 6 Nov 2023 03:44:50 +0000
Message-ID: <1c93129fac184534901eca45b563cf44@realtek.com>
References: <20231101113510.51290-1-dmantipov@yandex.ru>
 <20231101113510.51290-2-dmantipov@yandex.ru>
In-Reply-To: <20231101113510.51290-2-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
> Subject: [PATCH 2/2] wifi: rtlwifi: simplify _rtl8812ae_phy_get_txpower_limit()
> 
> Since 'regulation' is a compile-time constant equal to
> 'TXPWR_LMT_WW', mark it as such and simplify few branches
> in '_rtl8812ae_phy_get_txpower_limit()'. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  .../wireless/realtek/rtlwifi/rtl8821ae/phy.c  | 24 +++++++------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> index c262770fea29..27e256a82f00 100644

[...]

> @@ -2415,10 +2413,7 @@ static s8 _rtl8812ae_phy_get_txpower_limit(struct ieee80211_hw *hw,
>                         limits[i] = rtlphy->txpwr_limit_2_4g[i][bdwidth]
>                         [sec][chnl][rf_path];
> 
> -               power_limit = (regulation == TXPWR_LMT_WW) ?
> -                       _rtl8812ae_phy_get_world_wide_limit(limits) :
> -                       rtlphy->txpwr_limit_2_4g[regu][bdwidth]
> -                                       [sec][chnl][rf_path];
> +               power_limit = _rtl8812ae_phy_get_world_wide_limit(limits);

I think the constantly selection of "WW" is just a workaround, and correct
way is to add regd notifier and handle regulatory request.

Ping-Ke 

