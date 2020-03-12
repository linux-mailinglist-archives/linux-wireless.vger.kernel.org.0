Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8143D182A8E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 09:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCLIJB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 04:09:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59244 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgCLIJB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 04:09:01 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02C88sXc006396, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02C88sXc006396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 16:08:54 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:54 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 0/5] rtw88: TX path update for latency and efficiency
Date:   Thu, 12 Mar 2020 16:08:47 +0800
Message-ID: <20200312080852.16684-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This patchset makes the driver transmit with less CPU latency and
higher efficiency. Originally, the TX path hold an IRQ lock that
will disable all of the IRQs, to wait for the PS state transition.
It may sometimes cause the CPU to delay for a long enough time,
like several milliseconds. This could lead to some time-sensitive
programs to lose their immediacy. We can just use *_bh() locks to
not to block the IRQs, and only use *_irqsafe() locks to the ISR
related settings.

And, the TX path includes to send reserved pages to the device.
But the old reserved page routine did not consider that the driver
could possibly run multiple vifs at the same time. So, update the
reserved page routine of the TX path to generate reserved pages
and associate them to each vif, so we can take multi-vif into
consideration.

For the data packets come from TX queue, the driver used to kick
off them one by one, while we can do better to kick a bunch of
them at once to save some time to access to the IO register and
the DMA engine transition


Brian Norris (1):
  rtw88: don't hold all IRQs disabled for PS operations

Yan-Hsuan Chuang (4):
  rtw88: extract alloc rsvd_page and h2c skb routines
  rtw88: associate reserved pages with each vif
  rtw88: pci: define a mask for TX/RX BD indexes
  rtw88: kick off TX packets once for higher efficiency

 drivers/net/wireless/realtek/rtw88/fw.c       | 265 ++++++++++++++----
 drivers/net/wireless/realtek/rtw88/fw.h       |  25 +-
 drivers/net/wireless/realtek/rtw88/hci.h      |  20 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  22 +-
 drivers/net/wireless/realtek/rtw88/main.c     |   9 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   1 +
 drivers/net/wireless/realtek/rtw88/pci.c      | 199 ++++++++-----
 drivers/net/wireless/realtek/rtw88/pci.h      |   7 +-
 drivers/net/wireless/realtek/rtw88/tx.c       | 131 +++++++--
 drivers/net/wireless/realtek/rtw88/tx.h       |  10 +-
 drivers/net/wireless/realtek/rtw88/wow.c      |  39 +--
 11 files changed, 516 insertions(+), 212 deletions(-)

-- 
2.17.1

