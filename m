Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C164DD31A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 03:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiCRCev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 22:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiCRCen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 22:34:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7456199E15
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 19:33:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22I2X4RD0017604, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22I2X4RD0017604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:33:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 18 Mar 2022 10:33:03 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:33:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <johnson.lin@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 00/11] rtw89: update TX power table and 6G, refine IGI, and add TX/RX descriptors V1
Date:   Fri, 18 Mar 2022 10:32:03 +0800
Message-ID: <20220318023214.32411-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/18/2022 02:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTggpFekyCAxMjo0MDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

First portion (1/11 - 4/11) is to update TX power from internal tables
that support UK and 6G. Second portion (5/11 ~ 6/11) is to refine IGI
standing for initial gain index that can be known as RX gain, and some chip
versions don't support this, so add a flag to determine if we can support
it. The last portion is to implement TX/RX descriptors V1, because their
format and size are different.

This patchset is based on
 "rtw89: add firmware reset and dump firmware memory and backtrace"
But no actual function dependency.

Johnson Lin (2):
  rtw89: packed IGI configuration flow into function for DIG feature
  rtw89: disabled IGI configuration for unsupported hardware

Ping-Ke Shih (5):
  rtw89: add chip_info::h2c_desc_size/fill_txdesc_fwcmd to support new
    chips
  rtw89: pci: support variant of fill_txaddr_info
  rtw89: support variant of fill_txdesc
  rtw89: support hardware generate security header
  rtw89: read RX bandwidth from v1 type RX descriptor

Zong-Zhe Yang (4):
  rtw89: add UK to regulation type
  rtw89: 8852a: update txpwr tables to HALRF_027_00_038
  rtw89: regd: consider 6G band
  rtw89: regd: update mapping table to R59-R32

 drivers/net/wireless/realtek/rtw89/cam.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 146 ++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  53 ++
 drivers/net/wireless/realtek/rtw89/fw.c       |  74 +--
 drivers/net/wireless/realtek/rtw89/fw.h       |   4 +-
 drivers/net/wireless/realtek/rtw89/pci.c      |  82 ++-
 drivers/net/wireless/realtek/rtw89/pci.h      |  33 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  26 +-
 drivers/net/wireless/realtek/rtw89/regd.c     | 513 ++++++++--------
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   5 +
 .../wireless/realtek/rtw89/rtw8852a_table.c   | 581 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   5 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |   2 +
 drivers/net/wireless/realtek/rtw89/txrx.h     | 107 ++++
 15 files changed, 1317 insertions(+), 322 deletions(-)

-- 
2.25.1

