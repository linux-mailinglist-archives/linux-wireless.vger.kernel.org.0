Return-Path: <linux-wireless+bounces-1764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4AD82B955
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CA22860A7
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FCED7;
	Fri, 12 Jan 2024 02:11:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429081108
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C2Apd362061254, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C2Apd362061254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 10:10:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 12 Jan 2024 10:10:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Jan
 2024 10:10:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: 8922a: implement more chip_ops for 8922A
Date: Fri, 12 Jan 2024 10:10:27 +0800
Message-ID: <20240112021033.20104-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Introduce MLO/DBCC mode variable that is used to configure PHY mode for
various application. The later implementation of chip_ops will reference
the mode to set registers. Though we have not really enabled MLO.

Other patches are chips_ops to enable BB/RF, set TX power and BT
coexistence helpers. Also, define chip specified registers that are used
by common logic flow.

Chung-Hsuan Hung (1):
  wifi: rtw89: 8922a: add BTG functions to assist BT coexistence to
    control TX/RX

Ping-Ke Shih (5):
  wifi: rtw89: add mlo_dbcc_mode for WiFi 7 chips
  wifi: rtw89: 8922a: add chip_ops::{enable,disable}_bb_rf
  wifi: rtw89: 8922a: add chip_ops related to BB init
  wifi: rtw89: 8922a: add register definitions of H2C, C2H, page, RRSR
    and EDCCA
  wifi: rtw89: 8922a: add TX power related ops

 drivers/net/wireless/realtek/rtw89/core.c     |   3 +
 drivers/net/wireless/realtek/rtw89/core.h     |  42 ++
 drivers/net/wireless/realtek/rtw89/phy.c      |   1 +
 drivers/net/wireless/realtek/rtw89/phy.h      |  10 +
 drivers/net/wireless/realtek/rtw89/reg.h      | 195 ++++++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 514 ++++++++++++++++++
 10 files changed, 768 insertions(+), 1 deletion(-)

-- 
2.25.1


