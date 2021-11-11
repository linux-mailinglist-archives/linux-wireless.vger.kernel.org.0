Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C1844D00D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 03:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhKKCbM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 21:31:12 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51728 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhKKCbI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 21:31:08 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AB2SBPi8005815, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AB2SBPi8005815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Nov 2021 10:28:11 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 10:28:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 18:28:10 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Thu, 11 Nov 2021 10:28:10 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@gmail.com" <Larry.Finger@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtw89: Fix crash by loading compressed firmware file
Thread-Topic: [PATCH] rtw89: Fix crash by loading compressed firmware file
Thread-Index: AQHX0hU7VE24GGCl002qwvOXgdMXQqv0AUsAgACX6Q///34ogIAAjK5D///UggCAAArHAIAJHR/Q
Date:   Thu, 11 Nov 2021 02:28:09 +0000
Message-ID: <68f61525b26f46578a62b2a54d775c17@realtek.com>
References: <20211105071725.31539-1-tiwai@suse.de>
        <s5hpmrfgj93.wl-tiwai@suse.de>  <87zgqjqaae.fsf@codeaurora.org>
        <s5hh7crgflg.wl-tiwai@suse.de>  <87v917q8hw.fsf@codeaurora.org>
        <bd80d3b6cdc42d7818d7d5c6a5036d8188eb4a67.camel@realtek.com>
 <s5h5yt6fxpf.wl-tiwai@suse.de>
In-Reply-To: <s5h5yt6fxpf.wl-tiwai@suse.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/11/11_=3F=3F_12:23:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/11/2021 02:07:42
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167193 [Nov 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/11/2021 02:11:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Friday, November 5, 2021 11:07 PM
> To: Pkshih <pkshih@realtek.com>
> Cc: kvalo@codeaurora.org; linux-wireless@vger.kernel.org; Larry.Finger@gmail.com;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] rtw89: Fix crash by loading compressed firmware file
> 
> 
> You should put const in the cast in le32_get_bits() invocations, at
> least.
> 
> For the le32_replace_bits(), ideally it should be rewritten in some
> better way the compiler can catch.  e.g. use an inline function to
> take a void * argument without const,
> 
> static inline void RTW89_SET_FWCMD_CXRFK_TYPE(void *cmd, unsigned int val)
> {
> 	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(17, 10));
> }
> 
> Then the compiler will warn when you pass a const pointer there.
> 

I have sent a patchset [1] to do these two things by patch 2 and 3.

> 
> BTW, while reading your reply, I noticed that it's an unaligned access
> to a 32bit value, which is another potential breakage on some
> architectures.  So the whole stuff has to be rewritten in anyway...
> 

We use these macros/inline function on skb->data mostly, and I 
suppose skb->data is a 32bit aligned address. Since I don't have
this kind of machine on hand, I would like to defer this work until
I have one.

> 
> > The macro SET_FW_HDR_PART_SIZE() is used to set the firmware
> > partition size we are going to download, and it is only used
> > by rtw89_fw_download_hdr(). So, I will set the partition size
> > after copying constant firmware header into skb->data.
> 
> Sounds good.
> 

Please check if my patch works on your platform.
Thanks you.

[1] https://lore.kernel.org/linux-wireless/20211111021457.13776-1-pkshih@realtek.com/T/#t

--
Ping-Ke

