Return-Path: <linux-wireless+bounces-3090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD34848A27
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 02:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C471C22D60
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 01:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780F34C9F;
	Sun,  4 Feb 2024 01:27:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434FB4696
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010038; cv=none; b=oFaR5295aiqWGrhODsXU6wgkfRQ4UGLBJ9AzQBRFojzhMt6JofICxyUbmWncDNCklHwqbypZcww6Xeh6smbTlDEneCGaCLcvsYjhTMfXK+qpdibKWu4bNzeouCcmMkJN8GgtFbBm7pUL99glerYb9xavTH+A9uwpnO5vgAvHXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010038; c=relaxed/simple;
	bh=CCY7Mr2HcaTqEZKrbR3tdhZNES8OoUNW95IPWCIRmZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UJE2VvmlsfaLCeatO2dbMNT/Dns/iCRXOpgT4lYRxsHsN44uMQpYGeHb3h9mySLay5gl0//CSHsC5vH4kzBXM4FVoG5LlgbQ5NPFSFHCkfBzFSkwHiIQkM8MgxiSLFeQ1qUBA4D3/VP30mhHy8BWunA6FCWD9bZsahYWYzgTIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4141R2kR42615006, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4141R2kR42615006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Feb 2024 09:27:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sun, 4 Feb 2024 09:27:02 +0800
Received: from [127.0.1.1] (172.16.16.254) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 4 Feb
 2024 09:27:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/4] wifi: rtw89: fw: support firmware secure boot
Date: Sun, 4 Feb 2024 09:26:23 +0800
Message-ID: <20240204012627.9647-1-pkshih@realtek.com>
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

Firmware secure boot is to ensure firmware running on chip is the one
which is signed and released officially. Without this, it will be failed
to download firmware result from wrong security key data.

The main difference between secure and non-secure boot is content of
secure section, which is one type of many firmware sections, and is to
provide key data.

The basic steps for key data are:
 1. read cryptography method and key_index from efuse (patch 2/4)
 2. parse firmware file to select secure section by the information of
    step 1 (patch 3/4)
 3. download firmware with selected secure section and key data (patch 4/4)

v2:
 - use "%tx" to print out differences (subtraction) of two pointers
   in patch 3/4 (reported by kernel test robot)

Ping-Ke Shih (4):
  wifi: rtw89: fw: consider checksum length of security data
  wifi: rtw89: fw: read firmware secure information from efuse
  wifi: rtw89: fw: parse secure section from firmware file
  wifi: rtw89: fw: download firmware with key data for secure boot

 drivers/net/wireless/realtek/rtw89/core.h     |  15 +
 drivers/net/wireless/realtek/rtw89/efuse.h    |   1 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 142 +++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 296 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h       |  47 ++-
 drivers/net/wireless/realtek/rtw89/pci.c      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   3 +
 7 files changed, 484 insertions(+), 22 deletions(-)

-- 
2.25.1


