Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CE96C996F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 03:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjC0BzC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 21:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0BzB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 21:55:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB2F4EFF
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 18:55:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R1sVixD007454, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R1sVixD007454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 09:54:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 27 Mar 2023 09:54:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Mar 2023 09:54:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 09:54:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 09/14] wifi: rtl8xxxu: Add parameter role to report_connect
Thread-Topic: [RFC PATCH 09/14] wifi: rtl8xxxu: Add parameter role to
 report_connect
Thread-Index: AQHZXOKh24QZImxVPEenlEapVWzjgq8N4teA
Date:   Mon, 27 Mar 2023 01:54:46 +0000
Message-ID: <9d985022b5224a5cb371449b69ac680a@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-10-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-10-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
> Subject: [RFC PATCH 09/14] wifi: rtl8xxxu: Add parameter role to report_connect
> 
> This allows to tell the HW if a connection is made to a STA or an AP.
> Add the implementation for the gen2 version.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      |  9 ++++++---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 ++++++-----
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index c06ad33645974..e78e0bbd23354 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1280,6 +1280,9 @@ struct rtl8xxxu_rfregs {
>  #define  H2C_JOIN_BSS_DISCONNECT       0
>  #define  H2C_JOIN_BSS_CONNECT          1
> 
> +#define H2C_ROLE_STA                   1
> +#define H2C_ROLE_AP                    2
> +
>  /*
>   * H2C (firmware) commands differ between the older generation chips
>   * 8188[cr]u, 819[12]cu, and 8723au, and the more recent chips 8723bu,
> @@ -1908,7 +1911,7 @@ struct rtl8xxxu_fileops {
>                                   u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
>                                   u8 macid);
>         void (*report_connect) (struct rtl8xxxu_priv *priv,
> -                               u8 macid, bool connect);
> +                               u8 macid, u8 role, bool connect);
>         void (*report_rssi) (struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
>         void (*fill_txdesc) (struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>                              struct ieee80211_tx_info *tx_info,
> @@ -2012,9 +2015,9 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
>  void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
>                                     u32 ramask, u8 rateid, int sgi, int txbw_40mhz, u8 macid);
>  void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
> -                                 u8 macid, bool connect);
> +                                 u8 macid, u8 role, bool connect);
>  void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
> -                                 u8 macid, bool connect);
> +                                 u8 macid, u8 role, bool connect);
>  void rtl8xxxu_gen1_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
>  void rtl8xxxu_gen2_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
>  void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv);
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 4209880d724be..5e36fddbbb488 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4524,7 +4524,7 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
>  }
> 
>  void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
> -                                 u8 macid, bool connect)
> +                                 u8 macid, u8 role, bool connect)
>  {
>         struct h2c_cmd h2c;
> 
> @@ -4541,7 +4541,7 @@ void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
>  }
> 
>  void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
> -                                 u8 macid, bool connect)
> +                                 u8 macid, u8 role, bool connect)
>  {
>         /*
>          * The firmware turns on the rate control when it knows it's
> @@ -4557,6 +4557,7 @@ void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
>         else
>                 h2c.media_status_rpt.parm &= ~BIT(0);
> 
> +       h2c.media_status_rpt.parm |= ((role << 4) & 0xf0);
>         h2c.media_status_rpt.macid = macid;
> 
>         rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
> @@ -4886,13 +4887,13 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>                         rtl8xxxu_write16(priv, REG_BCN_PSR_RPT,
>                                          0xc000 | vif->cfg.aid);
> 
> -                       priv->fops->report_connect(priv, 0, true);
> +                       priv->fops->report_connect(priv, 0, H2C_ROLE_AP, true);

Should it be called only AP mode? Because STA mode can run into this too.

>                 } else {
>                         val8 = rtl8xxxu_read8(priv, REG_BEACON_CTRL);
>                         val8 |= BEACON_DISABLE_TSF_UPDATE;
>                         rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
> 
> -                       priv->fops->report_connect(priv, 0, false);
> +                       priv->fops->report_connect(priv, 0, H2C_ROLE_AP, false);
>                 }
>         }
> 
> @@ -4953,7 +4954,7 @@ static int rtl8xxxu_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>         dev_dbg(dev, "Start AP mode\n");
>         rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid);
>         rtl8xxxu_write16(priv, REG_BCN_INTERVAL, vif->bss_conf.beacon_int);
> -       priv->fops->report_connect(priv, 0, true);
> +       priv->fops->report_connect(priv, 0, 0, true);
> 
>         return 0;
>  }
> --
> 2.30.2

