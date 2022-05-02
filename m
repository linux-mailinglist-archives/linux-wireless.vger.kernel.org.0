Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40223517B11
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 01:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiECAAa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 20:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiEBX6A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 19:58:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD6340E0
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 16:54:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 242NsBLP1015632, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 242NsBLP1015632
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 May 2022 07:54:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 3 May 2022 07:54:11 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 3 May
 2022 07:54:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 0/8] rtw89: 8852c: add RF calibration
Date:   Tue, 3 May 2022 07:54:00 +0800
Message-ID: <20220502235408.15052-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 05/02/2022 23:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMiCkVaTIIDEwOjAxOjAw?=
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

These RFK (RF calibration) can be called once interface is going up, or
when we are going to connect to AP in certain channel, or band is changed.
The general steps of calibration are to backup registers (optional) and
set a set of registers before doing calibration according to channels or
something else, and then trigger the calibration and poll if calibration
is complete. Then, check the result is positive or not to decide to
adjust parameters and re-trigger again. If the result is okay, set
registers accordingly, and restore registers we backup before (optional).

v3:
    - shrink number of patches from 16 to 8
    - add blank lines to make code more readable
    - use upper case for macros name with proper prefix
    - move const tables upward to top of .c file
v2: add patch 15 to fix clang warning

Ping-Ke Shih (8):
  rtw89: 8852c: rfk: add RFK tables
  rtw89: 8852c: rfk: add DACK
  rtw89: 8852c: rfk: add LCK
  rtw89: 8852c: rfk: add TSSI
  rtw89: 8852c: rfk: add RCK
  rtw89: 8852c: rfk: add RX DCK
  rtw89: 8852c: rfk: add IQK
  rtw89: 8852c: rfk: add DPK

 drivers/net/wireless/realtek/rtw89/core.h     |   19 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |  211 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   34 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 3825 ++++++++++++++++-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |   13 +
 .../realtek/rtw89/rtw8852c_rfk_table.c        |  781 ++++
 .../realtek/rtw89/rtw8852c_rfk_table.h        |   67 +
 8 files changed, 4930 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.h

-- 
2.25.1

