Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CAC74378
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 04:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbfGYCyc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 22:54:32 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60787 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388122AbfGYCyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 22:54:32 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6P2sMRZ010367, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6P2sMRZ010367
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Jul 2019 10:54:22 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Thu, 25 Jul 2019 10:54:22 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>
Subject: [PATCH v2 0/5] rtw88: add support for BT co-existence mechanism
Date:   Thu, 25 Jul 2019 10:53:26 +0800
Message-ID: <1564023211-3138-1-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This patch set mainly adds a BT co-existence mechanism, which
helps WiFi device to work with BT device concurrently without
interfering each other. For Realtek's WiFi/BT combo devices,
the co-existence mechanism is on the WiFi side.

The first two patches "rtw88: switch specified efuse bank" and
"rtw88: check efuse for BT FT S1" aim to check if the device
is able to run with WiFi + BT, because some of the earlier
devices manufactured are in development for testing. These
device hence did not program the efuse for BT. Without being
programed, some of the hardware parameters are incorrect.

The rest of the patches add BTcoex support. BTcoex needs to
wake up events that is waiting for some C2H reported in IRQ
context, so these C2H skbs do not required to be queued into
workqueues to be processed. What we need to do is to simply
wake it uin IRQ context.

And actually C2H workqueue context should be protected by
rtwdev->mutex lock to perform some hardware operations
against mac80211 callbacks.

The final patch contains the most of the BTcoex logic.
It is not that complicated, just to gather information and
make decision on WiFi driver side. What makes the code so
much is that the mechanism needs to take care of a lot of
WiFi/BT combinations. Such as if WiFi is at 2G or is having
a lot of traffic or is connecting to AP. And BT has many
profiles such as A2DP/HID/PAN or it is slave or not.


v1 -> v2

    rebase onto the latest wireless-drivers-next
    the conflicts is in pci.c with patch
    "rtw88: pci: Rearrange the memory usage for skb in RX ISR"



Yan-Hsuan Chuang (5):
  rtw88: switch specified efuse bank
  rtw88: check efuse for BT FT S1
  rtw88: allow c2h operation in irq context
  rtw88: enclose c2h cmd handle with mutex
  rtw88: add BT co-existence support

 drivers/net/wireless/realtek/rtw88/Makefile   |    1 +
 drivers/net/wireless/realtek/rtw88/coex.c     | 2462 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/coex.h     |  363 ++++
 drivers/net/wireless/realtek/rtw88/efuse.c    |   30 +-
 drivers/net/wireless/realtek/rtw88/fw.c       |  135 +-
 drivers/net/wireless/realtek/rtw88/fw.h       |   73 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |   19 +
 drivers/net/wireless/realtek/rtw88/main.c     |   45 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  233 +++
 drivers/net/wireless/realtek/rtw88/pci.c      |    6 +-
 drivers/net/wireless/realtek/rtw88/ps.c       |    9 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   62 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  460 ++++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  355 +++-
 14 files changed, 4216 insertions(+), 37 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/coex.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/coex.h

-- 
2.7.4

