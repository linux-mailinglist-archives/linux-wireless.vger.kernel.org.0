Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6373E10C88E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 13:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfK1MTW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 07:19:22 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59536 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfK1MTV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 07:19:21 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xASCJC7h004439, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xASCJC7h004439
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Nov 2019 20:19:12 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 28 Nov 2019 20:19:11 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 0/6] rtw88: add wowlan support for 8822c
Date:   Thu, 28 Nov 2019 20:19:01 +0800
Message-ID: <20191128121907.6178-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Add wake on wireless LAN support for 8822c. When system enters
suspend, wifi driver can enable wowlan mode, and waits for
waking host up by receiving wireless LAN events. Events could
be AP lost, deauthed, magic packets, rekey, or patterns. Also
most of the functions can be shutdown to reduce power consumption.

To enter wowlan mode, Realtek's devices need to swap to another
firmware called wowlan firmware. It can monitor special events
and generate wake up signals if necessary. To swap the firmware,
driver needs to re-configure the HCI link, to make sure that
the link is idle, reset the link for sending H2C commands to
wowlan firmware, and then stop the link.

After wake up signals generated and sent to host, driver needs
to swap back to normal firmware to get to the original state
before suspend. So it should setup the link again and send
H2C commands to firmware to restore the information.

Chin-Yen Lee (6):
  rtw88: pci: reset ring index when release skbs in tx ring
  rtw88: pci: reset dma when reset pci trx ring
  rtw88: load wowlan firmware if wowlan is supported
  rtw88: support wowlan feature for 8822c
  rtw88: Add wowlan pattern match support
  rtw88: add wowlan net-detect support

 drivers/net/wireless/realtek/rtw88/Makefile   |   1 +
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/fw.c       | 384 +++++++-
 drivers/net/wireless/realtek/rtw88/fw.h       | 186 ++++
 drivers/net/wireless/realtek/rtw88/mac80211.c |  44 +
 drivers/net/wireless/realtek/rtw88/main.c     |  76 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  67 ++
 drivers/net/wireless/realtek/rtw88/pci.c      |  36 +-
 drivers/net/wireless/realtek/rtw88/reg.h      |  27 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  18 +
 drivers/net/wireless/realtek/rtw88/util.h     |   2 +
 drivers/net/wireless/realtek/rtw88/wow.c      | 890 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/wow.h      |  58 ++
 13 files changed, 1759 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/wow.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/wow.h

-- 
2.17.1

