Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8059C64F933
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiLQOSO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLQOSM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:18:12 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93D0BA1AA
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:18:11 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BHEH6q04024801, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BHEH6q04024801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 17 Dec 2022 22:17:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Sat, 17 Dec 2022 22:17:57 +0800
Received: from localhost (172.16.16.141) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 17 Dec
 2022 22:17:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/7] wifi: rtw89: add BTC format version to support newer firmware and features
Date:   Sat, 17 Dec 2022 22:17:38 +0800
Message-ID: <20221217141745.43291-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.141]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/17/2022 14:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE3IKRXpMggMTE6MjQ6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With more chips support, BT coexistence needs to handle newer firmware and
features. In vendor driver, versions of BT coexistence, firmware and
features are all fixed, which means it doesn't consider that a BT
coexistence can work well with _all_ firmware; instead, rtw89 must be.

The method we propose in this patchset is to add a btc_ver, namely
'struct rtw89_btc_ver', to define BTC formation version for specific
chip and firmware version. Also, this can be extended to define which
BTC features firmware can support.

Therefore, we define btc_ver in first patch, and then remove old design
version number from chip_info by second patch. Later patches are to adjust
the code to close our desire step by step.

To review easier, we keep patches smaller and backward compatible, so the
number of total patches is about 20+, and this patchset only contains
partial patches.

Ching-Te Ku (5):
  wifi: rtw89: coex: Enable Bluetooth report when show debug info
  wifi: rtw89: coex: Update BTC firmware report bitmap definition
  wifi: rtw89: coex: Add v2 BT AFH report and related variable
  wifi: rtw89: coex: refactor _chk_btc_report() to extend more features
  wifi: rtw89: coex: Change TDMA related logic to version separate

Ping-Ke Shih (2):
  wifi: rtw89: coex: add BTC format version derived from firmware
    version
  wifi: rtw89: coex: use new introduction BTC version format

 drivers/net/wireless/realtek/rtw89/coex.c     | 792 +++++++++++-------
 drivers/net/wireless/realtek/rtw89/coex.h     |   1 +
 drivers/net/wireless/realtek/rtw89/core.h     | 106 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  14 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  15 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  14 -
 7 files changed, 581 insertions(+), 363 deletions(-)

-- 
2.25.1

