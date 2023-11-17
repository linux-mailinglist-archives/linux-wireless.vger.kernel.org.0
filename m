Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808BD7EEB26
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 03:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjKQCla (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 21:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCl3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 21:41:29 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8ED1A8
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 18:41:25 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AH2fHJb92818701, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AH2fHJb92818701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 10:41:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Nov 2023 10:41:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 17 Nov
 2023 10:41:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: 8922a: add 8922A basic info and efuse stuff
Date:   Fri, 17 Nov 2023 10:40:23 +0800
Message-ID: <20231117024029.113845-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are going to add 8922A, and first step is to add basic info, and then
we will add more attributes one by one.

Firstly, we add efuse stuff that stores calibration values, capabilities,
PHY parameters and etc. Since efuse format is changed from existing WiFi 6
chips, we introduce new reader and parser by patch 3/6 mainly. The detail
of efuse format is also shown in commit message of that patch.

Patch 4/6~6/6 are to read necessary data into driver from efuse
physical/logical maps, so driver doesn't need to keep the large map
persistently.

Ping-Ke Shih (6):
  wifi: rtw89: 8922a: add 8922A basic chip info
  wifi: rtw89: mac: use mac_gen pointer to access about efuse
  wifi: rtw89: mac: add to access efuse for WiFi 7 chips
  wifi: rtw89: 8852c: read RX gain offset from efuse for 6GHz channels
  wifi: rtw89: 8922a: read efuse content via efuse map struct from logic
    map
  wifi: rtw89: 8922a: read efuse content from physical map

 drivers/net/wireless/realtek/rtw89/core.c     |   5 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  28 +-
 drivers/net/wireless/realtek/rtw89/efuse.c    |  11 +-
 drivers/net/wireless/realtek/rtw89/efuse.h    |  17 +-
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 420 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  16 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |   3 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   4 +
 drivers/net/wireless/realtek/rtw89/phy.h      |  16 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  81 ++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  28 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |  20 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 363 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.h |  73 +++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |   2 +
 18 files changed, 1082 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/efuse_be.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a.h

-- 
2.25.1

