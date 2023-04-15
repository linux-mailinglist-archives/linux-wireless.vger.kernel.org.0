Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634726E2EDD
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Apr 2023 05:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjDODtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 23:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDODta (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 23:49:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D014C2D
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 20:49:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33F3mtUW3021670, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33F3mtUW3021670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 15 Apr 2023 11:48:55 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 15 Apr 2023 11:49:18 +0800
Received: from localhost (172.16.20.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 15 Apr
 2023 11:49:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/6] wifi: rtw89: support single channel concurrent mode
Date:   Sat, 15 Apr 2023 11:48:54 +0800
Message-ID: <20230415034900.15679-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.53]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
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

With previous materials and some fine tune in this patchset, we can
declare this driver can support STA + P2P or STA + AP operating on single
one channel.

v2:
  - add patch 3/6 to convert H2C macros, because patch 2/5 in v1 touch
    these macros.
  - others don't change

Chih-Kang Chang (1):
  wifi: rtw89: prohibit enter IPS during HW scan

Ping-Ke Shih (1):
  wifi: rtw89: use struct instead of macros to set H2C command of
    hardware scan

Po-Hao Huang (4):
  wifi: rtw89: refine scan function after chanctx
  wifi: rtw89: update statistics to FW for fine-tuning performance
  wifi: rtw89: Disallow power save with multiple stations
  wifi: rtw89: add support of concurrent mode

 drivers/net/wireless/realtek/rtw89/core.c     |  41 +++++-
 drivers/net/wireless/realtek/rtw89/core.h     |   7 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 125 +++++++++++-------
 drivers/net/wireless/realtek/rtw89/fw.h       | 125 +++++-------------
 drivers/net/wireless/realtek/rtw89/mac.c      |  14 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   4 +-
 6 files changed, 166 insertions(+), 150 deletions(-)

-- 
2.25.1

