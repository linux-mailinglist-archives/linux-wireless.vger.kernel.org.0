Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D671A2234EA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 08:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGQGuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 02:50:10 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55020 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgGQGuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:05 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06H6nxMtB028960, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06H6nxMtB028960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jul 2020 14:49:59 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:49:59 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:49:59 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/7] rtw88: regular update and fixes
Date:   Fri, 17 Jul 2020 14:49:30 +0800
Message-ID: <20200717064937.27966-1-yhchuang@realtek.com>
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

This patchset adds some regular updates and fixes for the driver.

For the RA info and SGI fix, we found a little throughput
degradation under some situations. Fix it.

For the TX descriptor update, the driver asks the hardware to
update the sequence for some of the frames, such as management
frames, or the frames that are downloaded to the hardware.

The coex and the beacon enable/disable update are most for the
AP mode, the coex update can prevent sometimes the AP is not
able to transmit frames. The other can let the AP to disable
or enable the beacon.


Tsang-Shian Lin (2):
  rtw88: fix LDPC field for RA info
  rtw88: fix short GI capability based on current bandwidth

Tzu-En Huang (2):
  rtw88: update tx descriptor of mgmt and reserved page packets
  rtw88: add h2c command in debugfs

Yan-Hsuan Chuang (3):
  rtw88: coex: only skip coex triggered by BT info
  rtw88: add ieee80211_ops::change_interface
  rtw88: allows driver to enable/disable beacon

 drivers/net/wireless/realtek/rtw88/coex.c     |   3 +-
 drivers/net/wireless/realtek/rtw88/debug.c    |  30 +++++
 drivers/net/wireless/realtek/rtw88/fw.c       |  17 ++-
 drivers/net/wireless/realtek/rtw88/fw.h       |   2 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |  27 +++++
 drivers/net/wireless/realtek/rtw88/main.c     |  11 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   2 +
 drivers/net/wireless/realtek/rtw88/tx.c       | 104 ++++++++++++------
 drivers/net/wireless/realtek/rtw88/tx.h       |  13 ++-
 9 files changed, 163 insertions(+), 46 deletions(-)

-- 
2.17.1

