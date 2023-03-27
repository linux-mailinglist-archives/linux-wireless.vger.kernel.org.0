Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF1C6C994F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 03:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjC0BUY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 21:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjC0BUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 21:20:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C55242
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 18:20:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R1JuS22013608, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R1JuS22013608
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 09:19:56 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 27 Mar 2023 09:20:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 27 Mar 2023 09:20:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 09:20:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 04/14] wifi: rtl8xxxu: Add set_tim() callback
Thread-Topic: [RFC PATCH 04/14] wifi: rtl8xxxu: Add set_tim() callback
Thread-Index: AQHZXOKHYYobt9vonUag8+xa0Uo4Wa8N2rfQ
Date:   Mon, 27 Mar 2023 01:20:11 +0000
Message-ID: <b8b05063eb744bfc913198bea682905c@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-5-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-5-martin.kaistra@linutronix.de>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> Sent: Thursday, March 23, 2023 1:19 AM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [RFC PATCH 04/14] wifi: rtl8xxxu: Add set_tim() callback
> 
> Update beacon content if TIM bitmap maintained by mac80211 is changed.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 404fa6e322f58..f8380a2d51ae2 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4438,6 +4438,16 @@ int rtl8xxxu_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
>         return 0;
>  }
> 
> +static int rtl8xxxu_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
> +                           bool set)
> +{
> +       struct rtl8xxxu_priv *priv = hw->priv;
> +
> +       schedule_work(&priv->update_beacon_work);
> +
> +       return 0;
> +}
> +
>  static void rtl8xxxu_sw_scan_start(struct ieee80211_hw *hw,
>                                    struct ieee80211_vif *vif, const u8 *mac)
>  {
> @@ -7133,6 +7143,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
>         .ampdu_action = rtl8xxxu_ampdu_action,
>         .sta_statistics = rtl8xxxu_sta_statistics,
>         .get_antenna = rtl8xxxu_get_antenna,
> +       .set_tim = rtl8xxxu_set_tim,
>  };
> 
>  static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
> --
> 2.30.2

