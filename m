Return-Path: <linux-wireless+bounces-14695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2584A9B59D7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578961C210F2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8127E0FF;
	Wed, 30 Oct 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="deizVSDr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26468D531
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254932; cv=none; b=W7nWvBxnFpI9BjhUhX1XIvkFyHrtttqE+G97+c15Z1e2zK0DaNmt+1G9wn7ciddILEuvjegoX61iZXCcMG36Oh8NPmOKaYT0eDLPUj9Aq3fZmhUk6qYu5773juEaVsCcyauebp8yn/WKiUSHL/29d2qElPd1Gshk31CochR1avY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254932; c=relaxed/simple;
	bh=5EHBT132pXJ63PYDCAcrAokfilFSFg7ACQ1w3BL2e0g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A2MSrt4E3iPedLI5dg/Emx7vAaAuJYEB3lw3C9qEtRnymCU7gBP5IAcLkdlaM7Sh13GANESAhuk2yvqv+4oLVWGcpuRoRDmeWSyxcF4vZiu/ohvKcndyIefsY3cbB+43kcZpdGt8/sQw502Z0yS94cDe2AD4rlnsaahNiRtfm/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=deizVSDr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2M4LR03310540, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730254924; bh=5EHBT132pXJ63PYDCAcrAokfilFSFg7ACQ1w3BL2e0g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=deizVSDrGANlgfI3Xml1RYkGcMUr9PUKEcanS5FLKl/Rt+ozGlbIRZHOHvhEPlWJF
	 20YVJQYAtRkH4Ve4r1t0zOc3FDrbWo5IHG24RWmg1aqeHG87+KxUdwyPUeNvnYERrc
	 sF0lwr1QTyIPOiPedpBpx0Qca504BZnn6b/JtOeX3F6cM9B07auF62QIt5Pov6Oxmg
	 pi4/0TAO3RoExcuiQHxewgSm8k4r5GQAXUD1jTiJJn1VU1MulCXsZaOdTx2nfzy+AY
	 TPWl+8RNXPxGrpWdO9KDhEMYb4fX83qzlhWGsta2oT5QILkeNjjACv2l0kC5n9Hy08
	 aFckeFMlKklTg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2M4LR03310540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:22:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:22:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 10:22:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: support firmware secure boot for WiFi 6 chips
Date: Wed, 30 Oct 2024 10:21:27 +0800
Message-ID: <20241030022135.11688-1-pkshih@realtek.com>
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

rtw89 has supported firmware secure boot for WiFi 7 chip, and this
patchset is to support WiFi 6 chips.

Basically flow of firmware secure boot is:
1. read efuse to determine if hardware module need firmware secure boot
   (Patches 1~3 adjust existing code and add new foramt)
2. select key data and relocate firmware content
   (Patches 4, 6 and 7 adjust existing code to support new format)
3. download firmware

Remaining patches 5 and 8 are to set and unset registers for the case of
firmware secure boot. Both don't affect original behavior.

Ping-Ke Shih (8):
  wifi: rtw89: efuse: move reading efuse of fw secure info to common
  wifi: rtw89: efuse: move recognize firmware MSS info v1 to common
  wifi: rtw89: efuse: read firmware secure info v0 from efuse for WiFi 6
    chips
  wifi: rtw89: fw: shrink download size of security section for RTL8852B
  wifi: rtw89: fw: set recorded IDMEM share mode in firmware header to
    register
  wifi: rtw89: fw: move v1 MSSC out of __parse_security_section() to
    share with v0
  wifi: rtw89: fw: use common function to parse security section for
    WiFi 6 chips
  wifi: rtw89: mac: no configure CMAC/DMAC tables for firmware secure
    boot

 drivers/net/wireless/realtek/rtw89/core.h     |   5 +-
 drivers/net/wireless/realtek/rtw89/efuse.c    | 150 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/efuse.h    |   2 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c |  52 +-----
 drivers/net/wireless/realtek/rtw89/fw.c       | 109 ++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h       |   5 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  27 +++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  12 ++
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   2 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   3 -
 11 files changed, 291 insertions(+), 78 deletions(-)

-- 
2.25.1


