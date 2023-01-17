Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0F866DCB3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 12:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbjAQLl6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 06:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbjAQLl4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 06:41:56 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9DEB9012
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 03:41:55 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30HBffqC7012209, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30HBffqC7012209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Jan 2023 19:41:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 17 Jan 2023 19:41:41 +0800
Received: from localhost (172.16.17.65) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 17 Jan
 2023 19:41:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: coex: the last patchset to adapt BTC version
Date:   Tue, 17 Jan 2023 19:41:01 +0800
Message-ID: <20230117114109.4298-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.65]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/17/2023 11:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTcgpFekyCAwOToxNDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset is to add some fixes and refinements found during adapting
BTC version. After these, we can support all current firmware and will
continue to update to support newer ones in the future.

Ching-Te Ku (8):
  wifi: rtw89: coex: Update Wi-Fi external control TDMA
    parameters/tables
  wifi: rtw89: coex: Clear Bluetooth HW PTA counter when radio state
    change
  wifi: rtw89: coex: Force to update TDMA parameter when radio state
    change
  wifi: rtw89: coex: Refine coexistence log
  wifi: rtw89: coex: Set Bluetooth background scan PTA request priority
  wifi: rtw89: coex: Correct A2DP exist variable source
  wifi: rtw89: coex: Fix test fail when coexist with raspberryPI A2DP
    idle
  wifi: rtw89: coex: Update Wi-Fi Bluetooth coexistence version to 7.0.0

 drivers/net/wireless/realtek/rtw89/coex.c | 212 ++++++++++++----------
 1 file changed, 113 insertions(+), 99 deletions(-)

-- 
2.25.1

