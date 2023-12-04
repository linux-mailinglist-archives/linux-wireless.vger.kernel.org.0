Return-Path: <linux-wireless+bounces-350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6669B802CB9
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F56280D1A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E3ECA59;
	Mon,  4 Dec 2023 08:09:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63313BB
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 00:09:12 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B488xkI61945208, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B488xkI61945208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 16:08:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 4 Dec 2023 16:08:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 4 Dec 2023
 16:08:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: rtw89: 8922a: add SER related stuff
Date: Mon, 4 Dec 2023 16:07:46 +0800
Message-ID: <20231204080751.15354-1-pkshih@realtek.com>
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

SER (system error recovery) is a mechanism to try to recover WiFi
connection when hardware or firmware gets abnormal. It happens rarely, and
empirically it is hard to reproduce, so try to dump many registers if it
occasionally occurs to prevent debugging back and forth.

The address used by WiFi CPU and its program counter are changed, so
modify them for WiFi 7 chips. Also, driver configure SER interrupt mask
that affects considerations to trigger SER by firmware.

Chia-Yuan Li (1):
  wifi: rtw89: 8922a: dump MAC registers when SER occurs

Ping-Ke Shih (2):
  wifi: rtw89: 8922a: add SER IMR tables
  wifi: rtw89: mac: refine SER setting during WiFi CPU power on

Zong-Zhe Yang (2):
  wifi: rtw89: 8922a: configure CRASH_TRIGGER FW feature
  wifi: rtw89: fw: extend program counter dump for Wi-Fi 7 chip

 drivers/net/wireless/realtek/rtw89/core.h     |   13 +
 drivers/net/wireless/realtek/rtw89/fw.c       |   11 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |    2 -
 drivers/net/wireless/realtek/rtw89/mac.c      |  283 ++-
 drivers/net/wireless/realtek/rtw89/mac.h      |   10 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  257 ++-
 drivers/net/wireless/realtek/rtw89/pci.c      |   22 +-
 drivers/net/wireless/realtek/rtw89/pci.h      |    4 +
 drivers/net/wireless/realtek/rtw89/reg.h      | 1708 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   58 +
 drivers/net/wireless/realtek/rtw89/ser.c      |   10 +-
 15 files changed, 2299 insertions(+), 87 deletions(-)

-- 
2.25.1


