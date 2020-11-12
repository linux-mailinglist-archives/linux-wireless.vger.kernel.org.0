Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0B2AFE86
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgKLFip (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:45 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38677 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgKLDPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 22:15:37 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC3FU1d8025852, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC3FU1d8025852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 11:15:30 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 11:15:30 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 00/11] rtw88: coex: fix and update settings to enhance coex performance
Date:   Thu, 12 Nov 2020 11:14:19 +0800
Message-ID: <20201112031430.4846-1-pkshih@realtek.com>
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

This is second patchset of my total 32 coex patches, in which we fix and
update coex settings to enhance coex performance in field.

v2:
 - (01/11) "rtw88: coex: update TDMA settings for different beacon interval"
   give proper names and use suggested macros.
 - (02/11)"rtw88: coex: remove unnecessary feature/function"
   describe "why" in commit log

Ching-Te Ku (11):
  rtw88: coex: update TDMA settings for different beacon interval
  rtw88: coex: remove unnecessary feature/function
  rtw88: coex: add write scoreboard action when WLAN in critical
    procedure
  rtw88: coex: Add force flag for coexistence table function
  rtw88: coex: add the mechanism for RF4CE
  rtw88: coex: update the TDMA parameter when leave LPS
  rtw88: coex: Change antenna setting to enhance free-run performance
  rtw88: coex: fix BT performance drop during initial/power-on step
  rtw88: coex: remove write scan bit to scoreboard in scan and connect
    notify
  rtw88: coex: remove unnecessary WLAN slot extend
  rtw88: coex: change the decode method from firmware

 drivers/net/wireless/realtek/rtw88/coex.c     | 200 +++++++++++-------
 drivers/net/wireless/realtek/rtw88/coex.h     |   5 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |   7 +
 drivers/net/wireless/realtek/rtw88/main.h     |   1 +
 4 files changed, 135 insertions(+), 78 deletions(-)

-- 
2.21.0

