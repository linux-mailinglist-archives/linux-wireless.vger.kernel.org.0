Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9846C9970
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 03:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjC0B4s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 21:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0B4r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 21:56:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48C049EE
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 18:56:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R1uJdwD012036, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R1uJdwD012036
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 09:56:19 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 09:56:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Mar 2023 09:56:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 09:56:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 10/14] wifi: rtl8xxxu: Add sta_add() callback
Thread-Topic: [RFC PATCH 10/14] wifi: rtl8xxxu: Add sta_add() callback
Thread-Index: AQHZXOKklylqoHQC2UaKQtUi5RrUs68N5Iuw
Date:   Mon, 27 Mar 2023 01:56:35 +0000
Message-ID: <866d047d719342d5a50abb5dfd4462c7@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-11-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-11-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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
> Subject: [RFC PATCH 10/14] wifi: rtl8xxxu: Add sta_add() callback
> 
> This function gets called in AP mode, when a new STA gets associated to
> us. Call rtl8xxxu_refresh_rate_mask() to set a rate mask for the newly
> connected STA (referenced by the macid) and then send a media connnect
> report.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 5e36fddbbb488..d74a3c6452507 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -7159,6 +7159,19 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
>         rtl8xxxu_free_tx_resources(priv);
>  }
> 
> +static int rtl8xxxu_sta_add(struct ieee80211_hw *hw,
> +                           struct ieee80211_vif *vif,
> +                           struct ieee80211_sta *sta)
> +{
> +       struct rtl8xxxu_priv *priv = hw->priv;
> +
> +       if (sta) {
> +               rtl8xxxu_refresh_rate_mask(priv, 0, sta);
> +               priv->fops->report_connect(priv, sta->aid + 1, H2C_ROLE_STA, true);
> +       }
> +       return 0;
> +}
> +
>  static const struct ieee80211_ops rtl8xxxu_ops = {
>         .tx = rtl8xxxu_tx,
>         .wake_tx_queue = ieee80211_handle_wake_tx_queue,
> @@ -7179,6 +7192,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
>         .sta_statistics = rtl8xxxu_sta_statistics,
>         .get_antenna = rtl8xxxu_get_antenna,
>         .set_tim = rtl8xxxu_set_tim,
> +       .sta_add = rtl8xxxu_sta_add,
>  };
> 
>  static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
> --
> 2.30.2

