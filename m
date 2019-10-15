Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E390BD6DAE
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 05:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfJOD1O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 23:27:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33419 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfJOD1O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 23:27:14 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9F3R9R0005546, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9F3R9R0005546
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 15 Oct 2019 11:27:09 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Tue, 15 Oct
 2019 11:27:09 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     "g.schlmm" <g.schlmm@googlemail.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw88: M.2 RTL8822BE not working - rfe 3 isn't supported
Thread-Topic: rtw88: M.2 RTL8822BE not working - rfe 3 isn't supported
Thread-Index: AQHVHfV5qrKScUVcP06geVYCQL9tp6aXPCwAgAOaooCAv3qhAIABgmyg
Date:   Tue, 15 Oct 2019 03:27:07 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18FDB51@RTITMBSVM04.realtek.com.tw>
References: <0d0159a8-a83e-cef3-fd32-4928a2301719@gmail.com>
 <20190612091330.GC2965@redhat.com>
 <F7CD281DE3E379468C6D07993EA72F84D180639E@RTITMBSVM04.realtek.com.tw>
 <5960cc5a-becf-8bdc-7898-b9933247b6e3@gmail.com>
In-Reply-To: <5960cc5a-becf-8bdc-7898-b9933247b6e3@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: g.schlmm 
> 
> On 14.06.19 10:24, Tony Chuang wrote:
> >> Subject: Re: rtw88: M.2 RTL8822BE not working - rfe 3 isn't supported
> >>
> >> Cc Tony
> >>
> >> On Sat, Jun 08, 2019 at 02:26:51PM +0200, g.schlmm wrote:
> >>> my RTL8822BE M.2 card is not working with linux 5.2rc3
> >>>
> >>> the staging r8822be driver in linux 5.1 was working for this card
> >>>
> >>> from dmesg:
> >>>> [    8.001186] rtw_pci 0000:04:00.0: rfe 3 isn't supported
> >>>> [    8.003870] rtw_pci 0000:04:00.0: failed to setup chip efuse info
> >>>> [    8.006405] rtw_pci 0000:04:00.0: failed to setup chip information
> >>>
> >>> lspci:
> >>>> 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
> >> RTL8822BE 802.11a/b/g/n/ac WiFi adapter
> >>>>         Subsystem: Lenovo RTL8822BE 802.11a/b/g/n/ac WiFi
> adapter
> >>>>         Flags: fast devsel, IRQ 19
> >>>>         I/O ports at c000 [size=256]
> >>>>         Memory at 81200000 (64-bit, non-prefetchable) [size=64K]
> >>>>         Capabilities: [40] Power Management version 3
> >>>>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> >>>>         Capabilities: [70] Express Endpoint, MSI 00
> >>>>         Capabilities: [100] Advanced Error Reporting
> >>>>         Capabilities: [148] Device Serial Number
> >> 00-e0-4c-ff-fe-b8-22-01
> >>>>         Capabilities: [158] Latency Tolerance Reporting
> >>>>         Capabilities: [160] L1 PM Substates
> >>>>         Kernel modules: rtwpci
> >>
> >
> > Hi,
> >
> > Please use the attached patch. And RFE type 3 has not been well tested,
> > I am not sure if the quality is expected. But it should work fine I guess.
> > If there is any further problems, just tell me, thanks.
> >
> > Yan-Hsuan
> >
> 
> Hi,
> 
> the above patch doesnt apply anymore on newer kernel sources.
> can we except to see rfe type 3 support in the mainline kernel?
> what can i do to help testing, if testing is still needed?
> 

That's fine, I'll fix the conflicts and send them to mainline.
Also I will try to fix the array usage of the tables, use struct instead.
That was requested by Brian before.

Yan-Hsuan
