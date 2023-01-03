Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B0965C16F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 15:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbjACODh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 09:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbjACODT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 09:03:19 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA4E5101E1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 06:03:18 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 303E28Yn8016613, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 303E28Yn8016613
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 3 Jan 2023 22:02:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Jan 2023 22:03:04 +0800
Received: from localhost (172.16.19.22) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Jan 2023
 22:03:04 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/7] wifi: rtw89: coex: second patchset to adopt BTC version
Date:   Tue, 3 Jan 2023 22:02:31 +0800
Message-ID: <20230103140238.15601-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.19.22]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/03/2023 13:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMyCkVaTIIDAxOjA0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In former patchset, we introduce BTC version to support various firmware
version and features, and this is second patchset to adjust code to adopt
BTC version step by step.

There are about 10 remaining patches that will separate into two patchset,
and will send out later.

Ching-Te Ku (7):
  wifi: rtw89: coex: Remove le32 to CPU translator at firmware cycle
    report
  wifi: rtw89: coex: Rename BTC firmware cycle report by feature version
  wifi: rtw89: coex: Add v4 version firmware cycle report
  wifi: rtw89: coex: Change firmware control report to version separate
  wifi: rtw89: coex: Add v5 firmware control report
  wifi: rtw89: coex: only read Bluetooth counter of report version 1 for
    RTL8852A
  wifi: rtw89: coex: Update WiFi role info H2C report

 drivers/net/wireless/realtek/rtw89/coex.c     | 687 ++++++++++++------
 drivers/net/wireless/realtek/rtw89/core.h     | 122 +++-
 drivers/net/wireless/realtek/rtw89/fw.c       |  36 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   4 +
 4 files changed, 617 insertions(+), 232 deletions(-)

-- 
2.25.1

