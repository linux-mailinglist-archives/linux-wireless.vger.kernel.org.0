Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC40F6BCF18
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Mar 2023 13:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCPMOK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Mar 2023 08:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCPMOI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Mar 2023 08:14:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3059823A61
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 05:14:05 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32GCDkznE023040, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32GCDkznE023040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Mar 2023 20:13:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 16 Mar 2023 20:13:11 +0800
Received: from localhost (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 16 Mar
 2023 20:13:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/5] wifi: rtw89: preparation of multiple interface concurrency support
Date:   Thu, 16 Mar 2023 20:12:00 +0800
Message-ID: <20230316121206.11479-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.31]
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

To support concurrency, we implement beacon filter, CQM and
ieee80211::remain_on_channel ops. Since our firmware doesn't support to TX
null packet while doing remain-on-channel, driver does this instead. To
ensure null packet send out before switching channel, patch 2/5 adds a
waiting mechanism.

The patches 4/5 and 5/5 refine things we found during developing.

v2:
  - patch 1/5
    - remove unnecessary type casting
    - use clear style of mask definition for H2C/C2H
  - patch 2/5
    - add comment to describe why polling can help freeing
  - others
    - no change

Po-Hao Huang (5):
  wifi: rtw89: 8852c: add beacon filter and CQM support
  wifi: rtw89: add function to wait for completion of TX skbs
  wifi: rtw89: add ieee80211::remain_on_channel ops
  wifi: rtw89: add flag check for power state
  wifi: rtw89: fix authentication fail during scan

 drivers/net/wireless/realtek/rtw89/chan.c     |  35 +++
 drivers/net/wireless/realtek/rtw89/chan.h     |   3 +
 drivers/net/wireless/realtek/rtw89/core.c     | 288 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  64 ++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 118 ++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  48 +++
 drivers/net/wireless/realtek/rtw89/mac.c      |  61 ++++
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  88 +++++-
 drivers/net/wireless/realtek/rtw89/pci.c      |   6 +
 drivers/net/wireless/realtek/rtw89/pci.h      |   4 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |   6 +
 drivers/net/wireless/realtek/rtw89/ps.h       |  16 +
 13 files changed, 723 insertions(+), 15 deletions(-)

-- 
2.25.1

