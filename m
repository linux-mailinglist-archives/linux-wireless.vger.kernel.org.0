Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB95487151
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbiAGDm7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:42:59 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51029 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiAGDm7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:42:59 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073gqFA3022853, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073gqFA3022853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:42:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 11:42:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:42:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/19] rtw89: support AP mode
Date:   Fri, 7 Jan 2022 11:42:20 +0800
Message-ID: <20220107034239.22002-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To support AP mode, we implement ::start_ap and ::stop_ap to configure
firmware and hardware to play an AP. Then, we download beacon content to
firmware, so firmware can send out periodically the frames that must have
continual sequence number with other management frames.

When mac80211 buffers unicast packets for certain STAs, it tells driver via
::set_tim, and then we download the beacon content to firmware again. On the
other hand, if a broadcast packet is going to send out, it should go via
HIQ (HI queue) that hardware will raise group frame bit in TIM of beacon
frame. But if no STA sleeps, a broadcast packet is sent via AC queue.

When a STA is going to connect, it issues a probe request frame and then
auth/assoc frames. To receive these frames before it is connected, we need
to consider more RX filter flags to set registers properly.

When a connection is established, we need to assign a mac_id as a behalf of
this peer in firmware and hardware, and then use this mac_id to initialize
an instance in firmware via H2C(s). The most important part is to add a
corresponding address CAM entry that contains peer's MAC address and BSSID,
so hardware can determine a packet is belong to which peer. If it is a
security connection, keys will be filled to security CAM as well.

Since there are many CAM ID(s), I add a debugfs entry to see if the
relations between ID(s) and STA(s) are expected.

Ping-Ke Shih (19):
  rtw89: configure rx_filter according to FIF_PROBE_REQ
  rtw89: use hardware SSN to TX management frame
  rtw89: download beacon content to firmware
  rtw89: add C2H handle of BCN_CNT
  rtw89: implement mac80211_ops::set_tim to indicate STA to receive
    packets
  rtw89: allocate mac_id for each station in AP mode
  rtw89: extend firmware commands on states of sta_assoc and
    sta_disconnect
  rtw89: rename vif_maintain to role_maintain
  rtw89: configure mac port HIQ registers
  rtw89: send broadcast/multicast packets via HIQ if STAs are in sleep
    mode
  rtw89: set mac_id and port ID to TXWD
  rtw89: separate {init,deinit}_addr_cam functions
  rtw89: extend role_maintain to support AP mode
  rtw89: add addr_cam field to sta to support AP mode
  rtw89: only STA mode change vif_type mapping dynamically
  rtw89: maintain assoc/disassoc STA states of firmware and hardware
  rtw89: implement ieee80211_ops::start_ap and stop_ap
  rtw89: debug: add stations entry to show ID assignment
  rtw89: declare AP mode support

 drivers/net/wireless/realtek/rtw89/cam.c      |  40 +++---
 drivers/net/wireless/realtek/rtw89/cam.h      |   5 +
 drivers/net/wireless/realtek/rtw89/core.c     | 107 ++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  83 ++++++++-----
 drivers/net/wireless/realtek/rtw89/debug.c    |  71 +++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 110 ++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h       | 115 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c      |  50 +++++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |   2 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  67 +++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h      |  14 ++-
 drivers/net/wireless/realtek/rtw89/txrx.h     |   3 +
 12 files changed, 575 insertions(+), 92 deletions(-)

-- 
2.25.1

