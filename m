Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EC06EA1CA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjDUCqe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 22:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjDUCqd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 22:46:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F67D65A0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 19:46:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L2kNVb9016490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L2kNVb9016490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 10:46:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Apr 2023 10:46:01 +0800
Received: from localhost.localdomain (172.21.69.188) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 10:46:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: 8851b: add basic chip information of 8851B
Date:   Fri, 21 Apr 2023 10:45:43 +0800
Message-ID: <20230421024551.29994-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new files rtw8851b.c/.h and rtw8851be.c with basic chip information.
The more functions will be added by upcoming patches.

Chia-Yuan Li (1):
  wifi: rtw89: add CFO XTAL registers field to support 8851B

Chih-Kang Chang (1):
  wifi: rtw89: 8851b: add support WoWLAN to 8851B

Ping-Ke Shih (6):
  wifi: rtw89: 8851b: add 8851B basic chip_info
  wifi: rtw89: 8851be: add 8851BE PCI entry and fill PCI capabilities
  wifi: rtw89: 8851b: add NCTL post table
  wifi: rtw89: use chip_info::small_fifo_size to choose debug_mask
  wifi: rtw89: change naming of BA CAM from V1 to V0_EXT
  wifi: rtw89: 8851b: add DLE mem and HFC quota

 drivers/net/wireless/realtek/rtw89/core.h     |  18 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  12 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |   6 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   2 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/pci.c      |   4 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  22 ++-
 drivers/net/wireless/realtek/rtw89/reg.h      |   6 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 173 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.h |  15 ++
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  86 +++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  11 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   5 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |   2 +-
 15 files changed, 344 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851be.c

-- 
2.25.1

