Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671D557F845
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiGYCgA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jul 2022 22:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYCf6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jul 2022 22:35:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C97AE014
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 19:35:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26P2ZVEy8014702, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26P2ZVEy8014702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 Jul 2022 10:35:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 25 Jul 2022 10:35:37 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 25 Jul
 2022 10:35:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/9] rtw89: coex: add materials to support 8852C
Date:   Mon, 25 Jul 2022 10:35:00 +0800
Message-ID: <20220725023509.43114-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/25/2022 02:16:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMjQgpFWkyCAxMToyOTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8852C use new format and registers for BT coexistence mechanism. Some
existing codes aren't suitable for 8852C, and then need to correct them.

The patchset depends on another patchset "rtw89: support channel context"
due to structure but not functional conflicts.

v2: fix NULL pointer access if 8852A is adopted

Ching-Te Ku (9):
  rtw89: coex: update radio state for RTL8852A/RTL8852C
  rtw89: coex: Move Wi-Fi firmware coexistence matching version to chip
  rtw89: coex: Add logic to parsing rtl8852c firmware type ctrl report
  rtw89: coex: Define BT B1 slot length
  rtw89: coex: Add v1 version TDMA format and parameters
  rtw89: coex: update WL role info v1 for RTL8852C branch using
  rtw89: coex: Move _set_policy to chip_ops
  rtw89: coex: Add v1 Wi-Fi SCC coexistence policy
  rtw89: coex: Update Wi-Fi driver/firmware TDMA cycle report for
    RTL8852c

 drivers/net/wireless/realtek/rtw89/coex.c     | 1111 +++++++++++++++--
 drivers/net/wireless/realtek/rtw89/coex.h     |    2 +
 drivers/net/wireless/realtek/rtw89/core.h     |  241 +++-
 drivers/net/wireless/realtek/rtw89/fw.c       |  113 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |   88 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   15 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   33 +-
 7 files changed, 1378 insertions(+), 225 deletions(-)

-- 
2.25.1

