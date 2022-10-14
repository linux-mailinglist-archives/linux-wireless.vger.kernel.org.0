Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC415FE8A1
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 08:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJNGEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 02:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJNGEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 02:04:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AEEB1ABEC6
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 23:03:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29E62S7R0023528, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29E62S7R0023528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Oct 2022 14:02:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 14 Oct 2022 14:02:58 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 14 Oct
 2022 14:02:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: 8852b: add RF calibration part 2 and enable 8852BE
Date:   Fri, 14 Oct 2022 14:02:33 +0800
Message-ID: <20221014060237.29050-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/14/2022 05:44:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzE0IKRXpMggMDM6MTg6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

After this patchset, 8852BE is ready, so add 8852BE to Kconfig and
Makefile. With firmware v0.27.32.0, STA, AP and monitor can work well. 

This patchset depdens on "wifi: rtw89: 8852b: add RF calibration part 1"

Ping-Ke Shih (4):
  wifi: rtw89: 8852b: rfk: add DPK
  wifi: rtw89: 8852b: add chip_ops related to RF calibration
  wifi: rtw89: phy: add dummy C2H handler to avoid warning message
  wifi: rtw89: 8852b: add 8852be to Makefile and Kconfig

 drivers/net/wireless/realtek/rtw89/Kconfig    |   14 +
 drivers/net/wireless/realtek/rtw89/Makefile   |    9 +
 drivers/net/wireless/realtek/rtw89/core.h     |    1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |    4 +
 drivers/net/wireless/realtek/rtw89/phy.h      |    9 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   17 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   42 +
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 1148 +++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |    3 +
 9 files changed, 1247 insertions(+)

-- 
2.25.1

