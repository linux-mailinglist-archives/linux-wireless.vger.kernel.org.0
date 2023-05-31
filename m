Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACF47176A8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 08:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjEaGIZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 02:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjEaGIJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 02:08:09 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C3E60
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 23:07:47 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34V67OAZ0025588, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34V67OAZ0025588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 31 May 2023 14:07:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 31 May 2023 14:07:37 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 31 May
 2023 14:07:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: 8851b: enable firmware features of hw_scan and crash_trigger
Date:   Wed, 31 May 2023 14:07:09 +0800
Message-ID: <20230531060713.57203-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After verification, we can enable hw_scan and crash_trigger simulation by
this patchset. During verification of crash_trigger simulation (patch 4/4),
we find that driver doesn't configure TX power properly in certain
situation, so refine debugfs entry by patch 2/4 and correct TX power by
patch 3/4.

Po-Hao Huang (1):
  wifi: rtw89: 8851b: enable hw_scan support

Zong-Zhe Yang (3):
  wifi: rtw89: debug: txpwr table access only valid page according to
    chip
  wifi: rtw89: set TX power without precondition during setting channel
  wifi: rtw89: 8851b: configure CRASH_TRIGGER feature for 8851B

 drivers/net/wireless/realtek/rtw89/core.c  |  5 ++---
 drivers/net/wireless/realtek/rtw89/debug.c | 13 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.c    |  2 ++
 drivers/net/wireless/realtek/rtw89/fw.h    |  2 +-
 drivers/net/wireless/realtek/rtw89/reg.h   |  6 ++++++
 5 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.25.1

