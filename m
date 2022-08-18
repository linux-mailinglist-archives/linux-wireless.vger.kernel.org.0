Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07D9597BD4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 05:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242892AbiHRCz4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 22:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242883AbiHRCzz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 22:55:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E621A571E
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 19:55:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27I2tRioD010744, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27I2tRioD010744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 18 Aug 2022 10:55:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 18 Aug 2022 10:55:40 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 18 Aug
 2022 10:55:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: rtw89: correct MAC and PCI settings
Date:   Thu, 18 Aug 2022 10:55:25 +0800
Message-ID: <20220818025530.9087-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 08/18/2022 02:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTggpFekyCAxMjo0MDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In internal test, we found some problems containing MAC and PCI related
things, so correct them by this patchset.

Chia-Yuan Li (2):
  wifi: rtw89: 8852c: set TBTT shift configuration
  wifi: rtw89: pci: fix PCI PHY auto adaption by using software restore

Chin-Yen Lee (3):
  wifi: rtw89: add retry to change power_mode state
  wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and L1ss for 8852c
  wifi: rtw89: pci: correct suspend/resume setting for variant chips

 drivers/net/wireless/realtek/rtw89/mac.c |  44 +++-
 drivers/net/wireless/realtek/rtw89/mac.h |   1 +
 drivers/net/wireless/realtek/rtw89/pci.c | 258 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h |  39 ++++
 drivers/net/wireless/realtek/rtw89/reg.h |  14 ++
 5 files changed, 318 insertions(+), 38 deletions(-)

-- 
2.25.1

