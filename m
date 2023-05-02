Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378DE6F3FDB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 May 2023 11:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjEBJKV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 May 2023 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjEBJKT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 May 2023 05:10:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2733A2D61
        for <linux-wireless@vger.kernel.org>; Tue,  2 May 2023 02:10:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3429A0Bo8024844, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3429A0Bo8024844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 2 May 2023 17:10:01 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 2 May 2023 17:10:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 2 May 2023 17:10:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 2 May 2023 17:10:04 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kevin Lo <kevlo@kevlo.org>, Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: 8188f: no need to initialize interrupts
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: 8188f: no need to initialize
 interrupts
Thread-Index: AQHZeXnw1bVEGkPuTUKBTMt6fz5J1K9ANP9U//+JBgCABvhBIA==
Date:   Tue, 2 May 2023 09:10:04 +0000
Message-ID: <02a6f536d1a144749d97db5c301ee76c@realtek.com>
References: <ZEswqUHBXPHC/znL@ns.kevlo.org> <87ildgpnsd.fsf@kernel.org>
 <ZEtpDi8oCr0E9scd@ns.kevlo.org>
In-Reply-To: <ZEtpDi8oCr0E9scd@ns.kevlo.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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
> From: Kevin Lo <kevlo@kevlo.org>
> Sent: Friday, April 28, 2023 2:35 PM
> To: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Jes Sorensen
> <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
> Subject: Re: [PATCH v2] wifi: rtl8xxxu: 8188f: no need to initialize interrupts
> 
> On Fri, Apr 28, 2023 at 08:40:34AM +0300, Kalle Valo wrote:
> >
> > Kevin Lo <kevlo@kevlo.org> writes:
> >
> > > There's no need to initialize interrupts for RTL8188FTV like the vendor driver.
> > >
> > > Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> >
> > Why do this, what's the benefit? Or is this just a theoretical fix. The
> > commit log should explain this.
> 
> If I understand correctly, just like rtw88 usb devices, rtl8xxxu has no
> hardware interrupt.
> 

With/without hardware interrupt, it depends on IMR (interrupt mask register)
setting. If it is enabled, driver can receive C2H, PS indicators, and beacon
TBTT events via certain USB endpoint. But, normally vendor driver doesn't
use them neither.

Why it initializes interrupt in this patch is to reset ISR (interrupt status
register) to avoid unexpected interrupts are received. So, if it doesn't
really enable interrupt by IMR, I suppose it should work well even without
this patch.

Kevin, could I know the real problem you met?

Ping-Ke

