Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E5B3A3A35
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jun 2021 05:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhFKDZl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 23:25:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43798 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFKDZl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 23:25:41 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15B3NYznC016916, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15B3NYznC016916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Jun 2021 11:23:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 11 Jun 2021 11:23:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 11 Jun 2021 11:23:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Fri, 11 Jun 2021 11:23:33 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Pkshih <pkshih@realtek.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: Fix sw connection monitor and sw scan when STA is connected HE
Thread-Topic: [PATCH] mac80211: Fix sw connection monitor and sw scan when STA
 is connected HE
Thread-Index: AQHXXm6ItuGkMH9RLkaoOlE6YAkORKsOIMzw
Date:   Fri, 11 Jun 2021 03:23:33 +0000
Message-ID: <072bfd8473ac4054a43818009e66a914@realtek.com>
References: <20210611030422.9608-1-pkshih@realtek.com>
In-Reply-To: <20210611030422.9608-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/6/11_=3F=3F_01:08:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/11/2021 03:11:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164259 [Jun 10 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/11/2021 03:15:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Ping-Ke Shih [mailto:pkshih@realtek.com]
> Sent: Friday, June 11, 2021 11:04 AM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org
> Subject: [PATCH] mac80211: Fix sw connection monitor and sw scan when STA is connected HE
> 
> Add HE_NULLFUNC_STACK hw_flag to allow sending nullfunc when STA is
> connected HE. Then, sw connection monitor can detects AP has left, and sw
> scan can issue nullfunc properly when switching to off channel.
> 
> The related commits are commit 41cbb0f5a295 ("mac80211: add support for HE")
> that stops sending nullfunc when STA is connected HE, and commit f39b07fdfb68
> ("mac80211: HE STA disassoc due to QOS NULL not sent") that makes STA
> doesn't disconnect locally even if AP has left.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
[...]

Hi mac80211 team,

We are working on Realtek 11ax driver, rtw89, not being merged yet.
This driver uses software connection monitor and software scan, like our 11ac driver rtw88,
but we found these two functions don't work properly due to mac80211 doesn't send
null data frame when STA is connected HE.

We search for the reason why it can't send null frame, but we don't get the answer.
Possibly, it is because existing HE hardware supports hardware connection monitor
and scan, or supports TWT to avoid sending null data frame to tell AP its PS mode.
Could anyone enlighten me the reason?

Thank you
--
Ping-Ke


