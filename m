Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5C2525B11
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 07:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377102AbiEMFm5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 01:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiEMFmy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 01:42:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446971D89F0
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 22:42:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24D5ga663005661, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24D5ga663005661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 May 2022 13:42:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 13 May 2022 13:42:36 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 13 May
 2022 13:42:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 0/6] rtw89: add missing functions and fix misbehavior found by verification
Date:   Fri, 13 May 2022 13:42:18 +0800
Message-ID: <20220513054224.16902-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 05/13/2022 05:24:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMTIgpFWkyCAxMDo1OTowMA==?=
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

To continuously verify 8852ce, we add a patch to set TX antenna path to do
TX power measurement, so we also update the power table to ensure TX power
as expectation.

During verification, we got some messages from supplicant and kernel, and
then add ieee80211::sta_rc_update and fix a out-of-bounds issue.

In endurance test, it get stuck because SER interrupt event isn't handled
properly. Fix it by the last patch.

Ping-Ke Shih (4):
  rtw89: add ieee80211::sta_rc_update ops
  rtw89: 8852c: set TX antenna path
  rtw89: cfo: check mac_id to avoid out-of-bounds
  rtw89: pci: only mask out INT indicator register for disable interrupt
    v1

Zong-Zhe Yang (2):
  rtw89: 8852c: update txpwr tables to HALRF_027_00_052
  rtw89: convert rtw89_band to nl80211_band precisely

 drivers/net/wireless/realtek/rtw89/core.c     |   11 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   14 +
 drivers/net/wireless/realtek/rtw89/fw.c       |    2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   12 +-
 drivers/net/wireless/realtek/rtw89/pci.c      |    3 -
 drivers/net/wireless/realtek/rtw89/phy.c      |   30 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |    3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    9 +-
 .../wireless/realtek/rtw89/rtw8852c_table.c   | 3714 ++++++++---------
 9 files changed, 1918 insertions(+), 1880 deletions(-)

-- 
2.25.1

