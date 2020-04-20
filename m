Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FD91B0130
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 07:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTFvQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 01:51:16 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42177 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgDTFvP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 01:51:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03K5p7T21000866, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03K5p7T21000866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Apr 2020 13:51:08 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Apr 2020 13:51:07 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Apr 2020 13:51:07 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/8] rtw88: 8723d: add basic chip functions
Date:   Mon, 20 Apr 2020 13:50:46 +0800
Message-ID: <20200420055054.14592-1-yhchuang@realtek.com>
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

Add basic chip functions for new 802.11n devices RTL8723DE.

RTL8723DE is an 802.11n device, while rtw88 aimed to support
802.11ac devices, the 8723DE devices' architecture is close to
them. The PCI TRX paths are mostly the same, except that the
8723DE does not have H2CQ for sending H2C commands. And it also
uses a different way to download firmware, but it's not a big
deal, as we can add a legacy firmware download routine for it.

So, we can easily get 8723DE supported by rtw88. For easier
to review them, the 8723DE implementation is split into multiple
patches. First add the basic chip functionalities for it.

To make a new type of chip work, the chip capabilities should
be filled correctly. And it will have its own parameter tables,
including MAC/PHY and power squence tables. Note that 8723DE
introduces a slightly different way to access to the RF regs.
Beamform is not supported as well, assign NULL to them, and
check the chip_ops before we use.


v1 -> v2
  * make a patchset contains less patches for review


Ping-Ke Shih (8):
  rtw88: 8723d: Add basic chip capabilities
  rtw88: 8723d: add beamform wrapper functions
  rtw88: 8723d: Add power sequence
  rtw88: 8723d: Add RF read/write ops
  rtw88: 8723d: Add mac/bb/rf/agc/power_limit tables
  rtw88: 8723d: Add cfg_ldo25 to control LDO25
  rtw88: 8723d: Add new chip op efuse_grant() to control efuse access
  rtw88: 8723d: Add read_efuse to recognize efuse info from map

 drivers/net/wireless/realtek/rtw88/bf.c       |    7 +-
 drivers/net/wireless/realtek/rtw88/bf.h       |   22 +
 drivers/net/wireless/realtek/rtw88/efuse.c    |    4 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |    7 +-
 drivers/net/wireless/realtek/rtw88/main.c     |   12 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   26 +
 drivers/net/wireless/realtek/rtw88/pci.c      |    3 +
 drivers/net/wireless/realtek/rtw88/phy.c      |   56 +-
 drivers/net/wireless/realtek/rtw88/phy.h      |    6 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   14 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  544 ++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |   47 +
 .../wireless/realtek/rtw88/rtw8723d_table.c   | 1196 +++++++++++++++++
 .../wireless/realtek/rtw88/rtw8723d_table.h   |   15 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |    2 +-
 15 files changed, 1943 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d_table.h

-- 
2.17.1

