Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25A44E6DFE
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349575AbiCYGDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiCYGDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E129C681C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P61sZN2011000, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P61sZN2011000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:01:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 14:01:54 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:01:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 00/16] rtw89: refine PCI and MAC codes into function with attributes
Date:   Fri, 25 Mar 2022 14:00:39 +0800
Message-ID: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
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

The existing PCI and MAC codes are only used by 8852AE, so many settings are
put in single function. To be clear, move the settings into an individual
function according to its functionality. Since functions will be shared
with chips, add attributes to make it possible to use common functions.

Also, update the settings to the latest version of our internal code.

This patchset is based on                                                       
 "rtw89: add firmware reset and dump firmware memory and backtrace" and
 "rtw89: update TX power table and 6G, refine IGI, and add TX/RX descriptors V1"
But no actual function dependency.     

Chia-Yuan Li (1):
  rtw89: pci: refine pci pre_init function

Ping-Ke Shih (15):
  rtw89: pci: add register definition to rtw89_pci_info to generalize
    pci code
  rtw89: pci: add pci attributes to configure operating mode
  rtw89: pci: add LTR setting for v1 chip
  rtw89: pci: set address info registers depends on chips
  rtw89: pci: add deglitch setting
  rtw89: pci: add L1 settings
  rtw89: extend dmac_pre_init to support 8852C
  rtw89: update STA scheduler parameters for v1 chip
  rtw89: add chip_ops::{enable,disable}_bb_rf to support v1 chip
  rtw89: Turn on CR protection of CMAC
  rtw89: 8852c: update security engine setting
  rtw89: update scheduler setting
  rtw89: initialize NAV control
  rtw89: update TMAC parameters
  rtw89: update ptcl_init

 drivers/net/wireless/realtek/rtw89/core.c     |   7 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 129 ++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  19 +-
 drivers/net/wireless/realtek/rtw89/pci.c      | 519 +++++++++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h      | 211 +++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 187 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   2 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  30 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  45 ++
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  30 +
 11 files changed, 1080 insertions(+), 101 deletions(-)

-- 
2.25.1

