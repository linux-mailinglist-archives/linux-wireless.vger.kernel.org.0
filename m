Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210777A902D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 02:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjIUAg3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 20:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjIUAg2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 20:36:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CACCC
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 17:36:19 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38L0a7Bm91966983, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38L0a7Bm91966983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 08:36:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 21 Sep 2023 08:36:08 +0800
Received: from [127.0.1.1] (172.16.16.112) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 21 Sep
 2023 08:36:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: declare to support MCC
Date:   Thu, 21 Sep 2023 08:35:55 +0800
Message-ID: <20230921003559.11588-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.112]
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

This is the last patchset to support MCC. It includes patch 1/4 to correct
start time of NoA, and patch 2/4 is to treat remain-on-channel and hardware
scan, which are also to set/switch channels. To prevent interference,
stop firmware MCC switching when driver receive these two kinds of request.

Then, we declare 8852c can support two channel context, and update
interface combination to support MCC of STA + P2P.

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
Group 6. [DONE] disable some dynamic tracking mechanism of RF calibration when
                MCC is running.
Group 7. [DONE] monitor states and adjust timeslot patterns. For example, if
                BT device leaves, we can reassign the slot to WiFi.
Group 8. [CURRNET] Remain-on-channel and hardware scan are related to channel
                   context, so need some treatments to work with MCC properly.
Group 9. [CURRENT] Finally, we declare 8852C to support MCC

Zong-Zhe Yang (4):
  wifi: rtw89: mcc: fix NoA start time when GO is auxiliary
  wifi: rtw89: pause/proceed MCC for ROC and HW scan
  wifi: rtw89: 8852c: declare to support two chanctx
  wifi: rtw89: declare MCC in interface combination

 drivers/net/wireless/realtek/rtw89/chan.c     | 74 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |  8 ++
 drivers/net/wireless/realtek/rtw89/core.c     | 29 +++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +-
 6 files changed, 113 insertions(+), 5 deletions(-)

-- 
2.25.1

