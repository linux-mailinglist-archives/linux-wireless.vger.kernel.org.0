Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28107331B0
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 14:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345485AbjFPM4c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjFPM4c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 08:56:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1D830F7
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 05:56:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35GCtuvS7024330, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35GCtuvS7024330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Jun 2023 20:55:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 16 Jun 2023 20:56:15 +0800
Received: from [127.0.1.1] (172.16.16.227) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Jun
 2023 20:56:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/6] wifi: rtw88: correct AP and PS mode behaviors
Date:   Fri, 16 Jun 2023 20:55:34 +0800
Message-ID: <20230616125540.36877-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In AP mode, HI queue is used to transmit broadcast/multicast right after
issuing beacon, and we need set MORE_DATA in TX description to make
hardware transmits all packets in one go. Also, have special deal with
this queue when doing scan and flush.

After stopping AP from SCC (AP + STA), only one STA is working, so PS mode
is expected to enable. However, firmware checks the MAC port used by AP
mode before, and then can't enter PS mode. We add the last patch to set
"default port" to the port used by STA. Then, firmware will check correct
port to enter PS mode in expectation.

Note: The patch 5/6 ("wifi: rtw88: refine register based H2C command")
adds new static function that is used by patch 6/6, so compiler will
warn unused function if we build this path.

v2:
  - fix patch 1/6 problems
    * correct to use RTW_TX_DESC_W7_DMA_TXAGG_NUM to set agg_num
    * use correct le32p_replace_bits() to set value instead

Po-Hao Huang (6):
  wifi: rtw88: use struct instead of macros to set TX desc
  wifi: rtw88: Fix AP mode incorrect DTIM behavior
  wifi: rtw88: Skip high queue in hci_flush
  wifi: rtw88: Stop high queue during scan
  wifi: rtw88: refine register based H2C command
  wifi: rtw88: fix not entering PS mode after AP stops

 drivers/net/wireless/realtek/rtw88/fw.c       |  68 ++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h       |  13 ++
 drivers/net/wireless/realtek/rtw88/mac80211.c |   3 +
 drivers/net/wireless/realtek/rtw88/main.c     |  15 ++-
 drivers/net/wireless/realtek/rtw88/main.h     |   1 +
 drivers/net/wireless/realtek/rtw88/pci.c      |   5 +-
 drivers/net/wireless/realtek/rtw88/reg.h      |   2 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   6 +-
 drivers/net/wireless/realtek/rtw88/tx.c       |  84 +++++++-----
 drivers/net/wireless/realtek/rtw88/tx.h       | 123 ++++++++----------
 drivers/net/wireless/realtek/rtw88/usb.c      |  15 ++-
 11 files changed, 218 insertions(+), 117 deletions(-)

-- 
2.25.1

