Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E686EC394
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 04:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjDXC3y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Apr 2023 22:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjDXC3x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Apr 2023 22:29:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489AB1FCF
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 19:29:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33O2TRhS4001189, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33O2TRhS4001189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 24 Apr 2023 10:29:27 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 24 Apr 2023 10:29:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Apr 2023 10:29:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 24 Apr 2023 10:29:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [PATCH v2 03/18] wifi: rtl8xxxu: Add beacon functions
Thread-Topic: [PATCH v2 03/18] wifi: rtl8xxxu: Add beacon functions
Thread-Index: AQHZcqYH2x0CuNZCSE+iPPZUpCEpEq85wfeg
Date:   Mon, 24 Apr 2023 02:29:27 +0000
Message-ID: <9849321bafb64c4c941955e27f85fa13@realtek.com>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
 <20230419100145.159191-4-martin.kaistra@linutronix.de>
In-Reply-To: <20230419100145.159191-4-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> Sent: Wednesday, April 19, 2023 6:02 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH v2 03/18] wifi: rtl8xxxu: Add beacon functions
> 
> Add a workqueue to update the beacon contents asynchronously and
> implement downloading the beacon to the HW and starting beacon tx like
> the vendor driver.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

[...]

> @@ -4885,6 +4903,22 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>                 dev_dbg(dev, "Changed BASIC_RATES!\n");
>                 rtl8xxxu_set_basic_rates(priv, bss_conf->basic_rates);
>         }
> +
> +       if (changed & BSS_CHANGED_BEACON ||
> +           (changed & BSS_CHANGED_BEACON_ENABLED &&
> +            bss_conf->enable_beacon)) {
> +               if (!priv->beacon_enabled) {

Is it possible to rely on bss_conf->enable_beacon only? Then, we don't need
priv->beacon_enabled. Like

if (changed & BSS_CHANGED_BEACON_ENABLED && bss_conf->enable_beacon)
      rtl8xxxu_start_tx_beacon(priv);

if (changed & BSS_CHANGED_BEACON)
      schedule_work(&priv->update_beacon_work);

if (changed & BSS_CHANGED_BEACON_ENABLED && !bss_conf->enable_beacon)
      rtl8xxxu_stop_tx_beacon(priv);

> +                       dev_dbg(dev, "BSS_CHANGED_BEACON_ENABLED\n");
> +                       rtl8xxxu_start_tx_beacon(priv);
> +               }
> +               schedule_work(&priv->update_beacon_work);
> +       }
> +
> +       if (changed & BSS_CHANGED_BEACON_ENABLED && !bss_conf->enable_beacon) {
> +               if (priv->beacon_enabled)
> +                       rtl8xxxu_stop_tx_beacon(priv);
> +       }
> +
>  error:
>         return;
>  }

[...]

