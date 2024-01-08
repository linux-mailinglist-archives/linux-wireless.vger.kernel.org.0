Return-Path: <linux-wireless+bounces-1574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBA826A5A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B61D1F22865
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75067111BD;
	Mon,  8 Jan 2024 09:12:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FDDDCD
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4089BoFeA3872869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4089BoFeA3872869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 17:11:50 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 Jan 2024 17:11:50 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Jan 2024
 17:11:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/10] wifi: rtw89: update H2C commands of BA CAM, TX pause and beacon
Date: Mon, 8 Jan 2024 17:11:24 +0800
Message-ID: <20240108091134.67007-1-pkshih@realtek.com>
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
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Adjust and prepare H2C commands for WiFi 7 chips. BA CAM is a kind of
hardware CAM that is used to record received frame and reply BA frame.
TX pause H2C command is to stop transmitting to prevent send out unexpected
packets when we are going to enable a firmware/hardware entry for certain
station. Beacon H2C command is to tell firmware/hardware the beacon frame
and its attributes.

Ping-Ke Shih (10):
  wifi: rtw89: add firmware H2C command of BA CAM V1
  wifi: rtw89: mac: add feature_init to initialize BA CAM V1
  wifi: rtw89: add chip_ops::h2c_ba_cam() to configure BA CAM
  wifi: rtw89: 8922a: update BA CAM number to 24
  wifi: rtw89: fw: use struct to fill BA CAM H2C commands
  wifi: rtw89: refine H2C command that pause transmitting by MAC ID
  wifi: rtw89: add new H2C command to pause/sleep transmitting by MAC ID
  wifi: rtw89: use struct to fill H2C command to download beacon frame
  wifi: rtw89: add H2C command to download beacon frame for WiFi 7 chips
  wifi: rtw89: add chip_ops::update_beacon to abstract update beacon
    operation

 drivers/net/wireless/realtek/rtw89/chan.c     |   2 +-
 drivers/net/wireless/realtek/rtw89/core.c     |   2 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   7 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 329 +++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h       | 294 ++++++++--------
 drivers/net/wireless/realtek/rtw89/mac.c      |  26 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   4 +-
 12 files changed, 477 insertions(+), 201 deletions(-)

-- 
2.25.1


