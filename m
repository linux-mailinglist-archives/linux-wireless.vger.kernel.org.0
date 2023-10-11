Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594907C46E7
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 02:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344566AbjJKAy6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 20:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbjJKAy5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 20:54:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F519E
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 17:54:55 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39B0sbmdF3222061, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39B0sbmdF3222061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 08:54:37 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 11 Oct 2023 08:54:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 11 Oct 2023 08:54:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 11 Oct 2023 08:54:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 5/6] wifi: radiotap: add bandwidth definition of EHT U-SIG
Thread-Topic: [PATCH v2 5/6] wifi: radiotap: add bandwidth definition of EHT
 U-SIG
Thread-Index: AQHZ+x8BqZDTAYUsIky6kUQhKtEGKrBCjWh0gAE2/MA=
Date:   Wed, 11 Oct 2023 00:54:37 +0000
Message-ID: <6aa9a4e673004fe3b56755b93422dd29@realtek.com>
References: <20231010021006.6061-1-pkshih@realtek.com>
        <20231010021006.6061-6-pkshih@realtek.com> <8734yj578s.fsf@kernel.org>
In-Reply-To: <8734yj578s.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Tuesday, October 10, 2023 2:20 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v2 5/6] wifi: radiotap: add bandwidth definition of EHT U-SIG
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > Define EHT U-SIG bandwidth used by radiotap according to Table 36-28
> > "U-SIG field of an EHT MU PPDU" in 802.11be (D3.0).
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> > v2:
> >   - correct commit message about the source of bandwidth definition
> >     of EHT U-SIG suggested by Johannes
> > ---
> >  include/net/ieee80211_radiotap.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> This is nitpicking but in general it's good to have the patches touching
> files outside of drivers/net/wireless in the beginning of the patchset
> to make them more visible. No need to resend because of this, just a
> small tip.
> 

Got it. I will pay attention to it next time. 

Ping-Ke

