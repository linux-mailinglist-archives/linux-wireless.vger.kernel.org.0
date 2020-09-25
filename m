Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF46278070
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 08:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgIYGTa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 02:19:30 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39821 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgIYGTa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 02:19:30 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08P6CMOb8010468, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08P6CMOb8010468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 14:12:22 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 25 Sep 2020 14:12:22 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <yhchuang@realtek.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] rtw88: add firmware crash recovery and some fixes
Date:   Fri, 25 Sep 2020 14:12:14 +0800
Message-ID: <20200925061219.23754-1-tehuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.222]
X-ClientProxiedBy: RTEXMB05.realtek.com.tw (172.21.6.98) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

When firmware crashes, it inturrupts the driver, then driver will
save its association state, restart the chip and call
ieee80211_restart_hw().

The size of the rx buffer and the declared VHT capability are unmatch,
which may lead to rx buffer overflow.

Add regulatory information in the tramit power table.

Tzu-En Huang (5):
  rtw88: increse the size of rx buffer size
  rtw88: handle and recover when firmware crash
  rtw88: add dump firmware fifo support
  rtw88: add dump fw crash log
  rtw88: show current regulatory in tx power table

 drivers/net/wireless/realtek/rtw88/debug.c    |  26 ++-
 drivers/net/wireless/realtek/rtw88/fw.c       |  86 ++++++--
 drivers/net/wireless/realtek/rtw88/fw.h       |  18 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  81 ++------
 drivers/net/wireless/realtek/rtw88/main.c     | 193 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  32 +++
 drivers/net/wireless/realtek/rtw88/pci.c      |   3 +
 drivers/net/wireless/realtek/rtw88/pci.h      |   4 +-
 drivers/net/wireless/realtek/rtw88/reg.h      |   5 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   3 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   3 +
 drivers/net/wireless/realtek/rtw88/util.h     |   2 +
 12 files changed, 372 insertions(+), 84 deletions(-)

-- 
2.17.1

