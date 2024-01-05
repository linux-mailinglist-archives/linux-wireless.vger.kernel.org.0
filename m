Return-Path: <linux-wireless+bounces-1510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A683824EB7
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 07:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D307D2846D8
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 06:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA41DDDC;
	Fri,  5 Jan 2024 06:43:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E51DDD9
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4056geER32200572, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4056geER32200572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 14:42:40 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 5 Jan 2024 14:42:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 14:42:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: update/add PHY settings for WiFi 7 chips
Date: Fri, 5 Jan 2024 14:42:20 +0800
Message-ID: <20240105064228.36580-1-pkshih@realtek.com>
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

Add many PHY stuffs to support coming WiFi 7 chips: Add to parse
parameters of RX gain from firmware file, and then set these values to
registers according to specified channel. Update registers and logic to
share DIG flow with WiFi 7. Set TX power registers called BB wrapper
because these registers are used by BB but resides in MAC register domain.
WiFi 7 chips have additional settings of channel info to get desired
reports.

A set of NCTL pre-settings ops is introduced to configure conditional
settings before loading parameters from firmware file. Parameters could
contain a special value (0xbabecafe) as a dummy, so exclude it accordingly.

Cheng-Chieh Hsieh (1):
  wifi: rtw89: 8922a: update the register used in DIG and the DIG flow

Chung-Hsuan Hung (2):
  wifi: rtw89: phy: add parser to support RX gain dynamic setting flow
  wifi: rtw89: 8922a: set RX gain along with set_channel operation

Ping-Ke Shih (5):
  wifi: rtw89: phy: move bb_gain_info used by WiFi 6 chips to union
  wifi: rtw89: phy: ignore special data from BB parameter file
  wifi: rtw89: 8922a: add NCTL pre-settings for WiFi 7 chips
  wifi: rtw89: phy: add BB wrapper of TX power for WiFi 7 chips
  wifi: rtw89: phy: set channel_info for WiFi 7 chips

 drivers/net/wireless/realtek/rtw89/core.h     |  69 +++-
 drivers/net/wireless/realtek/rtw89/phy.c      |  45 ++-
 drivers/net/wireless/realtek/rtw89/phy.h      |  62 ++++
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 312 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  79 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 209 ++++++++++++
 9 files changed, 767 insertions(+), 19 deletions(-)

-- 
2.25.1


