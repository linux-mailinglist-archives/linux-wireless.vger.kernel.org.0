Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44B7545CA9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 08:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346535AbiFJGwB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 02:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245306AbiFJGvx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 02:51:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86CC9591
        for <linux-wireless@vger.kernel.org>; Thu,  9 Jun 2022 23:51:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25A6pbUS3000789, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25A6pbUS3000789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jun 2022 14:51:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 14:51:37 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 10 Jun
 2022 14:51:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <gary.chang@realtek.com>,
        <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 0/5] rtw88: use const pointer of chip_info and fix hw_scan misbehavior
Date:   Fri, 10 Jun 2022 14:50:57 +0800
Message-ID: <20220610065102.17580-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 06/10/2022 06:35:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTAgpFekyCAwNDoyMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset depends on the patch
"rtw88: 8821c: fix access const table of channel parameters"
https://patchwork.kernel.org/project/linux-wireless/patch/20220608020312.9663-1-pkshih@realtek.com/

The first one patch is to use const pointer to access chip_info, so we can
avoid writing const area.

Patch 2~4 is to fix hw_scan misbehavior, but patch 2/5 add a field in
core.h just above the fields of "rtw88: 8821c: fix access const table of channel parameters",
so it also depends on that.

The final patch is fix smatch warning.

---

Hi Kalle,

The patch "rtw88: 8821c: fix access const table of channel parameters"
makes thing a little complicated. If this patchset doesn't work to you,
please guide me the best way you want. Thank you.

Chih-Kang Chang (2):
  rtw88: fix stopping queues in wrong timing when HW scan
  rtw88: fix store OP channel info timing when HW scan

Ping-Ke Shih (1):
  rtw88: access chip_info by const pointer

Po-Hao Huang (1):
  rtw88: 8822c: extend supported probe request size

Zong-Zhe Yang (1):
  rtw88: phy: fix warning of possible buffer overflow

 drivers/net/wireless/realtek/rtw88/bf.c       |  2 +-
 drivers/net/wireless/realtek/rtw88/coex.c     | 88 +++++++++----------
 drivers/net/wireless/realtek/rtw88/coex.h     | 14 +--
 drivers/net/wireless/realtek/rtw88/efuse.c    |  4 +-
 drivers/net/wireless/realtek/rtw88/fw.c       | 56 ++++++++----
 drivers/net/wireless/realtek/rtw88/fw.h       | 19 +++-
 drivers/net/wireless/realtek/rtw88/mac.c      | 18 ++--
 drivers/net/wireless/realtek/rtw88/mac80211.c |  9 +-
 drivers/net/wireless/realtek/rtw88/main.c     | 49 +++++++----
 drivers/net/wireless/realtek/rtw88/main.h     |  6 +-
 drivers/net/wireless/realtek/rtw88/pci.c      | 20 ++---
 drivers/net/wireless/realtek/rtw88/phy.c      | 65 +++++++-------
 drivers/net/wireless/realtek/rtw88/phy.h      |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  3 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  3 +-
 drivers/net/wireless/realtek/rtw88/tx.c       |  8 +-
 drivers/net/wireless/realtek/rtw88/util.c     |  4 +-
 19 files changed, 219 insertions(+), 157 deletions(-)

-- 
2.25.1

