Return-Path: <linux-wireless+bounces-2515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18983D482
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DFB1F25A22
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 07:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322DE1CD35;
	Fri, 26 Jan 2024 06:34:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926351CD2D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250875; cv=none; b=PHLf4bKHNUHcEYIZHtROv8rqt5qgFAMBm3MCr4cIUdBped2wghIbVcPmxHoIJWTcwwX3sbDZFXbP1oIsWzMSBE9r4Qx8A0OumfowGO+WtGPY+3pI+j8Axs4spP60/H10KQRwu4Ub4+ulNC0HfzPpdk03g0yLVJWq/SAdRX2sB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250875; c=relaxed/simple;
	bh=klCmkMG1Q44K2w6cIoqcfJ79SVcLGzG6feldCRcpL9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UwUpzJpeSqyBo9+ei3/4zww5umRBTEm56nLWCYlbLv/OaEVj0QuqOt49wvHSzm0qyUp6PZrqyYcQ6K+0/O82BJ/9O9iJVGf74z62vImsAxPIpC3vCYEnoZ9+SkCUqKgxPXVuK5UntzSNDaUTAEC/rdN3DKxjyYKvEsNlEHGzi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40Q6YPFY02085583, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40Q6YPFY02085583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:34:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 26 Jan 2024 14:34:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 14:34:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/7] wifi: rtw89: add hardware scan and power save mode for WiFi 7 chips
Date: Fri, 26 Jan 2024 14:33:49 +0800
Message-ID: <20240126063356.17857-1-pkshih@realtek.com>
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

Hardware scan and power save mode for WiFi 7 chips are similar to existing
chips, but more settings are introduced for MLO feature that we have not
supported yet at this moment.

To support multi-links AP mode, the H2C command to download beacon frame to
firmware is extended, so the last patch does change accordingly, but
currently we don't release firmware of 8922A yet, so I don't have a
condition for backward compatibility.

Chin-Yen Lee (2):
  wifi: rtw89: add new H2C for PS mode in 802.11be chip
  wifi: rtw89: update ps_state register for chips with different
    generation

Po-Hao Huang (5):
  wifi: rtw89: update scan C2H messages for wifi 7 IC
  wifi: rtw89: debug: add FW log component for scan
  wifi: rtw89: prepare scan leaf functions for wifi 7 ICs
  wifi: rtw89: 8922a: add ieee80211_ops::hw_scan
  wifi: rtw89: 8922a: add more fields to beacon H2C command to support
    multi-links

 drivers/net/wireless/realtek/rtw89/core.h   |  39 ++
 drivers/net/wireless/realtek/rtw89/fw.c     | 450 +++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h     | 201 ++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c    |  42 +-
 drivers/net/wireless/realtek/rtw89/mac.h    |   7 +
 drivers/net/wireless/realtek/rtw89/mac_be.c |   4 +
 drivers/net/wireless/realtek/rtw89/ps.c     |  10 +-
 drivers/net/wireless/realtek/rtw89/reg.h    |   3 +
 8 files changed, 736 insertions(+), 20 deletions(-)

-- 
2.25.1


