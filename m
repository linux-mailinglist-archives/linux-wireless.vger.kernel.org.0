Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81EE5AB2D4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiIBOEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbiIBODu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:03:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 281E51306E3
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:32:51 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 282CiRPt9014078, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 282CiRPt9014078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Sep 2022 20:44:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 2 Sep 2022 20:44:44 +0800
Received: from localhost (172.16.17.75) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Sep 2022
 20:44:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: rtw89: support TX diversity for 1T2R variant model
Date:   Fri, 2 Sep 2022 20:44:17 +0800
Message-ID: <20220902124422.13610-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.75]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/02/2022 12:31:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMiCkV6TIIDA3OjQ1OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To support TX diversity, query firmware to know if it is 1T2R variant
model. Then, checking RSSI periodically to know which antenna has better
signal strength that can be seen as the antenna is close to AP. Therefore,
use the antenna with better RSSI to transmit packets dynamically.

Ping-Ke Shih (5):
  wifi: rtw89: use u32_get_bits to access C2H content of PHY capability
  wifi: rtw89: parse phycap of TX/RX antenna number
  wifi: rtw89: configure TX path via H2C command
  wifi: rtw89: record signal strength per RF path
  wifi: rtw89: support TX diversity for 1T2R chipset

 drivers/net/wireless/realtek/rtw89/core.c     | 21 +++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  6 +-
 drivers/net/wireless/realtek/rtw89/debug.c    | 12 +++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 60 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h       | 43 ++++++++-----
 drivers/net/wireless/realtek/rtw89/mac.c      | 35 ++++++++---
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 56 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  6 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  6 +-
 12 files changed, 209 insertions(+), 46 deletions(-)

-- 
2.25.1

