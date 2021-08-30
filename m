Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8F3FB151
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 08:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhH3Gme convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 02:42:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:44234 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhH3Gmd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 02:42:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17U6fXXG1029890, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17U6fXXG1029890
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Aug 2021 14:41:33 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 30 Aug 2021 14:41:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 30 Aug 2021 14:41:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Mon, 30 Aug 2021 14:41:32 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>, Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 2/4] rtw88: add regulatory strategy by chip type
Thread-Topic: [PATCH 2/4] rtw88: add regulatory strategy by chip type
Thread-Index: AQHXnMm/XgSYcZ3L+kmcf4MmXe5q0KuLmkow
Date:   Mon, 30 Aug 2021 06:41:32 +0000
Message-ID: <f9a78ca4554d41c8be6077c05258ad9b@realtek.com>
References: <20210802063140.25670-1-pkshih@realtek.com>
        <20210802063140.25670-3-pkshih@realtek.com>
 <87mtp04h9r.fsf@codeaurora.org>
In-Reply-To: <87mtp04h9r.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/8/30_=3F=3F_04:21:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/30/2021 06:26:36
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165837 [Aug 30 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 457 457 f9912fc467375383fbac52a53ade5bbe1c769e2a
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/30/2021 06:30:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org [mailto:kvalo=codeaurora.org@mg.codeaurora.org] On
> Behalf Of Kalle Valo
> Sent: Sunday, August 29, 2021 7:34 PM
> To: Pkshih
> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org; Timlee; Kevin Yang
> Subject: Re: [PATCH 2/4] rtw88: add regulatory strategy by chip type
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > Realtek chips can program a specific country domain on efuse to
> > indicate what is the expected rtw_regulatory. For chips with a
> > PGed country domain, we set REGULATORY_STRICT_REG to tell stack
> 
> In the commit logs please avoid using acronyms as much as possible, they
> make it harder to read. Only after looking at the patch I was able to
> figure out that "PGed" means "programmed", or that's I at least assume
> it to mean.
> 

I'll avoid these acronyms in next version.

--
Ping-Ke

