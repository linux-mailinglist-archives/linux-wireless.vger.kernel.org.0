Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38D15D44C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 10:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgBNJEA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 04:04:00 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:35655 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgBNJEA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 04:04:00 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 01E93p2c032383, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 01E93p2c032383
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 17:03:51 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 14 Feb 2020 17:03:51 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 14 Feb 2020 17:03:51 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 0/2] rtw88: add coex related debugfs
Date:   Fri, 14 Feb 2020 17:03:32 +0800
Message-ID: <20200214090334.330-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Sometimes WiFi/BT coexistence problems are difficult to debug. There
are many factors that can influence the coex. Such the different
scenarios of BT's profile, or the environment. So it is very useful
to have some tools to know the current status for WiFi and BT, so that
we can check if the decision made by the coex mechanism is good for
the current situation.

Also we can stop the coex mechanism to stop making any decisions, and
send some commands through user space, to help us check that specific
strategies are good for the current situation.


Yan-Hsuan Chuang (2):
  rtw88: add a debugfs entry to dump coex's info
  rtw88: add a debugfs entry to enable/disable coex mechanism

 drivers/net/wireless/realtek/rtw88/coex.c     | 497 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/coex.h     |  10 +
 drivers/net/wireless/realtek/rtw88/debug.c    |  63 +++
 drivers/net/wireless/realtek/rtw88/main.h     |  18 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  30 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  28 +
 6 files changed, 646 insertions(+)

-- 
2.17.1

