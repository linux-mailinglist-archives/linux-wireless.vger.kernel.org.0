Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00196C9974
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 03:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjC0B66 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 21:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0B65 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 21:58:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A5F4ED0
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 18:58:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R1wMD61013211, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R1wMD61013211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 09:58:22 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 09:58:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Mar 2023 09:58:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 09:58:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 11/14] wifi: rtl8xxxu: Put the macid in txdesc
Thread-Topic: [RFC PATCH 11/14] wifi: rtl8xxxu: Put the macid in txdesc
Thread-Index: AQHZXOKkiBkaeqDC/UeUJFWMnJoHTq8N5P2w
Date:   Mon, 27 Mar 2023 01:58:38 +0000
Message-ID: <2f1e974f9fce49f9a23fbe64d999773c@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-12-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-12-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
> Subject: [RFC PATCH 11/14] wifi: rtl8xxxu: Put the macid in txdesc
> 
> Add a parameter macid to fill_txdesc(), implement setting it for the
> gen2 version.
> This is used to tell the HW who the recipient of the packet is, so that
> the appropriate data rate can be selected.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h |  8 ++++----
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 16 ++++++++++++----
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index e78e0bbd23354..20304b0bd68a3 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1917,7 +1917,7 @@ struct rtl8xxxu_fileops {
>                              struct ieee80211_tx_info *tx_info,
>                              struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
>                              bool short_preamble, bool ampdu_enable,
> -                            u32 rts_rate);
> +                            u32 rts_rate, u8 macid);
>         void (*set_crystal_cap) (struct rtl8xxxu_priv *priv, u8 crystal_cap);
>         s8 (*cck_rssi) (struct rtl8xxxu_priv *priv, struct rtl8723au_phy_stats *phy_stats);
>         int (*led_classdev_brightness_set) (struct led_classdev *led_cdev,
> @@ -2046,17 +2046,17 @@ void rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>                              struct ieee80211_tx_info *tx_info,
>                              struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
>                              bool short_preamble, bool ampdu_enable,
> -                            u32 rts_rate);
> +                            u32 rts_rate, u8 macid);
>  void rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>                              struct ieee80211_tx_info *tx_info,
>                              struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
>                              bool short_preamble, bool ampdu_enable,
> -                            u32 rts_rate);
> +                            u32 rts_rate, u8 macid);
>  void rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>                              struct ieee80211_tx_info *tx_info,
>                              struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
>                              bool short_preamble, bool ampdu_enable,
> -                            u32 rts_rate);
> +                            u32 rts_rate, u8 macid);
>  void rtl8723bu_set_ps_tdma(struct rtl8xxxu_priv *priv,
>                            u8 arg1, u8 arg2, u8 arg3, u8 arg4, u8 arg5);
>  void rtl8723bu_phy_init_antenna_selection(struct rtl8xxxu_priv *priv);
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index d74a3c6452507..c232de1d47173 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -5152,7 +5152,8 @@ void
>  rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>                         struct ieee80211_tx_info *tx_info,
>                         struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
> -                       bool short_preamble, bool ampdu_enable, u32 rts_rate)
> +                       bool short_preamble, bool ampdu_enable, u32 rts_rate,
> +                       u8 macid)
>  {
>         struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
>         struct rtl8xxxu_priv *priv = hw->priv;
> @@ -5224,7 +5225,8 @@ void
>  rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>                         struct ieee80211_tx_info *tx_info,
>                         struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
> -                       bool short_preamble, bool ampdu_enable, u32 rts_rate)
> +                       bool short_preamble, bool ampdu_enable, u32 rts_rate,
> +                       u8 macid)
>  {
>         struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
>         struct rtl8xxxu_priv *priv = hw->priv;
> @@ -5248,6 +5250,8 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>                 dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
>                          __func__, rate, le16_to_cpu(tx_desc40->pkt_size));
> 
> +       tx_desc40->txdw1 |= cpu_to_le32(macid << TXDESC40_MACID_SHIFT);
> +
>         seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
> 
>         tx_desc40->txdw4 = cpu_to_le32(rate);
> @@ -5299,7 +5303,8 @@ void
>  rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>                         struct ieee80211_tx_info *tx_info,
>                         struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
> -                       bool short_preamble, bool ampdu_enable, u32 rts_rate)
> +                       bool short_preamble, bool ampdu_enable, u32 rts_rate,
> +                       u8 macid)
>  {
>         struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
>         struct rtl8xxxu_priv *priv = hw->priv;
> @@ -5398,6 +5403,7 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>         u16 pktlen = skb->len;
>         u16 rate_flag = tx_info->control.rates[0].flags;
>         int tx_desc_size = priv->fops->tx_desc_size;
> +       u8 macid = 0;
>         int ret;
>         bool ampdu_enable, sgi = false, short_preamble = false;
> 
> @@ -5497,9 +5503,11 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>         else
>                 rts_rate = 0;
> 
> +       if (vif->type == NL80211_IFTYPE_AP && sta)
> +               macid = sta->aid + 1;

As suggestion before, please make sure hostapd never assigns a big number like 100 as aid.

> 
>         priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
> -                               ampdu_enable, rts_rate);
> +                               ampdu_enable, rts_rate, macid);
> 
>         rtl8xxxu_calc_tx_desc_csum(tx_desc);
> 
> --
> 2.30.2

