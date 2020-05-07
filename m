Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6F1C80CD
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 06:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgEGEWU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 00:22:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34093 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgEGEWR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 00:22:17 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0474LubC6027269, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0474LubC6027269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 May 2020 12:21:56 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:21:56 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:21:56 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v2 0/9] rtw88: 8723d: Add RF calibration and coex
Date:   Thu, 7 May 2020 12:21:42 +0800
Message-ID: <20200507042151.15634-1-yhchuang@realtek.com>
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

This patch set is the last set for RTL8723D, it adds RF calibration
routines and BT-coex mechanism. The RFK includes IQK/LCK/PowerTrack.

Unlike other 802.11ac devices, RTL8723D is not supporting doing IQK
in firmware, which is called SW IQK. Hence more code is put in driver.
LCK is easier, just trigger the hardware circuit, and wait until it's
done by register polling.

For coex mechanisms, the driver's coex.c has implemented most of the
routines, what 8723D should add is the chip dependent settings.

For BT USB suspend, disable it when PCI shutdown. If not, the USB
part cannot be enumarated, and the card cannot be initialised.

Finally, it should be the last patch set for 8723D, so add it in
Makefile and Kconfig. The firmware has already been applied by
linux-firmware [1], one can found it in:
	
	linux-firmware/rtw88/rtw8723d_fw.bin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git


v1 -> v2
  * split the patches for review
  * move some macro to header file
  * include coex debug info in coex support
  * use read_poll_timeout for LCK
  * rename 'result' to 'status' to avoid confusion in IQK
  * drop unnecessary (u8) cast


Ping-Ke Shih (9):
  rtw88: 8723d: Add LC calibration
  rtw88: 8723d: add IQ calibration
  rtw88: 8723d: Add power tracking
  rtw88: 8723d: Add shutdown callback to disable BT USB suspend
  rtw88: 8723d: implement flush queue
  rtw88: 8723d: set ltecoex register address in chip_info
  rtw88: 8723d: Add coex support
  rtw88: fill zeros to words 0x06 and 0x07 of security cam entry
  rtw88: 8723d: Add 8723DE to Kconfig and Makefile

 drivers/net/wireless/realtek/rtw88/Kconfig    |   10 +
 drivers/net/wireless/realtek/rtw88/Makefile   |    1 +
 drivers/net/wireless/realtek/rtw88/debug.c    |    9 +-
 drivers/net/wireless/realtek/rtw88/mac.c      |   29 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   36 +
 drivers/net/wireless/realtek/rtw88/pci.c      |   17 +
 drivers/net/wireless/realtek/rtw88/phy.c      |    8 +-
 drivers/net/wireless/realtek/rtw88/phy.h      |    1 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   11 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1605 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  138 ++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   24 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   24 +
 drivers/net/wireless/realtek/rtw88/sec.c      |    6 +-
 drivers/net/wireless/realtek/rtw88/util.c     |   18 +-
 15 files changed, 1907 insertions(+), 30 deletions(-)

-- 
2.17.1

