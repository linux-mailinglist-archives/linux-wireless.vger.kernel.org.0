Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02496C992F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 02:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjC0Avg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 20:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjC0Ave (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 20:51:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C185E132
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 17:51:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R0p6Pj9012019, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R0p6Pj9012019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 08:51:06 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 08:51:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Mar 2023 08:51:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 08:51:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 02/14] wifi: rtl8xxxu: Select correct queue for beacon frames
Thread-Topic: [RFC PATCH 02/14] wifi: rtl8xxxu: Select correct queue for
 beacon frames
Thread-Index: AQHZXOKSGlQwKBGna0qA4ITiwI1tPq8N0Yvw
Date:   Mon, 27 Mar 2023 00:51:21 +0000
Message-ID: <e492122d11f345e18dd20fb6f296a709@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-3-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-3-martin.kaistra@linutronix.de>
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
> Subject: [RFC PATCH 02/14] wifi: rtl8xxxu: Select correct queue for beacon frames
> 
> Use the special beacon queue for beacon frames instead of the management
> frame queue, so that the HW sends them periodically instead of only
> once.

Frames with beacon queue will be put in a special area called reserved page
where hardware will treat the frame as beacon frame and send out periodically
when net_type is configured as AP mode.

> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 90b98b9dcbd9d..daeaa7d6864f9 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4941,7 +4941,9 @@ static u32 rtl8xxxu_queue_select(struct ieee80211_hdr *hdr, struct sk_buff *skb)
>  {
>         u32 queue;
> 
> -       if (ieee80211_is_mgmt(hdr->frame_control))
> +       if (unlikely(ieee80211_is_beacon(hdr->frame_control)))
> +               queue = TXDESC_QUEUE_BEACON;
> +       else if (ieee80211_is_mgmt(hdr->frame_control))
>                 queue = TXDESC_QUEUE_MGNT;
>         else
>                 queue = rtl8xxxu_80211_to_rtl_queue(skb_get_queue_mapping(skb));
> --
> 2.30.2

