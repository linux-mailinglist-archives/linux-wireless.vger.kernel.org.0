Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297CF5183B3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 14:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiECMER (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 May 2022 08:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiECMDy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 May 2022 08:03:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2118F15A22
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 05:00:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 243C09Wz8004791, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 243C09Wz8004791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 May 2022 20:00:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 20:00:09 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 3 May
 2022 20:00:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] rtw89: 8852c: add 8852ce to Makefile and Kconfig
Date:   Tue, 3 May 2022 19:59:53 +0800
Message-ID: <20220503120001.79272-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 05/03/2022 11:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMyCkV6TIIDEwOjAxOjAw?=
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

After this patchset, basic functions are ready, so we can enable 8852ce.
It can play as STA, AP and monitor modes. The BT coexistence and power save
are still cooking, but these don't affect the performance of Wi-Fi only.

These patchset contains a patch to send RF calibration settings to
firmware. Patches 2-3 are to add necessary chip_ops and chip_info.

Patch 4 is to fine tune polling interval to enter/leave low power mode.
Since 8852ce will do this more frequently, polling interval become more
important.

Patch 5-6 are to correct registers settings found when we develop 8852ce.

Patch 7 is to fix compiler warnings reported by clang.

Final patch is to add 8852ce to Makefile and Kconfig, and then user can
use it with firmware version 0.27.20.0 that has been merged.

Ping-Ke Shih (8):
  rtw89: 8852c: rfk: get calibrated channels to notify firmware
  rtw89: 8852c: add chip_ops::bb_ctrl_btc_preagc
  rtw89: 8852c: add basic and remaining chip_info
  rtw89: ps: fine tune polling interval while changing low power mode
  rtw89: correct AID settings of beamformee
  rtw89: 8852c: correct register definitions used by 8852c
  rtw89: 8852c: fix warning of FIELD_PREP() mask type
  rtw89: 8852c: add 8852ce to Makefile and Kconfig

 drivers/net/wireless/realtek/rtw89/Kconfig    |  18 +-
 drivers/net/wireless/realtek/rtw89/Makefile   |   9 +
 drivers/net/wireless/realtek/rtw89/mac.c      |   7 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 157 ++++++++++++++++--
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  18 ++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |   1 +
 7 files changed, 203 insertions(+), 15 deletions(-)

-- 
2.25.1

