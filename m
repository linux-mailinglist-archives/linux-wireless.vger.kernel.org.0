Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC3B3CB0A6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jul 2021 04:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhGPCDm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 22:03:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:56483 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhGPCDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 22:03:42 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16G20f0O2025106, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16G20f0O2025106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Jul 2021 10:00:41 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 16 Jul 2021 10:00:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 16 Jul 2021 10:00:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Fri, 16 Jul 2021 10:00:40 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 03/24] rtw89: add core and trx files
Thread-Topic: [PATCH 03/24] rtw89: add core and trx files
Thread-Index: AQHXZA3LU5R+TYuZxkuDWNpxAtkG6KtECC8AgAD7Y4A=
Date:   Fri, 16 Jul 2021 02:00:40 +0000
Message-ID: <817153a13a22449d9c6fd95471f3bfa1@realtek.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-4-pkshih@realtek.com> <YPCFABiygQbiMqcB@google.com>
In-Reply-To: <YPCFABiygQbiMqcB@google.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/7/15_=3F=3F_07:21:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/16/2021 01:42:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165062 [Jul 15 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/16/2021 01:46:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Brian Norris [mailto:briannorris@chromium.org]
> Sent: Friday, July 16, 2021 2:57 AM
> To: Pkshih
> Cc: kvalo@codeaurora.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 03/24] rtw89: add core and trx files
> 
> Hi,
> 
> On Fri, Jun 18, 2021 at 02:46:04PM +0800, Ping-Ke Shih wrote:
> > --- /dev/null
> > +++ b/drivers/net/wireless/realtek/rtw89/core.c
> > @@ -0,0 +1,2359 @@
> > +static void rtw89_traffic_stats_calc(struct rtw89_dev *rtwdev,
> > +				     struct rtw89_traffic_stats *stats)
> > +{
> ...
> > +	stats->tx_avg_len = (u32)(stats->tx_cnt ? stats->tx_unicast / stats->tx_cnt : 0);
> > +	stats->rx_avg_len = (u32)(stats->rx_cnt ? stats->rx_unicast / stats->rx_cnt : 0);
> 
> You're doing 64-bit division which isn't supported on all architectures.
> You need a do_div()-based solution here, like:
> 
> 	stats->tx_avg_len = stats->tx_cnt
> 			    ? DIV_ROUND_DOWN_ULL(stats->tx_unicast, stats->tx_cnt)
> 			    : 0;
> 	stats->rx_avg_len = stats->rx_cnt
> 			    ? DIV_ROUND_DOWN_ULL(stats->rx_unicast, stats->rx_cnt)
> 			    : 0;
> 

The kernel test robot has reported this on mips arch.
ERROR: modpost: "__udivdi3" [drivers/net/wireless/realtek/rtw89/rtw89_core.ko] undefined!

And, my fix is the same as yours. Next submission will include this.
Thank you.

--
Ping-Ke

