Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FCD4205F7
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Oct 2021 08:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhJDGsx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Oct 2021 02:48:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43826 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhJDGsw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Oct 2021 02:48:52 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1946kx5mB017297, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1946kx5mB017297
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 Oct 2021 14:46:59 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 4 Oct 2021 14:46:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 4 Oct 2021 14:46:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Mon, 4 Oct 2021 14:46:57 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
Thread-Topic: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
Thread-Index: AQHXlXz6iS5M0zbbfkSyaj358Nztiqu+mXDngAQPmeA=
Date:   Mon, 4 Oct 2021 06:46:57 +0000
Message-ID: <9b54e3c321a4414cbae62616d8a913f4@realtek.com>
References: <20210820043538.12424-1-pkshih@realtek.com>
 <8735pkiu0t.fsf@codeaurora.org>
In-Reply-To: <8735pkiu0t.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/10/4_=3F=3F_04:51:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/04/2021 06:29:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166474 [Oct 04 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;git.kernel.org:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/04/2021 06:34:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org <kvalo=codeaurora.org@mg.codeaurora.org> On
> Behalf Of Kalle Valo
> Sent: Saturday, October 2, 2021 12:34 AM
> To: Pkshih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > This driver named rtw89, which is the next generation of rtw88, supports
> > Realtek 8852AE 802.11ax 2x2 chip whose new features are OFDMA, DBCC,
> > Spatial reuse, TWT and BSS coloring; now some of them aren't implemented
> > though.
> >
> > The chip architecture is entirely different from the chips supported by
> > rtw88 like RTL8822CE 802.11ac chip. First of all, register address ranges
> > are totally redefined, so it's impossible to reuse register definition. To
> > communicate with firmware, new H2C/C2H format is proposed. In order to have
> > better utilization, TX DMA flow is changed to two stages DMA. To provide
> > rich RX status information, additional RX PPDU packets are added.
> >
> > Since there are so many differences mentioned above, we decide to propose
> > a new driver. It has many authors, they are listed in alphabetic order:
> 
> I did a review now and this looks pretty good to me. Kconfig has a
> different license and lots of static/extern variables which are not
> const, otherwise I only saw smaller issues. But I do have to admit that
> after mac.h (in alphabetical order) my review was more on the sloppy
> side, this is a large driver.

Thank you.
I will revise the driver according to your comments.

> 
> The community has been testing this driver already, right?

As Larry mentioned, end users use this driver. Since bugs found in v6,
we have fixed them and driver is under QA. I plan to have that fixes in v7
released this week.

This version will also include fixes of your comments. 
Does it work to you?

> 
> I pushed the driver to the pending branch for build testing:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=
> pending&id=c9dfa866a9f4004fcbde9fc3ad8772ad417c6ad9
> 

--
Ping-Ke

