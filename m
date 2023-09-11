Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A69479A5EA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Sep 2023 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjIKIWO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 04:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjIKIWN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 04:22:13 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D7DC
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 01:22:08 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38B8LwWF21002935, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38B8LwWF21002935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 16:21:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 11 Sep 2023 16:21:59 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Sep
 2023 16:21:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: add TX/RX descriptor v2 and mac port registers for WiFi 7 chips
Date:   Mon, 11 Sep 2023 16:20:43 +0800
Message-ID: <20230911082049.33541-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WiFi 7 chips use different TX/RX descriptors and mac port registers, but
logic is similar or the same as before, so implment them and reuse the
existing code.

Three descriptors types:
 - RX descriptor or RXWD (RX WiFi Descriptor) for short
   That is meta data of received packet, such as MAC_ID, security CAM
   index and etc.
 - TX descriptor or TXWD (TX WiFi Descriptor) for short
   That is meta data of sending packet. Similar to RX descriptor, it
   contains MAC_ID, security key ID and etc.
 - TX descriptor for firmware command
   To send firmware command or download firmware is via a special path, and
   use different descriptor from normal TX packets. Because it doesn't need
   much meta data to assist, we choose short form RXWD to reduce overhead.

About TXWD body and info:
   TXWD body is hard required, but TXWD info can be skipped to reduce
   overhead. A bit defined in TXWD body to indicate if TXWD info presents.
   For this driver, we always fill both.

About RXWD short and long forms:
   Similarly, RXWD can be short or long forms. For driver, it must handle
   both though.

This patchset doesn't change logic for existing chpis.

Ping-Ke Shih (6):
  wifi: rtw89: add to query RX descriptor format v2
  wifi: rtw89: add to fill TX descriptor for firmware command v2
  wifi: rtw89: add to fill TX descriptor v2
  wifi: rtw89: add chip_info::txwd_info size to generalize TX WD submit
  wifi: rtw89: consolidate registers of mac port to struct
  wifi: rtw89: add mac_gen pointer to access mac port registers

 drivers/net/wireless/realtek/rtw89/core.c     | 215 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  62 ++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  94 ++++--
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  27 ++
 drivers/net/wireless/realtek/rtw89/pci.c      |   3 +-
 drivers/net/wireless/realtek/rtw89/reg.h      | 147 ++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/txrx.h     | 271 ++++++++++++++++++
 12 files changed, 791 insertions(+), 33 deletions(-)

-- 
2.25.1

