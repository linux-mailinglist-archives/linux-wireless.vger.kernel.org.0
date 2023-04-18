Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F686E5670
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 03:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDRB26 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 21:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjDRB25 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 21:28:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8509859CA
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 18:28:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33I1SaX92015053, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33I1SaX92015053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 09:28:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 18 Apr 2023 09:28:36 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 18 Apr
 2023 09:28:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/7] wifi: rtw89: support antenna diversity
Date:   Tue, 18 Apr 2023 09:28:13 +0800
Message-ID: <20230418012820.5139-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We have had path diversity before, and the difference of adding antenna
diversity is that uses GPIO to control SPDT or DPDT to switch antenna.
The upcoming chip 8851B has two variety hardware modules; one is single
one antenna module, the other is two antenna module that needs this
mechanism to have benefit.

To help verify and debug this feature, patches 3/7 and 4/7 are to add
the debug information.

The last two patches are to add RSSI and EVM based antenna diversity
respectively.

v2:
  - correct wording of subject of patch 1/7 and 5/7
  - no change of patch content

Eric Huang (3):
  wifi: rtw89: initialize antenna for antenna diversity
  wifi: rtw89: add RSSI based antenna diversity
  wifi: rtw89: add EVM for antenna diversity

Ping-Ke Shih (4):
  wifi: rtw89: use struct rtw89_phy_sts_ie0 instead of macro to access
    PHY IE0 status
  wifi: rtw89: set capability of TX antenna diversity
  wifi: rtw89: add RSSI statistics for the case of antenna diversity to
    debugfs
  wifi: rtw89: add EVM and SNR statistics to debugfs

 drivers/net/wireless/realtek/rtw89/core.c     |  75 ++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  34 +++
 drivers/net/wireless/realtek/rtw89/debug.c    |  24 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   9 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   7 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 261 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  12 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  21 +-
 drivers/net/wireless/realtek/rtw89/txrx.h     |  19 +-
 9 files changed, 437 insertions(+), 25 deletions(-)

-- 
2.25.1

