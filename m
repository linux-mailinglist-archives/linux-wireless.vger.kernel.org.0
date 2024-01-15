Return-Path: <linux-wireless+bounces-1905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09BC82D364
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0FB1F21316
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47500186A;
	Mon, 15 Jan 2024 03:38:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B101842
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F3c0s853528736, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F3c0s853528736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 11:38:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 15 Jan 2024 11:38:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jan
 2024 11:38:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: fw: add H2C commands to set security CAM, CMAC, DMAC and JOIN
Date: Mon, 15 Jan 2024 11:37:34 +0800
Message-ID: <20240115033742.16372-1-pkshih@realtek.com>
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

To support coming WiFi 7 chip 8922AE, add more H2C commands. Security CAM
is to hardware to encrypt/decrypt packets with pairwise/broadcast keys.
CMAC and DMAC stand for Control-/Data- MAC that are also CAM to control and
TX/RX packets. JOIN command is to create a station instance named mac_id,
so it will be called after establishing connection.

Ping-Ke Shih (8):
  wifi: rtw89: fw: add H2C command to update security CAM v2
  wifi: rtw89: fw: fill CMAC table to associated station for WiFi 7
    chips
  wifi: rtw89: fw: add chip_ops to update CMAC table to associated
    station
  wifi: rtw89: fw: update TX AMPDU parameter to CMAC table
  wifi: rtw89: fw: add H2C command to reset CMAC table for WiFi 7
  wifi: rtw89: fw: add H2C command to reset DMAC table for WiFi 7
  wifi: rtw89: fw: use struct to fill JOIN H2C command
  wifi: rtw89: fw: extend JOIN H2C command to support WiFi 7 chips

 drivers/net/wireless/realtek/rtw89/cam.c      |  61 +++
 drivers/net/wireless/realtek/rtw89/cam.h      | 109 ++++
 drivers/net/wireless/realtek/rtw89/core.c     |  12 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  15 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 509 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       | 303 ++++++++---
 drivers/net/wireless/realtek/rtw89/mac.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   6 +
 drivers/net/wireless/realtek/rtw89/wow.c      |   2 +-
 14 files changed, 955 insertions(+), 92 deletions(-)

-- 
2.25.1


