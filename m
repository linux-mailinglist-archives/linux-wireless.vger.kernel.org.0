Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16D4DBF1E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 07:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiCQGSI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 02:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiCQGR6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 02:17:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D13C1D788D
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 22:56:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22H5uYnH5009622, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22H5uYnH5009622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Mar 2022 13:56:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 13:56:33 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 13:56:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH v2 00/12] rtw89: prepare more shared code to work with 8852c
Date:   Thu, 17 Mar 2022 13:55:31 +0800
Message-ID: <20220317055543.40514-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/17/2022 05:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTcgpFekyCAwMzoyNjowMA==?=
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

This patchset contains MAC, BB and RF functions. The BB part changes
CFO (central frequency offset) tracking functions to be general. The MAC
part makes the function work on 8852c. Propose new V1 method to access new
design of RF register. 

As usual, this doesn't affect existing chip, and 8852C is built internally.

v2: patch 9/12: assign data in 'if' branch instead of '? :' style.
    patch 10/12: add this patch because of the same reason of patch 9/12.
    others don't change

Chia-Yuan Li (3):
  rtw89: modify MAC enable functions
  rtw89: disable FW and H2C function if CPU disabled
  rtw89: 8852c: add mac_ctrl_path and mac_cfg_gnt APIs

Chung-Hsuan Hung (1):
  rtw89: 8852c: add read/write rf register function

Ping-Ke Shih (5):
  rtw89: add config_rf_reg_v1 to configure RF parameter tables
  rtw89: initialize preload window of D-MAC
  rtw89: change value assignment style of rtw89_mac_cfg_gnt()
  rtw89: extend mac tx_en bits from 16 to 32
  rtw89: implement stop and resume channels transmission v1

Yuan-Han Zhang (3):
  rtw89: modify dcfo_comp to share with chips
  rtw89: 8852c: add write/read crystal function in CFO tracking
  rtw89: 8852c: add setting of TB UL TX power offset

 drivers/net/wireless/realtek/rtw89/coex.c     |  24 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  47 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 283 +++++++++++++++---
 drivers/net/wireless/realtek/rtw89/mac.h      |  12 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 164 +++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |   9 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  77 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  22 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  24 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  50 ++++
 10 files changed, 630 insertions(+), 82 deletions(-)

-- 
2.25.1

