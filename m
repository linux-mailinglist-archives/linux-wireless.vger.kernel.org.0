Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F292C38C9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 06:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgKYFkZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 00:40:25 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45836 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgKYFkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 00:40:24 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AP5eHF11026134, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AP5eHF11026134
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 Nov 2020 13:40:17 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 25 Nov 2020 13:40:17 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <yhchuang@realtek.com>, <ku920601@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/10] rtw88: coex: enhance coex performance and synchronize coex code
Date:   Wed, 25 Nov 2020 13:38:51 +0800
Message-ID: <20201125053901.29678-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

This is the last patchset of my total 32 coex patches, fixing some issues
to improve user experience in field. And, some patches synchronized the
code from our internal tree are necessary for us to merge fixes, though
they doesn't really affect the behavior for now.

Ching-Te Ku (10):
  rtw88: coex: run coexistence when WLAN entering/leaving LPS
  rtw88: coex: add debug message
  rtw88: coex: update the mechanism for A2DP + PAN
  rtw88: coex: update AFH information while in free-run mode
  rtw88: coex: change the coexistence mechanism for HID
  rtw88: coex: change the coexistence mechanism for WLAN connected
  rtw88: coex: add function to avoid cck lock
  rtw88: coex: add action for coexistence in hardware initial
  rtw88: coex: upgrade coexistence A2DP mechanism
  rtw88: coex: add feature to enhance HID coexistence performance

 drivers/net/wireless/realtek/rtw88/coex.c     | 713 ++++++++++++++----
 drivers/net/wireless/realtek/rtw88/coex.h     |   6 +
 drivers/net/wireless/realtek/rtw88/debug.c    |  23 +
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/main.c     |   5 +
 drivers/net/wireless/realtek/rtw88/main.h     |  21 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   1 +
 10 files changed, 620 insertions(+), 153 deletions(-)

-- 
2.21.0

