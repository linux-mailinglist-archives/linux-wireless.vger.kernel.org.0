Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75967C626D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 03:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjJLBtl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 21:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjJLBtl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 21:49:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D4EA9
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 18:49:35 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39C1nQ7f9585690, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39C1nQ7f9585690
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 09:49:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 12 Oct 2023 09:49:26 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 12 Oct
 2023 09:49:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: generalize MAC registers to support WiFi 7 chips
Date:   Thu, 12 Oct 2023 09:48:56 +0800
Message-ID: <20231012014902.18523-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WiFi 7 registers of RTS, MU-EDCA and beamforming are different from
existing chips, but we can still possibly reuse most of existing code.
The initial beamformee code when associated is largely different, so make
them as individual functions.

Ping-Ke Shih (1):
  wifi: rtw89: mac: add registers of MU-EDCA parameters for WiFi 7 chips

Zong-Zhe Yang (5):
  wifi: rtw89: mac: update RTS threshold according to chip gen
  wifi: rtw89: mac: generalize register of MU-EDCA switch according to
    chip gen
  wifi: rtw89: mac: set bfee_ctrl() according to chip gen
  wifi: rtw89: mac: set bf_assoc capabilities according to chip gen
  wifi: rtw89: mac: do bf_monitor only if WiFi 6 chips

 drivers/net/wireless/realtek/rtw89/mac.c      |  57 ++++--
 drivers/net/wireless/realtek/rtw89/mac.h      |  22 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  16 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 174 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  79 ++++++++
 5 files changed, 322 insertions(+), 26 deletions(-)

-- 
2.25.1

