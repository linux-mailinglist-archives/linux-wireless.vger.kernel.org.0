Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F03869C5F9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 08:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBTH3K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 02:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBTH3I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 02:29:08 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D60EF9D
        for <linux-wireless@vger.kernel.org>; Sun, 19 Feb 2023 23:29:07 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31K72iAW2025215, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31K72iAW2025215
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Feb 2023 15:02:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Feb 2023 15:02:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Feb
 2023 15:02:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: add firmware features for 8852B
Date:   Mon, 20 Feb 2023 15:01:56 +0800
Message-ID: <20230220070202.29868-1-pkshih@realtek.com>
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We have implemented and verified these firmware features, so turn on them
by this patchset.

Among the features, HW_SCAN needs additional process, because the setting
of RX report channel information is different from driver, so adjust the
code by patches 3/6 and 4/6.

Chin-Yen Lee (1):
  wifi: rtw89: add tx_wake notify for 8852B

Ping-Ke Shih (1):
  wifi: rtw89: 8852b: enable hw_scan support

Po-Hao Huang (2):
  wifi: rtw89: adjust channel encoding to common function
  wifi: rtw89: 8852b: add channel encoding for hw_scan

Zong-Zhe Yang (2):
  wifi: rtw89: fw: configure CRASH_TRIGGER feature for 8852B
  wifi: rtw89: refine FW feature judgement on packet drop

 drivers/net/wireless/realtek/rtw89/core.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  7 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 72 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  3 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 12 +--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 74 +------------------
 8 files changed, 92 insertions(+), 82 deletions(-)

-- 
2.25.1

