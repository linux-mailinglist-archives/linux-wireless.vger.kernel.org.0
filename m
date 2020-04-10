Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F861A4505
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 12:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDJKKJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 06:10:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:32795 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgDJKKI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 06:10:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03AA9xYkA027570, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03AA9xYkA027570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Apr 2020 18:09:59 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Apr 2020 18:09:59 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Apr 2020 18:09:59 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 0/2] rtw88: add set antenna support
Date:   Fri, 10 Apr 2020 18:09:48 +0800
Message-ID: <20200410100950.3199-1-yhchuang@realtek.com>
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

Add support for ieee80211_ops::set_antenna to allow user space to

set the TX/RX antenna path. This is useful for a user wants to see
the output of different antenna/path.

Yan-Hsuan Chuang (2):
  rtw88: make rtw_chip_ops::set_antenna return int
  rtw88: add support for set/get antennas

 drivers/net/wireless/realtek/rtw88/mac80211.c | 33 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.c     |  3 ++
 drivers/net/wireless/realtek/rtw88/main.h     |  9 ++---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 18 ++++++----
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 35 +++++++++++++++++++
 5 files changed, 88 insertions(+), 10 deletions(-)

-- 
2.17.1

