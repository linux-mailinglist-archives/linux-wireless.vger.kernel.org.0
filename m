Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C916F4F8BB2
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 02:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiDHAQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 20:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiDHAQT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 20:16:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BA91F6359
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 17:14:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2380E81s8019323, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2380E81s8019323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Apr 2022 08:14:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 08:14:07 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 08:14:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH v2 00/13] rtw89: refine interrupt masks for SER, and add H2C for new chip
Date:   Fri, 8 Apr 2022 08:13:40 +0800
Message-ID: <20220408001353.17188-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.190]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/07/2022 23:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyCkVaTIIDEwOjAwOjAw?=
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

SER, standing for System Error Recovery, is triggered by hardware interrupt
with mask settings. Though it is working in firmware, driver needs to
configure masks properly before downloading firmware. Patches 1/13~4/13 are
related to it.

Patches 5/13~9/13 are to add some MAC and BB settings to be expected.

Patches 10/13~12/13 are to add new H2C for new chip to control TX info
and security CAM.

The last one is to fix trivial error of return value handling.

v2: correct register name of
    "rtw89: 8852c: disable firmware watchdog if CPU disabled",
    but not change logic.

Chia-Yuan Li (4):
  rtw89: ser: configure D-MAC interrupt mask
  rtw89: ser: configure C-MAC interrupt mask
  rtw89: 8852c: disable firmware watchdog if CPU disabled
  rtw89: 8852c: add 8852c specific BT-coexistence initial function

Johnson Lin (1):
  rtw89: Skip useless dig gain and igi related settings for 8852C

Ping-Ke Shih (7):
  rtw89: ser: configure top ERR IMR for firmware to recover
  rtw89: change station scheduler setting for hardware TX mode
  rtw89: reset BA CAM
  rtw89: extend H2C of CMAC control info
  rtw89: add new H2C to configure security CAM via DCTL for V1 chip
  rtw89: configure security CAM for V1 chip
  rtw89: pci: correct return value handling of rtw89_write16_mdio_mask()

Zong-Zhe Yang (1):
  rtw89: ser: fix unannotated fall-through

 drivers/net/wireless/realtek/rtw89/cam.c      |   37 +
 drivers/net/wireless/realtek/rtw89/cam.h      |    4 +
 drivers/net/wireless/realtek/rtw89/core.h     |   64 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |   82 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |  349 ++++-
 drivers/net/wireless/realtek/rtw89/mac.c      |  370 ++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |    8 +-
 drivers/net/wireless/realtek/rtw89/pci.c      |    4 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |    9 +-
 drivers/net/wireless/realtek/rtw89/reg.h      | 1243 ++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   48 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  108 ++
 drivers/net/wireless/realtek/rtw89/ser.c      |    1 +
 13 files changed, 2239 insertions(+), 88 deletions(-)

-- 
2.25.1

