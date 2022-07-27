Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36316582073
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 08:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiG0Gvs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 02:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiG0Gv2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 02:51:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1D1AD134
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 23:50:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26R6oPSp9001369, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26R6oPSp9001369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 27 Jul 2022 14:50:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 14:50:31 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 27 Jul
 2022 14:50:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 0/4] rtw88: use const pointer of chip_info and fix hw_scan misbehavior
Date:   Wed, 27 Jul 2022 14:49:59 +0800
Message-ID: <20220727065003.28340-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/27/2022 06:32:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMjcgpFekyCAwMToxNDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Patch 1~3 is to fix hw_scan misbehavior, and the final patch is fix smatch
warning.

v3: do rebase to the latest codebase.
v2: shink patchset from 5 to 4 patches, because the first patch is based on
    another patch that get merged into wireless.git. So, the patch is
    postponed.

Chih-Kang Chang (2):
  rtw88: fix stopping queues in wrong timing when HW scan
  rtw88: fix store OP channel info timing when HW scan

Po-Hao Huang (1):
  rtw88: 8822c: extend supported probe request size

Zong-Zhe Yang (1):
  rtw88: phy: fix warning of possible buffer overflow

 drivers/net/wireless/realtek/rtw88/fw.c       | 36 +++++++++++++++----
 drivers/net/wireless/realtek/rtw88/fw.h       | 19 +++++++++-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  5 ++-
 drivers/net/wireless/realtek/rtw88/main.c     | 21 ++++++++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  4 ++-
 drivers/net/wireless/realtek/rtw88/phy.c      | 21 +++++------
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  3 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  3 +-
 10 files changed, 90 insertions(+), 28 deletions(-)

-- 
2.25.1

