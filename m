Return-Path: <linux-wireless+bounces-20825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C230FA70EBD
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 03:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FDDB7A5766
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF732B9CF;
	Wed, 26 Mar 2025 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GJeH60JT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2D2629D
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 02:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954823; cv=none; b=e0aSGti5zfWh7AFgfc6RR3vROQUTU01PxQ/NLuMrhXSF5t8CoboZk1S6bduo9n9KtXZsjYUYPJW8Vw26DQogf6mH2ZWjfRDnlNmPA+sXtKlKT6QMW1uieRCH/kf1RM472+LO2+2crZzFKWo7xw7asvMi6CQXADFIuVYhqLlJNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954823; c=relaxed/simple;
	bh=uup0+yYfkCq7LDFw3Ew8FQU6d/y+L+YP5WjmWnfTOq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sLcmy4IF7SQICkwxUfnsWePl6JcSm3nFyEamIcy8MJW4KpgDPTcss8efO5HZmEbQhHgvbhcTx+QjZd68X8dlVRJRQ+iBsfnpcp/KqFdhY1YdxIDTG301gEooBdIMTENyMfIJifhvHlTnL9s9voe5387o3i0zpGuvX/i6i3AFQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GJeH60JT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52Q26wG021406985, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742954818; bh=uup0+yYfkCq7LDFw3Ew8FQU6d/y+L+YP5WjmWnfTOq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=GJeH60JTlfYN6Dde8HXl6PoUf8P+g4ZVKU1H7Mbc2z4kxwgtDaiZI05UcHPsRpIbY
	 PMorR5MqsQ1JdXErmj7iSm7FlZqrdA+WE0uZncqoGPuF2VUQsSr2dOblrc9cwaFITn
	 VX2xg8AT3NaaXlfew/rjitquEFky0/NhlLfzra62+9DDl8ub7ajTvEa2FiZjvny1Ql
	 +rCvriveBMhCysdmSZXs71Psu1pJkjXrOPQgmFRAz7OblIRDbBDm4JcDVLhtRnBcR5
	 e9myjZc4ccJJImvpLl0uspXiy9DR4F7eaua2D9NbeRLJtHwya+bq+GjCnnWhAgVSLr
	 QLzJPlyjfoNKA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52Q26wG021406985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 10:06:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Mar 2025 10:06:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Mar
 2025 10:06:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 00/12] wifi: rtw89: support SAR from BIOS ACPI
Date: Wed, 26 Mar 2025 10:06:31 +0800
Message-ID: <20250326020643.14487-1-pkshih@realtek.com>
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

The Realtek Windows driver has defined these SAR tables for ages, and
people can install Linux on the x86 platform. To be consistent, implement
to apply these tables, and later Linux distro can also use the same rules.

The SAR tables include static SAR table for basic use, and dynamic SAR
table for platforms that can support yoga mode for example. GEO SAR
table is to support different country's regulations.

Since two antenna solution can possibly use different SAR limit, the last
three patches add this feature to chips that can support delta of TX power
from main antenna to aux antenna.

v2:
 - "wifi: rtw89: acpi: support loading dynamic SAR tables and indicator"
   (patch 7/12) is changed, because indicator field can be different
   for different CID.

Zong-Zhe Yang (12):
  wifi: rtw89: fix typo of "access" in rtw89_sar_info description
  wifi: rtw89: regd: introduce string getter for reuse
  wifi: rtw89: sar: introduce structure to wrap query parameters
  wifi: rtw89: sar: add skeleton for SAR configuration via ACPI
  wifi: rtw89: acpi: introduce method evaluation function for reuse
  wifi: rtw89: acpi: support loading static SAR table
  wifi: rtw89: acpi: support loading dynamic SAR tables and indicator
  wifi: rtw89: acpi: support loading GEO SAR tables
  wifi: rtw89: sar: add skeleton for different configs by antenna
  wifi: rtw89: 8922a: support different SAR configs by antenna
  wifi: rtw89: 8852c: support different SAR configs by antenna
  wifi: rtw89: 8852bx: support different SAR configs by antenna

 drivers/net/wireless/realtek/rtw89/acpi.c     | 992 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/acpi.h     | 174 +++
 drivers/net/wireless/realtek/rtw89/core.c     |   6 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  63 +-
 drivers/net/wireless/realtek/rtw89/debug.c    |  33 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  12 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |  14 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   5 +
 drivers/net/wireless/realtek/rtw89/regd.c     |  32 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  |  24 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  27 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  28 +
 drivers/net/wireless/realtek/rtw89/sar.c      | 282 ++++-
 drivers/net/wireless/realtek/rtw89/sar.h      |  19 +-
 18 files changed, 1620 insertions(+), 95 deletions(-)

-- 
2.25.1


