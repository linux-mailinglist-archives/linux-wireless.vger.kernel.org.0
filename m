Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5136D56EB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 04:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjDDCyb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 22:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDDCya (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 22:54:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869DE1BE5
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 19:54:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3342s27s9014588, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3342s27s9014588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 4 Apr 2023 10:54:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 4 Apr 2023 10:54:21 +0800
Received: from localhost (172.16.18.209) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 4 Apr 2023
 10:54:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v5 0/5] wifi: rtw89: preparation of multiple interface concurrency support
Date:   Tue, 4 Apr 2023 10:52:54 +0800
Message-ID: <20230404025259.15503-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.18.209]
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
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To support concurrency, we implement beacon filter, CQM and
ieee80211::remain_on_channel ops. Since our firmware doesn't support to TX
null packet while doing remain-on-channel, driver does this instead. To
ensure null packet send out before switching channel, patch 2/5 adds a
waiting mechanism.

The patches 4/5 and 5/5 refine things we found during developing.

v5:
  - patch 2/5
    - use owner with spin_lock to replace original third work to make
      code simpler.
  - others
    - no change

v4:
  - patch 1/5
    - define h2c/c2h struct to set/get skb->data,
      for example

      * h2c = (__le32 *)skb->data; -->
        h2c = (struct rtw89_h2c_bcnfltr *)skb->data;

      * #define H2C_CFG_BCN_FLTR_LEN 4 (remove) --> sizeof(*h2c)

      * h2c[0] = le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_RSSI) -->
        h2c->w0 = le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_RSSI)

    - I think this could improve a little more. If anyone have more ideas
      in the future, I will open mind to change them again to make them
      look better.

  - others
    - no change

v3:
  - patch 1/5
    - remove unnecessary type casting
    - use clear style of mask definition for H2C/C2H
  - patch 2/5
    - add comment to describe why polling can help freeing
  - others
    - no change

v2:
  - messed up, please ignore.

Po-Hao Huang (5):
  wifi: rtw89: 8852c: add beacon filter and CQM support
  wifi: rtw89: add function to wait for completion of TX skbs
  wifi: rtw89: add ieee80211::remain_on_channel ops
  wifi: rtw89: add flag check for power state
  wifi: rtw89: fix authentication fail during scan

 drivers/net/wireless/realtek/rtw89/chan.c     |  35 +++
 drivers/net/wireless/realtek/rtw89/chan.h     |   3 +
 drivers/net/wireless/realtek/rtw89/core.c     | 272 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  80 ++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 116 +++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  63 ++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  62 ++++
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  88 +++++-
 drivers/net/wireless/realtek/rtw89/pci.c      |   6 +
 drivers/net/wireless/realtek/rtw89/pci.h      |   4 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |   6 +
 drivers/net/wireless/realtek/rtw89/ps.h       |  16 ++
 13 files changed, 737 insertions(+), 15 deletions(-)

-- 
2.25.1

