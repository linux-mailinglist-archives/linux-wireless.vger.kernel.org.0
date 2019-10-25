Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4FE5E475D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfJYJd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 05:33:57 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50460 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfJYJd5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 05:33:57 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9P9Xl8x026466, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9P9Xl8x026466
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 25 Oct 2019 17:33:47 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 25 Oct 2019 17:33:46 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <g.schlmm@googlemail.com>
Subject: [PATCH 0/6] rtw88: minor driver updates
Date:   Fri, 25 Oct 2019 17:33:39 +0800
Message-ID: <20191025093345.22643-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This patch set contains some minor driver updates including RFE
type 3 for RTL8822BE.

Also refine the tables with proper struct instead of arrays.


Tzu-En Huang (1):
  rtw88: fix potential read outside array boundary

Yan-Hsuan Chuang (5):
  rtw88: 8822b: add RFE type 3 support
  rtw88: use rtw_phy_pg_cfg_pair struct, not arrays
  rtw88: use a module parameter to control LPS enter
  rtw88: rearrange if..else statements for rx rate indexes
  rtw88: avoid FW info flood

 drivers/net/wireless/realtek/rtw88/mac.c      |  17 -
 drivers/net/wireless/realtek/rtw88/main.c     |  17 +-
 drivers/net/wireless/realtek/rtw88/phy.c      |  32 +-
 drivers/net/wireless/realtek/rtw88/phy.h      |  18 +
 drivers/net/wireless/realtek/rtw88/ps.h       |   2 -
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   4 +-
 .../wireless/realtek/rtw88/rtw8822b_table.c   | 829 ++++++++++++++++--
 .../wireless/realtek/rtw88/rtw8822b_table.h   |   2 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   4 +-
 .../wireless/realtek/rtw88/rtw8822c_table.c   |  94 +-
 drivers/net/wireless/realtek/rtw88/rx.c       |  14 +-
 11 files changed, 838 insertions(+), 195 deletions(-)

-- 
2.17.1

