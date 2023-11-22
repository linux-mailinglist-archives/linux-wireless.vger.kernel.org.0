Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD02D7F3DE8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 07:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjKVGGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 01:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKVGGL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 01:06:11 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F471B9
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 22:06:05 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AM65ugS62079010, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AM65ugS62079010
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Nov 2023 14:05:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Nov 2023 14:05:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 22 Nov
 2023 14:05:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <jamie_chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: phy: add dynamic EDCCA mechanism
Date:   Wed, 22 Nov 2023 14:04:54 +0800
Message-ID: <20231122060458.30878-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The dynamic EDCCA mechanism is to enhance performance in field, and this
mechanism is highly related to environment circumstance such as channel
loading. In order to continuously improve this mechanism, other patches
provide more debug interfaces as helpers.

This patchset depends on another patchset
"wifi: rtw89: read country list supporting 6 GHz from BIOS", because both
of they change debug.h.

Ping-Ke Shih (3):
  wifi: rtw89: debug: add to check if debug mask is enabled
  wifi: rtw89: debug: add debugfs entry to disable dynamic mechanism
  wifi: rtw89: debug: remove wrapper of rtw89_debug()

Yi-Chen Chen (1):
  wifi: rtw89: phy: dynamically adjust EDCCA threshold

 drivers/net/wireless/realtek/rtw89/core.c     |   1 +
 drivers/net/wireless/realtek/rtw89/core.h     |  32 ++-
 drivers/net/wireless/realtek/rtw89/debug.c    |  65 +++++-
 drivers/net/wireless/realtek/rtw89/debug.h    |  18 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 211 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |   9 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  39 +++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  16 +-
 11 files changed, 411 insertions(+), 28 deletions(-)

-- 
2.25.1

