Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75D7980D8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 05:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbjIHDNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 23:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjIHDND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 23:13:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0551BD8
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 20:12:57 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3883ClSkA1359300, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3883ClSkA1359300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 11:12:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 8 Sep 2023 11:12:47 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 8 Sep 2023
 11:12:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: adjust RFK and monitor states for MCC
Date:   Fri, 8 Sep 2023 11:11:37 +0800
Message-ID: <20230908031145.20931-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is third patchset to prepare more materials for MCC. It includes
group 6/7 patches below that aims to adjust RFK (RF calibrations) behavior
to fit MCC situation and add a track work to monitor states including
MAC ID bitmap of connected stations, beacon offset, P2P PS, and BT timeslot.

<<< Below commit message is kept as first patchset for reference >>>

TDMA-based MCC (STA+P2P) is a kind of multiple interfaces concurrence.
Basically, driver is to calculate timeslot pattern and firmware follows
the pattern to switch channels. Since BT-coexistence is also a TDMA-based
mechanism, also consider BT timeslot into pattern if BT devices present.
 
To easier to review these 20+ patches, I summary basic purpose of these
patches below by group, and submit them by small patchset one by one.
 
Group 1. [DONE] get BT timeslot from coex mechanism
Group 2. [DONE] adjust some stuff related to driver channel context
Group 3. [DONE] P2P NoA infrastructure to add the IE to beacon when playing GO
Group 4. [DONE] adjust driver to support 2 channel context
Group 5. [DONE] calculate timeslot patterns and trigger firmware to switch
                   channels followed the patterns
Group 6. [CURRENT] disable some dynamic tracking mechanism of RF calibration when
                   MCC is running.
Group 7. [CURRENT] monitor states and adjust timeslot patterns. For example, if
                   BT device leaves, we can reassign the slot to WiFi.
Group 8. Remain-on-channel and hardware scan are related to channel
         context, so need some treatments to work with MCC properly.
Group 9. Finally, we declare 8852C to support MCC

Zong-Zhe Yang (8):
  wifi: rtw89: 52c: rfk: refine MCC channel info notification
  wifi: rtw89: rfk: disable driver tracking during MCC
  wifi: rtw89: 52c: rfk: disable DPK during MCC
  wifi: rtw89: mcc: update role bitmap when changed
  wifi: rtw89: mcc: track beacon offset and update when needed
  wifi: rtw89: mcc: deal with P2P PS change
  wifi: rtw89: mcc: deal with BT slot change
  wifi: rtw89: mcc: deal with beacon NoA if GO exists

 drivers/net/wireless/realtek/rtw89/chan.c     | 336 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/chan.h     |   6 +
 drivers/net/wireless/realtek/rtw89/core.c     |  29 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  15 +
 drivers/net/wireless/realtek/rtw89/fw.c       |   7 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |   5 +
 drivers/net/wireless/realtek/rtw89/mac.c      |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   7 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  84 ++++-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |   3 +
 11 files changed, 477 insertions(+), 19 deletions(-)

-- 
2.25.1

