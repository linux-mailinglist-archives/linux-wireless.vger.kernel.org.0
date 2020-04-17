Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D5C1AD7BF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgDQHrK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:10 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36983 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgDQHrI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l0Of9020020, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l0Of9020020
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:00 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:00 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:46:59 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 00/40] rtw88: add support for 802.11n RTL8723DE devices
Date:   Fri, 17 Apr 2020 15:46:13 +0800
Message-ID: <20200417074653.15591-1-yhchuang@realtek.com>
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

Although RTL8723DE devices are 802.11n devices, while rtw88
aimed to support for 802.11ac devices, the 8723DE devices's
architecture is relatively close to the 802.11ac devices.
So, add support for them on rtw88, with some minor modifications.

Basically their TRX paths are the same, except that 8723DE
does not have H2CQ for H2C commands and the corresponding
HIMR3/HISR3 for H2CQ. Another thing is that 8723DE uses a
different way to download firmware, so it cannot share with
8822BE/8822CE mac firmware download routine.

For easier to review, the 8723DE implementation is split into
multiple patches. One can review on it to see the difference
of the chip's functionalities.

With 8723DE joining rtw88, we found that the core kernel
module's size increases a lot. It's because the various tables
for each chip are built into the core module.  Note that the
tables usually come up to 10+ K lines. Imagine that a user
only uses 8822CE, but the tables of 8822BE will also be loaded
into the kernel, waste a lot of the memory.

Hence, extract the various tables for each chip into separate
modules corresponding to 8822B/8822C/8723D. That way, once one
of the device, for example 8822CE, is probed, only 8822C's
tables in rtw88_8822c.ko will be loaded and its pci part, it
can reduce the usage of kernel memory.

Finally, to make them look consistent and avoid confusion,
rename the core module and the pci module with prefix "rtw88_".


Ping-Ke Shih (33):
  rtw88: 8723d: Add basic chip capabilities
  rtw88: 8723d: add beamform wrapper functions
  rtw88: 8723d: Add power sequence
  rtw88: 8723d: Add RF read/write ops
  rtw88: 8723d: Add mac/bb/rf/agc/power_limit tables
  rtw88: 8723d: Add cfg_ldo25 to control LDO25
  rtw88: 8723d: Add new chip op efuse_grant() to control efuse access
  rtw88: 8723d: Add read_efuse to recognize efuse info from map
  rtw88: add legacy firmware download for 8723D devices
  rtw88: no need to send additional information to legacy firmware
  rtw88: 8723d: Add mac power-on/-off function
  rtw88: decompose while(1) loop of power sequence polling command
  rtw88: 8723d: 11N chips don't support H2C queue
  rtw88: 8723d: implement set_tx_power_index ops
  rtw88: 8723d: Organize chip TX/RX FIFO
  rtw88: 8723d: initialize mac/bb/rf basic functions
  rtw88: 8723d: Add DIG parameter
  rtw88: 8723d: Add query_rx_desc
  rtw88: 8723d: Add set_channel
  rtw88: handle C2H_CCX_TX_RPT to know if packet TX'ed successfully
  rtw88: 8723d: 11N chips don't support LDPC
  rtw88: 8723d: Add chip_ops::false_alarm_statistics
  rtw88: 8723d: Set IG register for CCK rate
  rtw88: 8723d: add interface configurations table
  rtw88: 8723d: Add LC calibration
  rtw88: 8723d: add IQ calibration
  rtw88: 8723d: Add power tracking
  rtw88: 8723d: Add shutdown callback to disable BT USB suspend
  rtw88: 8723d: implement flush queue
  rtw88: 8723d: set ltecoex register address in chip_info
  rtw88: 8723d: Add coex support
  rtw88: fill zeros to words 0x06 and 0x07 of security cam entry
  rtw88: 8723d: Add 8723DE to Kconfig and Makefile

Yan-Hsuan Chuang (1):
  rtw88: rename rtw88.ko/rtwpci.ko to rtw88_core.ko/rtw88_pci.ko

Zong-Zhe Yang (6):
  rtw88: extract: export symbols used in chip functionalities
  rtw88: extract: export symbols about pci interface
  rtw88: extract: make 8822c an individual kernel module
  rtw88: extract: make 8822b an individual kernel module
  rtw88: extract: make 8723d an individual kernel module
  rtw88: extract: remove the unused after extracting

 drivers/net/wireless/realtek/rtw88/Kconfig    |   26 +-
 drivers/net/wireless/realtek/rtw88/Makefile   |   28 +-
 drivers/net/wireless/realtek/rtw88/bf.c       |   14 +-
 drivers/net/wireless/realtek/rtw88/bf.h       |   22 +
 drivers/net/wireless/realtek/rtw88/coex.c     |    3 +
 drivers/net/wireless/realtek/rtw88/debug.c    |    9 +-
 drivers/net/wireless/realtek/rtw88/efuse.c    |    4 +
 drivers/net/wireless/realtek/rtw88/fw.c       |   34 +-
 drivers/net/wireless/realtek/rtw88/fw.h       |   32 +-
 drivers/net/wireless/realtek/rtw88/mac.c      |  435 ++-
 drivers/net/wireless/realtek/rtw88/mac.h      |    1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |    7 +-
 drivers/net/wireless/realtek/rtw88/main.c     |   55 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   80 +-
 drivers/net/wireless/realtek/rtw88/pci.c      |   84 +-
 drivers/net/wireless/realtek/rtw88/pci.h      |    4 -
 drivers/net/wireless/realtek/rtw88/phy.c      |   94 +-
 drivers/net/wireless/realtek/rtw88/phy.h      |    7 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  108 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 2765 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  245 ++
 .../wireless/realtek/rtw88/rtw8723d_table.c   | 1196 +++++++
 .../wireless/realtek/rtw88/rtw8723d_table.h   |   15 +
 .../net/wireless/realtek/rtw88/rtw8723de.c    |   30 +
 .../net/wireless/realtek/rtw88/rtw8723de.h    |   20 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   33 +-
 .../net/wireless/realtek/rtw88/rtw8822be.c    |   30 +
 .../net/wireless/realtek/rtw88/rtw8822be.h    |   20 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   31 +
 .../net/wireless/realtek/rtw88/rtw8822ce.c    |   30 +
 .../net/wireless/realtek/rtw88/rtw8822ce.h    |   20 +
 drivers/net/wireless/realtek/rtw88/rx.c       |    1 +
 drivers/net/wireless/realtek/rtw88/sec.c      |    6 +-
 drivers/net/wireless/realtek/rtw88/tx.c       |   11 +-
 drivers/net/wireless/realtek/rtw88/tx.h       |    2 +-
 drivers/net/wireless/realtek/rtw88/util.c     |   20 +-
 36 files changed, 5324 insertions(+), 198 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723de.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723de.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822be.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822be.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822ce.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822ce.h

-- 
2.17.1

