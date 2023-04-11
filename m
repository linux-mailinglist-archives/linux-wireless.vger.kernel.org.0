Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64806DDB28
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 14:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjDKMtE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 08:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjDKMs7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 08:48:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520E344A4
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 05:48:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33BCmM9D1030599, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33BCmM9D1030599
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Apr 2023 20:48:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 20:48:43 +0800
Received: from localhost (172.16.20.144) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 11 Apr
 2023 20:48:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v6 0/5] wifi: rtw89: preparation of multiple interface concurrency support
Date:   Tue, 11 Apr 2023 20:48:27 +0800
Message-ID: <20230411124832.14965-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.144]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

v6:
  - patch 2/5
    - use kfree_rcu to free 'wait' object, so don't need spin_lock
      introduced by v5. Then, no lock in TX path.
  - others
    - no change

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
 drivers/net/wireless/realtek/rtw89/core.c     | 261 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  71 +++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 116 +++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  63 +++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  62 +++++
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  88 +++++-
 drivers/net/wireless/realtek/rtw89/pci.c      |   5 +
 drivers/net/wireless/realtek/rtw89/pci.h      |   4 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |   6 +
 drivers/net/wireless/realtek/rtw89/ps.h       |  16 ++
 13 files changed, 716 insertions(+), 15 deletions(-)

-- 
2.25.1

