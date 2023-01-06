Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0196965FFF0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 13:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjAFMJS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Jan 2023 07:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjAFMJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Jan 2023 07:09:15 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15A59718A7
        for <linux-wireless@vger.kernel.org>; Fri,  6 Jan 2023 04:09:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 306C83Em8028222, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 306C83Em8028222
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Jan 2023 20:08:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 6 Jan 2023 20:09:00 +0800
Received: from localhost (172.16.18.220) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 6 Jan 2023
 20:08:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/7] wifi: rtw89: coex: third patchset to adopt BTC version
Date:   Fri, 6 Jan 2023 20:08:37 +0800
Message-ID: <20230106120844.17441-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.18.220]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/06/2023 11:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvNiCkV6TIIDA5OjMyOjAw?=
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

This patchset is continue to adopt BTC version to coexistence, and
dependency is the second patchset
"wifi: rtw89: coex: second patchset to adopt BTC version"

Ching-Te Ku (7):
  wifi: rtw89: coex: Add version code for Wi-Fi firmware coexistence
    control
  wifi: rtw89: coex: Change Wi-Fi Null data report to version separate
  wifi: rtw89: coex: Change firmware steps report to version separate
  wifi: rtw89: coex: refactor debug log of slot list
  wifi: rtw89: coex: Packet traffic arbitration hardware owner monitor
  wifi: rtw89: coex: Change RTL8852B use v1 TDMA policy
  wifi: rtw89: coex: Change Wi-Fi role info related logic to version
    separate

 drivers/net/wireless/realtek/rtw89/coex.c     | 272 +++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h     |  58 +++-
 drivers/net/wireless/realtek/rtw89/fw.c       |   4 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  11 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   2 +-
 5 files changed, 223 insertions(+), 124 deletions(-)

-- 
2.25.1

