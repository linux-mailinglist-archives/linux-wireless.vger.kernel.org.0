Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A46FA285
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjEHIoH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjEHIoB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:44:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E155E1E98B
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:43:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3488hjjxF007915, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3488hjjxF007915
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 16:43:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 8 May 2023 16:43:51 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 May 2023
 16:43:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: rtw89: refine SER things of 8851B, 8852C and new state
Date:   Mon, 8 May 2023 16:43:32 +0800
Message-ID: <20230508084335.42953-1-pkshih@realtek.com>
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

SER (System Error Recovery) is to detect hardware/firmware abnormal. When
it is detected by firmware, it notifies driver to provide SER IMR and some
registers status to help diagnose the abnormal.

For the best case, we adjust hardware or firmware settings to fix the
problem and avoid this notification. However, some addressed problems
are still needed driver to help recovery; in this case, we don't want
driver show so much information. Patch 3/3 does this thing.

Patch 2/3 is to add pre-/post-M0 states to prevent SER state machine
timeout in driver side while firmware is processing much things.

Chin-Yen Lee (1):
  wifi: rtw89: suppress the log for specific SER called CMDPSR_FRZTO

Zong-Zhe Yang (2):
  wifi: rtw89: pci: fix interrupt enable mask for HALT C2H of RTL8851B
  wifi: rtw89: ser: L1 add pre-M0 and post-M0 states

 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/mac.c  | 42 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  |  2 ++
 drivers/net/wireless/realtek/rtw89/pci.c  |  9 +++--
 drivers/net/wireless/realtek/rtw89/pci.h  |  1 +
 drivers/net/wireless/realtek/rtw89/ser.c  | 43 ++++++++++++++++++++++-
 6 files changed, 96 insertions(+), 3 deletions(-)

-- 
2.25.1

