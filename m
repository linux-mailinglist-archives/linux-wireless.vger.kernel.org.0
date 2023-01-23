Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298B9677541
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 07:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjAWGys (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 01:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjAWGyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 01:54:45 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60999193F5
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 22:54:41 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30N6sOcuD012861, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30N6sOcuD012861
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 23 Jan 2023 14:54:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 23 Jan 2023 14:54:27 +0800
Received: from localhost (172.16.16.32) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 23 Jan
 2023 14:54:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: prepare packets offload to support newer firmware
Date:   Mon, 23 Jan 2023 14:53:55 +0800
Message-ID: <20230123065401.14174-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.32]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/23/2023 06:33:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMjMgpFekyCAxMjozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The packet offload is that driver prepare packets, such as QoS null or null
frames, and firmware uses these packets to tell AP about power state, for
example. The older firmware can prepare this itself, but further firmware
in the future will always need driver's help.

First three patches are to fix and adjust packet offload feature. The
latter three patches are to support new firmware type NORMAL_CE that
doesn't have LPS-PS mode but have P2P-PS and hardware scan.

Chin-Yen Lee (2):
  wifi: rtw89: fix potential wrong mapping for pkt-offload
  wifi: rtw89: refine packet offload flow

Ping-Ke Shih (4):
  wifi: rtw89: add use of pkt_list offload to debug entry
  wifi: rtw89: 8852b: reset IDMEM mode to default value
  wifi: rtw89: 8852b: don't support LPS-PG mode after firmware 0.29.26.0
  wifi: rtw89: 8852b: try to use NORMAL_CE type firmware first

 drivers/net/wireless/realtek/rtw89/core.c     | 23 ++---
 drivers/net/wireless/realtek/rtw89/core.h     |  5 +-
 drivers/net/wireless/realtek/rtw89/debug.c    | 36 ++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 84 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h       |  6 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  5 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  3 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/ser.c      |  1 +
 drivers/net/wireless/realtek/rtw89/wow.c      | 26 ++----
 13 files changed, 147 insertions(+), 46 deletions(-)

-- 
2.25.1

