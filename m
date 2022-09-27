Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D795EBAA2
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 08:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiI0G2P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 02:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiI0G2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 02:28:11 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CC80855B8
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 23:28:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28R6Qdy16008369, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28R6Qdy16008369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 27 Sep 2022 14:26:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:27:04 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 27 Sep
 2022 14:27:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/9] wifi: rtw89: adjust shared code to support 8852BE
Date:   Tue, 27 Sep 2022 14:26:02 +0800
Message-ID: <20220927062611.30484-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/27/2022 06:02:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjcgpFekyCAwNDo1MzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8852BE is a WiFi 6 chip. Its features are similar to 8852AE, but only
support single one channel context, so mask out unsupported MAC and PCI
channels for 8852BE. First three patches do this thing.

The remaining patches are to adjust other specific things for 8852BE.

v2: failed to apply v1, so do rebase to the latest codebase.

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

