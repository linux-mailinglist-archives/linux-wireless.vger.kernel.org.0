Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C607664B0
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjG1HDg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjG1HDe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:03:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74C0619AF
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:03:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36S737NR0031328, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36S737NR0031328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 28 Jul 2023 15:03:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 28 Jul 2023 15:03:20 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 28 Jul
 2023 15:03:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/10] wifi: rtw89: add hardware rate v1 and adjust related things for WiFi 7
Date:   Fri, 28 Jul 2023 15:02:42 +0800
Message-ID: <20230728070252.66525-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The coming WiFi 7 chip named 8922AE uses different rate code, and basically
we can use chip generations (i.e. 802.11ax/802.11be) to determine which one
we should use.

The things related to rate in this patchset are
 - The rate to set fixed rate configured by 'iw bitrates'
 - TX rate (set by rate mask for firmware rate adaptive mechanism)
 - TX rate report (reported by firmware to tell driver TX rate it is
   currently using)
 - RX rate from RX descriptor
 - TX/RX histogram in debugfs

It still only support HE rate, and we will support EHT later. So,
everything is almost unchanged for existing chips.

Among this patchset, some are to adjust H2C/C2H marco to use struct, such
as 4/10, 6/10 and 7/10. They don't change logic at all.

Ping-Ke Shih (9):
  wifi: rtw89: add chip_info::chip_gen to determine chip generation
  wifi: rtw89: define hardware rate v1 for WiFi 7 chips
  wifi: rtw89: use struct to set RA H2C command
  wifi: rtw89: add H2C RA command V1 to support WiFi 7 chips
  wifi: rtw89: use struct to access firmware C2H event header
  wifi: rtw89: use struct to access RA report
  wifi: rtw89: add C2H RA event V1 to support WiFi 7 chips
  wifi: rtw89: add to display hardware rates v1 histogram in debugfs
  wifi: rtw89: get data rate mode/NSS/MCS v1 from RX descriptor

Zong-Zhe Yang (1):
  wifi: rtw89: phy: rate pattern handles HW rate by chip gen

 drivers/net/wireless/realtek/rtw89/core.c     |  24 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 205 +++++++++++++-
 drivers/net/wireless/realtek/rtw89/debug.c    |  35 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 104 +++++---
 drivers/net/wireless/realtek/rtw89/fw.h       | 251 ++++++------------
 drivers/net/wireless/realtek/rtw89/phy.c      |  93 +++++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/txrx.h     |  47 +++-
 11 files changed, 486 insertions(+), 277 deletions(-)

-- 
2.25.1

