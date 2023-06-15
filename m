Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7159F731987
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 15:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbjFONFa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 09:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjFONF3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 09:05:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5951BC9
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 06:05:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35FD50LC0032311, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35FD50LC0032311
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 15 Jun 2023 21:05:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 15 Jun 2023 21:05:19 +0800
Received: from [127.0.1.1] (172.16.16.227) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 15 Jun
 2023 21:05:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: rtw89: 8851b: update 8851b to improve abnormal samples
Date:   Thu, 15 Jun 2023 21:04:37 +0800
Message-ID: <20230615130442.18116-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.227]
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

We found some samples work improperly in field. Some have poor RF
performance, and some can't transmit suddenly.

To fix these problems, update RF parameter, TX power table and IQK to the
latest version. LCK track is to improve poor RF performance result from
growing thermal value after stress test. The last patch is to fix some
samples can't transmit in certain situations.

Ping-Ke Shih (4):
  wifi: rtw89: 8851b: update RF radio A parameters to R28
  wifi: rtw89: 8851b: rfk: add LCK track
  wifi: rtw89: 8851b: rfk: update IQK to version 0x8
  wifi: rtw89: 8851b: configure to force 1 TX power value

Zong-Zhe Yang (1):
  wifi: rtw89: 8851b: update TX power tables to R28

 drivers/net/wireless/realtek/rtw89/reg.h      |  23 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   5 +
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 180 +++++++++----
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.h |   2 +
 .../wireless/realtek/rtw89/rtw8851b_table.c   | 250 ++++++++++--------
 5 files changed, 289 insertions(+), 171 deletions(-)

-- 
2.25.1

