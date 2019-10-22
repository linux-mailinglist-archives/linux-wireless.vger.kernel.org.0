Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1831EE0182
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 12:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfJVKEa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 06:04:30 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37555 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJVKE3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 06:04:29 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9MA4MTH017628, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9MA4MTH017628
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 22 Oct 2019 18:04:22 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 22 Oct 2019 18:04:21 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v3 0/5] rtw88: minor throughput improvement
Date:   Tue, 22 Oct 2019 18:04:15 +0800
Message-ID: <20191022100420.25116-1-yhchuang@realtek.com>
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


v1 -> v2
  * Do not use cast on "const" pointers
  * Add macros for checking current band, also used in power tracking
  * Some refinement for power tracking
  * Remove regulatory's module parameter for user's hint, and enable
    it by choosing the Kconfig
  * Add some description for beamforming module parameter

v2 -> v3
  * more refinement for magic numbers
  * split patch set, remove regulatory patch, for further discussion


Tsang-Shian Lin (1):
  rtw88: add phy_info debugfs to show Tx/Rx physical status

Tzu-En Huang (3):
  rtw88: add power tracking support
  rtw88: Enable 802.11ac beamformee support
  rtw88: add set_bitrate_mask support

Yan-Hsuan Chuang (1):
  rtw88: use macro to check the current band

 drivers/net/wireless/realtek/rtw88/Makefile   |   1 +
 drivers/net/wireless/realtek/rtw88/bf.c       | 400 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/bf.h       |  92 ++++
 drivers/net/wireless/realtek/rtw88/debug.c    | 174 ++++++-
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/fw.c       |   1 +
 drivers/net/wireless/realtek/rtw88/mac.c      |   2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  64 +++
 drivers/net/wireless/realtek/rtw88/main.c     | 153 +++++-
 drivers/net/wireless/realtek/rtw88/main.h     | 166 ++++++-
 drivers/net/wireless/realtek/rtw88/phy.c      | 137 +++++-
 drivers/net/wireless/realtek/rtw88/phy.h      |  12 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 461 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |  12 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 351 ++++++++++++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  12 +
 drivers/net/wireless/realtek/rtw88/rx.c       |  69 ++-
 18 files changed, 2027 insertions(+), 82 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/bf.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/bf.h

-- 
2.17.1

