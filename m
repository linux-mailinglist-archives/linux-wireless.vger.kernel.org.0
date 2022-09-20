Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59095BD92C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 03:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiITBLW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 21:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiITBKu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 21:10:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA9884DB56
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 18:10:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28K19s9M2031030, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28K19s9M2031030
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Sep 2022 09:09:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Sep 2022 09:10:16 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 20 Sep
 2022 09:10:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/9] wifi: rtw89: coex: complete BT-coexistence feature for 8852C
Date:   Tue, 20 Sep 2022 09:09:30 +0800
Message-ID: <20220920010939.12173-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/20/2022 00:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTkgpFWkyCAwNzowODowMA==?=
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

This is the last patchset to complete BT-coexistence feature for 8852C, so
users can smoothly use BT and WiFi simultaneously after this.

The former 4 patches in this patchset are to add debug things, and
remaining patches are to add to improve performance. Since BT-coexsitence
highly depends on exchange messages of WiFi and BT firmware, the final
patch is to update BT-coexistence version to help checking dependency
between them.

Ching-Te Ku (9):
  wifi: rtw89: coex: add v1 cycle report to parsing Bluetooth A2DP
    status
  wifi: rtw89: coex: translate slot ID to readable name
  wifi: rtw89: coex: add v1 summary info to parse the traffic status
    from firmware
  wifi: rtw89: coex: add v1 Wi-Fi firmware steps report
  wifi: rtw89: coex: add WL_S0 hardware TX/RX mask to allow WL_S0 TX/RX
    during GNT_BT
  wifi: rtw89: coex: modify LNA2 setting to avoid BT destroyed Wi-Fi
    aggregation
  wifi: rtw89: coex: summarize Wi-Fi to BT scoreboard and inform BT one
    time a cycle
  wifi: rtw89: coex: add logic to control BT scan priority
  wifi: rtw89: coex: update coexistence to 6.3.0

 drivers/net/wireless/realtek/rtw89/coex.c     | 449 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  55 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  60 ++-
 4 files changed, 527 insertions(+), 55 deletions(-)

-- 
2.25.1

