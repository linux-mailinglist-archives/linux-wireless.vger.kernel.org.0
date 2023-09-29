Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D207B29DA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 02:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjI2Alc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 20:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjI2Alb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 20:41:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531911F
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 17:41:28 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38T0fJlR5260772, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38T0fJlR5260772
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 08:41:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 29 Sep 2023 08:41:19 +0800
Received: from [127.0.1.1] (172.16.16.144) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 29 Sep
 2023 08:41:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/2] wifi: rtw89: consider UL-bandwidth of trigger frame as clue to improve OFDMA performance
Date:   Fri, 29 Sep 2023 08:40:22 +0800
Message-ID: <20230929004024.7504-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.144]
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

Patch 2/2 is the main patch to improve UL-OFDMA performance when
UL-bandwidth is 160MHz and RU < 106. In this case, apply pre-calculated
matrix to transmit with proper power.

To assist that, patch 1/2 is to adjust naming of waveform control related
to trigger frame to avoid ambiguity.

v2:
 - correct messed up patchset containing duplicate patch 3/3 in v1
 - since patch 1/3 of v1 has been merged. Only two patches in v2
 - don't change patches content at all

Po-Hao Huang (2):
  wifi: rtw89: refine uplink trigger based control mechanism
  wifi: rtw89: refine bandwidth 160MHz uplink OFDMA performance

 drivers/net/wireless/realtek/rtw89/core.c     |  17 ++-
 drivers/net/wireless/realtek/rtw89/core.h     |  29 +++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 129 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/reg.h      |  12 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   3 +-
 8 files changed, 159 insertions(+), 40 deletions(-)

-- 
2.25.1

