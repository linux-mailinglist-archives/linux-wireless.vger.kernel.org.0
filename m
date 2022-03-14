Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC0D4D7B5E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 08:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiCNHOz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 03:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCNHOx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 03:14:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77803E09C
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 00:13:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22E7DaWvA003272, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22E7DaWvA003272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Mar 2022 15:13:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 14 Mar 2022 15:13:35 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 15:13:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 0/8] rtw89: add firmware reset and dump firmware memory and backtrace
Date:   Mon, 14 Mar 2022 15:12:42 +0800
Message-ID: <20220314071250.40292-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/14/2022 06:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTQgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

Add a debugfs entry to trigger firmware reset manually, and then SER
(System Error Recovery) will catch the error and dump memory and backtrace
before calling ieee80211_restart_hw().

During development of this feature, we found some issues related to SER,
so fix them in this patchset as well.

Zong-Zhe Yang (8):
  rtw89: ser: fix CAM leaks occurring in L2 reset
  rtw89: mac: move table of mem base addr to common
  rtw89: mac: correct decision on error status by scenario
  rtw89: ser: control hci interrupts on/off by state
  rtw89: ser: dump memory for fw payload engine while L2 reset
  rtw89: ser: dump fw backtrace while L2 reset
  rtw89: reconstruct fw feature
  rtw89: support FW crash simulation

 drivers/net/wireless/realtek/rtw89/cam.c      |  14 +-
 drivers/net/wireless/realtek/rtw89/core.c     |   5 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  38 ++-
 drivers/net/wireless/realtek/rtw89/debug.c    |  70 +++--
 drivers/net/wireless/realtek/rtw89/fw.c       |  89 ++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  23 ++
 drivers/net/wireless/realtek/rtw89/mac.c      |  32 ++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  10 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   4 +-
 drivers/net/wireless/realtek/rtw89/pci.c      |  29 +++
 drivers/net/wireless/realtek/rtw89/pci.h      |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/ser.c      | 245 +++++++++++++++++-
 14 files changed, 516 insertions(+), 47 deletions(-)

-- 
2.25.1

