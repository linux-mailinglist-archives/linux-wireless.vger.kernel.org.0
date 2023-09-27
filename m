Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45AE7AFC3F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Sep 2023 09:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjI0Hme convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Sep 2023 03:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjI0Hma (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Sep 2023 03:42:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D627BF
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 00:42:29 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38R7gLIK12082719, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38R7gLIK12082719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 15:42:21 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 27 Sep 2023 15:42:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 27 Sep 2023 15:42:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Wed, 27 Sep 2023 15:42:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     Kevin Yang <kevin_yang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 0/4] wifi: rtw89: update to follow regulations of China and Thailand
Thread-Topic: [PATCH 0/4] wifi: rtw89: update to follow regulations of China
 and Thailand
Thread-Index: AQHZ8RNggOyofwedR0eyXs1E6/zFSbAuRy95gAAAXAA=
Date:   Wed, 27 Sep 2023 07:42:16 +0000
Message-ID: <fb8ece3e7e44490c93e69654ca404984@realtek.com>
References: <20230927072156.26336-1-pkshih@realtek.com>
 <8734z0842w.fsf@kernel.org>
In-Reply-To: <8734z0842w.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
> Sent: Wednesday, September 27, 2023 3:32 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kevin Yang <kevin_yang@realtek.com>; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 0/4] wifi: rtw89: update to follow regulations of China and Thailand
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > Recently regulations of China and Thailand are changed, and these chips
> > have gotten new certifications, so apply new TX power tables.
> >
> > Zong-Zhe Yang (4):
> >   wifi: rtw89: regd: configure Thailand in regulation type
> >   wifi: rtw89: 8852c: update TX power tables to R67
> >   wifi: rtw89: 8852b: update TX power tables to R35
> >   wifi: rtw89: 8851b: update TX power tables to R34
> 
> I don't see patch 2 in patchwork but I did receive it to my
> kvalo@kernel.org adddress, maybe it was too big for the list?

Yes, I think so. 

I noted that patch 2 was received late from linux-wireless@vger.kernel.org, so
I checked the size and found that was too big. I was trying to split the patch,
but minutes later I received it.

I think I should add a rule to my local script to check if patch size is larger
than 500k to prevent this again. 

> 
> But I can also apply that manually so no need to split that patch.
> 

Thank you.

Ping-Ke 

