Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF901D4529
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2020 07:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgEOFXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 May 2020 01:23:51 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55384 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOFXu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 May 2020 01:23:50 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04F5NURC0016800, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04F5NURC0016800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 May 2020 13:23:30 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 15 May 2020 13:23:30 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 15 May 2020 13:23:29 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <kevin_yang@realtek.com>, <briannorris@chromium.org>,
        <bigeasy@linutronix.de>
Subject: [PATCH v4 0/7] rtw88: extract chip tables from core module
Date:   Fri, 15 May 2020 13:23:20 +0800
Message-ID: <20200515052327.31874-1-yhchuang@realtek.com>
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

The PCI series devices RTL8822BE/RTL8822CE/RTL8723DE used to load
two kernel modules rtw88.ko/rtwpci.ko into the kernel. The rtw88.ko
is acting as the core module contains the common/core part of the
driver, including each chip's parameter tables and funcations. But
each chip's parameter tables take too much size of the memory, like
several 10K lines for each device. And when one of the the chip is
running, the other chip's table is a burden.

So, extract tables of different chips into another kernel module,
such as rtw88_8822b.ko/rtw88_8822c.ko/rtw88_8723d.ko. These chip
modules have those tables for each chip, so we can avoid loading
the huge tables of RTL8822BE when running RTL8822CE only. To make
the device probed choose the correct kernel module, add kernel
modules such as rtw88_8822be.ko/rtw88_8822ce.ko/rtw88_8723de.ko as
entry point. These module will be responsible to select the correct
corresponding modules they require. For example, if RTL8822CE device
is probed by rtw88_8822ce.ko, it will then select the common part
module rtw88_8822c.ko, and because RTL8822CE uses PCI bus as its
interface, it will then choose rtw88_pci.ko, finally, they both
depend on the core module rtw88_core.ko, it's loaded at the end.

The entry point may look redundant now, but the driver is going to
support USB devices, so the entry modules can help to select the
expected part of the interface module.

By extracting the tables, it can save a lot of memory usage to
not to load the unused tables, and the tables are so big.

Finally, the core module and pci module are named as rtw88.ko and
rtwpci.ko. To make them look consistent and to avoid confusion,
rename them to rtw88_core.ko and rtw88_pci.ko with proper prefix
"rtw88_" to easy distinguish them as modules of the rtw88 driver.


v1 -> v2
  * split patches for easier review

v2 -> v3
  * rebase on top of tree

v3 -> v4
  * fix compile issue for modpost by EXPORT_SYMBOL()


Yan-Hsuan Chuang (1):
  rtw88: rename rtw88.ko/rtwpci.ko to rtw88_core.ko/rtw88_pci.ko

Zong-Zhe Yang (6):
  rtw88: extract: export symbols used in chip functionalities
  rtw88: extract: export symbols about pci interface
  rtw88: extract: make 8822c an individual kernel module
  rtw88: extract: make 8822b an individual kernel module
  rtw88: extract: make 8723d an individual kernel module
  rtw88: extract: remove the unused after extracting

 drivers/net/wireless/realtek/rtw88/Kconfig    | 18 +++++++--
 drivers/net/wireless/realtek/rtw88/Makefile   | 29 ++++++++++----
 drivers/net/wireless/realtek/rtw88/bf.c       |  7 ++++
 drivers/net/wireless/realtek/rtw88/coex.c     |  3 ++
 drivers/net/wireless/realtek/rtw88/efuse.c    |  1 +
 drivers/net/wireless/realtek/rtw88/fw.c       |  1 +
 drivers/net/wireless/realtek/rtw88/mac.c      |  1 +
 drivers/net/wireless/realtek/rtw88/main.h     |  3 --
 drivers/net/wireless/realtek/rtw88/pci.c      | 38 +++++--------------
 drivers/net/wireless/realtek/rtw88/pci.h      |  4 --
 drivers/net/wireless/realtek/rtw88/phy.c      | 26 +++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  5 +++
 .../net/wireless/realtek/rtw88/rtw8723de.c    | 30 +++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8723de.h    | 14 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  5 +++
 .../net/wireless/realtek/rtw88/rtw8822be.c    | 30 +++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8822be.h    | 14 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  5 +++
 .../net/wireless/realtek/rtw88/rtw8822ce.c    | 30 +++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8822ce.h    | 14 +++++++
 drivers/net/wireless/realtek/rtw88/rx.c       |  1 +
 drivers/net/wireless/realtek/rtw88/util.c     |  2 +
 22 files changed, 235 insertions(+), 46 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723de.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723de.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822be.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822be.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822ce.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822ce.h

-- 
2.17.1

