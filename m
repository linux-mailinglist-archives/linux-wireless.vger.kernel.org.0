Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F74720553
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 17:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbjFBPGh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 11:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjFBPGf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 11:06:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C141BB
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 08:06:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 352F67D20004570, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 352F67D20004570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 2 Jun 2023 23:06:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 2 Jun 2023 23:06:22 +0800
Received: from [127.0.1.1] (172.16.22.87) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Jun 2023
 23:06:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: support 6 GHz power types STD/LPI/VLP
Date:   Fri, 2 Jun 2023 23:05:48 +0800
Message-ID: <20230602150556.36777-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.22.87]
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Originally, rtw89 has only single one power table for 6 GHz band, like
2/5 GHz, and uses the lowest power of STD/LPI/VLP for every regulatory
domain. Relying on power_type of mac80211, this patchset introduces
three power tables for 6 GHz band, so driver can follow AP's advertisement
to choose proper power type.

Since some platforms doesn't get 6 GHz certification before shipping
product, patch 2/8 reads the capability from BIOS and disable 6 GHz
channels for this kind of product.

To output properly 6 GHz TX power for all power types, update to the latest
version of power tables and RF parameters by patches 5-8/8.
(Because of increasing dimension, power tables are changed a lot. I split
power tables into three patches.)

Ping-Ke Shih (1):
  wifi: rtw89: 8852c: update RF radio A/B parameters to R63

Zong-Zhe Yang (7):
  wifi: rtw89: refine clearing supported bands to check 2/5 GHz first
  wifi: rtw89: regd: judge 6 GHz according to chip and BIOS
  wifi: rtw89: regd: update regulatory map to R64-R40
  wifi: rtw89: process regulatory for 6 GHz power type
  wifi: rtw89: 8852c: update TX power tables to R63 with 6 GHz power
    type (1 of 3)
  wifi: rtw89: 8852c: update TX power tables to R63 with 6 GHz power
    type (2 of 3)
  wifi: rtw89: 8852c: update TX power tables to R63 with 6 GHz power
    type (3 of 3)

 drivers/net/wireless/realtek/rtw89/core.c     |    13 +-
 drivers/net/wireless/realtek/rtw89/core.h     |    31 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |     9 +
 drivers/net/wireless/realtek/rtw89/phy.c      |    16 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |   263 +-
 .../wireless/realtek/rtw89/rtw8852c_table.c   | 28272 +++++++++++++---
 6 files changed, 23872 insertions(+), 4732 deletions(-)

-- 
2.25.1

