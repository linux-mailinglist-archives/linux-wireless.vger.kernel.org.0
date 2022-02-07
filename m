Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14324AB582
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 08:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbiBGHDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 02:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357056AbiBGGnI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 01:43:08 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F13C043186
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 22:43:07 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2176dMlO5024311, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2176dMlO5024311
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Feb 2022 14:39:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 14:39:21 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Feb
 2022 14:39:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/7] rtw89: support AP mode
Date:   Mon, 7 Feb 2022 14:38:53 +0800
Message-ID: <20220207063900.43643-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/07/2022 06:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvNyCkV6TIIDAzOjUyOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v2:
    - use full logic style of 'self_role'
    - 1~13/19 patches of patchset v1 are merged, so v2 contains remaining
      7 patches.

Ping-Ke Shih (7):
  rtw89: extend role_maintain to support AP mode
  rtw89: add addr_cam field to sta to support AP mode
  rtw89: only STA mode change vif_type mapping dynamically
  rtw89: maintain assoc/disassoc STA states of firmware and hardware
  rtw89: implement ieee80211_ops::start_ap and stop_ap
  rtw89: debug: add stations entry to show ID assignment
  rtw89: declare AP mode support

 drivers/net/wireless/realtek/rtw89/cam.c      |  6 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 43 +++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     | 62 +++++++++-------
 drivers/net/wireless/realtek/rtw89/debug.c    | 71 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 16 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  8 +--
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 36 ++++++++++
 9 files changed, 204 insertions(+), 40 deletions(-)

-- 
2.25.1

