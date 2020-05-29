Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAB1E72D0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 04:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436579AbgE2Cuh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 22:50:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35079 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407023AbgE2Cue (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 22:50:34 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04T2oGk05031983, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04T2oGk05031983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 10:50:16 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 10:50:15 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 10:50:15 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <kai.heng.feng@canonical.com>, <bigeasy@linutronix.de>,
        <vicamo.yang@canonical.com>
Subject: [PATCH v2 0/3] rtw88: 8723d: follow up fixes
Date:   Fri, 29 May 2020 10:50:06 +0800
Message-ID: <20200529025009.2468-1-yhchuang@realtek.com>
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

The RTL8723DE devices have been tested by Canonical for the coex
and basic wifi functions. And they have reported some issues for
RTL8723DE. Fix them accordingly.

From You-Sheng Yang <vicamo.yang@canonical.com>:

This works for me by following verification steps:

1. pair with one Bluetooth headset,
2. connect to some WLAN
3. run `nmcli d disconnect $ifname`, `nmcli d connect $ifname`
   interactively with time intervals for 100 runs.
4. wireless interface is still alive without that "deauthenticated
   (Reason: 23=IEEE8021X_FAILED)" error.

v1 -> v2
  * rewording

Ping-Ke Shih (3):
  rtw88: coex: 8723d: set antanna control owner
  rtw88: coex: 8723d: handle BT inquiry cases
  rtw88: fix EAPOL 4-way failure by finish IQK earlier

 drivers/net/wireless/realtek/rtw88/coex.c     | 21 ++++++++++++++-----
 drivers/net/wireless/realtek/rtw88/mac80211.c |  3 +--
 drivers/net/wireless/realtek/rtw88/main.c     | 17 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  4 ++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 10 +++++++--
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  1 +
 6 files changed, 47 insertions(+), 9 deletions(-)

-- 
2.17.1

