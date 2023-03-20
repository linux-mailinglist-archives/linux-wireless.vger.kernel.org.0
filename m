Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F86C12BA
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 14:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCTNHq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 09:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjCTNHo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 09:07:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8541B561
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 06:07:43 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32KD7NbrC025639, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32KD7NbrC025639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Mar 2023 21:07:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Mar 2023 21:07:16 +0800
Received: from localhost (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Mar
 2023 21:07:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: rtw89: improve firmware code to be backward compatible with old driver
Date:   Mon, 20 Mar 2023 21:06:03 +0800
Message-ID: <20230320130606.20777-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.31]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

Patch 1/3 and 2/3 are to refine code related to firmware. Among them,
patch 2/3 is to use schedule_work() to load firmware, so it will be
simpler to load more firmware and files in the future. The upcoming files
include predefined format string of firmware log, another MCU firmware
of WiFi 7 chip, and so on. I will explain them when we submit the patch.

Patch 3/3 is to be backward compatible with old driver. Currently, only
8852b support firmware-1.bin, and other can support more, like
firmware-2.bin and firmware-3.bin.

Supported matrix is listed below:
                    dirver-0    driver-1    driver-2
 firmware.bin          O           o           o
 firmware-1.bin        x           O           o
 firmware-2.bin        x           x           O

 Big-O: MODULE_FIRMWARE()
 small-o: supported firmware
 x: driver doesn't try to load

This patchset is based on two other patchsets:
 - "[PATCH v2] wifi: rtw89: add counters of register-based H2C/C2H"
 - "[PATCH v4 0/5] wifi: rtw89: preparation of multiple interface concurrency support"

Ping-Ke Shih (2):
  wifi: rtw89: use schedule_work to request firmware
  wifi: rtw89: add firmware format version to backward compatible with
    older drivers

Zong-Zhe Yang (1):
  wifi: rtw89: fw: use generic flow to set/check features

 drivers/net/wireless/realtek/rtw89/core.c     |  27 ++--
 drivers/net/wireless/realtek/rtw89/core.h     |  12 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 138 +++++++++---------
 drivers/net/wireless/realtek/rtw89/fw.h       |  14 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  10 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  10 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  10 +-
 7 files changed, 132 insertions(+), 89 deletions(-)

-- 
2.25.1

