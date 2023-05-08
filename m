Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE426FA1EE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjEHIMq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjEHIMp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:12:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EF83C34
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:12:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3488CLYP0006032, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3488CLYP0006032
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 16:12:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 May 2023 16:12:27 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 May 2023
 16:12:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: rtw89: support U-NII-4 5.9GHz channels
Date:   Mon, 8 May 2023 16:12:08 +0800
Message-ID: <20230508081211.38760-1-pkshih@realtek.com>
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

8852B, 8852C and upcoming 8851B can support U-NII-4, so add this patchset
to enable this feature. However, we can't turn it on unconditionally,
because hardware may not get certification in certain platforms, so add
a flag in BIOS ACPI to determine if we should disable these channels.

Zong-Zhe Yang (3):
  wifi: rtw89: introduce realtek ACPI DSM method
  wifi: rtw89: regd: judge UNII-4 according to BIOS and chip
  wifi: rtw89: support U-NII-4 channels on 5GHz band

 drivers/net/wireless/realtek/rtw89/Makefile   |  3 +-
 drivers/net/wireless/realtek/rtw89/acpi.c     | 52 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/acpi.h     | 21 +++++++
 drivers/net/wireless/realtek/rtw89/core.c     | 10 ++-
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/regd.c     | 61 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 10 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/acpi.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/acpi.h

-- 
2.25.1

