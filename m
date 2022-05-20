Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E240152E609
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 09:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiETHSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 03:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiETHSc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 03:18:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68F921E36
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 00:17:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24K7HnT92023699, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24K7HnT92023699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 May 2022 15:17:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 20 May 2022 15:17:49 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 20 May
 2022 15:17:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 0/6] rtw89: fix HW scan and complement some functions
Date:   Fri, 20 May 2022 15:17:25 +0800
Message-ID: <20220520071731.38563-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/20/2022 06:55:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjAgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Patches in this patchset don't have functional dependency, but I submit
them together to prevent merge conflict.

Fix some bugs related HW scan by first two patches. Third patch is to
handle more one SER event to recover firmware and hardware. Forth patch
is to re-calibrate RX DCK if thermal value is changed, and then we can
keep RF performance as expectation.

Since 8852CE can support 6GHz band, add SAR 6GHz frequency ranges by
fifth patch.

The last patch is to fix BSSID mask setting introduced by 8852CE chip,
and I do support of multiple BSSID as well.

Ping-Ke Shih (3):
  rtw89: pci: handle hardware watchdog timeout interrupt status
  rtw89: 8852c: rfk: re-calibrate RX DCK once thermal changes a lot
  rtw89: support MULTI_BSSID and correct BSSID mask of H2C

Po Hao Huang (2):
  rtw89: fix channel inconsistency during hw_scan
  rtw89: fix null vif pointer when hw_scan fails

Zong-Zhe Yang (1):
  rtw89: sar: adjust and support SAR on 6GHz band

 drivers/net/wireless/realtek/rtw89/cam.c      |   9 ++
 drivers/net/wireless/realtek/rtw89/cam.h      |   5 +
 drivers/net/wireless/realtek/rtw89/core.c     |   8 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  24 ++-
 drivers/net/wireless/realtek/rtw89/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  24 ++-
 drivers/net/wireless/realtek/rtw89/fw.h       |   5 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  15 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   2 +-
 drivers/net/wireless/realtek/rtw89/pci.c      |   9 +-
 drivers/net/wireless/realtek/rtw89/pci.h      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  27 ++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |   1 +
 drivers/net/wireless/realtek/rtw89/sar.c      | 140 +++++++++++++++---
 16 files changed, 230 insertions(+), 43 deletions(-)

-- 
2.25.1

