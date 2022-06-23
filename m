Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54979557215
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 06:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiFWEpt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 00:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbiFWDrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 23:47:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797538BEA
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 20:47:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25N3lHdM5018969, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25N3lHdM5018969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jun 2022 11:47:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 23 Jun 2022 11:47:17 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 23 Jun
 2022 11:47:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 00/13] rtw89: support channel context
Date:   Thu, 23 Jun 2022 11:46:22 +0800
Message-ID: <20220623034635.20964-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 06/23/2022 03:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMjMgpFekyCAxMjo1MTowMA==?=
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

In order to support multiple channels, we prepare this patchset to have
initial skeleton of channel context, and only SCC (single channel
concurrence) is supported for now.

The channel context needs some features, like hardware scan, but not all
chips can support these features, so this implement can still support
chips without channel context. The chip_info defines a support_chanctx_num
field to discriminate a chip can support channel context or not, and we
use this as clue to hook channel context ops of mac80211.

We add a module parameter rtw89_use_chanctx to enable channel context,
but by default set rtw89_use_chanctx=0 to pevent to break users' setup.
When users want channel context to support concurrency, set module
parameter rtw89_use_chanctx=1. If a chip declare it can support channel
context and proper firmware with hardware scan is adopted, it can run with
channel context. Otherwise, it could be failed to probe, users should
set rtw89_use_chanctx=0 or upgrade firmware.

When we concentrate stuffs of channel, some patches with a lot of changes
are used to adjust code for new struct. But, not really change logic.

v2:
 - patch 11/13: add link_id argument because ieee80211 ops prototype are
   changed.
 - patch 13/13: change to use module parameter rtw89_use_chanctx to prevent
   breaking users' setup by default, and users can try to use channel
   context after they upgrade firmware.

Zong-Zhe Yang (13):
  rtw89: rewrite decision on channel by entity state
  rtw89: introduce rtw89_chan for channel stuffs
  rtw89: re-arrange channel related stuffs under HAL
  rtw89: create rtw89_chan centrally to avoid breakage
  rtw89: txpwr: concentrate channel related control to top
  rtw89: rfk: concentrate parameter control while set_channel()
  rtw89: concentrate parameter control for setting channel callback
  rtw89: concentrate chandef setting to stack callback
  rtw89: initialize entity and configure default chandef
  rtw89: introduce entity mode and its recalculated prototype
  rtw89: add skeleton of mac80211 chanctx ops support
  rtw89: support mac80211 chanctx ops by chip
  rtw89: ensure chanctx ops are used with HW scan

 drivers/net/wireless/realtek/rtw89/Makefile   |   1 +
 drivers/net/wireless/realtek/rtw89/chan.c     | 237 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |  66 +++++
 drivers/net/wireless/realtek/rtw89/coex.c     |  11 +-
 drivers/net/wireless/realtek/rtw89/coex.h     |   4 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 260 +++++++++--------
 drivers/net/wireless/realtek/rtw89/core.h     | 149 +++++++---
 drivers/net/wireless/realtek/rtw89/debug.c    |   3 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  84 ++++--
 drivers/net/wireless/realtek/rtw89/mac.c      |  14 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  77 ++++-
 drivers/net/wireless/realtek/rtw89/pci.c      |  11 +-
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
 22 files changed, 1171 insertions(+), 526 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/chan.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/chan.h

-- 
2.25.1

