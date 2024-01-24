Return-Path: <linux-wireless+bounces-2427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6D83A026
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 04:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015FE1C217E3
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12E5C98;
	Wed, 24 Jan 2024 03:37:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C95C85
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067434; cv=none; b=VOoRk+krk19ZNr+LgXHTmEfWBACKrsr9MglJVpnObLKKREeJAExmmSBh6dEdm4ijaBuicVCpnf2ktXRw7ZQTn7MhDyESl3zOX6GisKFBuWzKugVJWBpJcP4xi1vkF2qnbtxvdcSmAgnY7bhCZV7h+nrISFjEOrPTAEb5vObwXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067434; c=relaxed/simple;
	bh=9oC8g9AoSv3IT4A2+hTjjSTEpn03C/KJV1c2vQbyjs0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CBkTWHXSYfirnGdC5i4yta55x9dtjg0N1yxR5Uus09CKsG0fd1yUumYTTJdmzXCj3XhGTQyRRHsyGiUU47CsDZ+LI2emtpPIK04vQBR9QHrlQ7WpdY4/cmW3+J8dMEopqD1eo6JpSJOnrP9OvtlYQGg/ItA6HRx2oWvW8VP9YWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40O3b2uqD723691, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40O3b2uqD723691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:37:02 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 24 Jan 2024 11:37:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 24 Jan
 2024 11:37:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: 8922a: add chip_ops related to TX/RX, RF access and thermal
Date: Wed, 24 Jan 2024 11:36:31 +0800
Message-ID: <20240124033637.12330-1-pkshih@realtek.com>
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

Add more chip_ops for 8922A. First is handlers of TX/RX descriptors to
fill/read descriptors. During switching channel, it needs to stop hardware
TX scheduler introduced by second patch. Patch 3/6 is to configure TX path,
which it can TX 1SS rate data via one or two paths, and normally 2-path TX
is adopted by default.

Then, add patch 4/6 to access RF registers via an indirect interface.
Normally, use thermal value to decide whether we trigger certain RF
calibration again, and it also helps to debug CFO because temperature can
affect the result too. The last patch is just to fill two ops that are NULL.

Ping-Ke Shih (6):
  wifi: rtw89: 8922a: hook handlers of TX/RX descriptors to chip_ops
  wifi: rtw89: 8922a: implement {stop,resume}_sch_tx and cfg_ppdu
  wifi: rtw89: 8922a: add chip_ops::cfg_txrx_path
  wifi: rtw89: 8922a: add RF read/write v2
  wifi: rtw89: 8922a: add chip_ops to get thermal value
  wifi: rtw89: 8922a: set chip_ops FEM and GPIO to NULL

 drivers/net/wireless/realtek/rtw89/mac.c      |   5 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |  14 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  96 +++++
 drivers/net/wireless/realtek/rtw89/phy.c      | 125 +++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |   4 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  84 +++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 344 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c |  33 ++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.h |  12 +
 9 files changed, 714 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h

-- 
2.25.1


