Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEF439D355
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jun 2021 05:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFGDS7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Jun 2021 23:18:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:41440 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFGDS6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Jun 2021 23:18:58 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1573H3V60025084, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1573H3V60025084
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Jun 2021 11:17:03 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Jun 2021 11:17:03 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Jun 2021 11:17:02 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5dd5:a082:ce5b:82b5]) by
 RTEXMBS03.realtek.com.tw ([fe80::5dd5:a082:ce5b:82b5%3]) with mapi id
 15.01.2106.013; Mon, 7 Jun 2021 11:17:02 +0800
From:   Steven Ting <steventing@realtek.com>
To:     "johannes.berg@intel.com" <johannes.berg@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Is the extra_tx_headroom guarenteed ?
Thread-Topic: Is the extra_tx_headroom guarenteed ?
Thread-Index: AddbSjppmAX3DQgITcSrSZZ1Rzj0gw==
Date:   Mon, 7 Jun 2021 03:17:02 +0000
Message-ID: <f045bc11c75e4603bf58f3d596448c7e@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.218]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/6/6_=3F=3F_11:20:00?=
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
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/07/2021 03:03:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164137 [Jun 06 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: steventing@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/07/2021 03:06:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes and all mac80211 gurus,

We encountered a problem that we use the extra_tx_headroom to reserve the headroom
which we put the txdesc in.

Current workaround is that we check our needed headroom size by skb_headroom()
in the driver layer.

Is extra_tx_headroom in struct ieee80211_hw always guaranteed?
The header file describes:
* @extra_tx_headroom: headroom to reserve in each transmit skb
*      for use by the driver (e.g. for transmit headers.)

But when the skb goes through the ieee80211_amsdu_realloc_pad(), it does not
take care of the extra_tx_headroom, i.e. the original reserved headroom might be
eaten.

Does the ieee80211_amsdu_realloc_pad() lacks some check for extra_tx_headroom
or the extra_tx_headroom in mac80211 is not guaranteed?

Furthermore, for the packet that would not be aggregate in A-MSDU and ndev->needed_headroom
is not guaranteed, in this case whether mac80211 layer still guarantee the extra_tx_headroom ?

Or mac80211 only guarantees the headroom of the skb which is built by itself ?

Steven
