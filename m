Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54D778808B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 09:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242478AbjHYHDR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 03:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242127AbjHYHCq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89FD219AC
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 00:02:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37P72DkkC025227, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37P72DkkC025227
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Aug 2023 15:02:13 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 25 Aug 2023 15:02:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 25 Aug 2023 15:02:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 25 Aug 2023 15:02:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: fix typo rtw8822cu_probe
Thread-Topic: [PATCH] wifi: rtw88: fix typo rtw8822cu_probe
Thread-Index: AQHZ1xz/geZUXeX9h0en2jA7542fja/6kWU9gAAEOLA=
Date:   Fri, 25 Aug 2023 07:02:35 +0000
Message-ID: <95d1062787fc4b2994f4b880179f41ef@realtek.com>
References: <20230825062404.50813-1-pkshih@realtek.com>
 <87o7ivvcta.fsf@kernel.org>
In-Reply-To: <87o7ivvcta.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Friday, August 25, 2023 2:47 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Bernie Huang <phhuang@realtek.com>; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH] wifi: rtw88: fix typo rtw8822cu_probe
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > From: Po-Hao Huang <phhuang@realtek.com>
> >
> > The probe function of 8822cu is misplaced to 8822bu, so we fix it.
> >
> > Fixes: 07cef03b8d44 ("wifi: rtw88: Add rtw8822cu chipset support")
> > Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> I guess this is just a cosmetic change and does not cause any changes in
> functionality? I can add that to the commit log.
> 

Yes, it doesn't change anything. If Fixes tag is not suitable, please also
remove it.

Thank you. 
Ping-ke


