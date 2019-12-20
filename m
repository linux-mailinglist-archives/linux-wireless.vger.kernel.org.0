Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41D31277FB
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 10:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLTJWa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 04:22:30 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47428 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLTJWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 04:22:30 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBK9MLGY025694, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBK9MLGY025694
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Dec 2019 17:22:21 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Dec 2019 17:22:21 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 00/11] rtw88: some driver fixes
Date:   Fri, 20 Dec 2019 17:21:45 +0800
Message-ID: <20191220092156.13443-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This set includes some driver fixes

Chien-Hsun Liao (1):
  rtw88: 8822c: modify rf protection setting

Chin-Yen Lee (1):
  rtw88: use rtw_hci_stop() instead of rtwdev->hci.ops->stop()

Ping-Ke Shih (3):
  rtw88: fix rate mask for 1SS chip
  rtw88: fix TX secondary channel offset of 40M if current bw is 20M or
    40M
  rtw88: Use secondary channel offset enumeration

Tzu-En Huang (2):
  rtw88: 8822c: update power sequence to v15
  rtw88: remove unused spinlock

Yan-Hsuan Chuang (3):
  rtw88: remove unused variable 'in_lps'
  rtw88: remove unused vif pointer in struct rtw_vif
  rtw88: assign NULL to skb after being kfree()'ed

Zong-Zhe Yang (1):
  rtw88: change max_num_of_tx_queue() definition to inline in pci.h

 drivers/net/wireless/realtek/rtw88/fw.c       |  5 +++-
 drivers/net/wireless/realtek/rtw88/mac.c      | 10 ++++---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 --
 drivers/net/wireless/realtek/rtw88/main.c     | 29 +++++++++----------
 drivers/net/wireless/realtek/rtw88/main.h     | 15 ++++++----
 drivers/net/wireless/realtek/rtw88/pci.h      |  2 +-
 drivers/net/wireless/realtek/rtw88/phy.c      | 10 -------
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 23 ++++++++++++---
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  5 ++++
 10 files changed, 59 insertions(+), 44 deletions(-)

-- 
2.17.1

