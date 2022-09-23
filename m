Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034FF5E7466
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 08:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiIWGyQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIWGyN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 02:54:13 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 490C9128A3D
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 23:54:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28N6rTcF5020779, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28N6rTcF5020779
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 23 Sep 2022 14:53:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 23 Sep 2022 14:53:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 23 Sep
 2022 14:53:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/9] wifi: rtw89: adjust shared code to support 8852BE
Date:   Fri, 23 Sep 2022 14:53:02 +0800
Message-ID: <20220923065311.123356-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/23/2022 06:38:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjMgpFekyCAwMzozMDowMA==?=
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

8852BE is a WiFi 6 chip. Its features are similar to 8852AE, but only
support single one channel context, so mask out unsupported MAC and PCI
channels for 8852BE. First three patches do this thing.

The remaining patches are to adjust other specific things for 8852BE.

Ping-Ke Shih (9):
  wifi: rtw89: pci: mask out unsupported TX channels
  wifi: rtw89: mac: define DMA channel mask to avoid unsupported
    channels
  wifi: rtw89: add DMA busy checking bits to chip info
  wifi: rtw89: 8852b: implement chip_ops::{enable,disable}_bb_rf
  wifi: rtw89: pci: add to do PCI auto calibration
  wifi: rtw89: pci: set power cut closed for 8852be
  wifi: rtw89: mac: correct register of report IMR
  wifi: rtw89: check DLE FIFO size with reserved size
  wifi: rtw89: 8852b: configure DLE mem

 drivers/net/wireless/realtek/rtw89/core.c     |  4 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  5 +-
 drivers/net/wireless/realtek/rtw89/mac.c      | 47 ++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h      | 15 ++-
 drivers/net/wireless/realtek/rtw89/pci.c      | 46 +++++++--
 drivers/net/wireless/realtek/rtw89/pci.h      | 13 ++-
 drivers/net/wireless/realtek/rtw89/reg.h      | 11 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  3 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 94 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852be.c    | 25 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  7 +-
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  3 +-
 13 files changed, 252 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852be.c

-- 
2.25.1

