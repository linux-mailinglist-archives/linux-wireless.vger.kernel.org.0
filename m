Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88F46C9960
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 03:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjC0BkN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 21:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjC0BkM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 21:40:12 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1174693
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 18:40:09 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R1dedQ7023897, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R1dedQ7023897
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 09:39:40 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 09:39:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Mar 2023 09:39:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 09:39:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 06/14] wifi: rtl8xxxu: Allow creating interface in AP mode
Thread-Topic: [RFC PATCH 06/14] wifi: rtl8xxxu: Allow creating interface in AP
 mode
Thread-Index: AQHZXOKhcfUYC5p0+U2YPZCNOghPE68N2yIA
Date:   Mon, 27 Mar 2023 01:39:56 +0000
Message-ID: <f7ee22097962476da7f8e8cdbf040712@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-7-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-7-martin.kaistra@linutronix.de>
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
> Subject: [RFC PATCH 06/14] wifi: rtl8xxxu: Allow creating interface in AP mode
> 
> Use the sequence from the vendor driver for setting up the beacon
> related registers.
> Also set the MAC address register.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 31 ++++++++++++++++---
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  2 ++
>  2 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index b233c66a7a5a8..b20ff8bc40870 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -6408,18 +6408,39 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>         int ret;
>         u8 val8;
> 
> +       if (!priv->vif)
> +               priv->vif = vif;
> +       else
> +               return -EOPNOTSUPP;
> +
>         switch (vif->type) {
>         case NL80211_IFTYPE_STATION:
> -               if (!priv->vif)
> -                       priv->vif = vif;
> -               else
> -                       return -EOPNOTSUPP;
>                 rtl8xxxu_stop_tx_beacon(priv);
> 
>                 val8 = rtl8xxxu_read8(priv, REG_BEACON_CTRL);
>                 val8 |= BEACON_ATIM | BEACON_FUNCTION_ENABLE |
>                         BEACON_DISABLE_TSF_UPDATE;
>                 rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
> +               ret = 0;
> +               break;
> +       case NL80211_IFTYPE_AP:
> +               rtl8xxxu_write8(priv, REG_BEACON_CTRL,
> +                               BEACON_DISABLE_TSF_UPDATE | BEACON_CTRL_MBSSID);
> +               rtl8xxxu_write8(priv, REG_ATIMWND, 0x0c); /* 12ms */
> +               rtl8xxxu_write16(priv, REG_TSFTR_SYN_OFFSET, 0x7fff); /* ~32ms */
> +               rtl8xxxu_write8(priv, REG_DUAL_TSF_RST, DUAL_TSF_RESET_TSF0);
> +
> +               /* enable BCN0 function */
> +               rtl8xxxu_write8(priv, REG_BEACON_CTRL,
> +                               BEACON_DISABLE_TSF_UPDATE |
> +                               BEACON_FUNCTION_ENABLE | BEACON_CTRL_MBSSID |
> +                               BEACON_CTRL_TX_BEACON_RPT);
> +
> +               /* select BCN on port 0 */
> +               val8 = rtl8xxxu_read8(priv, REG_CCK_CHECK);
> +               val8 &= ~BIT_BCN_PORT_SEL;
> +               rtl8xxxu_write8(priv, REG_CCK_CHECK, val8);
> +
>                 ret = 0;
>                 break;
>         default:
> @@ -6427,6 +6448,8 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>         }
> 
>         rtl8xxxu_set_linktype(priv, vif->type);
> +       ether_addr_copy(priv->mac_addr, vif->addr);
> +       rtl8xxxu_set_mac(priv);

rtl8xxxu_set_mac() is already called by rtl8xxxu_init_device(). Is there
anything unexpected? 

While I reviewed first patch, I would like to suggest to call calibration:
  fops->phy_lc_calibrate(priv);
  fops->phy_iq_calibrate(priv);
I traced rtl8xxxu and saw they present in rtl8xxxu_init_device() and rtl8xxxu
doesn't implement idle power saving to turn off power of wifi card. Then, I
think the calibration will be fine if rtl8xxxu only does it once.

So, I would like to know if something I miss.

> 
>         return ret;
>  }
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
> index 4dffbab494c3b..83e7f8fd82c0a 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
> @@ -572,6 +572,8 @@
>  #define REG_ARFR1                      0x0448
>  #define REG_ARFR2                      0x044c
>  #define REG_ARFR3                      0x0450
> +#define REG_CCK_CHECK                  0x0454
> +#define BIT_BCN_PORT_SEL               BIT(5)
>  #define REG_AMPDU_MAX_TIME_8723B       0x0456
>  #define REG_AGGLEN_LMT                 0x0458
>  #define REG_AMPDU_MIN_SPACE            0x045c
> --
> 2.30.2

