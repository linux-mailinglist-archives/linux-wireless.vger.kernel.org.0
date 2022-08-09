Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D707A58D797
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 12:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbiHIKuj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 06:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiHIKu3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 06:50:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 149F426F4
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 03:50:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 279Ao6731018813, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 279Ao6731018813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 9 Aug 2022 18:50:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 9 Aug 2022 18:50:16 +0800
Received: from localhost (172.16.16.191) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Aug 2022
 18:50:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 00/13] rtw89: support channel context
Date:   Tue, 9 Aug 2022 18:49:39 +0800
Message-ID: <20220809104952.61355-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.191]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2022 10:19:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvOSCkV6TIIDA4OjU0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to support multiple channels, we prepare this patchset to have
initial skeleton of channel context, and only SCC (single channel
concurrence) is supported for now.

The channel context needs some features, like hardware scan, but not all
chips can support these features, so this implement can still support
chips without channel context. The chip_info defines a support_chanctx_num
field to discriminate a chip can support channel context or not, and we
use this as clue to hook channel context ops of mac80211.

To determine if it can use channel context, load firmware header and parse
firmware when probing before ieee80211_register_hw(). If chip defines it
support channel context but firmware doesn't support hw_scan, it falls
back to not use channel context. That means end users don't need
additional update to use this driver after this patchset.

When we concentrate stuffs of channel, some patches with a lot of changes
are used to adjust code for new struct. But, not really change logic.

v3:
 - to have good user experience after applying this patchset. Load firmware
   header and parse firmware features to determine if we can use channel
   context. If old firmware is adopted, it still can run well as original.

v2:
 - patch 11/13: add link_id argument because ieee80211 ops prototype are
   changed.
 - patch 13/13: change to use module parameter rtw89_use_chanctx to prevent
   breaking users' setup by default, and users can try to use channel
   context after they upgrade firmware.

Zong-Zhe Yang (13):
  wifi: rtw89: rewrite decision on channel by entity state
  wifi: rtw89: introduce rtw89_chan for channel stuffs
  wifi: rtw89: re-arrange channel related stuffs under HAL
  wifi: rtw89: create rtw89_chan centrally to avoid breakage
  wifi: rtw89: txpwr: concentrate channel related control to top
  wifi: rtw89: rfk: concentrate parameter control while set_channel()
  wifi: rtw89: concentrate parameter control for setting channel
    callback
  wifi: rtw89: concentrate chandef setting to stack callback
  wifi: rtw89: initialize entity and configure default chandef
  wifi: rtw89: introduce entity mode and its recalculated prototype
  wifi: rtw89: add skeleton of mac80211 chanctx ops support
  wifi: rtw89: declare support for mac80211 chanctx ops by chip
  wifi: rtw89: early recognize FW feature to decide if chanctx

 drivers/net/wireless/realtek/rtw89/Makefile   |   1 +
 drivers/net/wireless/realtek/rtw89/chan.c     | 235 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |  64 +++++
 drivers/net/wireless/realtek/rtw89/coex.c     |  11 +-
 drivers/net/wireless/realtek/rtw89/coex.h     |   4 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 263 +++++++++--------
 drivers/net/wireless/realtek/rtw89/core.h     | 157 ++++++++---
 drivers/net/wireless/realtek/rtw89/debug.c    |   3 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  72 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  12 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  14 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  77 ++++-
 drivers/net/wireless/realtek/rtw89/pci.c      |  20 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 266 +++++++++++-------
 drivers/net/wireless/realtek/rtw89/phy.h      |   8 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 111 +++++---
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  77 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 231 ++++++++-------
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  73 +++--
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |   2 +-
 drivers/net/wireless/realtek/rtw89/sar.c      |   8 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |   2 +
 23 files changed, 1185 insertions(+), 528 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/chan.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/chan.h

-- 
2.25.1

