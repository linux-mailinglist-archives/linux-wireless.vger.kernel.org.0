Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618CB7AD2BA
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjIYIJu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 04:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjIYIJt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 04:09:49 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C0FC
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 01:09:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38P89ESR03456769, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38P89ESR03456769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:09:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 25 Sep 2023 16:09:14 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 25 Sep
 2023 16:09:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <johannes@sipsolutions.net>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: rtw89: consider UL-bandwidth of trigger frame as clue to improve OFDMA performance
Date:   Mon, 25 Sep 2023 16:08:58 +0800
Message-ID: <20230925080902.51449-1-pkshih@realtek.com>
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

Patch 3/3 is the main patch to improve UL-OFDMA performance when
UL-bandwidth is 160MHz and RU < 106. In this case, apply pre-calculated
matrix to transmit with proper power.

To assist that, patch 1/3 is to add UL-bandwidth definition of trigger
frame. Patch 2/3 is to adjust naming of waveform control related to trigger
frame to avoid ambiguity.

Po-Hao Huang (3):
  wifi: ieee80211: add UL-bandwidth definition of trigger frame
  wifi: rtw89: refine uplink trigger based control mechanism
  wifi: rtw89: refine bandwidth 160MHz uplink OFDMA performance

 drivers/net/wireless/realtek/rtw89/core.c     |  17 ++-
 drivers/net/wireless/realtek/rtw89/core.h     |  29 +++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 129 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/reg.h      |  12 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   3 +-
 include/linux/ieee80211.h                     |   7 +
 9 files changed, 166 insertions(+), 40 deletions(-)

-- 
2.25.1

