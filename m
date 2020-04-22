Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003D51B35B8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 05:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgDVDqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 23:46:18 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36999 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgDVDqS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 23:46:18 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03M3kAzB5004569, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03M3kAzB5004569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Apr 2020 11:46:10 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:10 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:09 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v2 0/8] rtw88: 8723d: add power on functions
Date:   Wed, 22 Apr 2020 11:45:59 +0800
Message-ID: <20200422034607.28747-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Add power on related functions for 8723D, whuch should switch
mac power, download firmware, and initialize mac/bb/rf.

The 8723D devices don't have H2C queue, so we should skip them,
by recognize that the device is for 802.11n. Because the other
802.11ac devices have H2C queue to send command to firmware.

The 8723D devices use a different way to download firmware, so
add a legacy firmware download routine.

While the 8723D devices don't have H2C queue, and also the TRX
FIFO is smaller, we cannot organize the TRX FIFO as the other
802.11ac devices (8723D has less queues can be mapped).


v1 -> v2
  * make a patchset contains less patches for review


Ping-Ke Shih (8):
  rtw88: add legacy firmware download for 8723D devices
  rtw88: no need to send additional information to legacy firmware
  rtw88: 8723d: Add mac power-on/-off function
  rtw88: decompose while(1) loop of power sequence polling command
  rtw88: 8723d: 11N chips don't support H2C queue
  rtw88: 8723d: implement set_tx_power_index ops
  rtw88: 8723d: Organize chip TX/RX FIFO
  rtw88: 8723d: initialize mac/bb/rf basic functions

 drivers/net/wireless/realtek/rtw88/fw.c       |  27 +-
 drivers/net/wireless/realtek/rtw88/fw.h       |  25 ++
 drivers/net/wireless/realtek/rtw88/mac.c      | 402 ++++++++++++++----
 drivers/net/wireless/realtek/rtw88/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw88/main.c     |  41 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  17 +
 drivers/net/wireless/realtek/rtw88/pci.c      |  35 +-
 drivers/net/wireless/realtek/rtw88/reg.h      |  83 ++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 217 ++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |   3 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   1 +
 12 files changed, 751 insertions(+), 102 deletions(-)

-- 
2.17.1

