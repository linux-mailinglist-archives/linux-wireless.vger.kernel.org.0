Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C317C9FF4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 08:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjJPGwC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 02:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjJPGwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 02:52:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F42AD
        for <linux-wireless@vger.kernel.org>; Sun, 15 Oct 2023 23:51:53 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39G6phpoF2264226, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39G6phpoF2264226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 14:51:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 16 Oct 2023 14:51:43 +0800
Received: from [127.0.1.1] (172.21.71.113) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 16 Oct
 2023 14:51:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: rtw89: add fields of PHY registers of BSS color and CFO for WiFi 7 chips
Date:   Mon, 16 Oct 2023 14:51:10 +0800
Message-ID: <20231016065115.751662-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.71.113]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adjust codes related to PHY for coming WiFi 7 chips, and correct CFO
(Carrier Frequency Offset) flow which we found during adjustment to
slightly improve performance.

Cheng-Chieh Hsieh (3):
  wifi: rtw89: modify the register setting and the flow of CFO tracking
  wifi: rtw89: correct the DCFO tracking flow to improve CFO
    compensation
  wifi: rtw89: move software DCFO compensation setting to proper
    position

Chung-Hsuan Hung (1):
  wifi: rtw89: phy: change naming related BT coexistence functions

Ping-Ke Shih (1):
  wifi: rtw89: phy: generalize valid bit of BSS color

 drivers/net/wireless/realtek/rtw89/coex.c     |  2 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 22 +++++----
 drivers/net/wireless/realtek/rtw89/phy.c      | 46 +++++++++++++------
 drivers/net/wireless/realtek/rtw89/phy.h      |  8 ++++
 drivers/net/wireless/realtek/rtw89/phy_be.c   |  8 ++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  4 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 17 ++++---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 21 +++++----
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 25 +++++-----
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 31 ++++++++-----
 10 files changed, 121 insertions(+), 63 deletions(-)

-- 
2.25.1

