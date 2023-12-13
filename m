Return-Path: <linux-wireless+bounces-719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4668106FF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 01:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4CA1C20DC7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 00:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DCFA50;
	Wed, 13 Dec 2023 00:52:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA90A0
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 16:52:15 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BD0q7IR13838288, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BD0q7IR13838288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 08:52:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 13 Dec 2023 08:52:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 13 Dec
 2023 08:52:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/6] wifi: rtw89: add/modify three fw elements and related RFK log
Date: Wed, 13 Dec 2023 08:50:48 +0800
Message-ID: <20231213005054.10568-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Patches 1/6 to 3/6 are to add/modify three firmware elements. First is to
add an new element to add TX power track tables that helps to adjust TX
power according to increasing/decreasing thermal value. Second is to modify
existing element of BB MCU firmware, because we need to add a field to
point out hardware version. Since we have not released firmware yet,
no need to process backward compatible thing.

The third patch is to add formatted string of firmware C2H events triggered
by firmware RFK (RF calibration) to help debugging. When RFK is running in
firmware, it sends logs with formatted string ID via C2H events, and then
patch 6/6 uses the ID to find corresponding formatted string as first
argument of printf() with fixed four arguments.

The remaining patches are to handle the C2H events and print out RFK status
or log in plain text. 

v2:
  - rebase to top of wireless-next to avoid conflict of patch 5/6, because
    another patchset change fw.h nearby.

Ping-Ke Shih (6):
  wifi: rtw89: fw: load TX power track tables from fw_element
  wifi: rtw89: fw: add version field to BB MCU firmware element
  wifi: rtw89: load RFK log format string from firmware file
  wifi: rtw89: add C2H event handlers of RFK log and report
  wifi: rtw89: parse and print out RFK log from C2H events
  wifi: rtw89: phy: print out RFK log with formatted string

 drivers/net/wireless/realtek/rtw89/core.h |   6 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 110 +++++++-
 drivers/net/wireless/realtek/rtw89/fw.h   | 144 +++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c  | 300 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h  |  24 +-
 5 files changed, 581 insertions(+), 3 deletions(-)

-- 
2.25.1


