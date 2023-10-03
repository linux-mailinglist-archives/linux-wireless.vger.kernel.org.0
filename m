Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AB97B5ED4
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 03:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjJCBzR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 21:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjJCBzR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 21:55:17 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA19BD
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 18:55:12 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3931t2Qj91334478, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3931t2Qj91334478
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 09:55:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Oct 2023 09:55:03 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Oct 2023
 09:55:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/7] wifi: rtw89: apply TX power read from firmware file
Date:   Tue, 3 Oct 2023 09:54:39 +0800
Message-ID: <20231003015446.14658-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
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

We have read TX power from firmware file (named firmware elements), and
then write TX power values to registers by this patchset.

The register addresses between WiFi 6 and 7 chips are different, and
tables for WiFi 7 are larger. But we still try to reuse functions if
possible, otherwise implement separate functions for each of them.

The registers of TX power can be categorized: 
 1. TX power by rate: a value for a rate section (RS for short in code)
 2. TX power offset: a offset value from base of rate section above.
    This uses less register bits than TX power by rate.
 3. TX power limit: the power to follow regulation, so output power is
    min(TX_power_by_rate, TX_power_limit) basically.
 4. TX power RU limit: like above, but for OFDMA RU.

Since there are many TX power values, we need to convert them to human
readable format to quickly check if values are expected. The last two
patches of this patchset are to extend existing debugfs to show current
TX power for all chips.

Zong-Zhe Yang (7):
  wifi: rtw89: mac: get TX power control register according to chip gen
  wifi: rtw89: phy: set TX power by rate according to chip gen
  wifi: rtw89: phy: set TX power offset according to chip gen
  wifi: rtw89: phy: set TX power limit according to chip gen
  wifi: rtw89: phy: set TX power RU limit according to chip gen
  wifi: rtw89: debug: show txpwr table according to chip gen
  wifi: rtw89: debug: txpwr table supports Wi-Fi 7 chips

 drivers/net/wireless/realtek/rtw89/core.h   |  30 --
 drivers/net/wireless/realtek/rtw89/debug.c  | 272 +++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c    |  14 +-
 drivers/net/wireless/realtek/rtw89/mac.h    |  16 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c |  40 ++
 drivers/net/wireless/realtek/rtw89/phy.c    | 173 +++---
 drivers/net/wireless/realtek/rtw89/phy.h    | 120 ++++-
 drivers/net/wireless/realtek/rtw89/phy_be.c | 568 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  50 +-
 9 files changed, 1126 insertions(+), 157 deletions(-)

-- 
2.25.1

