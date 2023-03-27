Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB586C9978
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 04:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjC0CGd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 22:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0CGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 22:06:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885634C38
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 19:06:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R263saC024699, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R263saC024699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 10:06:03 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 27 Mar 2023 10:06:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Mar 2023 10:06:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 10:06:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 13/14] wifi: rtl8xxxu: Clean up filter configuration
Thread-Topic: [RFC PATCH 13/14] wifi: rtl8xxxu: Clean up filter configuration
Thread-Index: AQHZXOKfVcPO2JHGpUSER0+v9g/H+68N5jlw
Date:   Mon, 27 Mar 2023 02:06:19 +0000
Message-ID: <ab74ec9f73b741f7b0dd3b8a498d7e32@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-14-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-14-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2023/3/27_=3F=3F_01:08:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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
> Subject: [RFC PATCH 13/14] wifi: rtl8xxxu: Clean up filter configuration
> 
> In AP mode, RCR_CHECK_BSSID_MATCH should not be set. Rearrange RCR bits
> to filter flags to match other realtek drivers and don't set
> RCR_CHECK_BSSID_BEACON and RCR_CHECK_BSSID_MATCH in AP mode.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 82fbe778fc5ec..b6f811ad01333 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -6597,23 +6597,24 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
>          * FIF_PLCPFAIL not supported?
>          */
> 
> -       if (*total_flags & FIF_BCN_PRBRESP_PROMISC)
> -               rcr &= ~RCR_CHECK_BSSID_BEACON;
> -       else
> -               rcr |= RCR_CHECK_BSSID_BEACON;
> +       if (priv->vif->type != NL80211_IFTYPE_AP) {

I think mac80211 configure filters depends on operating conditions, so it would
be possible to avoid checking vif->type. 

> +               if (*total_flags & FIF_BCN_PRBRESP_PROMISC)
> +                       rcr &= ~(RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH);
> +               else
> +                       rcr |= RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH;
> +       } else {
> +               rcr &= ~RCR_CHECK_BSSID_MATCH;
> +       }
> 
>         if (*total_flags & FIF_CONTROL)
>                 rcr |= RCR_ACCEPT_CTRL_FRAME;
>         else
>                 rcr &= ~RCR_ACCEPT_CTRL_FRAME;
> 
> -       if (*total_flags & FIF_OTHER_BSS) {
> +       if (*total_flags & FIF_OTHER_BSS)
>                 rcr |= RCR_ACCEPT_AP;
> -               rcr &= ~RCR_CHECK_BSSID_MATCH;
> -       } else {
> +       else
>                 rcr &= ~RCR_ACCEPT_AP;
> -               rcr |= RCR_CHECK_BSSID_MATCH;
> -       }
> 
>         if (*total_flags & FIF_PSPOLL)
>                 rcr |= RCR_ACCEPT_PM;
> --
> 2.30.2

