Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A36708E2D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 May 2023 05:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjESDPW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 23:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESDPV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 23:15:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F52B1
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 20:15:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34J3ExbF6004157, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34J3ExbF6004157
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 May 2023 11:14:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 19 May 2023 11:15:08 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 19 May
 2023 11:15:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/7] wifi: rtw89: 8851b: add to enable 8851BE
Date:   Fri, 19 May 2023 11:14:53 +0800
Message-ID: <20230519031500.21087-1-pkshih@realtek.com>
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

With preparation before, this patchset can enable 8851BE eventually.
Thanks for the review, Kalle.

The first four patches are to add remaining chip_ops and chip_info.
Patch 5/7 is to extend debugfs entry of read_reg to have ability to read
wider length of registers. Patch 6/7 is to enable a firmware feature, and
other features like hardware scan aren't verified completely, so I defer
to enable them later because current version can still work fine.

The last patch 7/7 is to modify Kconfig and Makefile to enable 8851BE.

Chin-Yen Lee (1):
  wifi: rtw89: add tx_wake notify for 8851B

Ping-Ke Shih (6):
  wifi: rtw89: 8851b: add TX power related functions
  wifi: rtw89: 8851b: fill BB related capabilities to chip_info
  wifi: rtw89: 8851b: add MAC configurations to chip_info
  wifi: rtw89: 8851b: add RF configurations
  wifi: rtw89: enlarge supported length of read_reg debugfs entry
  wifi: rtw89: 8851b: add 8851be to Makefile and Kconfig

 drivers/net/wireless/realtek/rtw89/Kconfig    |  14 +
 drivers/net/wireless/realtek/rtw89/Makefile   |   9 +
 drivers/net/wireless/realtek/rtw89/debug.c    |  23 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |   1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 603 ++++++++++++++++++
 6 files changed, 649 insertions(+), 3 deletions(-)

-- 
2.25.1

