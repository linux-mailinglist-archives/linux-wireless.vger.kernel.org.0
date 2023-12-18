Return-Path: <linux-wireless+bounces-881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D706281665A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 07:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928C3281241
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 06:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997C7464;
	Mon, 18 Dec 2023 06:15:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDE7460
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI6F2rB43224806, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI6F2rB43224806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:15:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 18 Dec 2023 14:15:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Dec
 2023 14:15:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/11] wifi: rtw89: coex: improve BT-coexistence performance for 8852B and 8851B
Date: Mon, 18 Dec 2023 14:13:30 +0800
Message-ID: <20231218061341.51255-1-pkshih@realtek.com>
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

In some situations, coexistence of WiFi and BT doesn't work well, such as
WiFi PS mode, BT inquiry, BT idle and etc. Also, we found some formats of
debugging report from firmware are wrong during debugging above situations,
so correct them as well.

Ching-Te Ku (11):
  wifi: rtw89: coex: Fix wrong Wi-Fi role info and FDDT parameter
    members
  wifi: rtw89: coex: Record down Wi-Fi initial mode information
  wifi: rtw89: coex: Add Pre-AGC control to enhance Wi-Fi RX performance
  wifi: rtw89: coex: Update BTG control related logic
  wifi: rtw89: coex: Still show hardware grant signal info even Wi-Fi is
    PS
  wifi: rtw89: coex: Update coexistence policy for Wi-Fi LPS
  wifi: rtw89: coex: Set Bluetooth scan low-priority when Wi-Fi
    link/scan
  wifi: rtw89: coex: Add Bluetooth RSSI level information
  wifi: rtw89: coex: Update RF parameter control setting logic
  wifi: rtw89: coex: Translate antenna configuration from ID to string
  wifi: rtw89: coex: To improve Wi-Fi performance while BT is idle

 drivers/net/wireless/realtek/rtw89/coex.c | 640 +++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/coex.h |  38 ++
 drivers/net/wireless/realtek/rtw89/core.h |  23 +-
 drivers/net/wireless/realtek/rtw89/mac.c  |   3 +-
 4 files changed, 548 insertions(+), 156 deletions(-)

-- 
2.25.1


