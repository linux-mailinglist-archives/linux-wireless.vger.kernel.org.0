Return-Path: <linux-wireless+bounces-2142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E736D83156D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67A7B21C8F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0804F208AD;
	Thu, 18 Jan 2024 09:04:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2882031B
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568689; cv=none; b=bH4/FdlnssKB5CvyNz0a+hxkLTvWasFfZi+F0QYGbLMUnGqw/tzIwZn6e8FpGtFcM7IZhePJy52Cdjo/pJ9hX0uEl8fXBeF/EijCY3rsWbRPeSLIWfmAK/EfAM2wUXIsrFdV5eeiSrzoUtHkJquFUwybTCDEMhTyJo3YQsk8LG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568689; c=relaxed/simple;
	bh=KNr1WUWW46BOgYh6JqDh7Cqz+Zz5npB+b8lq3hhoQCI=;
	h=X-SpamFilter-By:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy; b=khbrq2Ub9Y659o0CLtlguMmMJ+b31tWe4ntf3oAU4eaQIYO5Z6Yaq0vTCmdRAKVFVtmiqeiKcqGGGKq5JWO2PXBfjBCB0YTo/CADl2rpeVNV3ZhcFoDKdlL4tEZvOPgXK0tTM8NzPGT7e0DboJ2K4XWoll3NWtspNVDkM+xWSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40I94ZMn81580059, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40I94ZMn81580059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 17:04:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 18 Jan 2024 17:04:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jan
 2024 17:04:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/6] wifi: rtw89: 8922a: implement more chip_ops for 8922A
Date: Thu, 18 Jan 2024 17:04:07 +0800
Message-ID: <20240118090413.130989-1-pkshih@realtek.com>
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

Introduce MLO/DBCC mode variable that is used to configure PHY mode for
various application. The later implementation of chip_ops will reference
the mode to set registers. Though we have not really enabled MLO.

Other patches are chips_ops to enable BB/RF, set TX power and BT
coexistence helpers. Also, define chip specified registers that are used
by common logic flow.

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


