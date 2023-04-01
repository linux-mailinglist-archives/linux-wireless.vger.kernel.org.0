Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC526D314A
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 16:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDAO1V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Apr 2023 10:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjDAO1S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Apr 2023 10:27:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067B3DBC8
        for <linux-wireless@vger.kernel.org>; Sat,  1 Apr 2023 07:27:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 331EQnU02013306, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 331EQnU02013306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 1 Apr 2023 22:26:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 1 Apr 2023 22:27:07 +0800
Received: from localhost (172.16.16.15) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 1 Apr 2023
 22:27:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: rtw89: 8851b: add tables of parameters
Date:   Sat, 1 Apr 2023 22:25:45 +0800
Message-ID: <20230401142548.55466-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.15]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prepare parameter tables for 8851B. They are used to configure a lot of
hardware parameters and assist to complete RF calibration.

Ping-Ke Shih (3):
  wifi: rtw89: 8851b: add BB and RF tables (1 of 2)
  wifi: rtw89: 8851b: add BB and RF tables (2 of 2)
  wifi: rtw89: 8851b: add tables for RFK

 .../realtek/rtw89/rtw8851b_rfk_table.c        |   534 +
 .../realtek/rtw89/rtw8851b_rfk_table.h        |    38 +
 .../wireless/realtek/rtw89/rtw8851b_table.c   | 14824 ++++++++++++++++
 .../wireless/realtek/rtw89/rtw8851b_table.h   |    21 +
 4 files changed, 15417 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b_table.h

-- 
2.25.1

