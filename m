Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D9D50F10E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiDZGgV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 02:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiDZGgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 02:36:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9571582E
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 23:33:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23Q6WuKN2015183, This message is accepted by code: ctloc85258
Received: from mail.realtek.com ([172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23Q6WuKN2015183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Apr 2022 14:32:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 14:32:56 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 26 Apr
 2022 14:32:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/15] rtw89: 8852c: add RFK and then enable 8852ce in Makefile and Kconfig
Date:   Tue, 26 Apr 2022 14:32:20 +0800
Message-ID: <20220426063235.41650-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/26/2022 06:17:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjYgpFekyCAwNDozODowMA==?=
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

After this patchset, basic functions are ready, so we can enable 8852ce.
It can play as STA, AP and monitor modes. The BT coexistence and power save
are still cooking, but these don't affect the performance of Wi-Fi only.

Patches 1-9 are related to RF calibration (RFK). These RFK can be called
once interface is going up, or when we are going to connect to AP in
certain channel, or band is changed. The general steps of calibration are
to backup registers (optional) and set a set of registers before doing
calibration according to channels or something else, and then trigger the
calibration and poll if calibration is complete. Then, check the result
is positive or not to decide to adjust parameters and re-trigger again.
If the result is okay, set registers accordingly, and restore registers
we backup before (optional).

Patches 10-11 are to add necessary chip_ops and chip_info.

Patch 12 is to fine tune polling interval to enter/leave low power mode.
Since 8852ce will do this more frequently, polling interval become more
important.

Patch 13-14 are to correct registers settings found when we develop 8852ce.

Final patch is to add 8852ce to Makefile and Kconfig, so user can use it
with firmware version 0.27.20.0 that I will send out after this patchset.

Ping-Ke Shih (15):
  rtw89: 8852c: rfk: add RFK tables
  rtw89: 8852c: rfk: add DACK
  rtw89: 8852c: rfk: add LCK
  rtw89: 8852c: rfk: add TSSI
  rtw89: 8852c: rfk: add RCK
  rtw89: 8852c: rfk: add RX DCK
  rtw89: 8852c: rfk: add IQK
  rtw89: 8852c: rfk: add DPK
  rtw89: 8852c: rfk: get calibrated channels to notify firmware
  rtw89: 8852c: add chip_ops::bb_ctrl_btc_preagc
  rtw89: 8852c: add basic and remaining chip_info
  rtw89: ps: fine tune polling interval while changing low power mode
  rtw89: correct AID settings of beamformee
  rtw89: 8852c: correct register definitions used by 8852c
  rtw89: 8852c: add 8852ce to Makefile and Kconfig

 drivers/net/wireless/realtek/rtw89/Kconfig    |   18 +-
 drivers/net/wireless/realtek/rtw89/Makefile   |    9 +
 drivers/net/wireless/realtek/rtw89/core.h     |   19 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |  219 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  181 +-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 3812 +++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |   14 +
 .../realtek/rtw89/rtw8852c_rfk_table.c        |  781 ++++
 .../realtek/rtw89/rtw8852c_rfk_table.h        |   67 +
 11 files changed, 5107 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.h

-- 
2.25.1

