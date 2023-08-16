Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4667F77DC15
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbjHPIWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbjHPIW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:22:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45B901FF9
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:22:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37G8LvVN2001128, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37G8LvVN2001128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Aug 2023 16:21:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 16 Aug 2023 16:22:17 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 16 Aug
 2023 16:22:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: preparation of TDMA-based MCC (STA+P2P)
Date:   Wed, 16 Aug 2023 16:21:27 +0800
Message-ID: <20230816082133.57474-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TDMA-based MCC (STA+P2P) is a kind of multiple interfaces concurrence.
Basically, driver is to calculate timeslot pattern and firmware follows
the pattern to switch channels. Since BT-coexistence is also a TDMA-based
mechanism, also consider BT timeslot into pattern if BT devices present.
 
To easier to review these 20+ patches, I summary basic purpose of these
patches below by group, and submit them by small patchset one by one.
 
Group 1. get BT timeslot from coex mechanism
Group 2. adjust some stuff related to driver channel context
Group 3. P2P NoA infrastructure to add the IE to beacon when playing GO
Group 4. adjust driver to support 2 channel context
Group 5. calculate timeslot patterns and trigger firmware to switch
         channels followed the patterns
Group 6. disable some dynamic tracking mechanism of RF calibration when
         MCC is running.
Group 7. monitor states and adjust timeslot patterns. For example, if
         BT device leaves, we can reassign the slot to WiFi.
Group 8. Remain-on-channel and hardware scan are related to channel
         context, so need some treatments to work with MCC properly.
Group 9. Finally, we declare 8852C to support MCC

This patchset includes groups 1-4 above, and depends on another patch
"wifi: rtw89: Introduce Time Averaged SAR (TAS) feature"
because both modify the same file, not functional dependency. 

Zong-Zhe Yang (6):
  wifi: rtw89: add function prototype for coex request duration
  wifi: rtw89: refine rtw89_correct_cck_chan() by
    rtw89_hw_to_nl80211_band()
  wifi: rtw89: sar: let caller decide the center frequency to query
  wifi: rtw89: call rtw89_chan_get() by vif chanctx if aware of vif
  wifi: rtw89: provide functions to configure NoA for beacon update
  wifi: rtw89: initialize multi-channel handling

 drivers/net/wireless/realtek/rtw89/chan.c     | 124 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |   5 +
 drivers/net/wireless/realtek/rtw89/coex.c     |   3 +-
 drivers/net/wireless/realtek/rtw89/coex.h     |   9 ++
 drivers/net/wireless/realtek/rtw89/core.c     | 114 +++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h     |  78 +++++++++++
 drivers/net/wireless/realtek/rtw89/debug.c    |  10 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  16 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   7 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  29 ++--
 drivers/net/wireless/realtek/rtw89/ps.c       |  75 ++++++++++-
 drivers/net/wireless/realtek/rtw89/ps.h       |   4 +
 drivers/net/wireless/realtek/rtw89/sar.c      |  24 ++--
 drivers/net/wireless/realtek/rtw89/sar.h      |   6 +-
 14 files changed, 436 insertions(+), 68 deletions(-)

-- 
2.25.1

