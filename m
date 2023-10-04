Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A063B7B7AA7
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 10:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbjJDIv3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 04:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241878AbjJDIv2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 04:51:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01BCB4
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 01:51:23 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3948p9x753164811, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3948p9x753164811
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 16:51:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 4 Oct 2023 16:51:09 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 4 Oct 2023
 16:51:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: rtw88: update TX power along with regulations especially China
Date:   Wed, 4 Oct 2023 16:50:46 +0800
Message-ID: <20231004085051.205683-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The new regulation of China has been released, so update to the latest
TX power table that also includes some changes of QATAR and UK.

Zong-Zhe Yang (5):
  wifi: rtw88: regd: configure QATAR and UK
  wifi: rtw88: 8821c: update TX power limit to V67
  wifi: rtw88: 8822c: update TX power limit to V70
  wifi: rtw88: regd: update regulatory map to R64-R42
  wifi: rtw88: 8821c: tweak CCK TX filter setting for SRRC regulation

 drivers/net/wireless/realtek/rtw88/main.h     |    4 +-
 drivers/net/wireless/realtek/rtw88/regd.c     |   24 +-
 drivers/net/wireless/realtek/rtw88/regd.h     |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   67 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |    1 +
 .../wireless/realtek/rtw88/rtw8821c_table.c   | 1154 ++++++++++-----
 .../wireless/realtek/rtw88/rtw8822c_table.c   | 1239 +++++++----------
 7 files changed, 1437 insertions(+), 1054 deletions(-)

-- 
2.25.1

