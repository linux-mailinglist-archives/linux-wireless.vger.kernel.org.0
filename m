Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEF06C994E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 03:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC0BTx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 21:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjC0BTw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 21:19:52 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B295242
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 18:19:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R1JMUq8012799, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R1JMUq8012799
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 09:19:22 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 09:19:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Mar 2023 09:19:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 09:19:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 03/14] wifi: rtl8xxxu: Add beacon functions
Thread-Topic: [RFC PATCH 03/14] wifi: rtl8xxxu: Add beacon functions
Thread-Index: AQHZXOKIdpQbzVWDYkCL/ifTBFPwOK8N0vZA
Date:   Mon, 27 Mar 2023 01:19:38 +0000
Message-ID: <40f429331a2c4fc980789f88a3195b70@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-4-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-4-martin.kaistra@linutronix.de>
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
> Subject: [RFC PATCH 03/14] wifi: rtl8xxxu: Add beacon functions
> 
> Add a workqueue to update the beacon contents asynchronously and
> implement downloading the beacon to the HW and starting beacon tx like
> the vendor driver.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 +
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 81 +++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index 9d48c69ffece1..cac985271628c 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1744,6 +1744,8 @@ struct rtl8xxxu_priv {
>         bool shutdown;
>         struct work_struct rx_urb_wq;
> 
> +       bool beacon_enabled;
> +
>         u8 mac_addr[ETH_ALEN];
>         char chip_name[8];
>         char chip_vendor[8];
> @@ -1850,6 +1852,7 @@ struct rtl8xxxu_priv {
>         struct delayed_work ra_watchdog;
>         struct work_struct c2hcmd_work;
>         struct sk_buff_head c2hcmd_queue;
> +       struct work_struct update_beacon_work;
>         struct rtl8xxxu_btcoex bt_coex;
>         struct rtl8xxxu_ra_report ra_report;
>         struct rtl8xxxu_cfo_tracking cfo_tracking;
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index daeaa7d6864f9..404fa6e322f58 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -1104,6 +1104,24 @@ static void rtl8xxxu_stop_tx_beacon(struct rtl8xxxu_priv *priv)
>         val8 = rtl8xxxu_read8(priv, REG_TBTT_PROHIBIT + 2);
>         val8 &= ~BIT(0);
>         rtl8xxxu_write8(priv, REG_TBTT_PROHIBIT + 2, val8);
> +
> +       priv->beacon_enabled = false;
> +}
> +
> +static void rtl8xxxu_start_tx_beacon(struct rtl8xxxu_priv *priv)
> +{
> +       u8 val8;
> +
> +       val8 = rtl8xxxu_read8(priv, REG_FWHW_TXQ_CTRL + 2);
> +       val8 |= BIT(6);

#define EN_BCNQ_DL BIT(22)

val8 |= EN_BCNQ_DL >> 16;

> +       rtl8xxxu_write8(priv, REG_FWHW_TXQ_CTRL + 2, val8);
> +
> +       rtl8xxxu_write8(priv, REG_TBTT_PROHIBIT + 1, 0x80);
> +       val8 = rtl8xxxu_read8(priv, REG_TBTT_PROHIBIT + 2);
> +       val8 &= 0xF0;
> +       rtl8xxxu_write8(priv, REG_TBTT_PROHIBIT + 2, val8);
> +
> +       priv->beacon_enabled = true;
>  }
> 
> 
> @@ -4895,6 +4913,17 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>                 dev_dbg(dev, "Changed BASIC_RATES!\n");
>                 rtl8xxxu_set_basic_rates(priv, bss_conf->basic_rates);
>         }
> +
> +       if (changed & BSS_CHANGED_BEACON ||
> +           (changed & BSS_CHANGED_BEACON_ENABLED &&
> +            bss_conf->enable_beacon)) {
> +               if (!priv->beacon_enabled) {
> +                       dev_dbg(dev, "BSS_CHANGED_BEACON_ENABLED\n");
> +                       rtl8xxxu_start_tx_beacon(priv);
> +                       schedule_work(&priv->update_beacon_work);
> +               }
> +       }
> +
>  error:
>         return;
>  }
> @@ -5476,6 +5505,57 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>         dev_kfree_skb(skb);
>  }
> 
> +static void rtl8xxxu_send_beacon_frame(struct ieee80211_hw *hw,
> +                                      struct ieee80211_vif *vif)
> +{
> +       struct rtl8xxxu_priv *priv = hw->priv;
> +       struct sk_buff *skb = ieee80211_beacon_get(hw, vif, 0);
> +       struct device *dev = &priv->udev->dev;
> +       int retry;
> +       u8 val8;
> +
> +       /* BCN_VALID, BIT16 of REG_TDECTRL = BIT0 of REG_TDECTRL+2,
> +        * write 1 to clear, cleared by SW.
> +        */
> +       val8 = rtl8xxxu_read8(priv, REG_TDECTRL + 2);
> +       val8 |= BIT(0);

#define BIT_BCN_VALID BIT(16)
val8 |= BIT_BCN_VALID >> 16;

> +       rtl8xxxu_write8(priv, REG_TDECTRL + 2, val8);
> +
> +       /* SW_BCN_SEL - Port0 */
> +       val8 = rtl8xxxu_read8(priv, REG_DWBCN1_CTRL_8723B + 2);
> +       val8 &= ~BIT(4);

#define BIT_SW_BCN_SEL BIT(20)
val8 &= ~(BIT_SW_BCN_SEL >> 20);

> +       rtl8xxxu_write8(priv, REG_DWBCN1_CTRL_8723B + 2, val8);
> +
> +       if (skb)
> +               rtl8xxxu_tx(hw, NULL, skb);
> +
> +       retry = 100;
> +       do {
> +               val8 = rtl8xxxu_read8(priv, REG_TDECTRL + 2);
> +               if (val8 & BIT(0))

#define BIT_BCN_VALID BIT(16)

if (val8 & (BIT_BCN_VALID >> 16)

> +                       break;
> +               usleep_range(10, 20);
> +       } while (retry--);
> +
> +       if (!retry)
> +               dev_err(dev, "%s: Failed to read beacon valid bit\n", __func__);
> +}
> +
> +static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
> +{
> +       struct rtl8xxxu_priv *priv =
> +               container_of(work, struct rtl8xxxu_priv, update_beacon_work);
> +       struct ieee80211_hw *hw = priv->hw;
> +       struct ieee80211_vif *vif = priv->vif;
> +
> +       if (!vif) {
> +               WARN_ONCE(true, "no vif to update beacon\n");
> +               return;
> +       }
> +
> +       rtl8xxxu_send_beacon_frame(hw, vif);
> +}
> +
>  void rtl8723au_rx_parse_phystats(struct rtl8xxxu_priv *priv,
>                                  struct ieee80211_rx_status *rx_status,
>                                  struct rtl8723au_phy_stats *phy_stats,
> @@ -7244,6 +7324,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>         spin_lock_init(&priv->rx_urb_lock);
>         INIT_WORK(&priv->rx_urb_wq, rtl8xxxu_rx_urb_work);
>         INIT_DELAYED_WORK(&priv->ra_watchdog, rtl8xxxu_watchdog_callback);
> +       INIT_WORK(&priv->update_beacon_work, rtl8xxxu_update_beacon_work_callback);
>         skb_queue_head_init(&priv->c2hcmd_queue);
> 
>         usb_set_intfdata(interface, hw);
> --
> 2.30.2

