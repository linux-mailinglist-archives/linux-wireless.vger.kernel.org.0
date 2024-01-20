Return-Path: <linux-wireless+bounces-2281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597068331DB
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 01:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5075B21EC0
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 00:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBF439C;
	Sat, 20 Jan 2024 00:39:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E70392
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jan 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711146; cv=none; b=GRISZeMFBMYtaHh4OOEhwUhJEmfhG9QCTT9R5GI5erhJ820+cIMPkVdZvinxCo3e6jkduAkJvBhEVJuDI4R5mDmAMNCRdW/51T0opZLIJ5uEaI4vxnFur/f0oT/9jll/f5A+bX74etpCTi7DBHs8MW+XVPq2zRm4j2oO8ZGAA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711146; c=relaxed/simple;
	bh=RbFXuALUsVS8k5elYKNiRk6j9BdcIYTOdLw1gWXHHyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FcIO9VvT0y7SpFwOjVDObV8jioRPVhHT49tebY97/NTgrdpJe6DGLRfKn9GD3mrwIwbB1vDQtd1+Nvy/vuabv3sXOFAZCbBY9h//AC2tQIaFsTRGF5P7ouL5ofcmPGsUkkrrL15YwZJv0rhFLVgTOxAZLtYSKCA7fqd8KU+G8mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40K0ctRI32596449, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40K0ctRI32596449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jan 2024 08:38:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sat, 20 Jan 2024 08:38:56 +0800
Received: from [127.0.1.1] (172.16.16.202) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 20 Jan
 2024 08:38:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 0/6] wifi: rtw89: 8922a: implement more chip_ops for 8922A
Date: Sat, 20 Jan 2024 08:38:25 +0800
Message-ID: <20240120003831.7014-1-pkshih@realtek.com>
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

v3:
 - rebase to top of wireless-next tree to resolve conflicts of patch 5/6
 - no logic changes.

v2:
 - modify patches 3/6 and 5/6 because we found some problems during
   verification.

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
 drivers/net/wireless/realtek/rtw89/reg.h      | 199 +++++++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 482 ++++++++++++++++++
 10 files changed, 740 insertions(+), 1 deletion(-)

-- 
2.25.1


