Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2B5B13DD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 07:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIHFNm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 01:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHFNl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 01:13:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAEAAB69C1
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 22:13:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2885D8Og8009344, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2885D8Og8009344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 8 Sep 2022 13:13:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 13:13:27 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 8 Sep 2022
 13:13:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <echuang@realtek.com>,
        <phhuang@realtek.com>, <chiuyitang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/9] wifi: rtw89: complete basic features of 8852c
Date:   Thu, 8 Sep 2022 13:12:48 +0800
Message-ID: <20220908051257.25353-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/08/2022 04:54:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvOCCkV6TIIDEyOjQ5OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In this patchset, we turn on basic features low power mode and hardware
scan, and add some fixes found by testing.

Chia-Yuan Li (1):
  wifi: rtw89: set response rate selection

Chin-Yen Lee (2):
  wifi: rtw89: support deep ps mode for rtw8852c
  wifi: rtw89: call tx_wake notify for 8852c in deep ps mode

Eric Huang (1):
  wifi: rtw89: add DIG register struct to share common algorithm

Ping-Ke Shih (2):
  wifi: rtw89: 8852c: enable the interference cancellation of MU-MIMO on
    6GHz
  wifi: rtw89: 8852c: enlarge polling timeout of RX DCK

Po-Hao Huang (2):
  wifi: rtw89: 8852c: support hw_scan
  wifi: rtw89: split scan including lots of channels

Yi-Tang Chiu (1):
  wifi: rtw89: 8852c: set TX to single path TX on path B in 6GHz band

 drivers/net/wireless/realtek/rtw89/core.c     |  8 ++-
 drivers/net/wireless/realtek/rtw89/core.h     | 49 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 25 +++++---
 drivers/net/wireless/realtek/rtw89/fw.h       |  8 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 34 +++++++++--
 drivers/net/wireless/realtek/rtw89/phy.c      | 59 ++++++++++---------
 drivers/net/wireless/realtek/rtw89/reg.h      | 56 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 29 ++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 52 ++++++++++++++--
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  3 +-
 10 files changed, 269 insertions(+), 54 deletions(-)

-- 
2.25.1

