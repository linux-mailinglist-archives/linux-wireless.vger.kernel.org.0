Return-Path: <linux-wireless+bounces-20595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C1A69EC6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 04:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C54E7B1D26
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78C1EB1B2;
	Thu, 20 Mar 2025 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dxt3NgFh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9111EB1BA
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441263; cv=none; b=I/mZVslXM/792xJK/0FSw+tNZto3WCgy22+B0K2MpBKFED2fl7ZutoBMyXkpx0UVI69xsYCeKkTEEludbcaDhenccNC4plPqyNR/rfBQYAb2S9Xd5cY2ykxMzHajEqJSJJK08GKgXpMFEVH/Npjp5SQ20wfXcdJKRYiFjfQZ7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441263; c=relaxed/simple;
	bh=e76auXtfWkIpPNm5xq19FoeUD6DzOQr6XF9fGM4CuFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e22FtCXBG9X5kszcWdZp7QokzPeM7YzEZ9lG48towlyjiIWmZZ81iytjduEQHRN8M5lPqMsH8LIByj4wT8BJwtN3FNAGflP37LN1RPIjDANQhrMce4Kmcpn2aP7LVqiZ1WhfP3b33H5Zql0EuoCWY691E58nVEMchDrO+gHvo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dxt3NgFh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K3RaGtA1750890, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742441256; bh=e76auXtfWkIpPNm5xq19FoeUD6DzOQr6XF9fGM4CuFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=dxt3NgFhDZWevi2vSCIZ8xV13UrKqj6K+kmwTUMB6tG2d3KckBnK1Z4q8xEjgGfB8
	 ZlfqV1WaErkMva26OzDIH/jtzrfqKHIoqGQzaB5Y9HWRfQeQ03ZWp/pZvGvEz6X2q/
	 XEWeXbkTyKieiatJa2guhGH4OwoQ4GbGFdF+JsMS0DR256jB38glicot8Sr9pWYqe6
	 PGoZKdoyGSxcIcWJrSJrmsCUYWdgfEJowVoU5bGuV88ylZA6ufmJMb6iLeza8+7el9
	 1aDvFMTt+hRdCRz7IEm+in+jkk7BwRh7/1ZwtAOc9/angp+9Ut4hV7VRjGn+IsJBTz
	 KIrT1OCjpA78w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K3RaGtA1750890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 11:27:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 11:27:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Mar
 2025 11:27:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/12] wifi: rtw89: support SAR from BIOS ACPI
Date: Thu, 20 Mar 2025 11:27:00 +0800
Message-ID: <20250320032712.20284-1-pkshih@realtek.com>
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

 drivers/net/wireless/realtek/rtw89/acpi.c     | 991 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/acpi.h     | 182 ++++
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
 18 files changed, 1627 insertions(+), 95 deletions(-)

-- 
2.25.1


