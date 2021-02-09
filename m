Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5322731493F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 08:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBIHKF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 02:10:05 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:35023 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhBIHKE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 02:10:04 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 11979FN40006388, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 11979FN40006388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Feb 2021 15:09:15 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Feb 2021
 15:09:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v5 0/8] rtw88: improve TX performance in field
Date:   Tue, 9 Feb 2021 15:07:47 +0800
Message-ID: <20210209070755.23019-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Improve TX performance in aspects of protocol and software design. Also,
update PHY parameters to fix incorrect RSSI report.

v2: Since 5/5 of v1 is too large, I split it into three patches.
v3: Since 6/7 of v2 is still too large for patchwork, I split parameter
    into four patches.
v4: tx work use work queue instead of bare kthread
v5: (only patch 3/8 is changed)
    - Ensure RX rings aren't changed by NAPI and other operations
      simultaneously
    - Mask out RX IMR while napi_schedule(), and resume RX IMR until
      no more RX data.
    - Change napi_init order prior to enable interrupt.

Po-Hao Huang (8):
  rtw88: add dynamic rrsr configuration
  rtw88: add rts condition
  rtw88: add napi support
  rtw88: replace tx tasklet with work queue
  rtw88: 8822c: update MAC/BB parameter tables to v60
  rtw88: 8822c: update RF_A parameter tables to v60
  rtw88: 8822c: update RF_B (1/2) parameter tables to v60
  rtw88: 8822c: update RF_B (2/2) parameter tables to v60

 drivers/net/wireless/realtek/rtw88/mac80211.c |     2 +-
 drivers/net/wireless/realtek/rtw88/main.c     |     8 +-
 drivers/net/wireless/realtek/rtw88/main.h     |    10 +-
 drivers/net/wireless/realtek/rtw88/pci.c      |   154 +-
 drivers/net/wireless/realtek/rtw88/pci.h      |    14 +-
 drivers/net/wireless/realtek/rtw88/phy.c      |    62 +-
 drivers/net/wireless/realtek/rtw88/phy.h      |     3 +
 drivers/net/wireless/realtek/rtw88/reg.h      |     2 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |     2 -
 .../wireless/realtek/rtw88/rtw8822c_table.c   | 32755 ++++++++++++----
 drivers/net/wireless/realtek/rtw88/tx.c       |    11 +-
 drivers/net/wireless/realtek/rtw88/tx.h       |     6 +-
 12 files changed, 24638 insertions(+), 8391 deletions(-)

-- 
2.21.0

