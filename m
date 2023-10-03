Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA77B5E26
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 02:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjJCAXI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 20:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbjJCAXH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 20:23:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF52D7
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 17:22:59 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3930Mg9L21230567, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3930Mg9L21230567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 08:22:42 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 3 Oct 2023 08:22:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 3 Oct 2023 08:22:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 3 Oct 2023 08:22:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH] wifi: rtlwifi: remove unreachable code in rtl92d_dm_check_edca_turbo()
Thread-Topic: [PATCH] wifi: rtlwifi: remove unreachable code in
 rtl92d_dm_check_edca_turbo()
Thread-Index: AQHZ8rVTtTSwq0cjjEmg6oiYu7UkE7A3OXgw
Date:   Tue, 3 Oct 2023 00:22:42 +0000
Message-ID: <ce2f5b6b051748db84b8d4234d758ef7@realtek.com>
References: <20230929091229.13129-1-dmantipov@yandex.ru>
In-Reply-To: <20230929091229.13129-1-dmantipov@yandex.ru>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Friday, September 29, 2023 5:12 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; lvc-project@linuxtesting.org; Dmitry
> Antipov <dmantipov@yandex.ru>
> Subject: [PATCH] wifi: rtlwifi: remove unreachable code in rtl92d_dm_check_edca_turbo()
> 
> Since '!(0x5ea42b & 0xffff0000)' is always zero, remove unreachable

s/zero/false/ 

> block in 'rtl92d_dm_check_edca_turbo()' and convert EDCA limits to
> constant variables. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  .../wireless/realtek/rtlwifi/rtl8192de/dm.c    | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
> index 6cc9c7649eda..87798d7f5407 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
> @@ -596,28 +596,14 @@ static void rtl92d_dm_check_edca_turbo(struct ieee80211_hw *hw)
>         static u64 last_rxok_cnt;
>         u64 cur_txok_cnt;
>         u64 cur_rxok_cnt;
> -       u32 edca_be_ul = 0x5ea42b;
> -       u32 edca_be_dl = 0x5ea42b;
> +       const u32 edca_be_ul = 0x5ea42b;
> +       const u32 edca_be_dl = 0x5ea42b;

move upward to have reverse X'mas tree order. 

> 
>         if (mac->link_state != MAC80211_LINKED) {
>                 rtlpriv->dm.current_turbo_edca = false;
>                 goto exit;
>         }
> 
> -       /* Enable BEQ TxOP limit configuration in wireless G-mode. */
> -       /* To check whether we shall force turn on TXOP configuration. */
> -       if ((!rtlpriv->dm.disable_framebursting) &&
> -           (rtlpriv->sec.pairwise_enc_algorithm == WEP40_ENCRYPTION ||
> -           rtlpriv->sec.pairwise_enc_algorithm == WEP104_ENCRYPTION ||
> -           rtlpriv->sec.pairwise_enc_algorithm == TKIP_ENCRYPTION)) {
> -               /* Force TxOP limit to 0x005e for UL. */
> -               if (!(edca_be_ul & 0xffff0000))
> -                       edca_be_ul |= 0x005e0000;
> -               /* Force TxOP limit to 0x005e for DL. */
> -               if (!(edca_be_dl & 0xffff0000))
> -                       edca_be_dl |= 0x005e0000;
> -       }
> -
>         if ((!rtlpriv->dm.is_any_nonbepkts) &&
>             (!rtlpriv->dm.disable_framebursting)) {
>                 cur_txok_cnt = rtlpriv->stats.txbytesunicast - last_txok_cnt;
> --
> 2.41.0

