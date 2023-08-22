Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01A6784166
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjHVM7W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjHVM7V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:59:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6260ECD0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 05:59:19 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37MCwmpR7022521, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37MCwmpR7022521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 20:58:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 22 Aug 2023 20:59:10 +0800
Received: from [127.0.1.1] (172.16.23.216) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 22 Aug
 2023 20:59:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: introduce struct {mac,phy}_gen_def to define register address for WiFi 6 and 7 chips
Date:   Tue, 22 Aug 2023 20:58:16 +0800
Message-ID: <20230822125822.23817-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.23.216]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The address space of WiFi 7 chips is changed from WiFi 6, and the layout
looks like below.

 +---------------------+ 0x0_0000 MAC base address   (WiFi 6: 0x0_0000 the same)
 |                     |
 |                     |
 |  +-----------+  ----|-------+
 |  |  BAND0    |      |       | offset = 0x0_4000   (WiFi 6: 0x0_2000)
 |  +-----------+  <---|-------+
 |  |  BAND1    |      |
 |  +-----------+      |
 |                     |
 +---------------------+ 0x2_0000 PHY0 base address  (WiFi 6: 0x1_0000)
 |                     |
 |                     |
 +---------------------+ 0x4_0000 PHY1 base address  (WiFi 6: not simple offset)
 |                     |
 |                     |
 +---------------------+

Thus, introduce struct {mac,phy}_gen_def to define these addresses, and also
registers addresses are changed after WiFi 7, so add fields to the struct to
reuse codes. More functions will be added into the struct afterward, because
register settings and flows are also changed.

Currently, we add mac_be.c and phy_be.c for WiFi 7 chips, and the share code
and WiFi 6 specified code still locate on existing mac.c and phy.c. In the
future, we might move WiFi 6 part into mac_ax.c and phy_ax.c in one go
if needed.

Cheng-Chieh Hsieh (1):
  wifi: rtw89: phy: modify register setting of ENV_MNTR, PHYSTS and DIG

Ping-Ke Shih (5):
  wifi: rtw89: mac: add mac_gen_def::band1_offset to map MAC band1
    register address
  wifi: rtw89: mac: generalize code to indirectly access WiFi internal
    memory
  wifi: rtw89: mac: define internal memory address for WiFi 7 chip
  wifi: rtw89: mac: define register address of rx_filter to generalize
    code
  wifi: rtw89: phy: add phy_gen_def::cr_base to support WiFi 7 chips

 drivers/net/wireless/realtek/rtw89/core.c     |   6 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   8 +
 drivers/net/wireless/realtek/rtw89/debug.c    |  13 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |   6 +-
 drivers/net/wireless/realtek/rtw89/mac.c      | 197 ++++++++-------
 drivers/net/wireless/realtek/rtw89/mac.h      |  69 ++++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   7 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  38 +++
 drivers/net/wireless/realtek/rtw89/phy.c      | 239 +++++++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.h      | 114 ++++++++-
 drivers/net/wireless/realtek/rtw89/phy_be.c   |  77 ++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  34 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  19 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  24 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |  20 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |   3 +-
 18 files changed, 680 insertions(+), 230 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/mac_be.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/phy_be.c

-- 
2.25.1

