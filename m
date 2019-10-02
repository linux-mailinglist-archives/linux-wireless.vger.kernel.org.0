Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D872C45E9
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 04:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfJBCbk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 22:31:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45997 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbfJBCbj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 22:31:39 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x922VUK6031823, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x922VUK6031823
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 10:31:31 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 10:31:30 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 00/12] rtw88: Add support for deep PS mode
Date:   Wed, 2 Oct 2019 10:31:16 +0800
Message-ID: <20191002023128.12090-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

RTL8822B/RTL8822C series devices are capable of entering deep PS
mode. In contrast to Leisure Power Save (LPS) which turns off RF
components periodically between beacons, deep PS mode turns off
more hardware circuits. But device should enter LPS before enter
deep PS mode, otherwise the state of the firmware is undefined.

Under deep PS mode, driver can not read/write registers, and also
the TX path is reuiqred to be idle. To make sure it, driver should
acquired rtwdev->mutex lock, and then leave deep PS mode before
operating on the hardware, otherwise the behavior of the device
is unexpected and undefined.

To add deep PS mode, some modifications for the driver are needed.

For PCI part, drivers need to keep tracking on the SKBs delivered
to the device and see if there will have any activity on the TX
path. For the others, driver should make sure to acquire lock and
leave deep PS mode.

Also remove a misleading module parameter named "rtw_fw_support_lps".
It is not representing property of the firmware, but to let driver
decide if it wants to use LPS mode. But IEEE80211_CONF_PS can
handle it, by setting power save [on/off] through user space.
So just remove it, and listen to IEEE80211_CONF_CHANGE_PS.


v1 -> v2
  - rebase on top of wireless-drivers-next

Yan-Hsuan Chuang (12):
  rtw88: remove redundant flag check helper function
  rtw88: pci: reset H2C queue indexes in a single write
  rtw88: not to enter or leave PS under IRQ
  rtw88: not to control LPS by each vif
  rtw88: remove unused lps state check helper
  rtw88: LPS enter/leave should be protected by lock
  rtw88: leave PS state for dynamic mechanism
  rtw88: add deep power save support
  rtw88: not to enter LPS by coex strategy
  rtw88: select deep PS mode when module is inserted
  rtw88: add deep PS PG mode for 8822c
  rtw88: remove misleading module parameter rtw_fw_support_lps

 drivers/net/wireless/realtek/rtw88/coex.c     |  14 +-
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/fw.c       |  77 +++++++++
 drivers/net/wireless/realtek/rtw88/fw.h       |  29 ++++
 drivers/net/wireless/realtek/rtw88/hci.h      |   6 +
 drivers/net/wireless/realtek/rtw88/mac.c      |   2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  43 ++++-
 drivers/net/wireless/realtek/rtw88/main.c     |  84 +++++----
 drivers/net/wireless/realtek/rtw88/main.h     |  32 ++--
 drivers/net/wireless/realtek/rtw88/pci.c      |  77 ++++++++-
 drivers/net/wireless/realtek/rtw88/phy.c      |   2 +-
 drivers/net/wireless/realtek/rtw88/ps.c       | 162 ++++++++++++------
 drivers/net/wireless/realtek/rtw88/ps.h       |  14 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   1 +
 drivers/net/wireless/realtek/rtw88/rx.c       |   2 -
 drivers/net/wireless/realtek/rtw88/sec.c      |  21 +++
 drivers/net/wireless/realtek/rtw88/sec.h      |   1 +
 drivers/net/wireless/realtek/rtw88/tx.c       |   2 -
 19 files changed, 429 insertions(+), 142 deletions(-)

-- 
2.17.1

