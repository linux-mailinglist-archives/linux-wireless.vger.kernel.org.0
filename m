Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB1742BBE6
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 11:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhJMJsG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 05:48:06 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:56739 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhJMJsF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 05:48:05 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 19D9jxpvF004789, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 19D9jxpvF004789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Oct 2021 17:45:59 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 13 Oct 2021 17:45:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 13 Oct 2021 17:45:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Wed, 13 Oct 2021 17:45:58 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull request: rtw89: 8852a: update fw to v0.13.30.0
Thread-Topic: pull request: rtw89: 8852a: update fw to v0.13.30.0
Thread-Index: AdfAFs+Noya6ABOFSO2DBhPxcrac4Q==
Date:   Wed, 13 Oct 2021 09:45:58 +0000
Message-ID: <b3dc77916dc7486eb312e1e44119116b@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/10/13_=3F=3F_06:20:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/13/2021 09:34:45
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166685 [Oct 13 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: github.com:7.1.1;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/13/2021 09:38:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Update firmware of rtw89 driver that get merged.

Ping-Ke

--

The following changes since commit ec17b637b7ab928ca7ebc0389e0e3921f1cc7d17:

  rtw89: 8852a: update fw to v0.13.30.0 (2021-10-13 17:40:46 +0800)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git

for you to fetch changes up to ec17b637b7ab928ca7ebc0389e0e3921f1cc7d17:

  rtw89: 8852a: update fw to v0.13.30.0 (2021-10-13 17:40:46 +0800)

----------------------------------------------------------------

