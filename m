Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3207C4701
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 03:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbjJKBFT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 21:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJKBFS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 21:05:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A7E92
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 18:05:16 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39B13rWF23233580, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39B13rWF23233580
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 09:03:53 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 11 Oct 2023 09:03:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 11 Oct 2023 09:03:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 11 Oct 2023 09:03:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>, neo_jou <neo_jou@realtek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans Ulli Kroll <linux@ulli-kroll.de>
Subject: RE: [PATCH] wifi: rtw88: Remove duplicate NULL check before calling usb_kill/free_urb()
Thread-Topic: [PATCH] wifi: rtw88: Remove duplicate NULL check before calling
 usb_kill/free_urb()
Thread-Index: AQHZ+ZN3js7IFeq3f0St41aqKB+9S7BDyljA
Date:   Wed, 11 Oct 2023 01:03:53 +0000
Message-ID: <0c513b55a4db45a29d0ae4e7f80b0b66@realtek.com>
References: <20231008025852.1239450-1-ruanjinjie@huawei.com>
In-Reply-To: <20231008025852.1239450-1-ruanjinjie@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> Sent: Sunday, October 8, 2023 10:59 AM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>;
> neo_jou <neo_jou@realtek.com>; Sascha Hauer <s.hauer@pengutronix.de>; Hans Ulli Kroll
> <linux@ulli-kroll.de>
> Cc: ruanjinjie@huawei.com
> Subject: [PATCH] wifi: rtw88: Remove duplicate NULL check before calling usb_kill/free_urb()
> 
> Both usb_kill_urb() and usb_free_urb() do the NULL check itself, so there
> is no need to duplicate it prior to calling.
> 
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


