Return-Path: <linux-wireless+bounces-633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C34EF80C353
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 09:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79ECF1F20F07
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2705720DE1;
	Mon, 11 Dec 2023 08:35:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593E8E
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 00:35:01 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB8YqrI62598349, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB8YqrI62598349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 16:34:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 11 Dec 2023 16:34:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Dec
 2023 16:34:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: adjust mac init code to support WiFi 7 chips
Date: Mon, 11 Dec 2023 16:33:35 +0800
Message-ID: <20231211083341.118047-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The mac initial code is different between WiFi 6 and 7 chips, so add
suffix _ax for WiFi 6 chips, and export shared functions. For WiFi 7, the
code to initialize MAC is a little big, so I defer the patches to next
submission.

Other stuffs are to add necessary API used by initial flow. Include
XTAL SI to control analog hardware, driver flags to reflect CMAC/DMAC
status, DBCC H2C command to notify firmware current MAC quota mode, and
avoid to additionally reset BB/RF while starting.

Ping-Ke Shih (6):
  wifi: rtw89: add XTAL SI for WiFi 7 chips
  wifi: rtw89: 8922a: add power on/off functions
  wifi: rtw89: mac: add flags to check if CMAC and DMAC are enabled
  wifi: rtw89: mac: add suffix _ax to MAC functions
  wifi: rtw89: add DBCC H2C to notify firmware the status
  wifi: rtw89: only reset BB/RF for existing WiFi 6 chips while starting
    up

 drivers/net/wireless/realtek/rtw89/core.c     |   5 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   3 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  35 +++
 drivers/net/wireless/realtek/rtw89/fw.h       |   8 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 184 +++++++-------
 drivers/net/wireless/realtek/rtw89/mac.h      |  71 +++++-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  71 ++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 176 +++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 237 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/wow.c      |   7 +-
 10 files changed, 699 insertions(+), 98 deletions(-)

-- 
2.25.1


