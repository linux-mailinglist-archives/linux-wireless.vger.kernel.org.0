Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B60125D18
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 09:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLSI6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 03:58:41 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59555 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSI6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 03:58:41 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBJ8wV5T024844, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBJ8wV5T024844
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 19 Dec 2019 16:58:31 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 19 Dec 2019 16:58:30 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <chiu@endlessm.com>
Subject: [PATCH v4 0/7] rtw88: add wowlan support for 8822c
Date:   Thu, 19 Dec 2019 16:58:09 +0800
Message-ID: <20191219085816.20709-1-yhchuang@realtek.com>
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


v1 -> v2
 * remove duplicated rtw_pci_dma_reset()

v2 -> v3
 * include new patch "rtw88: add interface config for 8822c"

v3 -> v4
 * mark some functions static
 * remove some unnecessary double-underscores


Chin-Yen Lee (6):
  rtw88: pci: reset ring index when release skbs in tx ring
  rtw88: pci: reset dma when reset pci trx ring
  rtw88: load wowlan firmware if wowlan is supported
  rtw88: support wowlan feature for 8822c
  rtw88: Add wowlan pattern match support
  rtw88: Add wowlan net-detect support

Yan-Hsuan Chuang (1):
  rtw88: add interface config for 8822c

 drivers/net/wireless/realtek/rtw88/Makefile   |   1 +
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/fw.c       | 384 +++++++-
 drivers/net/wireless/realtek/rtw88/fw.h       | 186 ++++
 drivers/net/wireless/realtek/rtw88/hci.h      |   6 +
 drivers/net/wireless/realtek/rtw88/mac.c      |   2 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |  44 +
 drivers/net/wireless/realtek/rtw88/main.c     |  76 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  67 ++
 drivers/net/wireless/realtek/rtw88/pci.c      |  55 +-
 drivers/net/wireless/realtek/rtw88/reg.h      |  29 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  18 +
 drivers/net/wireless/realtek/rtw88/util.h     |   2 +
 drivers/net/wireless/realtek/rtw88/wow.c      | 890 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/wow.h      |  58 ++
 15 files changed, 1786 insertions(+), 33 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/wow.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/wow.h

-- 
2.17.1

