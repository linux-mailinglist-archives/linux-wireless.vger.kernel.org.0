Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFBF7606CB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 05:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjGYDlR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 23:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjGYDlK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 23:41:10 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDC551735
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 20:41:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36P3eOsZ5013054, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36P3eOsZ5013054
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Jul 2023 11:40:24 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 25 Jul 2023 11:40:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 25 Jul 2023 11:40:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 25 Jul 2023 11:40:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Takashi Iwai" <tiwai@suse.de>
Subject: RE: [PATCH] wifi: rtw89: Fix loading of compressed firmware
Thread-Topic: [PATCH] wifi: rtw89: Fix loading of compressed firmware
Thread-Index: AQHZvl45NTY6Zd5s70uHF7Bey25uoK/JzMmQ
Date:   Tue, 25 Jul 2023 03:40:35 +0000
Message-ID: <fa4609f5720a4affa2bb4ace61800df5@realtek.com>
References: <20230724183927.28553-1-Larry.Finger@lwfinger.net>
In-Reply-To: <20230724183927.28553-1-Larry.Finger@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
> Sent: Tuesday, July 25, 2023 2:39 AM
> To: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org; Larry Finger
> <Larry.Finger@lwfinger.net>; Ping-Ke Shih <pkshih@realtek.com>; Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] wifi: rtw89: Fix loading of compressed firmware
> 
> When using compressed firmware, the early firmware load feature will fail.
> In most cases, the only downside is that if a device has more than one
> firmware version available, only the last one listed will be loaded.
> In at least two cases, there is no firmware loaded, and the device fails
> initialization. See https://github.com/lwfinger/rtw89/issues/259 and
> https://bugzilla.opensuse.org/show_bug.cgi?id=1212808 for examples of
> the failure.
> 

Personally, I'm fine to avoid loading partial firmware, because of limitation of
compressed firmware. What I care is driver probe time, so I measure the time
100 times and remove the highest/lowest 5% numbers, and then get the average
probe time of 8852BE:
  Without this patch: 342,245,770ns
  With this patch:    346,473,726ns

This patch increases about 4ms that can be acceptable. 

[...]

> 
> Fixes: ffde7f3476a6 ("wifi: rtw89: add firmware format version to backward compatible with older drivers")
> Cc: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Tested-and-acked-by: Ping-Ke Shih <pkshih@realtek.com>


