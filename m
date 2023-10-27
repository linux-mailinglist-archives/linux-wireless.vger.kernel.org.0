Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983C87D8CD9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 03:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjJ0BpO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 21:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0BpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 21:45:13 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F8BAB
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 18:45:09 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39R1ix2H33456085, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39R1ix2H33456085
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 09:44:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 27 Oct 2023 09:44:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 27 Oct
 2023 09:44:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: update address CAM size and PPDU parser to support WiFi 7 chips
Date:   Fri, 27 Oct 2023 09:43:58 +0800
Message-ID: <20231027014402.9448-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Patch 1/3 is to fill various entry size of address CAM accordingly, because
hardware designer shrinks size for new chips.

Patch 2/4 ~ 3/4 aim to adjust parser of RX PPDU status, the logic is almost
the same as existing, but size and fields are changed a little. The PPDU
packet looks like

 +---------------------------+
 |           RX WD           |  (RX WD is fixed length basically)
 | type = PDDU satus         |
 |                           |
 +---------------------------+
 | PPDU status - MAC part    |
 | * basic info (8 bytes)    |  (basic info indicates if following fields
 |   - usr_num               |   are existing)
 |   - with_rx_info          |
 |   - plcp_len              |
 | * usrs[usr_num]           |
 | * rx info(128 bytes opt.) |
 | * plcp[plcp_len]          |
 +---------------------------+
 |  PPDU status - PHY part   |
 | * basic info (8 bytes)    |
 |   - total length          |
 | * IEs[]                   |  (iterate all IEs within total length)
 +---------------------------+

Ping-Ke Shih (3):
  wifi: rtw89: set entry size of address CAM to H2C field by chip
  wifi: rwt89: consider RX info for WiFi 7 chips
  wifi: rtw89: extend PHY status parser to support WiFi 7 chips

Zong-Zhe Yang (1):
  wifi: rtw89: configure PPDU max user by chip

 drivers/net/wireless/realtek/rtw89/cam.c      | 16 +++-
 drivers/net/wireless/realtek/rtw89/core.c     | 86 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/txrx.h     |  4 +
 9 files changed, 99 insertions(+), 15 deletions(-)

-- 
2.25.1

