Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7CD78E5C0
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 07:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbjHaFcx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 01:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245132AbjHaFcu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 01:32:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74FE5E0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 22:32:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37V5W62A0020409, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37V5W62A0020409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Aug 2023 13:32:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 31 Aug 2023 13:32:31 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 31 Aug
 2023 13:32:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/6] wifi: rtw89: prepare timeslot and trigger firmware for MCC
Date:   Thu, 31 Aug 2023 13:31:27 +0800
Message-ID: <20230831053133.24015-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is second patchset to prepare more materials for MCC. It includes
group 5 patch below that is to calculate timeslot assignment (or named
pattern) for various combinations, such as use cases with/without BT
devices connected.

Since the detail calculation of timeslot is complicated, we split them
into several patches. Each of them calculates timeslot from
'coarse-grained' to 'fine-grained'. Then, use H2C command to notify
firmware to start MCC work that follows these timeslot patterns to
switch channels with protocols of 802.11 PS and NoA.

v2:
  - fix unfined '__umoddi3' issue found by 0-DAY CI Kernel Test Service

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
Group 5. [CURRENT] calculate timeslot patterns and trigger firmware to switch
                   channels followed the patterns
Group 6. disable some dynamic tracking mechanism of RF calibration when
         MCC is running.
Group 7. monitor states and adjust timeslot patterns. For example, if
         BT device leaves, we can reassign the slot to WiFi.
Group 8. Remain-on-channel and hardware scan are related to channel
         context, so need some treatments to work with MCC properly.
Group 9. Finally, we declare 8852C to support MCC

Zong-Zhe Yang (6):
  wifi: rtw89: mcc: initialize start flow
  wifi: rtw89: mcc: fill fundamental configurations
  wifi: rtw89: mcc: consider and determine BT duration
  wifi: rtw89: mcc: decide pattern and calculate parameters
  wifi: rtw89: fix typo of rtw89_fw_h2c_mcc_macid_bitmap()
  wifi: rtw89: mcc: trigger FW to start/stop MCC

 drivers/net/wireless/realtek/rtw89/chan.c | 1155 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |   20 +
 drivers/net/wireless/realtek/rtw89/core.c |    4 +
 drivers/net/wireless/realtek/rtw89/core.h |   87 ++
 drivers/net/wireless/realtek/rtw89/fw.c   |    2 +-
 drivers/net/wireless/realtek/rtw89/fw.h   |    2 +-
 6 files changed, 1268 insertions(+), 2 deletions(-)

-- 
2.25.1

