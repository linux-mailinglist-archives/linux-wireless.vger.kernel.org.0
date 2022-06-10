Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2094E545D59
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbiFJH1P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346504AbiFJH0v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:26:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC44121CFB
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:26:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25A7QgpP6010099, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25A7QgpP6010099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jun 2022 15:26:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 15:26:42 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 10 Jun
 2022 15:26:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 00/11] rtw89: add TDLS and various fixes
Date:   Fri, 10 Jun 2022 15:25:59 +0800
Message-ID: <20220610072610.27095-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 06/10/2022 07:06:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTAgpFekyCAwNjowMDowMA==?=
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

Patch 1/11 ~ 4/11 are related to TDLS. To support TDLS, we need to create
CAM entries like STA in AP mode. Besides, it also needs BSSID CAM by
hardware design.

The remaining patches are to fix various issues met in field, so fix them.

Since patches have dependency, I submit them together.

Kuan-Chung Chen (2):
  rtw89: fix potential TX stuck
  rtw89: enable VO TX AMPDU

Ping-Ke Shih (8):
  rtw89: allocate address CAM and MAC ID to TDLS peer
  rtw89: separate BSSID CAM operations
  rtw89: allocate BSSID CAM per TDLS peer
  rtw89: support TDLS
  rtw89: add UNEXP debug mask to keep monitor messages unexpected to
    happen frequently
  rtw89: drop invalid TX rate report of legacy rate
  rtw89: fix long RX latency in low power mode
  rtw89: pci: fix PCI doesn't reclaim TX BD properly

Po-Hao Huang (1):
  rtw89: disable invalid phy reports for all ICs

 drivers/net/wireless/realtek/rtw89/cam.c      |  29 ++--
 drivers/net/wireless/realtek/rtw89/cam.h      |   9 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 148 +++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h     |  33 +++-
 drivers/net/wireless/realtek/rtw89/debug.c    |   3 +-
 drivers/net/wireless/realtek/rtw89/debug.h    |   2 +
 drivers/net/wireless/realtek/rtw89/fw.c       |   2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   2 +-
 drivers/net/wireless/realtek/rtw89/pci.c      |  16 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  18 ++-
 drivers/net/wireless/realtek/rtw89/ser.c      |  15 +-
 11 files changed, 218 insertions(+), 59 deletions(-)

-- 
2.25.1

