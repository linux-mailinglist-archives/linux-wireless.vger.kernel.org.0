Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49E66C997A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 04:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjC0CHN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 22:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0CHM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 22:07:12 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC94C38
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 19:07:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R26iyL6025974, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R26iyL6025974
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 10:06:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 10:07:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 27 Mar 2023 10:06:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 10:06:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 14/14] wifi: rtl8xxxu: Declare AP mode support for 8188f
Thread-Topic: [RFC PATCH 14/14] wifi: rtl8xxxu: Declare AP mode support for
 8188f
Thread-Index: AQHZXOKk6c2ei5MpVkS6zlVkNRv45a8N58kg
Date:   Mon, 27 Mar 2023 02:06:59 +0000
Message-ID: <b78909a86e2642b5bc6a08225fb63ff0@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-15-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-15-martin.kaistra@linutronix.de>
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
> Subject: [RFC PATCH 14/14] wifi: rtl8xxxu: Declare AP mode support for 8188f
> 
> Everything is in place now for AP mode, we can tell the system that we
> support it. Put the feature behind a flag in priv->fops, because it is
> not (yet) implemented for all chips.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 1 +
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 1 +
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index 20304b0bd68a3..31f9cf9e558d7 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1930,6 +1930,7 @@ struct rtl8xxxu_fileops {
>         u8 has_tx_report:1;
>         u8 gen2_thermal_meter:1;
>         u8 needs_full_init:1;
> +       u8 supports_ap:1;
>         u32 adda_1t_init;
>         u32 adda_1t_path_on;
>         u32 adda_2t_path_on_a;
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> index 82dee1fed4779..c4c1f015a7fd9 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> @@ -1746,6 +1746,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
>         .has_tx_report = 1,
>         .gen2_thermal_meter = 1,
>         .needs_full_init = 1,
> +       .supports_ap = 1,
>         .adda_1t_init = 0x03c00014,
>         .adda_1t_path_on = 0x03c00014,
>         .trxff_boundary = 0x3f7f,
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index b6f811ad01333..31bd1f2711aed 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -7449,6 +7449,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>         hw->wiphy->max_scan_ssids = 1;
>         hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
>         hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
> +       if (priv->fops->supports_ap)
> +               hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
>         hw->queues = 4;
> 
>         sband = &rtl8xxxu_supported_band;
> --
> 2.30.2

