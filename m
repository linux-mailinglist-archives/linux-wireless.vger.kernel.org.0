Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607C9F2D36
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 12:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbfKGLQR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 06:16:17 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43299 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388178AbfKGLQP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 06:16:15 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA7BG7TT012861, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA7BG7TT012861
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 7 Nov 2019 19:16:07 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 7 Nov 2019 19:16:06 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 0/4] rtw88: enable PCI CLKREQ and ASPM
Date:   Thu, 7 Nov 2019 19:15:59 +0800
Message-ID: <20191107111603.12317-1-yhchuang@realtek.com>
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

Yan-Hsuan Chuang (4):
  rtw88: pci: use macros to access PCI DBI/MDIO registers
  rtw88: pci: use for loop instead of while loop for DBI/MDIO
  rtw88: pci: enable CLKREQ function if host supports it
  rtw88: allows to enable/disable HCI link PS mechanism

 drivers/net/wireless/realtek/rtw88/hci.h |   6 +
 drivers/net/wireless/realtek/rtw88/pci.c | 158 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/pci.h |  16 +++
 drivers/net/wireless/realtek/rtw88/ps.c  |   6 +
 4 files changed, 168 insertions(+), 18 deletions(-)

-- 
2.17.1

