Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C560EF7A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 07:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiJ0F14 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Oct 2022 01:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiJ0F1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Oct 2022 01:27:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C28D415A8E5
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 22:27:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29R5R64L0019395, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29R5R64L0019395
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Oct 2022 13:27:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 27 Oct 2022 13:27:40 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 27 Oct
 2022 13:27:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/7] wifi: rtw89: support WoWLAN
Date:   Thu, 27 Oct 2022 13:27:00 +0800
Message-ID: <20221027052707.14605-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/27/2022 05:04:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI2IKRVpMggMTE6MzI6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WoWLAN (Wake on WLAN) is a feature which allows devices to be woken up from
suspend state by WLAN events. When specific events are received, WiFi chip
raises a physical pin or sends an in-band message to wake up system. For a
PCIE WiFi device, it sends a PCIE PME event to host.

Before entering suspend, driver needs to stop TX/RX DMA, swap to WoWLAN
firmware due to firmware size is limited, and then restart HCI properly for
WoWLAN mode. To avoid track work to ask entering LPS while process of
going to suspend, we forbid the work during suspend/resume period.

In additional to main flow mentioned above, patch 1/7 is to prepare RF
parameters to help WoWLAN firmware configure RF. Patch 2/7 is to refine
download_firmware(), because swapping WoWLAN firmware can reuse the flow.
Patch 4/7 is to drop TX packets to ensure TX queue empty before entering
suspend.

The main patch is 6/7, it adds main flow of WoWLAN, and the last patch is
to add WoWLAN pattern match. Since WoWLAN of 8852B is still under
development, we don't enable it at this patchset, and will support it soon.

v2:
  - patch "wifi: rtw89: add drop tx packet function"
    add RTW89_PKT_DROP_SEL_BAND_ONCE case to avoid unhandled message.
  - patch "wifi: rtw89: add WoWLAN function support"
    use int instead of u8 as type of 'ret' for read_poll_timeout_atomic()
    in rtw89_wow_check_fw_status().

Chih-Kang Chang (4):
  wifi: rtw89: collect and send RF parameters to firmware for WoWLAN
  wifi: rtw89: move enable_cpu/disable_cpu into fw_download
  wifi: rtw89: add function to adjust and restore PLE quota
  wifi: rtw89: add drop tx packet function

Chin-Yen Lee (3):
  wifi: rtw89: add related H2C for WoWLAN mode
  wifi: rtw89: add WoWLAN function support
  wifi: rtw89: add WoWLAN pattern match support

 drivers/net/wireless/realtek/rtw89/Makefile   |   2 +
 drivers/net/wireless/realtek/rtw89/core.c     |  10 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 129 ++-
 drivers/net/wireless/realtek/rtw89/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 295 ++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 249 ++++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 135 ++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  31 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  55 ++
 drivers/net/wireless/realtek/rtw89/pci.c      |  23 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  31 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |   2 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |   2 +-
 drivers/net/wireless/realtek/rtw89/ps.h       |   1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  21 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  18 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  14 +
 drivers/net/wireless/realtek/rtw89/util.h     |  11 +
 drivers/net/wireless/realtek/rtw89/wow.c      | 859 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/wow.h      |  21 +
 20 files changed, 1890 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/wow.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/wow.h

-- 
2.25.1

