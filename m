Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC97172B8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 02:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjEaAqV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 20:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEaAqU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 20:46:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A9DE8
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 17:46:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34V0ifa97025976, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34V0ifa97025976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 31 May 2023 08:44:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 31 May 2023 08:44:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 31 May 2023 08:44:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 31 May 2023 08:44:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "petter@technux.se" <petter@technux.se>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "andreas@fatal.se" <andreas@fatal.se>,
        "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux@ulli-kroll.de" <linux@ulli-kroll.de>,
        "petter.mabacker@esab.se" <petter.mabacker@esab.se>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [PATCH] wifi: rtw88: usb: Make work queues high prio
Thread-Topic: [PATCH] wifi: rtw88: usb: Make work queues high prio
Thread-Index: AQHZktdSd7H9r3V3PEuOOEkQppWIDa9ynIlG//+njICAAUS58A==
Date:   Wed, 31 May 2023 00:44:54 +0000
Message-ID: <96e0b705b5a64679a14ce5440674f4b0@realtek.com>
References: <87zg5mjeu4.fsf@kernel.org>
 <20230530130917.2716182-1-petter@technux.se>
In-Reply-To: <20230530130917.2716182-1-petter@technux.se>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: petter@technux.se <petter@technux.se>
> Sent: Tuesday, May 30, 2023 9:09 PM
> To: kvalo@kernel.org
> Cc: Larry.Finger@lwfinger.net; andreas@fatal.se; iam@valdikss.org.ru; kernel@pengutronix.de;
> linux-wireless@vger.kernel.org; linux@ulli-kroll.de; petter.mabacker@esab.se; petter@technux.se; Ping-Ke
> Shih <pkshih@realtek.com>; s.hauer@pengutronix.de
> Subject: Re: [PATCH] wifi: rtw88: usb: Make work queues high prio
> 
> petter@technux.se writes:
> 
> >> From: Petter Mabacker <petter.mabacker@esab.se>
> >>
> >> The rtw8822cu driver have problem to handle high rx or tx rates compared
> >> with high load (such as high I/O) on slower systems, such as for example
> >> i.MX6 SoloX and similar platforms.
> >>
> >> The problems are more frequent when having the access point close to the
> >> device. On slower systems it's often enough to download a large file,
> >> combined with generating I/O load to trigger:
> >>
> >> [  374.763424] rtw_8822cu 1-1.2:1.2: failed to get tx report from firmware
> >> [  377.771790] rtw_8822cu 1-1.2:1.2: failed to send h2c command
> >> [  407.813460] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
> >> [  414.965826] rtw_8822cu 1-1.2:1.2: failed to send h2c command
> >> [  444.993462] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
> >> [  452.144551] rtw_8822cu 1-1.2:1.2: failed to send h2c command
> >> [  482.183445] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
> >> [  489.426263] rtw_8822cu 1-1.2:1.2: failed to send h2c command
> >>
> >> Another way is to simply perform a wifi rescan.
> >>
> >> Benchmarking shows that setting a high prio workqueue for tx/rx will
> >> significally improve things. Also compared alloc_workqueue with
> >> alloc_ordered_workqueue, but even thou the later seems to slightly
> >> improve things it's still quite easy to reproduce the above issues. So
> >> that leads to the decision to go for alloc_workqueue.
> >>
> >> Thanks to Ping-Ke Shih <pkshih@realtek.com> that came up with the idea
> >> of exploring tweaking of the work queue's within a similar discussion.
> >>
> >> Fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")
> >> Signed-off-by: Petter Mabacker <petter.mabacker@esab.se>
> >> ---
> >>  drivers/net/wireless/realtek/rtw88/usb.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> >> index 44a5fafb9905..bfe0845528ec 100644
> >> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> >> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> >> @@ -716,7 +716,7 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
> >>      struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
> >>      int i;
> >>
> >> -    rtwusb->rxwq = create_singlethread_workqueue("rtw88_usb: rx wq");
> >> +    rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
> >>      if (!rtwusb->rxwq) {
> >>              rtw_err(rtwdev, "failed to create RX work queue\n");
> >>              return -ENOMEM;
> >> @@ -750,7 +750,7 @@ static int rtw_usb_init_tx(struct rtw_dev *rtwdev)
> >>      struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
> >>      int i;
> >>
> >> -    rtwusb->txwq = create_singlethread_workqueue("rtw88_usb: tx wq");
> >> +    rtwusb->txwq = alloc_workqueue("rtw88_usb: tx wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
> >>      if (!rtwusb->txwq) {
> >>              rtw_err(rtwdev, "failed to create TX work queue\n");
> >>              return -ENOMEM;
> 
> >Should this workqueue be ordered or not? Please check Tejun's patchset
> >about using ordered queues:
> 
> >https://lore.kernel.org/lkml/20230421025046.4008499-1-tj@kernel.org/
> 
> Thanks for pointing out this interesting patchset. As described in the
> commit msg, I did play around with alloc_ordered_workqueue. But at least
> on the slower systems I tested it on (i.MX6 SoloX and BCM2835) it worked
> a bit better, but I was still able to reproduce the above mention issue.
> So I tried to instead use alloc_workqueue and set max_active=0 and that
> seems to be enough to make things a lot more stable.
> 
> However after reading Tejun's patchet I'm very intersted of feedback if
> you or someone else have comments about using alloc_workqueue with
> max_active=0 , or if this can give some other issues? It seems to work
> fine for me when running it also on a i.MX8 multicore system.
> 

Both rtwusb->rxwq and rtwusb->txwq are only queued single one work respectively,
so I thought alloc_workqueue() and alloc_ordered_workqueue() would get the same
results, but it seems not. That is a little weird to me.

I'm not familiar with workqueue, but I think we can bisect arguments to address
what impact the results.

First we can expand macro alloc_ordered_workqueue() below
    rtwusb->txwq = alloc_ordered_workqueue("rtw88_usb: tx wq", WQ_HIGHPRI);
into
    rtwusb->txwq = alloc_workqueue("rtw88_usb: tx wq",
                                   WQ_UNBOUND | __WQ_ORDERED | __WQ_ORDERED_EXPLICIT |
                                   WQ_HIGHPRI, 1);

Secondly, compare the one you are using:
    rtwusb->txwq = alloc_workqueue("rtw88_usb: tx wq", WQ_UNBOUND | WQ_HIGHPRI, 0);

Then, we can align the arguments one-by-one to know which argument dominates
the result. 

Ping-Ke

