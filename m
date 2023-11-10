Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687F87E767A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 02:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjKJBY0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 20:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJBYZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 20:24:25 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6510182
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 17:24:22 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AA1O88o81890496, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AA1O88o81890496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:24:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 10 Nov 2023 09:24:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 10 Nov
 2023 09:24:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/7] wifi: rtw89: pci: add PCI DMA and interrupt stuff for WiFi 7 chips
Date:   Fri, 10 Nov 2023 09:23:12 +0800
Message-ID: <20231110012319.12727-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
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
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The PCI flow of WiFi 6 and 7 chips are almost the same, so abstract
register definition to reuse them.

Patches 1-3 are to add new functions to configure WiFi 7 chips; patches 4-5
are to refine interrupt handlers. Then, refine the frequent interrupts by
the last two patches that can largely reduce interrupts.

Ping-Ke Shih (5):
  wifi: rtw89: pci: add pre_deinit to be called after probe complete
  wifi: rtw89: pci: generalize interrupt status bits of interrupt
    handlers
  wifi: rtw89: 8922ae: add v2 interrupt handlers for 8922AE
  wifi: rtw89: pci: correct interrupt mitigation register for 8852CE
  wifi: rtw89: pci: update interrupt mitigation register for 8922AE

Zong-Zhe Yang (2):
  wifi: rtw89: pci: reset BDRAM according to chip gen
  wifi: rtw89: pci: stop/start DMA for level 1 recovery according to
    chip gen

 drivers/net/wireless/realtek/rtw89/core.c     |   2 +
 drivers/net/wireless/realtek/rtw89/core.h     |   6 +
 drivers/net/wireless/realtek/rtw89/pci.c      | 177 ++++++++++++----
 drivers/net/wireless/realtek/rtw89/pci.h      | 197 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c   |  80 +++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  63 ++++++
 .../net/wireless/realtek/rtw89/rtw8851be.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |   5 +
 drivers/net/wireless/realtek/rtw89/ser.c      |   6 +
 12 files changed, 495 insertions(+), 45 deletions(-)

-- 
2.25.1

