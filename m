Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933A26E22E2
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDNMMC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDNMMA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:12:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4515D86AA
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:11:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33ECBRLa8007074, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33ECBRLa8007074
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 14 Apr 2023 20:11:27 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 14 Apr 2023 20:11:50 +0800
Received: from localhost (172.16.20.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 14 Apr
 2023 20:11:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/8] wifi: rtw88: support single channel concurrency
Date:   Fri, 14 Apr 2023 20:11:27 +0800
Message-ID: <20230414121135.17828-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.53]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

To support SCC (1 STA + 1 AP), we need to deal some hardware things:
 1. AP mode only can work on hardware port 0
 2. adjust and enlarge reserved pages for two VIFs

Other things are to coordinate two VIFs work well to prevent interference
with each other, like scan thing.

v2:
  - use rtw_dbg() instead of rtw_info() for switching port. (patch 2/8)
  - Don't reject scan when operating AP mode, so remove the limitation
    from patch 4/8 and add patch 7/8 to handle it.
    Due to hardware limitation, we can't sending beacon and do scan at
    the same time, so it could lose some packets or AP's clients get
    disconnected.

Po-Hao Huang (8):
  wifi: rtw88: add bitmap for dynamic port settings
  wifi: rtw88: add port switch for AP mode
  wifi: rtw88: 8822c: extend reserved page number
  wifi: rtw88: disallow PS during AP mode
  wifi: rtw88: refine reserved page flow for AP mode
  wifi: rtw88: prevent scan abort with other VIFs
  wifi: rtw88: handle station mode concurrent scan with AP mode
  wifi: rtw88: 8822c: add iface combination

 drivers/net/wireless/realtek/rtw88/fw.c       |  20 ++-
 drivers/net/wireless/realtek/rtw88/fw.h       |   2 +-
 drivers/net/wireless/realtek/rtw88/mac.c      |   2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  40 ++++-
 drivers/net/wireless/realtek/rtw88/main.c     | 146 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  15 ++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   1 +
 10 files changed, 217 insertions(+), 12 deletions(-)

-- 
2.25.1

