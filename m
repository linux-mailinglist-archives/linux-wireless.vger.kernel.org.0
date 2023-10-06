Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C177BB8AB
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Oct 2023 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjJFNOI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Oct 2023 09:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJFNOH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Oct 2023 09:14:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E49F
        for <linux-wireless@vger.kernel.org>; Fri,  6 Oct 2023 06:14:05 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 396DDmkO61891442, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 396DDmkO61891442
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Oct 2023 21:13:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 6 Oct 2023 21:13:48 +0800
Received: from [127.0.1.1] (172.16.16.139) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 6 Oct 2023
 21:13:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: handle EHT rate
Date:   Fri, 6 Oct 2023 21:13:21 +0800
Message-ID: <20231006131327.16806-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.139]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

We have parsed new formats used by WiFi 7 chips before, and this patchset
is to handle EHT rate. The handlers contain
 - RX rate
   * from RX descriptor, which is also used to find corresponding PPDU
     status packet
 - TX rate
   * RA (Rate adaptive) mask to tell firmware selectable rates
   * RA report tells driver the rate selected by firmware
 - debugfs
   * show TX/RX rate above
 - monitor mode
   * add enumerators of radiotap bandwidth of EHT U-SIG
   * add EHT radiotap if working on monitor mode

Ping-Ke Shih (6):
  wifi: rtw89: parse EHT information from RX descriptor and PPDU status
    packet
  wifi: rtw89: Add EHT rate mask as parameters of RA H2C command
  wifi: rtw89: parse TX EHT rate selected by firmware from RA C2H report
  wifi: rtw89: show EHT rate in debugfs
  wifi: radiotap: add bandwidth definition of EHT U-SIG
  wifi: rtw89: add EHT radiotap in monitor mode

 drivers/net/wireless/realtek/rtw89/core.c  | 125 ++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h  |  11 +-
 drivers/net/wireless/realtek/rtw89/debug.c |  14 +++
 drivers/net/wireless/realtek/rtw89/phy.c   |  70 +++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h   |   5 +
 include/net/ieee80211_radiotap.h           |   6 +
 6 files changed, 214 insertions(+), 17 deletions(-)

-- 
2.25.1

