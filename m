Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C983F4CCE01
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 07:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiCDGr5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 01:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiCDGrx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 01:47:53 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22918CC21
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 22:47:05 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2246kv5xB011584, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2246kv5xB011584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 4 Mar 2022 14:46:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 14:46:57 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 4 Mar
 2022 14:46:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/13] rtw89: generalize functions shared with 8852CE
Date:   Fri, 4 Mar 2022 14:46:06 +0800
Message-ID: <20220304064619.23662-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/04/2022 06:29:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNCCkV6TIIDA0OjM0OjAw?=
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

The existing common flow can share with 8852CE, so I add chip_info and
chip_ops to share the functions that doesn't change the behavior of
existing chip 8852AE.

In this patchset, I add 8852c files and add chip_info/chip_ops along with
the process to generalize functions. But, I don't build the files, because
it doesn't work unless I have all necessary chip information and functions.

No function dependency, but this patchset is based on another patchset
"rtw89: support hw_scan and tx_wake firmware features".

Ping-Ke Shih (13):
  rtw89: 8852c: add 8852c empty files
  rtw89: pci: add struct rtw89_pci_info
  rtw89: pci: add V1 of PCI channel address
  rtw89: pci: use a struct to describe all registers address related to
    DMA channel
  rtw89: read chip version depends on chip ID
  rtw89: add power_{on/off}_func
  rtw89: add hci_func_en_addr to support variant generation
  rtw89: add chip_info::{h2c,c2h}_reg to support more chips
  rtw89: add page_regs to handle v1 chips
  rtw89: 8852c: add chip::dle_mem
  rtw89: support DAV efuse reading operation
  rtw89: 8852c: process efuse of phycap
  rtw89: 8852c: process logic efuse map

 drivers/net/wireless/realtek/rtw89/core.c     |   3 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  38 ++
 drivers/net/wireless/realtek/rtw89/efuse.c    | 160 +++++-
 drivers/net/wireless/realtek/rtw89/fw.c       |  20 +-
 drivers/net/wireless/realtek/rtw89/mac.c      | 184 ++++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  36 ++
 drivers/net/wireless/realtek/rtw89/pci.c      | 200 ++++----
 drivers/net/wireless/realtek/rtw89/pci.h      |  76 ++-
 drivers/net/wireless/realtek/rtw89/reg.h      | 121 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  36 ++
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   7 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 471 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |  76 +++
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  43 ++
 14 files changed, 1329 insertions(+), 142 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852ce.c

-- 
2.25.1

