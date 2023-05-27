Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93A7713359
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 10:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjE0IaL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjE0IaK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 04:30:10 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34107E1;
        Sat, 27 May 2023 01:30:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34R8TlAH2019714, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34R8TlAH2019714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 27 May 2023 16:29:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 27 May 2023 16:29:59 +0800
Received: from [127.0.1.1] (172.16.16.243) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 27 May
 2023 16:29:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <tony0620emma@gmail.com>
CC:     <stable@vger.kernel.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: rtw88/89: add PS calculation to repair PS mode 
Date:   Sat, 27 May 2023 16:29:36 +0800
Message-ID: <20230527082939.11206-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.243]
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

The commit 28977e790b5d ("wifi: mac80211: skip powersave recalc if driver SUPPORTS_DYNAMIC_PS")
introduced by kernel 5.20 will skip to recalculate IEEE80211_CONF_PS           
of hw->conf.flags if driver sets SUPPORTS_DYNAMIC_PS.   

Since this problem was happened since 5.20, patches 1/3 and 2/3 should be
applied to kernel 6.1+.

Patch 3/3 is to remove redundant/unnecessary check, so this can be seen as
an independent patch that can go either wireless or wireless-next tree.
Note, I can't combine this into patch 2/3, because this redundant check
is introduced by upcoming kernel 6.4, but patch 2/3 would go kernel 6.1+.

Ping-Ke Shih (3):
  wifi: rtw88: correct PS calculation for SUPPORTS_DYNAMIC_PS
  wifi: rtw89: correct PS calculation for SUPPORTS_DYNAMIC_PS
  wifi: rtw89: remove redundant check of entering LPS

 drivers/net/wireless/realtek/rtw88/mac80211.c | 14 +++---
 drivers/net/wireless/realtek/rtw88/main.c     |  4 +-
 drivers/net/wireless/realtek/rtw88/ps.c       | 43 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/ps.h       |  2 +
 drivers/net/wireless/realtek/rtw89/core.c     |  3 --
 drivers/net/wireless/realtek/rtw89/mac80211.c | 15 +++----
 drivers/net/wireless/realtek/rtw89/ps.c       | 26 +++++++++++
 drivers/net/wireless/realtek/rtw89/ps.h       |  1 +
 8 files changed, 85 insertions(+), 23 deletions(-)

-- 
2.25.1

