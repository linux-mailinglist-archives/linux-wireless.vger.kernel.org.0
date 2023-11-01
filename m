Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6817DDD15
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 08:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjKAHWm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 03:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjKAHWl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 03:22:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E231EE4
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 00:22:38 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A17MUQH01220453, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A17MUQH01220453
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 15:22:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 1 Nov 2023 15:22:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 1 Nov 2023
 15:22:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: rtw89: pci: add PCI generation struct to reuse common flow
Date:   Wed, 1 Nov 2023 15:21:44 +0800
Message-ID: <20231101072149.21997-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: license violation
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For WiFi 7 chips, the PCI settings are similar, but registers' names are
changed, so it will be difficult to understand the code if we mix the code
of two generations into one function. Therefore, we add a struct to
abstract PCI generation info, and put the code used by WiFi 7 chips
in pci_be.c.

Then, the struct hierarchy looks like

 rtwdev
   |
   v
 const struct rtw89_pci_info *pci_info;   // per chip (e.g. 8922ae.c)
   |
   v
 const struct rtw89_pci_gen_def *gen_def; // per generation (e.g. pci_be.c)

Ping-Ke Shih (5):
  wifi: rtw89: pci: add PCI generation information to pci_info for each
    chip
  wifi: rtw89: pci: use gen_def pointer to configure mac_{pre,post}_init
    and clear PCI ring index
  wifi: rtw89: pci: implement PCI mac_pre_init for WiFi 7 chips
  wifi: rtw89: pci: add LTR v2 for WiFi 7 chip
  wifi: rtw89: pci: implement PCI mac_post_init for WiFi 7 chips

 drivers/net/wireless/realtek/rtw89/pci.c      |  16 +-
 drivers/net/wireless/realtek/rtw89/pci.h      | 150 ++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c   | 429 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 271 +++++++++++
 .../net/wireless/realtek/rtw89/rtw8851be.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |   2 +
 9 files changed, 868 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/pci_be.c

-- 
2.25.1

