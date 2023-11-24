Return-Path: <linux-wireless+bounces-25-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16D77F6CB4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077C01C20926
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B863A5;
	Fri, 24 Nov 2023 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F7BD6C
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 23:18:11 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AO7I3Vv83551102, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AO7I3Vv83551102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 15:18:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Nov 2023 15:18:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 24 Nov
 2023 15:18:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: 8922a: configure hardware engines and quota
Date: Fri, 24 Nov 2023 15:16:55 +0800
Message-ID: <20231124071703.132549-1-pkshih@realtek.com>
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

The quota is allocation of chip internal buffer size assigned to certain
hardware engines, such DLE (data link engine), PLE (payload engine) and
so on.

Configure the quota according to operation modes, for example, download
firmware and normal mode. In the future, we will add more one operation
mode to support MLO for WiFi 7 chip. To support that mode, we need more
works to adjust code, so defer to add quota along with that work.

Ping-Ke Shih (6):
  wifi: rtw89: 8922a: extend and add quota number
  wifi: rtw89: mac: add to get DLE reserved quota
  wifi: rtw89: add reserved size as factor of DLE used size
  wifi: rtw89: mac: move code related to hardware engine to individual
    functions
  wifi: rtw89: mac: use pointer to access functions of hardware engine
    and quota
  wifi: rtw89: mac: functions to configure hardware engine and quota for
    WiFi 7 chips

Zong-Zhe Yang (2):
  wifi: rtw89: refine element naming used by queue empty check
  wifi: rtw89: mac: check queue empty according to chip gen

 drivers/net/wireless/realtek/rtw89/core.h     |  32 +-
 drivers/net/wireless/realtek/rtw89/debug.c    |   5 +-
 drivers/net/wireless/realtek/rtw89/mac.c      | 267 ++++++++---
 drivers/net/wireless/realtek/rtw89/mac.h      |  64 ++-
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 437 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 294 ++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  52 +++
 11 files changed, 1085 insertions(+), 82 deletions(-)

-- 
2.25.1


