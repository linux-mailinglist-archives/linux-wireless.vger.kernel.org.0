Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457591001D5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKRJyp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 04:54:45 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:40036 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfKRJyo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 04:54:44 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAI9saIB018243, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAI9saIB018243
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Nov 2019 17:54:36 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 18 Nov 2019 17:54:35 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 0/4] rtw88: enable PCI CLKREQ and ASPM
Date:   Mon, 18 Nov 2019 17:54:28 +0800
Message-ID: <20191118095432.4507-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This set enables PCI CLKREQ and ASPM for power save. Basically
they should be enabled through PCI configuration space, but
for some reasons (see comments in pci.c), they are disabled by
default. So driver requires to check the configuration space
and then enable them properly.


v1 -> v2
 * slightly modify code flow to look cleaner


Yan-Hsuan Chuang (4):
  rtw88: pci: use macros to access PCI DBI/MDIO registers
  rtw88: pci: use for loop instead of while loop for DBI/MDIO
  rtw88: pci: enable CLKREQ function if host supports it
  rtw88: allows to enable/disable HCI link PS mechanism

 drivers/net/wireless/realtek/rtw88/hci.h |   6 +
 drivers/net/wireless/realtek/rtw88/pci.c | 155 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/pci.h |  16 +++
 drivers/net/wireless/realtek/rtw88/ps.c  |   6 +
 4 files changed, 165 insertions(+), 18 deletions(-)

-- 
2.17.1

