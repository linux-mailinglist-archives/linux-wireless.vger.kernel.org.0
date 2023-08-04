Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1476F67E
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 02:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjHDAVv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 20:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHDAVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 20:21:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B46193AB1
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 17:21:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3740LQ6c8004189, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3740LQ6c8004189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 4 Aug 2023 08:21:26 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 4 Aug 2023 08:21:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 4 Aug 2023 08:21:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 4 Aug 2023 08:21:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     Kevin Yang <kevin_yang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: regd: update regulatory map to R64-R42
Thread-Topic: [PATCH] wifi: rtw89: regd: update regulatory map to R64-R42
Thread-Index: AQHZxfj//ifzzfT9pE+qUdwfaODwq6/YePuAgADOB9A=
Date:   Fri, 4 Aug 2023 00:21:36 +0000
Message-ID: <9cb1e6ea6fbb4fccb8920cd8fbd9a8bc@realtek.com>
References: <20230803105430.6985-1-pkshih@realtek.com>
 <87il9wtjtb.fsf@kernel.org>
In-Reply-To: <87il9wtjtb.fsf@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Thursday, August 3, 2023 8:03 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kevin Yang <kevin_yang@realtek.com>; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH] wifi: rtw89: regd: update regulatory map to R64-R42
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > Update notes:
> 
> No need to have that sentence.
> 
> > sync Realtek Regulatory R42 and Realtek Channel Plan R64
> 
> R42 and R64 tells nothing to the community. A some kind of summary would
> be nice.

I add some description about that by v2 [1]
Thanks

[1] https://lore.kernel.org/linux-wireless/20230804001322.4131-1-pkshih@realtek.com/T/#u

