Return-Path: <linux-wireless+bounces-2981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D634846655
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 04:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EE8B2130B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88DCBE69;
	Fri,  2 Feb 2024 03:07:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C6BE5A
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843252; cv=none; b=ZdD/Rci14geVSfsqEW+2wBrMw0ZFfwdN4XMGlKubv83cjW+Vv30OTxbssduyqf+DgEwt/0e7FG8PQpzMRgel+7UDAmjHNO+U75ujRvAdbKxw+C0nea40dcPhjt66IrdmQXGj8X3WpPvKLJA1wGo/29+rgbRlqbkHYSQ8u3zkL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843252; c=relaxed/simple;
	bh=fptnPP62aGzf2Pri6IdvlIA8hKByIpFKmAWtId9v4Xk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VkU4PobXThyLobKs6MCp+fxLxeZ0evfN3MQ0QBGjkpt+EGgnvPZfIoSboQcn+t33b0g144y+1BqFQ6WMo9iY/TizqJ6U5PX0f4puKTK3OCU4royhq59duZKm8m1zLbte6FxjsKwjnXIF5sFMo8kN3UNPG92McqUHNMMUTuBZuMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41237GjtC1862997, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41237GjtC1862997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:07:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 2 Feb 2024 11:07:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Feb
 2024 11:07:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/11] wifi: rtw89: 8922a: add firmware RF calibrations
Date: Fri, 2 Feb 2024 11:06:31 +0800
Message-ID: <20240202030642.108385-1-pkshih@realtek.com>
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

For WiFi 7 chips, we move RF calibrations from driver to firmware. Driver
must trigger them one by one, so add H2C commands to trigger each of them,
and add a C2H event to know the result.

Because H2C commands and C2H event go via PCI ring, we should trigger them
after PCI enabled, so add a chip_ops::rfk_init_late for this purpose.

Ping-Ke Shih (11):
  wifi: rtw89: rfk: add a completion to wait RF calibration report from
    C2H event
  wifi: rtw89: rfk: send channel information to firmware for RF
    calibrations
  wifi: rtw89: rfk: add H2C command to trigger IQK
  wifi: rtw89: rfk: add H2C command to trigger RX DCK
  wifi: rtw89: rfk: add H2C command to trigger DPK
  wifi: rtw89: rfk: add H2C command to trigger DACK
  wifi: rtw89: rfk: add H2C command to trigger TXGAPK
  wifi: rtw89: rfk: add H2C command to trigger TSSI
  wifi: rtw89: 8922a: rfk: implement chip_ops to call RF calibrations
  wifi: rtw89: 8922a: add chip_ops::rfk_init_late to do initial RF
    calibrations later
  wifi: rtw89: 8922a: add chip_ops::rfk_hw_init

 drivers/net/wireless/realtek/rtw89/coex.h     |   1 +
 drivers/net/wireless/realtek/rtw89/core.c     |   2 +
 drivers/net/wireless/realtek/rtw89/core.h     |  51 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 322 ++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 134 +++
 drivers/net/wireless/realtek/rtw89/mac.h      |   2 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 775 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  30 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   8 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  79 ++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 202 +++++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.h |   1 +
 16 files changed, 1611 insertions(+), 4 deletions(-)

-- 
2.25.1


