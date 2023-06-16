Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDBB732478
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 03:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjFPBL0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 21:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjFPBLY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 21:11:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A51FE2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 18:11:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35G1Aqu16032174, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35G1Aqu16032174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Jun 2023 09:10:52 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 16 Jun 2023 09:11:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 16 Jun 2023 09:11:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 16 Jun 2023 09:11:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>
CC:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] [v2] wifi: rtw88: delete timer and free skb queue when unloading
Thread-Topic: [PATCH] [v2] wifi: rtw88: delete timer and free skb queue when
 unloading
Thread-Index: AQHZn5zgajoIIGul30uNrZf2KgsQxa+MmiZw
Date:   Fri, 16 Jun 2023 01:11:10 +0000
Message-ID: <5fb6969687da47b2a12cb35041accca2@realtek.com>
References: <87leglaqkl.fsf@kernel.org>
 <20230615151911.5793-1-dmantipov@yandex.ru>
In-Reply-To: <20230615151911.5793-1-dmantipov@yandex.ru>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Sent: Thursday, June 15, 2023 11:19 PM
> To: Kalle Valo <kvalo@kernel.org>
> Cc: Yan-Hsuan Chuang <tony0620emma@gmail.com>; linux-wireless@vger.kernel.org; Dmitry Antipov
> <dmantipov@yandex.ru>
> Subject: [PATCH] [v2] wifi: rtw88: delete timer and free skb queue when unloading
> 
> Fix possible crash and memory leak on driver unload by deleting
> TX purge timer and freeing C2H queue in 'rtw_core_deinit()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: fix title and commit message (Kalle Valo)
> ---
>  drivers/net/wireless/realtek/rtw88/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index 9447a3aae3b5..572fc126b9de 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -2180,9 +2180,11 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
>                 release_firmware(wow_fw->firmware);
> 
>         destroy_workqueue(rtwdev->tx_wq);
> +       timer_delete_sync(&rtwdev->tx_report.purge_timer);
>         spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
>         skb_queue_purge(&rtwdev->tx_report.queue);
>         skb_queue_purge(&rtwdev->coex.queue);
> +       skb_queue_purge(&rtwdev->c2h_queue);

rtwdev->tx_report.q_lock is used to protect rtwdev->tx_report.queue, so don't
add to purge c2h queue in this critical section. I think coex.queue is
the bad example.

>         spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
> 
>         list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list,
> --
> 2.40.1

