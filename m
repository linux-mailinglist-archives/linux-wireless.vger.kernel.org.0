Return-Path: <linux-wireless+bounces-1785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3632E82BB3F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 07:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B4D1C24F23
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 06:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C5A5B5D8;
	Fri, 12 Jan 2024 06:27:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695F1B28E
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C6QvJpA2173881, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C6QvJpA2173881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 14:26:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 12 Jan 2024 14:26:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Jan
 2024 14:26:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: declare EHT capabilities
Date: Fri, 12 Jan 2024 14:26:36 +0800
Message-ID: <20240112062640.36922-1-pkshih@realtek.com>
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

Adjust initial flow of HE capabilities to add EHT capabilities, and then
8922AE can connect to WiFi 7 AP with EHT rate.

Ping-Ke Shih (4):
  wifi: rtw89: adjust init_he_cap() to add EHT cap into iftype_data
  wifi: rtw89: change supported bandwidths of chip_info to bit mask
  wifi: rtw89: add EHT capabilities for WiFi 7 chips
  wifi: rtw89: declare EXT NSS BW of VHT capability

 drivers/net/wireless/realtek/rtw89/core.c     | 319 ++++++++++++------
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   5 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   4 +
 7 files changed, 232 insertions(+), 110 deletions(-)

-- 
2.25.1


