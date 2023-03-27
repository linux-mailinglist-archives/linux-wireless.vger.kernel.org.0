Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15156C9964
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 03:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjC0Bs0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 21:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC0BsZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 21:48:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A37270D
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 18:48:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R1lql77032229, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R1lql77032229
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 09:47:52 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 09:48:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Mar 2023 09:48:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 09:48:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
Thread-Topic: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to
 update_rate_mask
Thread-Index: AQHZXOKii0d8HuoRPkCJFbimooDKPK8N4b3g
Date:   Mon, 27 Mar 2023 01:48:06 +0000
Message-ID: <b48af4c2e9ef4555997b4a6388fdd270@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-8-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-8-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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
> Subject: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
> 
> The HW maintains a rate_mask for each connection, referenced by the
> macid. Add a parameter to update_rate_mask and add the macid to the
> h2c call in the gen2 implementation.
> 
> Also extend refresh_rate_mask to generate the macid in AP mode from
> sta->aid.

Firmware can support 32 mac_id (station instance) at most, so it will be a
problem if hostapd assigns aid more than 32. Though I'm not clear how
hostpad assigns the aid, it would be always safe that rtl8xxxu maintains
mac_id by a bitmap in driver.

> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h    |  7 ++++---
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c  |  3 ++-
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c   | 17 +++++++++++++----
>  3 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index cac985271628c..c06ad33645974 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1905,7 +1905,8 @@ struct rtl8xxxu_fileops {
>         void (*set_tx_power) (struct rtl8xxxu_priv *priv, int channel,
>                               bool ht40);
>         void (*update_rate_mask) (struct rtl8xxxu_priv *priv,
> -                                 u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
> +                                 u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
> +                                 u8 macid);
>         void (*report_connect) (struct rtl8xxxu_priv *priv,
>                                 u8 macid, bool connect);
>         void (*report_rssi) (struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
> @@ -2007,9 +2008,9 @@ void rtl8xxxu_gen2_config_channel(struct ieee80211_hw *hw);
>  void rtl8xxxu_gen1_usb_quirks(struct rtl8xxxu_priv *priv);
>  void rtl8xxxu_gen2_usb_quirks(struct rtl8xxxu_priv *priv);
>  void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
> -                              u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
> +                              u32 ramask, u8 rateid, int sgi, int txbw_40mhz, u8 macid);
>  void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
> -                                   u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
> +                                   u32 ramask, u8 rateid, int sgi, int txbw_40mhz, u8 macid);
>  void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
>                                   u8 macid, bool connect);
>  void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> index 6a82ec47568ee..c3dc5130c9f37 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> @@ -1798,7 +1798,8 @@ static void rtl8188e_arfb_refresh(struct rtl8xxxu_ra_info *ra)
> 
>  static void
>  rtl8188e_update_rate_mask(struct rtl8xxxu_priv *priv,
> -                         u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
> +                         u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
> +                         u8 macid)
>  {
>         struct rtl8xxxu_ra_info *ra = &priv->ra_info;
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index b20ff8bc40870..b5cb15e472f1c 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4471,7 +4471,8 @@ static void rtl8xxxu_sw_scan_complete(struct ieee80211_hw *hw,
>  }
> 
>  void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
> -                              u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
> +                              u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
> +                              u8 macid)
>  {
>         struct h2c_cmd h2c;
> 
> @@ -4491,7 +4492,8 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
>  }
> 
>  void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
> -                                   u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
> +                                   u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
> +                                   u8 macid)
>  {
>         struct h2c_cmd h2c;
>         u8 bw;
> @@ -4508,6 +4510,7 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
>         h2c.b_macid_cfg.ramask1 = (ramask >> 8) & 0xff;
>         h2c.b_macid_cfg.ramask2 = (ramask >> 16) & 0xff;
>         h2c.b_macid_cfg.ramask3 = (ramask >> 24) & 0xff;
> +       h2c.b_macid_cfg.macid = macid;
> 
>         h2c.b_macid_cfg.data1 = rateid;
>         if (sgi)
> @@ -4870,7 +4873,8 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>                         priv->vif = vif;
>                         priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
> 
> -                       priv->fops->update_rate_mask(priv, ramask, 0, sgi, bw == RATE_INFO_BW_40);
> +                       priv->fops->update_rate_mask(priv, ramask, 0, sgi,
> +                                                    bw == RATE_INFO_BW_40, 0);
> 
>                         rtl8xxxu_write8(priv, REG_BCN_MAX_ERR, 0xff);
> 
> @@ -6772,6 +6776,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
>         u8 txbw_40mhz;
>         u8 snr, snr_thresh_high, snr_thresh_low;
>         u8 go_up_gap = 5;
> +       u8 macid = 0;
> 
>         rssi_level = priv->rssi_level;
>         snr = rtl8xxxu_signal_to_snr(signal);
> @@ -6891,7 +6896,11 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
>                 }
> 
>                 priv->rssi_level = rssi_level;
> -               priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi, txbw_40mhz);
> +
> +               if (priv->vif->type == NL80211_IFTYPE_AP)
> +                       macid = sta->aid + 1;

We should reserve a special mac_id for broadcast packets, because rate adaptive 
algorithm in firmware also uses mac_id as instance ID of rate selection.

> +
> +               priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi, txbw_40mhz, macid);
>         }
>  }
> 
> --
> 2.30.2

