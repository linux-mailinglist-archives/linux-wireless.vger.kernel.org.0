Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E71215549B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 10:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgBGJ2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 04:28:54 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44676 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgBGJ2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 04:28:53 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0179Sk35018548, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0179Sk35018548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 17:28:46 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:46 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:46 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Fri, 7 Feb 2020 17:28:46 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 7 Feb 2020 17:28:45 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <pkshih@realtek.com>
Subject: [PATCH 0/8] rtw88: Add SAR implementation
Date:   Fri, 7 Feb 2020 17:28:36 +0800
Message-ID: <20200207092844.29175-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Add SAR implemention that allows driver to set SAR power from
three different sources:
  1. From vendor command
  2. From static SAR configuration
  3. From dynamic SAR

SAR sources will provide driver a list of target power in dBm
which should be translated into power indexes. Then driver
will just treat those indexes as another power limit to force
the power output being lower then SAR restriction.

For either vendor command, static or dynamic SAR, driver stores
the values in tx_pwr_sar_{2,5}g[regd][path][rs][ch]. Whenever
the channel is changed or a new SAR table is applied, driver
will configure the power indexes.

To check if SAR power is configured properly, append a column
to debugfs "tx_pwr_tbl". But for dynamic SAR, the profile ID
may change, so add a new debugfs "sar" to display SAR power.


Ping-Ke Shih (8):
  rtw88: sar: add SAR of TX power limit
  nl80211: vendor-cmd: realtek: Add vendor command to set SAR power
    limit
  rtw88: vndcmd: sar: Apply SAR power limit via vendor command
  rtw88: sar: Load static SAR table from ACPI WRDS method
  rtw88: sar: Load dynamic SAR table from ACPI methods
  rtw88: sar: apply dynamic SAR table to tx power limit
  rtw88: sar: add sar_work to poll if dynamic SAR table is changed
  rtw88: sar: dump sar information via debugfs

 drivers/net/wireless/realtek/rtw88/Makefile |   2 +
 drivers/net/wireless/realtek/rtw88/debug.c  |  30 +-
 drivers/net/wireless/realtek/rtw88/main.c   |  10 +
 drivers/net/wireless/realtek/rtw88/main.h   |  26 +
 drivers/net/wireless/realtek/rtw88/phy.c    | 173 ++++-
 drivers/net/wireless/realtek/rtw88/phy.h    |   3 +
 drivers/net/wireless/realtek/rtw88/sar.c    | 778 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/sar.h    |  15 +
 drivers/net/wireless/realtek/rtw88/vndcmd.c | 131 ++++
 drivers/net/wireless/realtek/rtw88/vndcmd.h |  10 +
 include/uapi/nl80211-vnd-realtek.h          |  72 ++
 11 files changed, 1218 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/sar.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/sar.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/vndcmd.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/vndcmd.h
 create mode 100644 include/uapi/nl80211-vnd-realtek.h

-- 
2.17.1

