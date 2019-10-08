Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E04EBCF4E2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfJHIVM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:21:12 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47339 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbfJHIVM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:21:12 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x988L42H028120, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x988L42H028120
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 8 Oct 2019 16:21:04 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 8 Oct 2019 16:21:03 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 00/10] rtw88: minor throughput improvement
Date:   Tue, 8 Oct 2019 16:20:51 +0800
Message-ID: <20191008082101.2494-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This patchset mainly adds support for beamforming and power
tracking. Power tracking can monitor the thermal value of
the device and adjust corresponding power indexes, to make
sure the RF output power is expected.

And another thing is to add a debugfs for physical layer
information. This is useful when sometimes the environment
is too harsh for the device, and provides the activities
for us to debug.

The rest patches are some minor fixes.


Ping-Ke Shih (1):
  rtw88: coex: Set 4 slot mode for A2DP

Tsang-Shian Lin (1):
  rtw88: add phy_info debugfs to show Tx/Rx physical status

Tzu-En Huang (6):
  rtw88: add power tracking support
  rtw88: Enable 802.11ac beamformee support
  rtw88: config 8822c multicast address in MAC init flow
  rtw88: add set_bitrate_mask support
  rtw88: update regulatory settings implementaion
  rtw88: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support

Yan-Hsuan Chuang (2):
  rtw88: Use rtw_write8_set to set SYS_FUNC
  rtw88: pci: config phy after chip info is setup

 drivers/net/wireless/realtek/rtw88/Makefile   |   1 +
 drivers/net/wireless/realtek/rtw88/bf.c       | 408 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/bf.h       |  92 ++++
 drivers/net/wireless/realtek/rtw88/coex.c     |  24 +-
 drivers/net/wireless/realtek/rtw88/debug.c    | 174 +++++++-
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/fw.c       |   1 +
 drivers/net/wireless/realtek/rtw88/mac.c      |   2 +-
 drivers/net/wireless/realtek/rtw88/mac.h      |   5 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |  65 +++
 drivers/net/wireless/realtek/rtw88/main.c     | 159 ++++++-
 drivers/net/wireless/realtek/rtw88/main.h     | 155 ++++++-
 drivers/net/wireless/realtek/rtw88/pci.c      |   4 +-
 drivers/net/wireless/realtek/rtw88/phy.c      | 118 +++++
 drivers/net/wireless/realtek/rtw88/phy.h      |  12 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   2 +
 drivers/net/wireless/realtek/rtw88/regd.c     |  61 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 413 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |  12 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 341 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  12 +
 drivers/net/wireless/realtek/rtw88/rx.c       |  69 ++-
 22 files changed, 2056 insertions(+), 75 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/bf.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/bf.h

-- 
2.17.1

