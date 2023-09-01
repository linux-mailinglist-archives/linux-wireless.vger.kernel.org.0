Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FFD78F870
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 08:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjIAGQW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 02:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjIAGQW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 02:16:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D79A412F
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 23:16:19 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3816FeVB2003773, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3816FeVB2003773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 14:15:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 1 Sep 2023 14:16:05 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 1 Sep 2023
 14:16:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: generalize download firmware flow to support WiFi 7 chips
Date:   Fri, 1 Sep 2023 14:14:59 +0800
Message-ID: <20230901061507.34312-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WiFi 7 chips can download BB MCU firmware via the same path as existing
WiFi CPU firmware, and we need to check them successful after downloading,
so use a corresponding hardware bit to confirm certain firmware is ready.

To reuse the flow, uses mac_gen pointers to adapt WiFi 6/7 chips with
different settings and checking rules. Also, refine flow to support
download firmware one by one. Then, changes of flow look like

  1. initial setup                 --> no logic change
  2. download WiFi CPU firmware    --> 2. for all firmware suits
                                       2.1. download WiFi CPU firmware &
                                            check ready
                                       2.2. download BB MCU firmware &
                                            check ready
  3. check ready by status code    --> no logic change

Ping-Ke Shih (8):
  wifi: rtw89: fw: move polling function of firmware path ready to an
    individual function
  wifi: rtw89: fw: generalize download firmware flow by mac_gen pointers
  wifi: rtw89: fw: implement supported functions of download firmware
    for WiFi 7 chips
  wifi: rtw89: fw: add checking type for variant type of firmware
  wifi: rtw89: fw: propagate an argument include_bb for BB MCU firmware
  wifi: rtw89: 8922a: add chip_ops::bb_preinit to enable BB before
    downloading firmware
  wifi: rtw89: fw: refine download flow to support variant firmware
    suits
  wifi: rtw89: 8922a: set memory heap address for secure firmware

 drivers/net/wireless/realtek/rtw89/core.c     |   2 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  19 +++
 drivers/net/wireless/realtek/rtw89/fw.c       | 122 +++++++++-----
 drivers/net/wireless/realtek/rtw89/fw.h       |   7 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  45 +++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  10 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 151 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 109 +++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   2 +
 drivers/net/wireless/realtek/rtw89/wow.c      |   4 +-
 13 files changed, 424 insertions(+), 53 deletions(-)

-- 
2.25.1

