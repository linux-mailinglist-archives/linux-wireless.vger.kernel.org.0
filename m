Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B213DD09A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 08:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhHBGcc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 02:32:32 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40026 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhHBGcc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 02:32:32 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1726WEmaC014975, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1726WEmaC014975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 2 Aug 2021 14:32:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 2 Aug 2021 14:32:14 +0800
Received: from localhost (172.16.21.121) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 2 Aug 2021
 14:32:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 0/4] rtw88: update regulartory mapping and adaptivity
Date:   Mon, 2 Aug 2021 14:31:36 +0800
Message-ID: <20210802063140.25670-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.121]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/02/2021 06:13:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMiCkV6TIIDA2OjAxOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/02/2021 06:21:01
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165335 [Aug 01 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/02/2021 06:23:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mapping table of regulatory, which manages tx power limit, is updated, and
we update the mapping architecture according to this change. In order to
choose proper regulatory domain from this table, we regard efuse value and
regulatory hint. With proper regulatory domain, we can have adaptivity for
ETSI/JP DFS region, and also have a firmware version of adaptivity.

Chin-Yen Lee (1):
  rtw88: move adaptivity mechanism to firmware

Zong-Zhe Yang (3):
  rtw88: upgrade rtw_regulatory mechanism and mapping
  rtw88: add regulatory strategy by chip type
  rtw88: support adaptivity for ETSI/JP DFS region

 drivers/net/wireless/realtek/rtw88/debug.c    |  41 +-
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/fw.c       |  47 ++
 drivers/net/wireless/realtek/rtw88/fw.h       |  24 +
 drivers/net/wireless/realtek/rtw88/main.c     |  14 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  48 +-
 drivers/net/wireless/realtek/rtw88/phy.c      | 119 ++-
 drivers/net/wireless/realtek/rtw88/phy.h      |   2 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   5 +
 drivers/net/wireless/realtek/rtw88/regd.c     | 753 ++++++++++--------
 drivers/net/wireless/realtek/rtw88/regd.h     |   8 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  46 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |   8 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  47 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |   3 +
 16 files changed, 844 insertions(+), 325 deletions(-)

-- 
2.25.1

