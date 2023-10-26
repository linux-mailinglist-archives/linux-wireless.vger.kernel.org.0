Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01F37D8224
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjJZMBm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjJZMBl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 08:01:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7C791
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 05:01:35 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39QC1HSA02779270, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39QC1HSA02779270
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:01:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Oct 2023 20:01:18 +0800
Received: from [127.0.1.1] (172.16.17.48) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 26 Oct
 2023 20:01:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: add 8922AE PCI entry and used functions
Date:   Thu, 26 Oct 2023 20:00:45 +0800
Message-ID: <20231026120049.9187-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.48]
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

8922AE is a PCIe 802.11be WiFi adapter that is 2x2 20/40/80/160MHz
bandwidth on 2/5/6GHz bands. This patchset is to add the PCI entry and
add functions that are different from existing WiFi 6 chips.

Currently only a little stuff is added, so I don't add it to
Makefile/Kconfig for now.

Ping-Ke Shih (4):
  wifi: rtw89: 8922ae: add 8922AE PCI entry and basic info
  wifi: rtw89: pci: define PCI ring address for WiFi 7 chips
  wifi: rtw89: pci: add new RX ring design to determine full RX ring
    efficiently
  wifi: rtw89: pci: generalize code of PCI control DMA IO for WiFi 7

 drivers/net/wireless/realtek/rtw89/pci.c      | 130 ++++++++++----
 drivers/net/wireless/realtek/rtw89/pci.h      | 168 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  22 +++
 .../net/wireless/realtek/rtw89/rtw8851be.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   2 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |   2 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |   2 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  79 ++++++++
 8 files changed, 372 insertions(+), 34 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922ae.c

-- 
2.25.1

