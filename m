Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544825005DD
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 08:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbiDNGXg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 02:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbiDNGXc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 02:23:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD85F1EECB
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 23:21:05 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23E6KpW52001318, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23E6KpW52001318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:20:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 14:20:51 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 14 Apr
 2022 14:20:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 00/12] rtw89: 8852c: add 8852c tables, TX power and set channel functions
Date:   Thu, 14 Apr 2022 14:20:14 +0800
Message-ID: <20220414062027.62638-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/14/2022 06:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTQgpFekyCAwMzo1OTowMA==?=
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

This patchset is to add 8852c specific tables and functions, so it doesn't
affect existing chip as usual.

First patch is to add BB and RF parameters tables. Patch 2/12 and 3/13 are
to set TX power by rate, limit and tracking tables. Patch 4/13~7/13 belongs
to BB gain and waveform. Patch 8/13 is to configure HFC parameter. The last
4 patches are used to set channel, a basic and important function.

Ping-Ke Shih (10):
  rtw89: 8852c: add BB and RF parameters tables
  rtw89: 8852c: add TX power by rate and limit tables
  rtw89: 8852c: phy: configure TSSI bandedge
  rtw89: 8852c: add BB initial and reset functions
  rtw89: 8852c: add efuse gain offset parser
  rtw89: 8852c: add HFC parameters
  rtw89: 8852c: add set channel function of RF part
  rtw89: 8852c: set channel of MAC part
  rtw89: 8852c: add set channel of BB part
  rtw89: 8852c: add help function of set channel

Zong-Zhe Yang (2):
  rtw89: 8852c: add TX power track tables
  rtw89: 8852c: support bb gain info

 drivers/net/wireless/realtek/rtw89/core.h     |    57 +
 drivers/net/wireless/realtek/rtw89/phy.c      |   349 +
 drivers/net/wireless/realtek/rtw89/phy.h      |    73 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   171 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |     2 +
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |     8 +-
 .../wireless/realtek/rtw89/rtw8852a_table.c   |    24 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1338 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |    19 +-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |   214 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |    14 +
 .../wireless/realtek/rtw89/rtw8852c_table.c   | 19470 ++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852c_table.h   |    36 +
 drivers/net/wireless/realtek/rtw89/util.h     |    30 +
 14 files changed, 21769 insertions(+), 36 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_table.h

-- 
2.25.1

