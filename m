Return-Path: <linux-wireless+bounces-8663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B1A8FFCC7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31586B265C6
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 07:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966FC15575C;
	Fri,  7 Jun 2024 07:07:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1091527BA
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744045; cv=none; b=Ow8kVJHJ47eeqSUQnrkaRLKd/f6DVNY4W/n+TtbMQtYMwr/3kedyOd5kYFyV73VoPXWCkGM3vrXw20gL9vJ9W9+bqCGlXbYmc9hU10o6UeiFvYD5l7NVLEGbuIzgM8hUyTUedlABH1bXp7rC84TiUucLigfuK3AZFVjMr3GgXXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744045; c=relaxed/simple;
	bh=7IUrDfoSWyYi18jCdjjGpeTGE05VFEa8TN3XikASQQg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h97kWIddotL2JXzKFA2LXw0C//n3Y9U2pFkWybeIOquWjd2gtnHajwNJgJjG3LkENbNSgBEotnucf2Yz8yeT5lRMpGTgw/7F0YFeLm4fIvHgTydkDOIDCpwo/eNHIN3dOzas9xI8ajtMAXmYWKPZMX3cZtYnweohcDMwyuoqK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45777J7e83728575, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45777J7e83728575
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 7 Jun 2024 15:07:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 15:07:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 7 Jun
 2024 15:07:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: rtw89: 8852bx: prepare common module to support 8852BE-VT
Date: Fri, 7 Jun 2024 15:06:56 +0800
Message-ID: <20240607070659.80263-1-pkshih@realtek.com>
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

8852BE-VT is an new chip driven from 8852BE, and WiFi features are almost
the same, so many codes can be shared. Move them to a common kernel module.

Considering chip ID, driver defines RTL8852BT, and combine abbreviation
of HCI interface (e.g. 'E' for PCIE) to be 8852BTE, which driver uses only.
For marketing, 8852BTE is named as 8852BE-VT.

Ping-Ke Shih (3):
  wifi: rtw89: 8852bx: move common code from 8852b to 8852b_common
  wifi: rtw89: 8852bx: add extra handles for 8852BT in 8852b_common
  wifi: rtw89: 885xbx: apply common settings to 8851B, 8852B and 8852BT

 drivers/net/wireless/realtek/rtw89/Kconfig    |    4 +
 drivers/net/wireless/realtek/rtw89/Makefile   |    6 +-
 drivers/net/wireless/realtek/rtw89/cam.c      |    1 +
 drivers/net/wireless/realtek/rtw89/coex.c     |    3 +-
 drivers/net/wireless/realtek/rtw89/core.c     |    2 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   11 +
 drivers/net/wireless/realtek/rtw89/debug.c    |    2 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   43 +-
 drivers/net/wireless/realtek/rtw89/pci.c      |   38 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |    1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |    8 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1691 +--------------
 drivers/net/wireless/realtek/rtw89/rtw8852b.h |  122 --
 .../wireless/realtek/rtw89/rtw8852b_common.c  | 1880 +++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852b_common.h  |  346 +++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |   19 +-
 drivers/net/wireless/realtek/rtw89/util.c     |  106 +
 drivers/net/wireless/realtek/rtw89/util.h     |    5 +
 19 files changed, 2443 insertions(+), 1847 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/util.c

-- 
2.25.1


