Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17543414FA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 06:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhCSFn3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 01:43:29 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39688 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhCSFnC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 01:43:02 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12J5grNhB007625, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12J5grNhB007625
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Mar 2021 13:42:53 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Mar
 2021 13:42:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>,
        <phhuang@realtek.com>, <shaofu@realtek.com>,
        <steventing@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 0/7] rtw88: add some fixes and 8822c features
Date:   Fri, 19 Mar 2021 13:42:11 +0800
Message-ID: <20210319054218.3319-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The patches in this patchset aren't all related, but they will conflict
if I submit them individually.

First and second patches are fixes that we found in certain circumstances.
Patches 3-7 add features and a fix to improve performance.
The last patch is to fix BT-coexistence issue.

Ching-Te Ku (1):
  rtw88: coex: fix A2DP stutters while WL busy + WL scan

Po-Hao Huang (2):
  rtw88: 8822c: add LC calibration for RTL8822C
  rtw88: 8822c: add CFO tracking

Shao-Fu Cheng (1):
  rtw88: follow the AP basic rates for tx mgmt frame

Zong-Zhe Yang (3):
  rtw88: add flush hci support
  rtw88: fix DIG min setting
  rtw88: 8822c: update tx power limit table to RF v40.1

 drivers/net/wireless/realtek/rtw88/coex.c     |   8 +-
 drivers/net/wireless/realtek/rtw88/coex.h     |   8 +
 drivers/net/wireless/realtek/rtw88/debug.c    |  39 +
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/hci.h      |  16 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |   2 +
 drivers/net/wireless/realtek/rtw88/main.h     |  16 +
 drivers/net/wireless/realtek/rtw88/pci.c      |  69 ++
 drivers/net/wireless/realtek/rtw88/phy.c      |  89 ++-
 drivers/net/wireless/realtek/rtw88/phy.h      |   3 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   6 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 158 +++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |   5 +
 .../wireless/realtek/rtw88/rtw8822c_table.c   | 686 +++++++++---------
 drivers/net/wireless/realtek/rtw88/tx.c       |  27 +-
 15 files changed, 774 insertions(+), 359 deletions(-)

-- 
2.21.0

