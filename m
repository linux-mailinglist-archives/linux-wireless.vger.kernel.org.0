Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83041FAC1E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 11:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgFPJQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 05:16:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46538 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPJQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 05:16:49 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05G9GWV30021723, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05G9GWV30021723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 17:16:32 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 17:16:32 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 17:16:31 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v4 0/7] rtw88: 8821c: add basic function routines
Date:   Tue, 16 Jun 2020 17:16:18 +0800
Message-ID: <20200616091625.26489-1-yhchuang@realtek.com>
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

v2 -> v3
  * fix some wordings
  * give register definition possible

v3 -> v4
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
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1089 +++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  229 +
 .../wireless/realtek/rtw88/rtw8821c_table.c   | 6611 +++++++++++++++++
 .../wireless/realtek/rtw88/rtw8821c_table.h   |   15 +
 .../net/wireless/realtek/rtw88/rtw8821ce.c    |   30 +
 .../net/wireless/realtek/rtw88/rtw8821ce.h    |   14 +
 9 files changed, 8002 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821c.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821c.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821c_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821c_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821ce.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821ce.h

-- 
2.17.1

