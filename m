Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20655418D79
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 03:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhI0BaA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Sep 2021 21:30:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39197 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhI0BaA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Sep 2021 21:30:00 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 18R1S8Fn8025807, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 18R1S8Fn8025807
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Sep 2021 09:28:08 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 27 Sep 2021 09:28:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 27 Sep 2021 09:28:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Mon, 27 Sep 2021 09:28:07 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "andy200511@126.com" <andy200511@126.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Authentication Failure when target WiFi's signal strength is below 40% (rtw89)
Thread-Topic: Authentication Failure when target WiFi's signal strength is
 below 40% (rtw89)
Thread-Index: AQHXscRxDEiLbdM4IESPiClNRvGXtqu3GE4g
Date:   Mon, 27 Sep 2021 01:28:07 +0000
Message-ID: <897b9605327946a0b0d774dd3c0dbdd2@realtek.com>
References: <2931264.cLPqxE5pUp@omenarch>
In-Reply-To: <2931264.cLPqxE5pUp@omenarch>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/9/26_=3F=3F_10:29:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: andy200511@126.com <andy200511@126.com>
> Sent: Saturday, September 25, 2021 11:48 AM
> To: linux-wireless@vger.kernel.org
> Subject: Authentication Failure when target WiFi's signal strength is below
> 40% (rtw89)
> 
> Hello, dear Realtek engineers:
> I am a user of the RTL8852AE card with the rtw89 kernel driver's unofficial
> DKMS module AUR package
> (https://aur.archlinux.org/packages/rtw89-dkms-git/). I have experienced
> some issue of authentication when I tried to connect to a 5Ghz WiFi when its
> signal strength is below 40%. The specific problem is even when I give the
> correct password, the system keeps asking me to provide the password again
> (using KDE's NetworkManager, unsure if it is related and have not yet tested
> with other wifi managers). This issue solves when I move closer to my router
> to gain more signal strength.
> Here is the output of dmesg:
> http://fars.ee/00U7
> 
> 

Hi,

We have fixed similar symptom by v6 submitted on end of August, but
the last update of DKMS module you took is 2021-07-08 06:29.
So, I suggest to try the novel version of rtw89, and use the novel
firmware as well. Please reference to [1]

[1] https://lore.kernel.org/linux-wireless/20210820043538.12424-1-pkshih@realtek.com/

--
Ping-Ke

