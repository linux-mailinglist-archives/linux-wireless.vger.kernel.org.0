Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3971D6EC3C2
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 04:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjDXCq1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Apr 2023 22:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXCqZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Apr 2023 22:46:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE946114
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 19:46:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33O2kCzQ5027839, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33O2kCzQ5027839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 24 Apr 2023 10:46:12 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 24 Apr 2023 10:46:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Apr 2023 10:46:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 24 Apr 2023 10:46:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [PATCH v2 10/18] wifi: rtl8xxxu: Add sta_add() and sta_remove() callbacks
Thread-Topic: [PATCH v2 10/18] wifi: rtl8xxxu: Add sta_add() and sta_remove()
 callbacks
Thread-Index: AQHZcqYJni0u2IsarEe0xpNm0jFik685yHiQ
Date:   Mon, 24 Apr 2023 02:46:13 +0000
Message-ID: <cbc8d6904c414823bebc8ce009f43269@realtek.com>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
 <20230419100145.159191-11-martin.kaistra@linutronix.de>
In-Reply-To: <20230419100145.159191-11-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> Sent: Wednesday, April 19, 2023 6:02 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH v2 10/18] wifi: rtl8xxxu: Add sta_add() and sta_remove() callbacks
> 
> In AP mode, sta_add() gets called when a new STA gets associated to
> us. Call rtl8xxxu_refresh_rate_mask() to set a rate mask for the newly
> connected STA (referenced by the macid) and then send a media connnect
> report. Ignore the call to sta_add() in station mode.
> 
> Reserve one macid for broadcast/multicast packets in init.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

