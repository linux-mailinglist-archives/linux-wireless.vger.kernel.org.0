Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0843B1E5A89
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 10:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgE1IPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 04:15:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54755 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgE1IPa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 04:15:30 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04S8FLNi8027376, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04S8FLNi8027376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 May 2020 16:15:21 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 May 2020 16:15:21 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 May 2020 16:15:21 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>
Subject: [PATCH v2 0/7] rtw88: 8821c: add basic function routines
Date:   Thu, 28 May 2020 16:15:06 +0800
Message-ID: <20200528081513.26415-1-yhchuang@realtek.com>
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

RTL8821CE chipsets are 802.11ac 1x1 WiFi+BT combo devices.
This series is going to add support for them in rtw88 driver.
The basic functions include power on/off routines and the chip
specific informations.

Also add routines for setting TX power, channel, RX parsing and
PHY components calibration.

The firmware of RTL8821C series can be found at linux-firmware[1].
It's put at linux-firmware/rtw88/rtw8821c_fw.bin

[1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git


v1 -> v2
  * rebase on top of tree


Tzu-En Huang (7):
  rtw88: 8821c: add basic functions
  rtw88: 8821c: add set tx power index
  rtw88: 8821c: add dig related settings
  rtw88: 8821c: add set channel support
  rtw88: 8821c: add query rx desc support
  rtw88: 8821c: add false alarm statistics
  rtw88: 8821c: add phy calibration

 drivers/net/wireless/realtek/rtw88/main.c     |    4 +
 drivers/net/wireless/realtek/rtw88/main.h     |    6 +
 drivers/net/wireless/realtek/rtw88/reg.h      |    4 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1081 +++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  226 +
 .../wireless/realtek/rtw88/rtw8821c_table.c   | 6611 +++++++++++++++++
 .../wireless/realtek/rtw88/rtw8821c_table.h   |   15 +
 .../net/wireless/realtek/rtw88/rtw8821ce.c    |   30 +
 .../net/wireless/realtek/rtw88/rtw8821ce.h    |   14 +
 9 files changed, 7991 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821c.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821c.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821c_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821c_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821ce.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821ce.h

-- 
2.17.1

