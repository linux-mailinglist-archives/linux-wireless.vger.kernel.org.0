Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A281464AC94
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Dec 2022 01:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiLMAqc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 19:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLMAqa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 19:46:30 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1864F18E1A
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 16:46:27 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BD0jYnZ5002124, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BD0jYnZ5002124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 13 Dec 2022 08:45:34 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 13 Dec 2022 08:46:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 08:46:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 13 Dec 2022 08:46:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] rtw89: add Realtek 802.11ax driver
Thread-Topic: [bug report] rtw89: add Realtek 802.11ax driver
Thread-Index: AQHZDj8d9/5rxcspTEKQ1qIVRqtu4a5q+3zw
Date:   Tue, 13 Dec 2022 00:46:22 +0000
Message-ID: <e87d10cd962d4d118b86a280f986f6ef@realtek.com>
References: <Y5dJymTl15fBnQtV@kili>
In-Reply-To: <Y5dJymTl15fBnQtV@kili>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/12/12_=3F=3F_08:35:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter <error27@gmail.com>
> Sent: Monday, December 12, 2022 11:34 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: [bug report] rtw89: add Realtek 802.11ax driver
> 
> Hello Ping-Ke Shih,
> 
> The patch e3ec7017f6a2: "rtw89: add Realtek 802.11ax driver" from Oct
> 11, 2021, leads to the following potential issue (just from reading
> the code):
> 
> drivers/net/wireless/realtek/rtw89/core.h
>     3878 static inline u32
>     3879 rtw89_read32_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask)
>     3880 {
>     3881         u32 shift = __ffs(mask);
>     3882         u32 orig;
>     3883         u32 ret;
>     3884
>     3885         orig = rtw89_read32(rtwdev, addr);
> --> 3886         ret = (orig & mask) >> shift;
> 
> I think this line should be:
> 
> 	ret = (orig & mask) >> (shift - 1);
> 
> A typical mask here is 0xff so __ffs() is 1 because the first bit is
> set.  This code will do: ret = (orig & 0xff) >> 1;  I think it should be
> ret = (orig & 0xff) >> 0;
> 
> If the mask was 0xff00 I would expect >> 8 instead of >> 9 etc.

ffs(0xff)=1 and __ffs(0xff)=0, so I think original is correct.

Ping-Ke

