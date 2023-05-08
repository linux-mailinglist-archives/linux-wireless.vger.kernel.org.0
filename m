Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567CA6FA2D2
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 11:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjEHJBb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 05:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjEHJAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 05:00:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F9F93C1
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 02:00:34 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34890KgU4002165, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34890KgU4002165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 17:00:20 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 May 2023 17:00:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 17:00:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 8 May 2023 17:00:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] wifi: rtw88: usb: fix priority queue to endpoint mapping
Thread-Topic: [bug report] wifi: rtw88: usb: fix priority queue to endpoint
 mapping
Thread-Index: AQHZfnckew+PUCPgkEGu0NoEQg74H69PrtFAgABqVRA=
Date:   Mon, 8 May 2023 09:00:25 +0000
Message-ID: <f0206253275b4e0a8b0e4097084f2109@realtek.com>
References: <c3f70197-829d-48ed-ae15-66a9de80fa90@kili.mountain>
 <ab52f337fdf842499912458efab7704c@realtek.com>
In-Reply-To: <ab52f337fdf842499912458efab7704c@realtek.com>
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
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Monday, May 8, 2023 10:39 AM
> To: Dan Carpenter <dan.carpenter@linaro.org>; s.hauer@pengutronix.de
> Cc: linux-wireless@vger.kernel.org
> Subject: RE: [bug report] wifi: rtw88: usb: fix priority queue to endpoint mapping
> 
> Hi Sascha,
> 
> > -----Original Message-----
> > From: Dan Carpenter <dan.carpenter@linaro.org>
> > Sent: Thursday, May 4, 2023 6:56 PM
> > To: s.hauer@pengutronix.de
> > Cc: linux-wireless@vger.kernel.org
> > Subject: [bug report] wifi: rtw88: usb: fix priority queue to endpoint mapping
> >
> > Hello Sascha Hauer,
> >
> > The patch a6f187f92bcc: "wifi: rtw88: usb: fix priority queue to
> > endpoint mapping" from Apr 17, 2023, leads to the following Smatch
> > static checker warning:
> >
> > drivers/net/wireless/realtek/rtw88/usb.c:219 rtw_usb_parse() warn: assigning (-22) to unsigned variable
> > 'rtwusb->qsel_to_ep[8]'
> 
> [...]
> 
> >     218         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID7] = dma_mapping_to_ep(rqpn->dma_map_vo);
> > --> 219         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID8] = -EINVAL;
> >
> > Can't save negative error codes to a u8.
> >
> 
> return type of dma_mapping_to_ep() is 'int' and it also possibly returns -EINVAL, and
> rtwusb->qsel_to_ep[] is used by qsel_to_ep() that also use 'int' as return type.
> Therefore, I would like to change type of qsel_to_ep[] from 'u8' to 'int'. Does it
> work to you?
> 

I have made a patch [1] along with above idea. 

[1] https://lore.kernel.org/linux-wireless/20230508085539.46795-1-pkshih@realtek.com/T/#u

Ping-Ke

