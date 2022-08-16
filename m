Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35695952C8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 08:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiHPGn1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 02:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHPGnE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 02:43:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6238AF2D6C
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 18:33:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27G1WrwU6011752, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27G1WrwU6011752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 16 Aug 2022 09:32:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 09:33:05 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 16 Aug
 2022 09:33:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/3] wifi: rtw89: correct BA CAM allocation
Date:   Tue, 16 Aug 2022 09:32:44 +0800
Message-ID: <20220816013247.6243-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 08/16/2022 01:16:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTUgpFWkyCAxMDo1MjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

BA CAM is a global hardware resource, but we incorrectly see it as a
per-station resource. In station mode, it works well, but it will be wrong
if AP mode or multiple vif(s) in the future.

Therefore, move bitmap of BA_CAM to struct rtw89_dev::rtw89_cam_info.

v2: fix compiler warning reported by kernel test robot

Ping-Ke Shih (3):
  wifi: rtw89: 8852c: declare correct BA CAM number
  wifi: rtw89: 8852c: initialize and correct BA CAM content
  wifi: rtw89: correct BA CAM allocation

 drivers/net/wireless/realtek/rtw89/core.c     | 60 ++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h     | 19 ++++--
 drivers/net/wireless/realtek/rtw89/debug.c    | 27 ++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 66 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  9 +++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  3 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  3 +
 drivers/net/wireless/realtek/rtw89/ser.c      |  8 ++-
 8 files changed, 166 insertions(+), 29 deletions(-)

-- 
2.25.1

