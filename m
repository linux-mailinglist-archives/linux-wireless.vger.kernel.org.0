Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA145F50E2
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 10:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJEIdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 04:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJEIdH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 04:33:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0057775489
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 01:32:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2958W88B0010386, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2958W88B0010386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Oct 2022 16:32:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 5 Oct 2022 16:32:26 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 5 Oct 2022
 16:32:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <echuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: 8852b: add more to support 8852b
Date:   Wed, 5 Oct 2022 16:32:06 +0800
Message-ID: <20221005083212.45683-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/05/2022 03:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzUgpFekyCAwMjo1OTowMA==?=
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

First patch is to leverage coex code to 8852b, so move the chunk to a
generic code. Second is a CFO issue found during 8852b development. Patches
3-6 are to add more chip_ops/chip_info needed by 8852b. The last patch is
a big one, because chip_ops::set_channel contains lots of settings.

Ching-Te Ku (1):
  wifi: rtw89: coex: move chip_ops::btc_bt_aci_imp to a generic code

Eric Huang (1):
  wifi: rtw89: parse PHY status only when PPDU is to_self

Ping-Ke Shih (4):
  wifi: rtw89: 8852b: set proper configuration before loading NCTL
  wifi: rtw89: 8852b: add HFC quota arrays
  wifi: rtw89: make generic functions to convert subband gain index
  wifi: rtw89: 8852b: add chip_ops::set_channel

 drivers/net/wireless/realtek/rtw89/coex.c     |   9 +-
 drivers/net/wireless/realtek/rtw89/core.c     |   3 +
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  21 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |  46 ++
 drivers/net/wireless/realtek/rtw89/reg.h      |  60 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  14 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 596 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 256 ++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |  14 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  60 +-
 11 files changed, 1000 insertions(+), 81 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h

-- 
2.25.1

