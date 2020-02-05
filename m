Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24961526A6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 08:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgBEHJL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 02:09:11 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49339 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgBEHJL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 02:09:11 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 015793YS008596, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 015793YS008596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Feb 2020 15:09:03 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 5 Feb 2020 15:09:03 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 5 Feb 2020 15:09:02 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Wed, 5 Feb 2020 15:09:02 +0800
Received: from localhost.localdomain (172.21.69.117) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 5 Feb 2020 15:09:02 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 0/7] rtw88: regular driver updates
Date:   Wed, 5 Feb 2020 15:08:51 +0800
Message-ID: <20200205070858.15386-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.117]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This patch set has some patches for regular update.

Ping-Ke Shih (2):
  rtw88: move rtw_enter_ips() to the last when config
  rtw88: add ciphers to suppress error message

Tzu-En Huang (1):
  rtw88: 8822c: update power sequence to v16

Yan-Hsuan Chuang (4):
  rtw88: remove unused parameter vif in rtw_lps_pg_info_get()
  rtw88: add rtw_read8_mask and rtw_read16_mask
  rtw88: pci: 8822c should set clock delay to zero
  rtw88: avoid holding mutex for cancel_delayed_work_sync()

 drivers/net/wireless/realtek/rtw88/coex.c     |  3 +++
 drivers/net/wireless/realtek/rtw88/fw.c       |  9 ++++---
 drivers/net/wireless/realtek/rtw88/hci.h      | 26 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/mac80211.c | 22 +++++++++-------
 drivers/net/wireless/realtek/rtw88/main.c     |  5 ++++
 drivers/net/wireless/realtek/rtw88/pci.c      |  7 +++++
 drivers/net/wireless/realtek/rtw88/pci.h      |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  5 ++++
 8 files changed, 66 insertions(+), 12 deletions(-)

-- 
2.17.1

