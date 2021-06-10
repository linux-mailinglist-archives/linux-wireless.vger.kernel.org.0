Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA53A228B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 05:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFJDFe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Jun 2021 23:05:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59370 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJDFd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Jun 2021 23:05:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15A33TV30014714, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15A33TV30014714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Jun 2021 11:03:29 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Jun 2021 11:03:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Jun 2021 11:03:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Thu, 10 Jun 2021 11:03:27 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Pkshih <pkshih@realtek.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Steven Ting" <steventing@realtek.com>
Subject: RE: [PATCH v2 1/2] rtw88: follow the AP basic rates for tx mgmt frame
Thread-Topic: [PATCH v2 1/2] rtw88: follow the AP basic rates for tx mgmt
 frame
Thread-Index: AQHXNyQ+ZgVlrlrPK06kM3pFweZvEasM1qXA
Date:   Thu, 10 Jun 2021 03:03:27 +0000
Message-ID: <2a8f9bcc4a6b47f2bff1f68aa9b53254@realtek.com>
References: <20210422030413.9738-1-pkshih@realtek.com>
In-Reply-To: <20210422030413.9738-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/6/10_=3F=3F_01:06:00?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/10/2021 02:50:37
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164226 [Jun 09 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/10/2021 02:52:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Ping-Ke Shih [mailto:pkshih@realtek.com]
> Sent: Thursday, April 22, 2021 11:04 AM
> To: tony0620emma@gmail.com; kvalo@codeaurora.org
> Cc: linux-wireless@vger.kernel.org; Steven Ting
> Subject: [PATCH v2 1/2] rtw88: follow the AP basic rates for tx mgmt frame
> 
> From: Yu-Yen Ting <steventing@realtek.com>
> 
> By default the driver uses the 1M and 6M rate for managemnt frames
> in 2G and 5G bands respectively. But when the basic rates is
> configured from the mac80211, we need to send the management frames
> according to the basic rates.
> 
> This commit makes the driver use the lowest basic rates to send
> the management frames.
> 
> Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2: move debugfs as a separated patch
> v1: the original patch is "[PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame"
> ---

[...]

Gentle ping.
The patchset v2 is separated into two patches. Is there any further suggestion?

--
Ping-Ke

