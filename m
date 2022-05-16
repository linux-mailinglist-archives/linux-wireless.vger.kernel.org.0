Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BDD527B20
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 02:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiEPAwh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 May 2022 20:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiEPAwf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 May 2022 20:52:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C64D252B5
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 17:52:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24G0qQKS1000784, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24G0qQKS1000784
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 May 2022 08:52:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 16 May 2022 08:52:26 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 16 May
 2022 08:52:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH v2 0/6] rtw89: add missing functions and fix misbehavior found by verification
Date:   Mon, 16 May 2022 08:52:09 +0800
Message-ID: <20220516005215.5878-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 05/16/2022 00:38:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMTUgpFWkyCAxMDowMDowMA==?=
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

To continuously verify 8852ce, we add a patch to set TX antenna path to do
TX power measurement, so we also update the power table to ensure TX power
as expectation.

During verification, we got some messages from supplicant and kernel, and
then add ieee80211::sta_rc_update and fix a out-of-bounds issue.

In endurance test, it get stuck because SER interrupt event isn't handled
properly. Fix it by the last patch.

v2: Use SI terminology to describe frequencies in commit messages.

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

