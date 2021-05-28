Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8DA393BEB
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 05:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhE1Dav (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 23:30:51 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39334 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhE1Dat (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 23:30:49 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 14S3T7oS4003303, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 14S3T7oS4003303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 May 2021 11:29:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 28 May 2021 11:29:07 +0800
Received: from localhost (172.16.16.242) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 28 May
 2021 11:29:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 0/2] rtw88: dump firmware log by devcoredump and refine unwanted H2C
Date:   Fri, 28 May 2021 11:28:59 +0800
Message-ID: <20210528032901.12927-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.242]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/28/2021 03:00:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzUvMjggpFekyCAwMjoxOTowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-KSE-AntiSpam-Interceptor-Info: bases corrupted
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset depends on previous one; 
"[PATCH 0/2] rtw88: add scan notify to firmware and refine fw_feature check".
The content isn't highly related, but it leads conflict if the order is wrong.

Po-Hao Huang (1):
  rtw88: refine unwanted h2c command

Zong-Zhe Yang (1):
  rtw88: dump FW crash via devcoredump

 drivers/net/wireless/realtek/rtw88/debug.c    |   7 +
 drivers/net/wireless/realtek/rtw88/fw.c       |   7 +-
 drivers/net/wireless/realtek/rtw88/main.c     | 170 ++++++++++++------
 drivers/net/wireless/realtek/rtw88/main.h     |  37 +++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  51 +++++-
 5 files changed, 203 insertions(+), 69 deletions(-)

-- 
2.25.1

